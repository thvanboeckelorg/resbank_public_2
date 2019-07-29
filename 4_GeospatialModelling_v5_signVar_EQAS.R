######################################
# step 1. Load Raster Objects 
#source('scripts/pre_treat_rasters.r')

# Use P10 instead of P50
Pchar = "P50" 
if(P10Bin == T){
XYTable$PN50 = XYTable$PN10 
Pchar = "P10" 
}
# Load raster objects 
#####################
# Load stack of covariates for child-models 
myRS = stack("/Users/thomavan/Dropbox/resbank/data/predStackl10")
myRS = dropLayer(myRS,2)
# Drop X,Y coordinates layersm, as well as the livestock production systems 
#myRS = myRS[[2:(nlayers(myRS)-3)]]
proj4string(myRS) = CRS("+proj=longlat +datum=WGS84")
names(myRS) = c("use","acc","tmp","irg","PgExt","PgInt","ChExt","ChInt","Ca","veg")
nVars = nlayers(myRS)

# Convert the Stack of raster for future LASSO predictions 
# glmnet oesn't support predictions directly on a raster*, so we use first have to conver raster stack to data.frame 
StackAsDF = as.data.frame(myRS[])

# Convert the data.frame of the raster stack to a matrix
StackAsM = as.matrix(StackAsDF)

# Load General Mask
myMask_p = raster("/Users/thomavan/Dropbox/resbank/data/mask")

# Load rural population density (log10) using GRUMP, and GlobeCover for UrbanAreas. 
rhpop = raster("/Users/thomavan/Dropbox/resbank/data/L1prhpop")
proj4string(rhpop) = CRS("+proj=longlat +datum=WGS84")

# Absences, presence and speudo-asbences
######################################
# Define presence and absence. 
Npresence = nrow(XYTable[(XYTable$PN50 > 0),])
Nabsence = nrow(XYTable[(XYTable$PN50 == 0),])

# Calculate the number of pseudo absences to build a balanced data set of presence vs non-presence (true absence + pseudo absence), will be used for each bootsrap. 
NpseudoA = Npresence - Nabsence

RatioPA = NpseudoA / (Npresence+Nabsence+NpseudoA)

# Load Distance to positives (THIS NEEDS TO BE RECALCULATED once Joao has Finish China)
#xxx = Sys.time()
#DFpositives = XYTable[(XYTable$PN50 > 0),][c("XCoord","YCoord")]
#coordinates(DFpositives) = c("XCoord","YCoord")
#distFromPos = distanceFromPoints(rhpop,XYTable[(XYTable$PN50 > 0),][c("XCoord","YCoord")])/1000
#print(Sys.time()-xxx)
#writeRaster(distFromPos, file = "/Users/thomavan/Dropbox/resbank/data/Dpositives", overwrite = T)
Dpositives=raster("/Users/thomavan/Dropbox/resbank/data/Dpositives")

# Mask distance that are either too close or too far:
Dpositives[][Dpositives[] < 20] = NA
Dpositives[][Dpositives[] > 2000] = NA

# Define sampling mask for speudo-absence: the rural population density that is within [10-2000] kilometers from positives. 
rhpopm = mask(rhpop,Dpositives)
#rhpopm = rhpopm > 0

# Number of boostrats for non-spatial models, and number of replications of teh datasets. 
nBS = 10
nReps = 5

# Initialize final result objects, for mapped predictions and for spatial sorting bias 
PresRSBRT = PresRSLASSO = PresRSGAM = myRS[[1]]
PresRSBRT[] = PresRSLASSO[] = PresRSGAM[] = NA
SSBs = rep(NA,nBS)
AUCsM = matrix(NA,nBS,3)

# Variable Diagnostic Objects 
RelImpV = matrix(NA,nBS,nVars)
CoefsLASSOV = matrix(NA,nBS,nVars)
CoefsLASSOGAMlinV = matrix(NA,nBS,nVars)
CoefsLASSOGAMnlV = matrix(NA,nBS,nVars)
LASSOLossDevExpPCt = matrix(NA,nBS,nVars) 
LASSOGAMLossDevExpPCt = matrix(NA,nBS,nVars) 

# Presence/Absence non-spatial models
#####################################################################
# Duplicate datasets 
####################
for (i in 1:nBS){
  
  DFbrt = NULL
  for (ii in 1:nReps){
  DFbrt=rbind(DFbrt,XYTable)
  }

DFbrt$HasRes = ifelse(DFbrt$PN50 > runif(nrow(DFbrt)),1,0)


#Number of pseudo-absence missing to create a balanced dataset of presence/absence 
NpseudoA = round(nrow(DFbrt) * RatioPA * 1.8)

# generate pseudo-absence point by sampling according to rural population density within a certain radius of presence [10-1000 Km] 
pseudoAXY = as.data.frame(bgSample(rhpopm, n = NpseudoA,prob = T, replace = FALSE, spatial = F)) # sample too times too many to remove those that will not satisfy the distance condition

colNames <- names(DFbrt)
XYTablePA <- as.data.frame(matrix(NA,NpseudoA,length(colNames)))
names(XYTablePA) <- colNames

XYTablePA$XCoord = pseudoAXY$x
XYTablePA$YCoord = pseudoAXY$y

# Assign country and region tot he pseudo-absence points
XYTablePA$ISO3 = extract(mySHPLMICs,pseudoAXY)$ISO3
XYTablePA$Continent = world$CONTINENT[match(XYTablePA$ISO3,world$ISO3)]
XYTablePA$Continent[XYTablePA$Continent == "South America"] = "Americas"
XYTablePA$Continent[XYTablePA$Continent == "North America"] = "Americas"

# assign zero resistance for pseudo-absence 
XYTablePA$PN50 = rep(0,NpseudoA)
XYTablePA$HasRes = rep(0,NpseudoA)

# Combine real data (presence and absence) with pseudo-absences 
DFbrt = rbind(DFbrt,XYTablePA)

# Extract covariates for pseudo absences 
DFCov = as.data.frame(extract(myRS,DFbrt[c("XCoord","YCoord")]))
DFbrt = cbind(DFbrt,DFCov)

# Remove NA
NAs = which(is.na(rowSums(DFbrt[names(myRS)])))
DFbrt = DFbrt[-NAs,]

# Assign Spatial Fold 
DFbrt$SPfold = rep(NA, nrow(DFbrt))
DFbrt$SPfold[DFbrt$Continent == "Asia" & DFbrt$XCoord > 90] = 3
DFbrt$SPfold[DFbrt$Continent == "Asia" & DFbrt$XCoord <= 90] = 4
DFbrt$SPfold[DFbrt$Continent == "Africa"] = 2
DFbrt$SPfold[DFbrt$Continent == "Americas"] = 1
DFbrt = DFbrt[-which(is.na(DFbrt$SPfold)),]

# Calculate Spatial sorting Bias (necessary for running BRT). If this is close to one it means it is OK to proceed. 
SSB_by_SPfold = rep(NA,length(unique(DFbrt$SPfold))) 

for (k in 1:length(unique(DFbrt$SPfold))){
  
  idTr1geo <- which(DFbrt$HasRes == 1 & DFbrt$SPfold != k) 
  idTr0geo <- which(DFbrt$HasRes == 0 & DFbrt$SPfold != k)
  
  idVal1geo <- which(DFbrt$HasRes == 1 & DFbrt$SPfold == k)
  idVal0geo <- which(DFbrt$HasRes == 0 & DFbrt$SPfold == k)
  
  Tr1geo <- DFbrt[idTr1geo,]
  Tr0geo <- DFbrt[idTr0geo,]
  
  Val1geo <- DFbrt[idVal1geo,]
  Val0geo <- DFbrt[idVal0geo,]
  
  SSB2 <- ssb(Val1geo[, c("XCoord","YCoord")], Val0geo[, c("XCoord","YCoord")],Tr1geo[, c("XCoord","YCoord")], lonlat = TRUE)
  SSB_by_SPfold[i] = SSB2[1, "p"] / SSB2[1, "a"]
  
}
SSBs[i]= mean(SSB_by_SPfold, na.rm = T)

# Run BRT model 
###############
ColIndexCov = match(names(myRS),names(DFbrt))
ColIndexResp = match(c("HasRes"),names(DFbrt))

myBRT = gbm.step(data=DFbrt, 
                 gbm.x = ColIndexCov, 
                 gbm.y = ColIndexResp,
                 tree.complexity = 3,
                 learning.rate = 0.0025,
                 n.trees = 50,
                 family = "bernoulli",
                 n.folds = 4,
                 fold.vector = DFbrt$SPfold,
                 step.size = 50,
                 verbose = F,
                 silent = T
                 )  

# Store AUC
AUCsM[i,1] = as.numeric(myBRT$cv.statistics["discrimination.mean"])

# Store relative influence 
RelImpV[i,] = summary(myBRT,plotit=F)$rel.inf[match(names(myRS),summary(myBRT, plotit=F)$var)]

# Running predictions for BRT
PresRSBRTtmp = predict(myRS, myBRT, n.trees = myBRT$gbm.call$best.trees, type="response") 
PresRSBRT = sum(PresRSBRT,PresRSBRTtmp, na.rm = T)

# Run logistic regression model with LASSO regularization
#######################################################
# Convert data.frame as matrix (requested for cv.glmnet) 
x = as.matrix(DFbrt[ColIndexCov])
y = as.matrix(DFbrt$HasRes)

# Run LASSO optimization
LASSO = cv.glmnet(x,y,alpha=1,family="binomial",foldid = DFbrt$SPfold, nfolds = 4)

# Extract optimal lanbda following spatial cross-validation
lambda = LASSO$lambda.min
IndexMin = which(LASSO$lambda == lambda)

# Calculate AUCs Mannually
AUcsLASSO = rep(NA,length(unique(DFbrt$SPfold)))
for (k in 1:length(unique(DFbrt$SPfold))){
  Preds = predict(LASSO, newx = x[DFbrt$SPfold == k,], type = "response",s = lambda)
  AUcsLASSO[k] = auc(y[DFbrt$SPfold == k],as.vector(Preds))
}
AUCsM[[i,2]] = mean(AUcsLASSO)

# Inspect coefficients fitted with minimum lambda
CoefsLASSO = coef(LASSO,s=lambda)
CoefsLASSOV[i,] = sign(as.vector(CoefsLASSO[2:length(CoefsLASSO)]))

# Make vector of predictions using optimal lambda
PresRSLASSOV = predict(LASSO, newx = StackAsM, type = "response", s = lambda)

# Create raster object that contains the prediction
PresRSLASSOtmp = myRS[[1]] #Take first image of teh raster as template for the predictions
PresRSLASSOtmp[] = PresRSLASSOV
PresRSLASSO = sum(PresRSLASSO,PresRSLASSOtmp, na.rm = T)

# Run GAM with LASSO regularization
#######################################################
# Convert data.frame as matrix (requested for cv.glmnet) 

# Run LASSO optimization
gamLASSO = cv.gamsel(x, y, family = "binomial",nfolds = 4, foldid = DFbrt$SPfold)

# Extract optimal lanbda following spatial cross-validation
lambdaM = gamLASSO$lambda.min

# Run the gam with optimal lambda prameter 
myGAM = gamsel(x, y, lambda = lambdaM, family = "binomial")

  # Calculate cross-validation AUCs Mannually
  AUcsGAM = rep(NA,length(unique(DFbrt$SPfold)))
  for (k in 1:length(unique(DFbrt$SPfold))){
  myGAMModel = gamsel(x[(DFbrt$SPfold != k),], y[(DFbrt$SPfold != k)], lambda = lambdaM, family = "binomial")
  Preds = predict(myGAMModel, newdata = x[DFbrt$SPfold == k,], type = "response")
  AUcsGAM[k] = auc(y[DFbrt$SPfold == k],as.vector(Preds))
  }
  AUCsM[[i,3]] = mean(AUcsGAM)
  
# Track number of time a covariates was fitted as anon-linear term
  
  nonlin = getActive(myGAM, index = 1, type = "nonlinear")[[1]]
  active_linear <- getActive(myGAM, index=1, type = "linear")[[1]]
  linear = setdiff(active_linear, nonlin)
  CoefsLASSOGAMnlV[i,nonlin] = 1
  CoefsLASSOGAMlinV[i,linear] = 1
  
# Make vector of predictions using optimal lambda
PresRSgamV = predict(myGAM, newdata = StackAsM, type = "response")

# Create raster object that contains the prediction
PresRSGAMtmp = myRS[[1]] #Take first image of teh raster as template for the predictions
PresRSGAMtmp[] = PresRSgamV

PresRSGAM = sum(PresRSGAM,PresRSGAMtmp, na.rm = T)

} #end of loop on boostraps

# Average Boostrap predictions for BRT 
PresRSBRTm = PresRSBRT / nBS
PresRSLASSOm = PresRSLASSO / nBS
PresRSGAMm = PresRSGAM / nBS

MeanSSBs = print(SSBs)

# Print Fitting Metrics 
print("AUC: BRT, LASSO-GLM, LASSO-GAM")
print(format(colMeans(AUCsM), digits = 3))
AUCTable = as.data.frame(t(colMeans(AUCsM)))
AUCTable = format(AUCTable, digits = 4)
names(AUCTable) = c("AUC: BRT","LASSO-GLM","LASSO-GAM")
write.table(AUCTable, file = "/Users/thomavan/Dropbox/resbank/data/outputs/TableAUC_Child_models.txt")


# Visulalize BRT and LASSO predictions
###########################

pdf(
  file = paste0("/Users/thomavan/Dropbox/resbank/Figures/Child_models_",Pchar,"_EQAS_2018.pdf"),
  width = 6,
  height = 5
)
par(mfrow = c(3,1))
par(mar = c(1,0,1,0))
Zlims = range(summary(PresRSBRTm)[5],summary(PresRSBRTm)[1],summary(PresRSLASSOm)[1],summary(PresRSLASSOm)[5],summary(PresRSGAMm)[1],summary(PresRSGAMm)[5])
plot(mySHPLMICs, main = "Boosted Regression Trees",lwd = 0.3, border = T)
plot(mask(PresRSBRTm,myMask_p), col = ColsRes, zlim = Zlims, axes = F, box = F, legend = T,main = "BRT",xlim=as.vector(bbox(mySHPLMICs)[1,]), ylim = as.vector(bbox(mySHPLMICs)[2,]),add=T, border = 0.2)

plot(mySHPLMICs, main = "LASSO-GLM",lwd = 0.3, border = T)
plot(mask(PresRSLASSOm,myMask_p), col = ColsRes, zlim = Zlims, axes = F, box = F, legend = T,main = "LASSO", xlim=as.vector(bbox(mySHPLMICs)[1,]), ylim = as.vector(bbox(mySHPLMICs)[2,]),add=T, border = 0.2)

plot(mySHPLMICs, main = "LASSO-GAM",lwd = 0.3, border = T)
plot(mask(PresRSGAMm,myMask_p), col = ColsRes, zlim = Zlims, axes = F, box = F, legend = T,main = "LASSO", xlim=as.vector(bbox(mySHPLMICs)[1,]), ylim = as.vector(bbox(mySHPLMICs)[2,]),add=T, border = 0.2)
dev.off()

# Visulalize Spatial Folds 
##########################
# Spatial folds 
par(mfrow = c(1,1))
par(mar = c(4,4,4,4))
plot(mySHP, col = "grey90", border = "white", lwd = 0.4, main = "Spatial Folds")
plot(mySHPLMICs, col = "darkgrey", border = "white", lwd = .5,add = T)
IndexPA = unique(c(which(DFbrt$PN50==0),which(is.na(DFbrt$DOI))))
points(DFbrt$XCoord[IndexPA],DFbrt$YCoord[IndexPA],col = addalpha(c("blue","black","orange","red"),0.5)[DFbrt$SPfold[IndexPA]], cex = 1)
points(DFbrt$XCoord[DFbrt$PN50>0],DFbrt$YCoord[DFbrt$PN50>0],col = c("blue","black","orange","red")[DFbrt$SPfold[DFbrt$PN50>0]], pch = 16)

legend(-140,10,c("Presence","Pseudo-absence"),pch = c(16,1), bty = "n", cex = 2)

############################################
# Ensemble modelling (Spatial + non-spatial)
############################################
StackMask = ((PresRSBRTm > 0) * (PresRSLASSOm > 0) * (PresRSGAMm > 0)) 

# Create meta-covariates
myRSMeta = stack(PresRSBRTm,PresRSLASSOm,PresRSGAMm)
myRSMeta = myRSMeta * myMask_p
names(myRSMeta) = c("PresRSBRT","PresRSLASSO","PresRSGAM")

# Variogram fitting for Kriging 
###############################
# Use original data expanded according to sample size. 
VariogXYTable = NULL

# duplicated according to weights (this helps fitting varigram models): 
for (i in 1:nrow(XYTable)){
  
  NumbRep = round(XYTable$L10NMsamplesEQAS[i])
  tmpROW = NULL
  
  for (ii in 1:NumbRep){
    tmpROW = rbind(tmpROW,XYTable[i,]) 
  }
  
  VariogXYTable = rbind(VariogXYTable,tmpROW)
}
# Microscale uniform noise to avoid double coordinates in the kriging routine
VariogXYTable$XCoord = VariogXYTable$XCoord + runif(nrow(VariogXYTable),0,0.00083333 * VariogXYTable$L10NMsamplesEQAS) 
VariogXYTable$YCoord = VariogXYTable$YCoord + runif(nrow(VariogXYTable),0,0.00083333 * VariogXYTable$L10NMsamplesEQAS)

XYTableSPDF = VariogXYTable
coordinates(XYTableSPDF) = c("XCoord","YCoord")
proj4string(XYTableSPDF) = CRS("+proj=longlat +datum=WGS84")

# Sample Meta-covariates 
CovMetaDF = as.data.frame(extract(myRSMeta,coordinates(XYTableSPDF)))
names(CovMetaDF) = names(myRSMeta)
XYTableSPDF@data = cbind(XYTableSPDF@data,CovMetaDF)
NAs = which(is.na(rowSums(XYTableSPDF@data[c("PresRSBRT","PresRSLASSO","PresRSGAM")])))
XYTableSPDF = XYTableSPDF[-NAs,]

### Build variograms 
vu = variogram(PN50~PresRSBRT+PresRSLASSO+PresRSGAM, data = XYTableSPDF, cutoff = 1000) 
mu = fit.variogram(vu, vgm("Mat"), fit.method = 6)
plot(vu,mu)

gUK <- gstat(NULL, "PN50", PN50~PresRSBRT+PresRSLASSO+PresRSGAM, data = XYTableSPDF, model=mu, weights = XYTableSPDF$NMsamplesEQAS)

myStack = aggregate(myRSMeta, fact=1, fun=mean, expand=TRUE, na.rm=TRUE)

# Convert Stack as SpatialGrid (we could use interpolate but this doesn't allow to calculate the kriging variance)
myStackg = as(myStack, 'SpatialGridDataFrame')

# Universal Kriging on Spatial Grid
xxx = Sys.time()
UK <- predict(gUK,myStackg)
UKb <- brick(UK)
print(Sys.time()-xxx)

# Resample and mask predictions for LMICs
UKbrs = resample(UKb,myStack, method = "bilinear")
names(UKbrs) <- c('prediction', 'variance')

# Predictions UK
UKp = UKbrs[[c("prediction")]]
UKp[UKp[] < 0 ] = 0
UKp[UKp[] > 1 ] = 1

# Uncertainty 
# Interpolation Uncertainty (Spatial uncertainty)
UKvar = UKbrs[[c("variance")]]
SpatialVar = UKvar-min(UKvar[],na.rm = T)

SpatialSD = sqrt(SpatialVar)

# Trends Uncertainty (deviation between the child models)
TrendSD = calc(myStack,sd, na.rm = F)
Uncertainty = 1.96 * sum(SpatialSD,TrendSD, na.rm = T)

# Uncomment if necessary: CONSERVATIVE MASK: Boudn the Uncertainty layers that the max value of the pixel where all child models prediction a value > 0
StackMask5x = resample(StackMask,myStack, method = "ngb")
myMask_p5x = resample(myMask_p,myStack, method = "ngb")
UncertaintyZone = Uncertainty * StackMask5x 
UncertaintyZoneMax = max(UncertaintyZone[], na.rm = T)
UncertaintyTH = Uncertainty
UncertaintyTH[][UncertaintyTH[] > UncertaintyZoneMax] = UncertaintyZoneMax
Uncertainty = UncertaintyTH * (StackMask5x > -1)
# Uncomment if necessary: STRICT MASK: only show uncertainty for pixel where ALL child model predicted a value > 0
StrictMask5x = StackMask5x 
StrictMask5x[][StackMask5x[] == 0] = NA
UKp = UKp * StrictMask5x
Uncertainty = Uncertainty * StrictMask5x * myMask_p5x
Uncertainty[Uncertainty >.35] = .35
########################
# Write outputs 
#writeRaster(UKp, paste0("/Users/thomavan/Dropbox/resbank/data/outputs/",Pchar,"_10k_EQAS_2018"),overwrite=TRUE)
#writeRaster(Uncertainty, paste0("/Users/thomavan/Dropbox/resbank/data/outputs/",Pchar,"_ci_10k_EQAS_2018"),overwrite=TRUE)
#writeRaster(SpatialSD, paste0("/Users/thomavan/Dropbox/resbank/data/outputs/",Pchar,"SpatialSD_EQAS_2018"),overwrite=TRUE)
#writeRaster(TrendSD, paste0("/Users/thomavan/Dropbox/resbank/data/outputs/",Pchar,"TrendSD_EQAS_2018"),overwrite=TRUE)

# Plots 
##################################################################

# Mask
myPMaskc = raster("/Users/thomavan/Dropbox/resbank/data/plot_mask")

# Define LMIC mask 
myPMaskcLMICs = crop(myPMaskc,extent(c(-118,140,-57,57)))

ColsRes = colorRampPalette(brewer.pal(9,"Reds"))(101)
ColDiv = colorRampPalette(rev(brewer.pal(9,"RdYlGn")))(115)[1:100]

par(mfrow = c(2,1))
par(mar = c(0,0,0,0))
# 1. Kriging predictions
plot(myPMaskcLMICs, col = "white", axes = F, legend = F, box = F)
plot(mySHP, col = "grey90", border = "white", lwd = 0.3,add=T)
plot(UKp, col = ColsRes, axes = F, box = F, add = T, legend = T)
plot(mySHPLMICs, add = T, lwd = 0.1)

# 2. Kriging variance 
plot(myPMaskcLMICs, col = "white", axes = F, legend = F, box = F)
plot(mySHP, col = "grey90", border = "white", lwd = 0.3,add=T)
plot(Uncertainty, col = ColDiv, axes = F, box = F, add = T, legend = T)
plot(mySHPLMICs, add = T, lwd = 0.1)
points(XYTable$XCoord,XYTable$YCoord, pch = 16, col = "darkgreen", cex = 0.1)







