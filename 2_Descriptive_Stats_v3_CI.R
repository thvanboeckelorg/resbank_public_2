# Average resistance by drug class and species accross continents 
################################################################################
# Resistance by WHO drug and Region
################################################################################
pdf(
  file = "/Users/thomavan/Dropbox/resbank/Figures/Figure_4.pdf",
  width = 26,
  height = 14,
  bg = "white"
)
par(mar = c(4,5,4,4))
par(mfrow = c(4,3))

# read drug IDs
DrugIDTable = read.csv("/Users/thomavan/Dropbox/resbank/data/who_list_drugs.csv", sep = "\t", stringsAsFactors = F)
DrugIDTable$ATC_Code[18] = "J01CA17"
DrugIDTable$ATC_Code = gsub(" ","",DrugIDTable$ATC_Code)

names(DrugIDTable) = c("Compound","Name","ATC_Code","WHO_Ecoli","WHO_Salmonella","WHO_Staphylococcus","WHO_Campylobacter")
DrugIDTable$Compound = as.character(DrugIDTable$Compound)
NPubsM = matrix(NA,length(PathID),3)

SpeciesID = c("Cattle","Chicken","Pig")
DrugIDM = list(
as.character(DrugIDTable$Compound[which(DrugIDTable[4] == "yes")]),
as.character(DrugIDTable$Compound[which(DrugIDTable[5] == "yes")]),
as.character(DrugIDTable$Compound[which(DrugIDTable[7] == "yes")]),
as.character(DrugIDTable$Compound[which(DrugIDTable[6] == "yes")])
)

DrugIDM = list(
  as.character(DrugIDTable$Compound[((DrugIDTable[4] == "yes")*(DrugIDTable[8] == "no"))==1]),
  as.character(DrugIDTable$Compound[((DrugIDTable[5] == "yes")*(DrugIDTable[9] == "no"))==1]),
  as.character(DrugIDTable$Compound[((DrugIDTable[7] == "yes")*(DrugIDTable[11] == "no"))==1]),
  as.character(DrugIDTable$Compound[((DrugIDTable[6] == "yes")*(DrugIDTable[10] == "no"))==1])
)
PathID = unique(myTD$Pathogens)
Continents = unique(myTD$Continent)

DrugTextM = NULL


for(k in 1:length(PathID)){
  
  myTPath = subset(myTD, Pathogens == PathID[k])
  
  for(j in 1:length(Continents)){
    
    myTPathCont = subset(myTPath, Continent == unique(myTD$Continent)[j])
    myTPathContWHO = myTPathCont[myTPathCont$Compound %in% DrugIDM[[k]],]
    NPubs = length(unique(myTPathContWHO$DOI))
    NPubsM[k,j] = NPubs

    myAT = aggregate(RescomC ~ Compound + Species, data = myTPathContWHO, FUN = mean)
    myATsd = aggregate(RescomC ~ Compound + Species, data = myTPathContWHO, FUN = sd)
    
    myTPathContWHO$Count = rep(1,nrow(myTPathContWHO))
    myATCount = aggregate(Count ~ DOI+ Compound + Species, data = myTPathContWHO, FUN = sum)
    
    myATCount$Count = rep(1,nrow(myATCount))
    myATCount2 = aggregate(Count ~ Compound + Species, data = myATCount, FUN = sum)
    
    # Get proportion of studies represenetd in each bar 
    AllDFalpha = as.data.frame(matrix(NA,ncol = length(DrugIDM[[k]]),nrow = length(SpeciesID)))
    row.names(AllDFalpha) = SpeciesID
    names(AllDFalpha) = DrugIDM[[k]]
    
    for(i in 1:length(SpeciesID)){
    myST = subset(myATCount2, Species == SpeciesID[i])
    AllDFalpha[i,] = myST$Count[match(DrugIDM[[k]],myST$Compound)]
    DrugTextV = c(PathID[k],unique(myTD$Continent)[j],SpeciesID[i],paste0(myST$Compound,"(n=",myST$Count,")",collapse = ","))
    DrugTextM = rbind(DrugTextM,DrugTextV)
    }
    
    AllDFalpha = AllDFalpha/10
    AllDFalpha[AllDFalpha>1] = 1
    
    # Get resistance for each species/drug combination
    AllDF = as.data.frame(matrix(NA,ncol = length(DrugIDM[[k]]),nrow = length(SpeciesID)))
    row.names(AllDF) = SpeciesID
    names(AllDF) = DrugIDM[[k]]
    
    AllDFsd = as.data.frame(matrix(NA,ncol = length(DrugIDM[[k]]),nrow = length(SpeciesID)))
    row.names(AllDFsd) = SpeciesID
    names(AllDFsd) = DrugIDM[[k]]
    
    for(i in 1:length(SpeciesID)){
      myST = subset(myAT, Species == SpeciesID[i])
      mySTsd = subset(myATsd, Species == SpeciesID[i])
      AllDF[i,] = myST$RescomC[match(DrugIDM[[k]],myST$Compound)]
      AllDFsd[i,] = mySTsd$RescomC[match(DrugIDM[[k]],mySTsd$Compound)]
      
    }
    
    # Remove small species
    Cols = c("darkgreen","orange","pink")
    colMeans(AllDF)
    
    AllDFold = AllDF
    
    AllDF = AllDF[,rev(order(colMeans(AllDFold, na.rm = T)))]
    AllDFalpha = AllDFalpha[,rev(order(colMeans(AllDFold, na.rm = T)))]
    AllDFsd = AllDFsd[,rev(order(colMeans(AllDFold, na.rm = T)))]
    
    cs = colSums(AllDF, na.rm = T)
    AllDF = AllDF[,cs>0]
    AllDFalpha = AllDFalpha[,cs>0]
    AllDFsd = AllDFsd[,cs>0]
    
    AllDF[is.na(AllDF)] = 0
    AllDFalpha[is.na(AllDFalpha)] = 0
    AllDFsd[is.na(AllDFsd)] = 0
    
    # Fix to avoid too high transparency levels 
    ColsM = rep(Cols,ncol(AllDF))
    ColsMA = addalpha(ColsM,as.vector(as.matrix(AllDFalpha)))
    ColsMA_CI = addalpha(rep(c("grey","grey","grey"),ncol(AllDF)),as.vector(as.matrix(AllDFalpha)))
    ColsMA_CIM = matrix(ColsMA_CI, nrow = 3, ncol = ncol(AllDF))
    
    if( k==1 & j==1){
    barplot(as.matrix(AllDF), beside = T, col = ColsMA, border = F, ylim = c(0,100), cex.names = 1.5, cex.axis = 2, 
    #main = paste0(unique(myT$Continent)[j]," - ",unique(myT$Pathogens)[k],"\n (n = ",NPubs,")"), 
    main=substitute({bold(nj) - italic(ni)},list(ni=paste0(PathID[k]," (n = ",NPubs,")"), nj = Continents[j])),
    cex.main = 2, ylab = "Resistance (%)", cex.lab = 2, las = 2)
    x =  barplot(as.matrix(AllDF), beside = T, plot = FALSE)
    High = as.matrix(AllDF) + as.matrix(AllDFsd)
    High[High > 100] = 100
    Low = as.matrix(AllDF) - as.matrix(AllDFsd)
    Low[Low < 0] = 0
    
      for (b in 1:3){
      segments(x[b,],High[b,],x[b,],Low[b,], col = ColsMA_CIM[b,])
      #segments(x[b,],High[b,],x[b,],Low[b,], col = "grey")
        
      }
    } else {
    barplot(as.matrix(AllDF), beside = T, col = ColsMA, border = F, ylim = c(0,100), cex.names = 1.5, cex.axis = 2, 
    #main = paste0(unique(myT$Continent)[j]," - ",unique(myT$Pathogens)[k],"\n (n = ",NPubs,")"), 
    main=substitute({bold(nj) - italic(ni)},list(ni=paste0(PathID[k]," (n = ",NPubs,")"), nj = Continents[j])),
    cex.main = 2, las = 2)
    x =  barplot(as.matrix(AllDF), beside = T, plot = FALSE)
    High = as.matrix(AllDF) + as.matrix(AllDFsd)
    High[High > 100] = 100
    Low = as.matrix(AllDF) - as.matrix(AllDFsd)
    Low[Low < 0] = 0
    
      for (b in 1:3){
        segments(x[b,],High[b,],x[b,],Low[b,], col = ColsMA_CIM[b,])
        #segments(x[b,],High[b,],x[b,],Low[b,], col = "grey")
        
      }
    }
    abline(h = seq(0,100,20), col = "grey", lty = 3)
    if( k==1 & j==1){legend(25,90,legend = c("Cattle","Chicken","Pigs"), fill = Cols, bty = 'n', cex = 2.5, horiz = T)}
  }
  
}
DrugTextM = as.data.frame(DrugTextM, stringsAsFactors = F, row.names = NA)
names(DrugTextM) = c("Pathogen","Continent","Species","Studies per compound")
# Here we write Table S6 with the number of surveys per pathogens, host species, continent and antimicrobial compound. 
write.table(DrugTextM, "/Users/thomavan/Dropbox/resbank/data/Fig1Table.txt", sep = "\t", quote = F, row.names = F)
#legend(5,120,legend = c("Cattle","Chicken","Pigs"), fill = Cols, bty = 'n', cex = 1, horiz = T)
dev.off()
# Export Table for SM with the number of surveys per continent/species/bacterium combination 
################################################################################
pdf(
  file = "/Users/thomavan/Dropbox/resbank/Figures/Figure_1.pdf",
  width = 17,
  height = 9.2,
  bg = "white"
)
par(mar = c(5,5,5,1))
par(mfrow = c(1,2))

# Number of publications over time 
myT$count = rep(1,nrow(myT)) 
ADF = aggregate(count ~ DOI+PubDate+Continent, data = myT, FUN = sum)
ADF$count = rep(1,nrow(ADF))
Continents = unique(myT$Continent)
myT$PubDate = as.numeric(myT$PubDate)
myM = t(matrix(NA,(max(myT$PubDate, na.rm = T)-min(myT$PubDate, na.rm = T))+1,length(Continents)))
colnames(myM) = min(myT$PubDate, na.rm = T):max(myT$PubDate, na.rm = T)

# Calculate the number of surveys per country (for results section)
ADISO = aggregate(count ~ DOI+ISO3, data = myT, FUN = sum)
ADISO$count = rep(1,nrow(ADISO))

ADISOtot = aggregate(count ~ ISO3, data = ADISO, FUN = sum)
ADISOtot$areaKm = area(mySHP)[match(ADISOtot$ISO3,mySHP@data$ISO3)]  / 1e6

# number of PPS per country
print(ADISOtot$count[ADISOtot$ISO3 %in% c("ETH","MAR","KEN","THA")])

# number of PPS per 100000 square kilometers 
ADISOtot$PPS1000km = 100000 * (ADISOtot$count / ADISOtot$area)

print(ADISOtot$PPS1000km[ADISOtot$ISO3 %in% c("ETH","MAR","KEN","THA")])

for (i in 1:length(Continents)){
AADF = aggregate(count ~ PubDate, data = subset(ADF, Continent == Continents[i]), FUN = sum)
match(AADF$PubDate,colnames(myM))
myM[i,match(AADF$PubDate,colnames(myM))] = AADF$count
}

myM[is.na(myM)] = 0
barplot(myM, col = c("black","orange","red"), ylab = "Publications on AMR in animals", cex.lab = 2, cex.axis =2, cex.names = 2, space = 0, border = "white", font = 1)
legend(1,125, legend = c("Africa","Asia","Americas"),fill =  c("black","orange","red"), bty = "n", cex = 2)
text(1,140,font = 2,"A",cex = 6)

print(paste0("number of publication in 2000 = ",colSums(myM)[1]))
print(paste0("number of publication in 2017 = ",colSums(myM)[18]))
print(paste0("number of publication in 2018 = ",colSums(myM)[19]))

print(paste0("Surveys in Asia : ",rowSums(myM)[2]))
print(paste0("Surveys in Americas : ",rowSums(myM)[1]+rowSums(myM)[3]))


# Number of Studies by Country
NPCountry = rep(NA,length(unique(myT$ISO3)))

for (i in 1:length(unique(myT$ISO3))){
  NPCountry[i] = length(unique(subset(myT, ISO3 == unique(myT$ISO3)[i])$DOI))
}

NPdf = as.data.frame(cbind(NPCountry,unique(myT$ISO3)), stringsAsFactors = F)
names(NPdf) = c("publications","ISO3")
NPdf$Continent = myT$Continent[match(NPdf$ISO3,myT$ISO3)]

# rEmove granade 
NPdf = NPdf[-which(NPdf$ISO3 == "GRD"),]

ContCol = as.data.frame(cbind(c("Africa","Americas","Asia"),c("black","red","orange")))
names(ContCol) = c("Continent","color")
NPdf$ContinentCol = as.character(ContCol$color[match(NPdf$Continent,ContCol$Continent)])

NPdf$publications = as.numeric(NPdf$publications)
NPdf$ISO3 = as.character(NPdf$ISO3)

myGDP = read.csv("/Users/thomavan/Dropbox/resbank/covariates/gdp_ppp_2016.csv")
myGDP$ISO3 = as.character(myGDP$ISO3)
NPdf$gdp2016 = myGDP$GDP_2016[match(NPdf$ISO3,myGDP$ISO3)]

myPop = read.csv("/Users/thomavan/Dropbox/resbank/data/pop_2016.csv")
myPop$ISO3 = as.character(myPop$ISO3)
NPdf$pop2016 = myPop$X2016[match(NPdf$ISO3,myPop$ISO3)]

NPdf$PubPop = NPdf$publications/NPdf$pop2016

# Parallel figures 
par(mar = c(5,5,5,0))
plot((NPdf$gdp2016),log10(NPdf$PubPop), cex = 0, xlab = "GDP per capita $US (2016)", ylab = "log[surveys per capita]", cex.axis = 2, cex.lab = 2, xlim = c(0,16500), axes = F)
axis(1, at = c(0,5000,10000,15000), labels = c("0","5,000","10,000","15,000"), cex.lab = 2, cex.axis = 2)
axis(2, at = c(-8,-7,-6,-5,-4),labels = rev(c("1/10,000","1/100,000","1/1e-6","1/1e-7","1e-8")), cex.axis = 2)
text((NPdf$gdp2016),log10(NPdf$PubPop),NPdf$ISO3, col = NPdf$ContinentCol, font = 2, cex = 1.5)
text(1000,-5.4,font = 2,"B",cex = 6)
dev.off()
################################################################################
# Needs re-order the dataframe 
################################################################################
# 3. Correlation between resistance patterns
################################################################################
# Look for correlation for patterns of resistance between drugs for the same pathogens 
par(mfrow = c(2,2))
par(mar = c(1,1,1,1))

for (k in 1:4){
WHODrugList = DrugIDM[[k]]
myST = subset(myTD, Pathogens == PathID[k])
mySST = myST[myST$Compound %in% WHODrugList,]

DOIs = unique(mySST$DOI)
myCM = matrix(NA,length(DOIs),length(WHODrugList))

for(i in 1:length(DOIs)){

    for (ii in 1:length(WHODrugList)){
    
    tmp = mySST[((mySST$DOI == DOIs[i]) * (mySST$Compound == WHODrugList[ii]))==T,]
    if(nrow(tmp)>0){  myCM[i,ii] = mean(tmp$RescomC, na.rm = T) }
    
  }

}

# remove drug for which we do not have at least 10 points 
myCMP = myCM[,colSums(myCM>0, na.rm = T)>10]
WHODrugListP = WHODrugList[colSums(myCM>0, na.rm = T)>10]

corCM = cor(myCMP, use = "pairwise.complete.obs")
corCM[is.na(corCM)] = 0
corCM[upper.tri(corCM, diag = T)]=NA

corCMR <- raster(nrows=ncol(myCMP), ncols=ncol(myCMP), xmn=0, xmx=ncol(myCMP),ymn=0, ymx=ncol(myCMP))
corCMR[] = corCM
corCMRx = flip(corCMR, direction='y')


plot(NULL, xlim = c(-2,ncol(myCMP)+2), ylim = c(-2,ncol(myCMP)+2), asp = 1, axes = F, xlab = "", ylab = "", main = paste0(PathID[k]," (n= ",length(unique(myST$DOI)),")"))
text(rep(0,ncol(myCMP))-0.5,(1:ncol(myCMP))-0.5,(WHODrugListP), cex = 0.9)
#text((1:ncol(myCMP))-0.5,rep(0,ncol(myCMP))-0.5,(WHODrugListP), cex = 0.9)
text((1:ncol(myCMP))-0.5,rep(ncol(myCMP)+1.5,ncol(myCMP))-0.5,(WHODrugListP), cex = 0.9)
plot(corCMRx, col = rev(brewer.pal(9,"RdBu")), zlim = c(-1,1), xlim = c(-5,ncol(myCMP)+2), ylim = c(-5,ncol(myCMP)+2), asp = 1, add = T, axes = F)
}


