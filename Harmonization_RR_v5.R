##################################################################################
# 1 Potential Bias due to AST methods
##################################################################################
par(mfrow = c(1,1))

  print(aggregate(data.frame(myT$Method2C), list(myT$Method2C), length))

  # First lets look at where each methods is  used 
  mySHP = shapefile("/Users/thomavan/Dropbox/AAuse/data/World.shp")
  # Define 'low and middle-income countries'
  mySHPLMICs = mySHP[(mySHP@data$ISO3 %in% c("USA","CAN","RUS","KOR","JPN","AUS","NZL","GRL") == F),]
  mySHPLMICs = mySHPLMICs[(mySHPLMICs@data$CONTINENT != "Europe"),]
  mySHPLMICs = mySHPLMICs[mySHPLMICs@data$CONTINENT %in% c("North America","South America","Africa","Asia"),]
  
  # Only look at records that have reported resistance
  myTD = myT
  myTDDD = subset(myTD, Method2C == "DD")
  myTDAD = subset(myTD, Method2C == "AD")
  
  plot(mySHP, lwd = 0.5, col = "darkgrey", border = "white")
  plot(mySHPLMICs, lwd = 0.5, col = "lightgrey", add= T, border = "white")
  points(myTDDD$XCoord,myTDDD$YCoord, pch = 16, col = "red", cex = 2)
  points(myTDAD$XCoord,myTDAD$YCoord, pch = 16, col = "cornflowerblue", cex = 2)
  legend(-160,0, legend = c(paste0("Disc Diffusion (n = ",nrow(myTDDD),")"),paste0("Microdilution (n = ",nrow(myTDAD),")")),  pch = 16, col = c("red","cornflowerblue"), bty = 'n', cex = 2)
  
  myTD$count = rep(1,nrow(myTD))
  myTD$IsChina = ifelse(myTD$ISO3 == "CHN","CHN","RestoftheWorld")
  myXiDF = aggregate(count ~ IsChina+Method2C, data = myTD, FUN = sum)
  myXIM = matrix(as.vector(myXiDF$count[1:4]), nrow = 2, ncol = 2, byrow = T)
  
  ADs = myXiDF$count[1:2] 
  TOTs = myXiDF$count[1:2] + myXiDF$count[3:4]
  prop.test(ADs,TOTs)

# 1.1 Look a Systematic Difference in Resistance Rates According to method used for each pathogen (exclude underrespresenetd classes, and for PPS where resistance was > 0)
###########################################################################
par(mfrow = c(4,1))
par(mar = c(4,5,4,5))

PathID = unique(myTD$Pathogens)
source('/Users/thomavan/Dropbox/resbank/scripts/HarmonizationColors.r')  
for (i in 1:length(PathID)){
mySTD = subset(myTD, Pathogens == PathID[i] & Rescom > 0 & ISO3 != "CHN")

ATD = aggregate(count~Method2C+Compound, data = mySTD, FUN = sum)

# Drug class that should be removed for comparison 
RMclass = c(unique(ATD$Compound[which(ATD$count < 10)]), "OTH")
myTDMethod = mySTD[((mySTD$Compound %in% RMclass) == F), ]

# re-aggregate to get sample size for each box 
ATDclass  = aggregate(count~Method2C+Compound, data = myTDMethod, FUN = sum)
IncludeClass = unique(ATDclass$Compound[duplicated(ATDclass$Compound)==T])
myTDMethod = myTDMethod[(myTDMethod$Compound %in% IncludeClass),]

# Final chech-test for inclusion 
ATDclass  = aggregate(count~Method2C+Compound, data = myTDMethod, FUN = sum)

#boxplot(Rescom~Method2C+Compound, data = myTDMethod, col = t(Cols), ylab = "Resistance (%)")
x = boxplot(Rescom~Method2C+Compound, data = myTDMethod, col = t(Cols), ylab = "Resistance (%)", plot = FALSE, cex.lab = 2)
NamesCompounds = substr(x$names,4,6)

# One way ANOVa or MannU test on each 
Ncombs = length(unique(myTDMethod$Compound))
myAOVsPvals = myMAnnUPvals = rep(NA, Ncombs)
NsamplesbyDD = rep(NA,Ncombs)
NsamplesbyAD = rep(NA,Ncombs)

for (ii in 1:Ncombs){
  
myAOVDF = subset(myTDMethod, Compound == unique(myTDMethod$Compound)[ii])  
#myAOVsPvals[ii] = unlist(summary(aov(as.formula("Rescom ~ Method2C"),data = myAOVDF))[[1]][5])[1]
myMAnnUPvals[ii] = wilcox.test(Rescom~Method2C, data = myAOVDF)$p.value

NsamplesbyDD[ii] = nrow(subset(myAOVDF, Method2C == "DD"))
NsamplesbyAD[ii] = nrow(subset(myAOVDF, Method2C == "AD"))

}

#cbind(unique(myTDMethod$Compound),myAOVsPvals<0.05,myMAnnUPvals<0.05)
ISSignCompounds = unique(myTDMethod$Compound)[myMAnnUPvals<0.05]

SIGNIndex = NamesCompounds %in% ISSignCompounds 

# Amount of difference for drug with signifiocant difference
# Only take singificant drugs

myTDMethodIsSign = myTDMethod[myTDMethod$Compound %in% ISSignCompounds,]

# AMount of difference for the drug classes that ahd a significant difference. 
KMeanDiff = NA
if(length(ISSignCompounds)>0){
MeanDiffDF = aggregate(Rescom ~ Method2C, data = myTDMethodIsSign, FUN = mean)
KMeanDiff = (MeanDiffDF$Rescom[1]-MeanDiffDF$Rescom[2])
}

Cols = t(t(colorRampPalette(brewer.pal(9,"Set1"))(nrow(ATDclass)/2)))
Cols = as.vector(Cols)
Cols = as.vector(rbind(Cols,Cols))

Cols = t(t(colorRampPalette(brewer.pal(9,"Set1"))(nrow(ATDclass)/2)))
Cols = as.vector(Cols)
Cols = as.vector(rbind(Cols,Cols))


Names = paste0((rep(c("AD","DD"),Ncombs)),".",NamesCompounds)
SSize = NULL

  for (ii in 1:Ncombs){
    SSize = c(SSize,NsamplesbyAD[ii],NsamplesbyDD[ii])  
  }
boxplot(Rescom~Method2C+Compound, data = myTDMethod, col = RandomPal[match(NamesCompounds,UNames)], border = c("grey","red")[SIGNIndex+1],ylab = "Resistance (%)", main = PathID[i], cex.main = 2, cex.lab = 2, xlab = NA)
}

RecordsSystDiff = sum(
nrow(subset(myTD, Pathogens == "Staphylococcus" & Compound == "FOX" & Method2C == "AD")),
nrow(subset(myTD, Pathogens == "Staphylococcus" & Compound == "OXA" & Method2C == "AD")),
nrow(subset(myTD, Pathogens == "Ecoli" & Compound == "NAL" & Method2C == "AD"))
)
print(paste0("Number of Records with Systematic Differences : ",RecordsSystDiff))
print(paste0("Percentage of Records with Systematic Differences : ",round(100*RecordsSystDiff/nrow(myTD),digits = 3)))

# Correct systematic methods differences 
# Average difference rations 
MeanADFOX = mean(subset(myTD, Pathogens == "Staphylococcus" & Compound == "FOX" & Method2C == "AD")$Rescom)
MeanDDFOX = mean(subset(myTD, Pathogens == "Staphylococcus" & Compound == "FOX" & Method2C == "DD")$Rescom)
RADDD_FOX = MeanDDFOX / MeanADFOX

MeanADOXA = mean(subset(myTD, Pathogens == "Staphylococcus" & Compound == "OXA" & Method2C == "AD")$Rescom)
MeanDDOXA = mean(subset(myTD, Pathogens == "Staphylococcus" & Compound == "OXA" & Method2C == "DD")$Rescom)
RADDD_OXA = MeanDDOXA / MeanADOXA

MeanADNAL = mean(subset(myTD, Pathogens == "Ecoli" & Compound == "NAL" & Method2C == "AD")$Rescom)
MeanDDNAL = mean(subset(myTD, Pathogens == "Ecoli" & Compound == "NAL" & Method2C == "DD")$Rescom)
RADDD_NAL = MeanDDNAL / MeanADNAL

# Apply correction 
PosFOX = which(((myTD$Pathogens == "Staphylococcus") * (myTD$Compound == "FOX") * (myTD$Method2C == "AD")) == T)
PosOXA = which(((myTD$Pathogens == "Staphylococcus") * (myTD$Compound == "OXA") * (myTD$Method2C == "AD")) == T)
PosNAL = which(((myTD$Pathogens == "Ecoli") * (myTD$Compound == "NAL") * (myTD$Method2C == "AD")) == T)

# Number of FOX and OXA Records for MRSA compared to the whole dataset
myTD$Rescom[PosFOX] = myTD$Rescom[PosFOX] * RADDD_FOX
myTD$Rescom[PosOXA] = myTD$Rescom[PosOXA] * RADDD_OXA
myTD$Rescom[PosNAL] = myTD$Rescom[PosNAL] * RADDD_NAL

##################################################################################
# 2 Assign year for each guidelines 
##################################################################################
# Percentage of records with actual breakpoints values reported in the study
myTD$Breakpoint[myTD$Breakpoint == ""] = NA
print(paste0("Studies with Breakpoints = ",format(100 * sum(is.na(myTD$Breakpoint)==F)/nrow(myTD), digits = 4), "%"))

# Percentage of records with guidelines reported in the study
myTD$Guidelines[myTD$Guidelines == ""] = NA
print(paste0("Studies with guidelines = ",format(100 * sum(is.na(myTD$Guidelines)==F)/nrow(myTD), digits = 4), "%"))

# Percentage of studies without guidelines that reported BP values 
myNGTD = myTD[is.na(myTD$Guidelines) == T,]
print(paste0("Studies without Guidelines that reported BP = ",format(100 * sum(is.na(myNGTD$Breakpoint) == F) / nrow(myNGTD), digits = 2), "%"))

# Assign CLSI Guidelines to missing guidelines 
myT$Guidelines[is.na(myT$Guidelines)] = "CLSI" #CLSI assigned for unmentionned guidelines

# Define a Guidelines 4 letter code (include space for "SFM ")
myTD$GDID = substr(myTD$Guidelines, 1,4)

myTD$GDID[myTD$GDID == ""] = NA

myTD$GDYear = ifelse(myTD$GDID == "CLSI",substr(myTD$Guidelines,6,9),NA)
myTD$GDYear = ifelse(myTD$GDID == "EUCA",substr(myTD$Guidelines,8,11),myTD$GDYear)
myTD$GDYear = ifelse(myTD$GDID == "SFM ",substr(myTD$Guidelines,5,8),myTD$GDYear)

myTD$GDYear = as.numeric(myTD$GDYear)
print(paste0("Studies with year for guidelines = ",format(100 * sum(is.na(myTD$GDYear) == F)/nrow(myTD), digits = 4), "%"))

DiffPUBGD = as.numeric(myTD$PubDate)-myTD$GDYear

medianDelay = median(DiffPUBGD, na.rm = T)
myTD$GDYear[is.na(myTD$GDYear)] = as.numeric(myTD$PubDate[is.na(myTD$GDYear)]) - medianDelay

# Prevent assigning guidelines older than the first guidelines ever published  
myTD$GDYear = ifelse(((myTD$GDYear < 2005) * (myTD$GDID == "SFM")) == 1,2005,myTD$GDYear)
myTD$GDYear = ifelse(((myTD$GDYear < 2009) * (myTD$GDID == "EUCA")) == 1,2009,myTD$GDYear)

# Create unique identified for Method/Drug/Bug/Yeah/Guidelines
myTD$DBYID = paste(myTD$Method2C,myTD$ATC.Code,myTD$Pathogens,myTD$GDYear,myTD$GDID, sep = "_")
myTD$IDY = paste(myTD$Method2C,myTD$ATC.Code,myTD$Pathogens,myTD$GDID, sep = "_")
myTD$IDY_EUCA = myTD$IDYAGD = paste(myTD$Method2C,myTD$ATC.Code,myTD$Pathogens, sep = "_")

source("scripts/Bind_Breakpoints_Guidelines_v2.r")
myTD$BreakpointsGD = as.numeric(myGTT$Breakpoints[match(myTD$DBYID,myGTT$ID)])

# clean reported breakpoint. 
myTD$Breakpoint = gsub(" ","",myTD$Breakpoint)
myTD$Breakpoint = gsub(">","",myTD$Breakpoint)
myTD$Breakpoint = gsub("<","",myTD$Breakpoint)
myTD$Breakpoint = gsub("=","",myTD$Breakpoint)

myTD$Breakpoint = as.numeric(myTD$Breakpoint)
myTD$BreakpointC = ifelse(is.na(myTD$Breakpoint),myTD$BreakpointsGD,myTD$Breakpoint)
myTD$BreakpointRef = as.numeric(MinBP$MinBP[match(myTD$IDYAGD,MinBP$IDYAGD)])

print(paste0("Correction records = ",sum(myTD$BreakpointC  != myTD$BreakpointRef, na.rm = T)))
print(paste0("No correction needed records= ",sum(myTD$BreakpointC  == myTD$BreakpointRef, na.rm = T)))
print(paste0("No correction possible = ",nrow(myTD) - sum(myTD$BreakpointC  == myTD$BreakpointRef, na.rm = T) - sum(myTD$BreakpointC  != myTD$BreakpointRef, na.rm = T)))

source("scripts/EUCAST_MIC_DD_Dist_Load.r")

# Cieling values beyond range of MIC
myTD$BreakpointC[myTD$BreakpointC > 512] = 512 

myTD$MFR = rep(NA,nrow(myTD))
myTD$RescomC = rep(NA,nrow(myTD))

# Here we apply the correction to modulate resistance rates accoring to potential change of guidelines over time
for (k in 1:nrow(myTD)){
myTD$MFR[k] = ModulateFR2(BP= myTD$BreakpointC[k],BPref  = myTD$BreakpointRef[k], IDY_EUCA = myTD$IDY_EUCA[k])
myTD$RescomC[k] = myTD$Rescom[k] * myTD$MFR[k]  
}

# Keep rates between [0,100]
myTD$RescomC[myTD$RescomC>100] = 100
myTD$RescomC[myTD$RescomC<0] = 0

# Used uncorrected rate if correction led to absurd values
myTD$RescomC = ifelse(is.na(myTD$RescomC)==T,myTD$Rescom,myTD$RescomC)

# plot Final Results of Rates correction
# Plot cumulative curve of resistance rates 
par(mfrow = c(1,1))
par(mar = c(5,5,5,5))
plot(1:nrow(myTD),myTD$RescomC[order(myTD$Rescom)], lwd = 2, col = "red4",
     xlab = "Number of Observations (WHO List)",
     ylab = "Ranked Resistance Rate (%)",
     cex.axis = 2, cex.lab = 2, cex = 0.3)
points(1:nrow(myTD),myTD$Rescom[order(myTD$Rescom)], lwd = 2, col = "grey", cex = 0.3)

legend(0,90,c("Observed Resistance Rates","Corrected Resistance Rates"), fill = c("grey","red3"), bty = "n", cex = 1.5)
MeanDiffPct =  mean((myTD$RescomC-myTD$Rescom)/myTD$Rescom, na.rm = T)
abline(h = c(0,20,40,60,80,100), col = "lightgrey", lty = 3)
 
# aggregate %pct change after correction by drug/bug combination 
myTD$PctC = (myTD$RescomC-myTD$Rescom)/myTD$Rescom
myTD$ID_DBC = paste0(myTD$Pathogens,"_",myTD$ATC.Code)

PctDF = aggregate(PctC~ID_DBC, data = myTD, na.rm = T, FUN = mean)
PctDF$PctC = PctDF$PctC * 100
PctDF = PctDF[-which(abs(PctDF$PctC) < 1),]
barplot(PctDF$PctC[rev(order(PctDF$PctC))], names = PctDF$ID_DBC, space = 0, axes = F)
axis(2)

# now we need to go and assignt the breakpoint of the corresponsing year for each drug bug combination 

##################################################################################
# 3 Bias due to breakpoints (let's look at one example)
##################################################################################
# Let's focus on one combination E.coli/Ciprofloxacine
myTEcoliTET = subset(myTD, Compound == "CIP" & Pathogens == "Ecoli")

# The informaiton on the breakpoints used is very seldom. We will have to go through each CLSI/EUCAST guidelines for every year to retrieve the breakpoint used. 
# In the mean tim we are doing to rpetend that the Breakpoints were known to develop the correction methodology 

BPAD = 0.25
BPDD = 22

# Hypothetical breakpoints used. This cna be be non CLSI/EUCAsT breakpoint or 
# CLSI/EUCAST breakpoints from previous years 

myTEcoliTET$BreakpointN = ifelse(substr(myTEcoliTET$Breakpoint,1,1) %in% c(">","<","="),
                                 substr(myTEcoliTET$Breakpoint,2,nchar(myTEcoliTET$Breakpoint)),
                                 myTEcoliTET$Breakpoint)

myTEcoliTET$BreakpointN = ifelse(substr(myTEcoliTET$BreakpointN,1,1) %in% c(">","<","="),
                                 substr(myTEcoliTET$BreakpointN,2,nchar(myTEcoliTET$BreakpointN)),
                                 myTEcoliTET$BreakpointN)

myTEcoliTET$BreakpointN  = as.numeric(myTEcoliTET$BreakpointN)
myTEcoliTET$BreakpointN = ifelse(myTEcoliTET$BreakpointN == 0.06,0.064,myTEcoliTET$BreakpointN)

BPADobs = min(subset(myTEcoliTET, Method2C == "AD")$BreakpointN , na.rm = T)
BPDDobs = 9

# Identify Breakpoint for DD and AD

# MIC for AD 
MICs = c(0.002,0.004,0.008,0.016,0.032,0.064,0.125,0.25,0.5,1,2,4,8,16,32,64,128,256,512)
NSamplesMICs = c(14,189,3967,7300,1576,613,566,599,196,113,55,131,263,236,565,168,85,59,7) 
NSamplesMICs = NSamplesMICs/sum(NSamplesMICs)

# Distance of Inhibition for DD
DIs = c(6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50)
NSamplesDD = c(2916,7,42,44,64,79,94,72,70,33,28,25,39,68,95,127,248,395,443,497,609,994,1754,2690,4224,4514,4317,3609,2746,2195,1543,955,601,323,178,58,31,14,14,4,5,3,2,1,4)
NSamplesDD = NSamplesDD/sum(NSamplesDD)

par(mfrow = c(1,2))
par(mar = c(5,5,5,5))

plot(log2(MICs),NSamplesMICs, axes = F, xlab = "Minimum Inhibitory Concentration", ylab = "Samples (%)", cex = 0, main = "E.coli/Cipro")
polygon(x=c(log2(MICs),rev(log2(MICs))),y=c(NSamplesMICs,rep(0,length(NSamplesMICs))), border = NA, col = "lightgrey")
axis(1, at = log2(MICs), labels = MICs)
abline(v = log2(BPAD), lwd = 2 , col = "red4", lty = 3)
abline(v = log2(BPADobs), lwd = 2, col = "red4")

# For building polygon 
MICsCLSI = MICs[which(MICs >= BPAD)]
MICsObs = MICs[which(MICs >= BPADobs)]
NSamplesMICsCLSI = NSamplesMICs[which(MICs >= BPAD)]
NSamplesMICsObs = NSamplesMICs[which(MICs >= BPADobs)]


polygon(x=c(log2(MICsObs),rev(log2(MICsObs))),y=c(NSamplesMICsObs,rep(0,length(NSamplesMICsObs))), col = "coral1")
polygon(x=c(log2(MICsObs),rev(log2(MICsObs))),y=c(NSamplesMICsObs,rep(0,length(NSamplesMICsObs))), density = 20, angle = 45+90)

polygon(x=c(log2(MICsCLSI),rev(log2(MICsCLSI))),y=c(NSamplesMICsCLSI,rep(0,length(NSamplesMICsCLSI))), col = "coral3")
polygon(x=c(log2(MICsCLSI),rev(log2(MICsCLSI))),y=c(NSamplesMICsCLSI,rep(0,length(NSamplesMICsCLSI))), density = 20)


legend(-1.24,0.35, legend = c("Ref. Min. \nBreakpoint","Obs. \nBreakpoint"), col = "red3", bty = "n", lty = c(1,3))

plot(DIs,NSamplesDD, axes = F, xlab = "Inhibition diameter", ylab = "Samples (%)", cex = 0)
polygon(x=c(DIs,rev(DIs)),y=c(NSamplesDD,rep(0,length(NSamplesDD))), border = NA, col = "lightgrey")
axis(1, at = DIs, labels = DIs)
abline(v = BPDD, lwd = 2 , col = "red4")
abline(v = BPDDobs, lwd = 2,  col = "red4",lty = 3)

legend(32,.10, legend = c("Ref. \nBreakpoint","Obs. \nBreakpoint"), lty = c(1,3), col = "red4", bty = "n")

# For building polygon 
DDsCLSI = DIs[which(DIs <= BPDD)]
DDsObs = DIs[which(DIs <= BPDDobs)]
NSamplesDDsCLSI = NSamplesDD[which(DIs <= BPDD)]
NSamplesDDsObs = NSamplesDD[which(DIs <= BPDDobs)]

polygon(x=c((DDsCLSI),rev((DDsCLSI))),y=c(NSamplesDDsCLSI,rep(0,length(NSamplesDDsCLSI))), col = "navyblue")
polygon(x=c((DDsCLSI),rev((DDsCLSI))),y=c(NSamplesDDsCLSI,rep(0,length(NSamplesDDsCLSI))), density = 20, col = "white")

polygon(x=c((DDsObs),rev((DDsObs))),y=c(NSamplesDDsObs,rep(0,length(NSamplesDDsObs))), col = "cornflowerblue")
polygon(x=c((DDsObs),rev((DDsObs))),y=c(NSamplesDDsObs,rep(0,length(NSamplesDDsObs))), density = 20, angle = 45+90)

# Here the goal should be to get to a vector of co0rrecte rates "RescomC"

# Modulate samples size based on EQAS uncertainty levels
source("/Users/thomavan/Dropbox/resbank/scripts/EQASmodulation.r")
myTD$minGDYear = ifelse(myTD$GDYear < 2000, 2000, myTD$GDYear)
myTD$minGDYear = ifelse(is.na(myTD$minGDYear)==T, myTD$PubDate, myTD$minGDYear)

myTD$EQASID = paste0(myTD$SubRegion,"_",myTD$Pathogen,"_",myTD$minGDYear)
myTD$Accuracy = 0.01 * myEQ$Accuracy[match(myTD$EQASID,myEQ$EQASID)]

myTD$NsamplesEQAS = round(myTD$Nsamples * myTD$Accuracy)
