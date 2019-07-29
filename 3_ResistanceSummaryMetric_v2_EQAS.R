# Build summary metric of resistance in each location for each pathogen. 
########################################################################

# Convert resistance to proportions
myTD$RescomP = round(myTD$RescomC) / 100

# Define a summary metric or resistance (and check which one leads ot the correation/best maps a posteriori)
XYTable = NULL
PathID = c("Ecoli","Salmonella","Campylobacter","Staphylococcus")
SpeciesID = c("Chicken","Pig","Cattle")

for (i in 1:length(PathID)){
  
  myTNZs = subset(myTD, Pathogens == PathID[i])

  for (ii in 1:length(unique(myTNZs$XCoord))){
    
    myTNZss = subset(myTNZs, XCoord == unique(myTNZs$XCoord)[ii])
    
    for (iii in 1:length(SpeciesID)){
      tmp = subset(myTNZss, Species == SpeciesID[iii])
      #pool species 
      #tmp = myTNZsss
      
      if(nrow(tmp)>0){
        
        #Define summary metrics 
        tmpMeanAlldrug = mean(tmp$RescomP, na.rm = T)
        tmpPN50 = sum(tmp$RescomP>.5, na.rm = T) / nrow(tmp)
        tmpPN10 = sum(tmp$RescomP>.1, na.rm = T) / nrow(tmp)
        
        tmpNMsamples = round(mean(tmp$Nsamples))
        tmpNMsamplesEQAS = round(mean(tmp$NsamplesEQAS))
        
        SMetrics = as.data.frame(cbind(tmpMeanAlldrug,tmpPN50,tmpPN10,tmpNMsamples,tmpNMsamplesEQAS))
        names(SMetrics) = c("MeanAlldrug","PN50","PN10","NMsamples","NMsamplesEQAS")
        tmpXYTable = cbind(tmp[c("DOI","ISO3","Continent","PubDate","Pathogens","Species","XCoord","YCoord","Prev")][1,],SMetrics)
        XYTable = rbind(XYTable,tmpXYTable)
      }
      
    }
  }
  
}

# Trial to restrict the analysis to those that had at least on drug resistant 
XYTable$MeanAlldrug[is.finite(XYTable$MeanAlldrug)==F] = NA
XYTable$MeanAlldrug[is.finite(XYTable$MeanAlldrug)==F] = NA
XYTable$L10NMsamples = log10(XYTable$NMsamples+1)
XYTable$L10NMsamplesEQAS = log10(XYTable$NMsamplesEQAS+1)
XYTable$PubDate = as.numeric(XYTable$PubDate)
#XYTable$PN50 = XYTable$MeanAlldrug
write.csv(XYTable, file = "/Users/thomavan/Dropbox/resbank/data/XYTable.csv")
# Make plost of PN50 over time
source('scripts/PN50time_GLM.r')

####### Visual Check of summary metric of resistance 
ColsRes = colorRampPalette(brewer.pal(9,"Reds"))(101)
par(mfrow = c(1,1))
par(mar = c(0,0,0,0))
plot(mySHP, col = "grey90", border = "white", lwd = 0.3)
plot(mySHPLMICs, col = "darkgrey", border = "white", lwd = .5,add = T)
points(XYTable$XCoord,XYTable$YCoord, pch = 16, col = ColsRes[round(100*XYTable$PN50)+1], cex = 0.8*log10(XYTable$NMsamples+1))

points(seq(-160,-100,(60/10)),rep(-10,11),col = ColsRes[seq(1,101,10)], pch = 16, cex = 1.5)
text(-160,-2,"0", cex = 2)
text(-100,-2,"1", cex = 2)
text(-135,-25,"Proportion of drugs \nwith 50% resistance", cex = 2)
text(-160,40,"A",cex = 5)

# Visual check on Individual countries 
par(mfrow = c(1,3))
par(mar = c(0,0,0,0))

mySHPBRAadm1 = shapefile("/Users/thomavan/Dropbox/resbank/data/BRA_adm_shp/BRA_adm1.shp")
mySHPETHadm1 = shapefile("/Users/thomavan/Dropbox/resbank/data/ETH_adm_shp/ETH_adm1.shp")
mySHPINDadm1 = shapefile("/Users/thomavan/Dropbox/resbank/data/IND_adm_shp/IND_adm1.shp")

# Brazil
########
mySHPS = mySHP[which(mySHP@data$ISO3 == "BRA"),]
plot(mySHPS, col = "darkgrey",border = "white")
plot(mySHPBRAadm1, add = T, col = NA, border = "white")
myPTSBra = subset(XYTable, ISO3 == "BRA")
points(myPTSBra$XCoord,myPTSBra$YCoord, pch = 16, col = ColsRes[round(100*myPTSBra$PN50)+1], cex = 2*log10(myPTSBra$NMsamples+1))
text(-68.07625,-28.22701,"B",cex = 5)

#points(seq(-70,-60,1),rep(-20,11),col = ColsRes[seq(1,101,10)], cex = 3, pch = 16)
#text(-70,-18,"0", cex = 2)
#text(-60,-18,"1", cex = 2)
#text(-65,-23,"Proportion of drugs tested \nwith 50% resistance", cex = 2)

########
# Ethiopia
########
mySHPS = mySHP[which(mySHP@data$ISO3 == "ETH"),]
plot(mySHPS, col = "darkgrey",border = "white")
plot(mySHPETHadm1, add = T, col = NA, border = "white")
myPTSEth = subset(XYTable, ISO3 == "ETH")
points(myPTSEth$XCoord,myPTSEth$YCoord, pch = 16, col = ColsRes[round(100*myPTSEth$PN50)+1], cex = 2*log10(myPTSEth$NMsamples+1))
text(33.78842,4.150,"C",cex = 5)

########
# India
########
mySHPS = mySHP[which(mySHP@data$ISO3 == "IND"),]
plot(mySHPS, col = "darkgrey",border = "white")
plot(mySHPINDadm1, add = T, col = NA, border = "white")
myPTSInd = subset(XYTable, ISO3 == "IND")
points(myPTSInd$XCoord,myPTSInd$YCoord, pch = 16, col = ColsRes[round(100*myPTSInd$PN50)+1], cex = 2*log10(myPTSInd$NMsamples+1))
text(69.49681,12.5029,"D",cex = 5)



