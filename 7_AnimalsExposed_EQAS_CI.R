# load raster stack with animals densities 
myRS = stack("/Users/thomavan/Dropbox/resbank/data/predStackl10")
myRS = dropLayer(myRS,2)
# Drop X,Y coordinates layersm, as well as the livestock production systems 
#myRS = myRS[[2:(nlayers(myRS)-3)]]
proj4string(myRS) = CRS("+proj=longlat +datum=WGS84")
names(myRS) = c("use","acc","tmp","irg","PgExt","PgInt","ChExt","ChInt","Ca","veg")

# Load Shapefile
mySHP = shapefile("/Users/thomavan/Dropbox/AAuse/data/World.shp")

# Load P50 & CI 95
myUKp = raster("/Users/thomavan/Dropbox/resbank/data/outputs/P50_10k_EQAS_2018")
#Uncertainty = raster("/Users/thomavan/Dropbox/resbank/data/outputs/P10_ci_10k_EQAS_2018.gri")

TrendSD = raster("/Users/thomavan/Dropbox/resbank/data/outputs/P50TrendSD_EQAS_2018")
SpatialSD = raster("/Users/thomavan/Dropbox/resbank/data/outputs/P50SpatialSD_EQAS_2018")

#Create htospots map
myHotspots = myUKp > .4

#Calculate mean spatial uncertianty in the hotspots
myHotspotsSpatialSD = myHotspots * SpatialSD
MeanSpatialSDinHS = mean(myHotspotsSpatialSD[],na.rm = T)
Uncertainty = 1.96 * (TrendSD+MeanSpatialSDinHS)

# Calculate the Confidence Interval on the hotspots
myHotspotsUP = (myUKp + Uncertainty) > .4
myHotspotsLO = (myUKp - Uncertainty) > .4

  # Calculate hotspots using Getis-Ord method (anbandonend because it yield simialr results as using the threhold P50>0.4) 
  source("scripts/7_1_Hotspot_Getis_Ord.r")


  #par(mfrow = c(1,1))
  #par(mar = c(1,1,1,1))
  #mySHPExt = mySHP[mySHP@data$ISO3 %in% c("CHN","IND","IRN"),]
  #mySHPAsia = mySHP[mySHP@data$CONTINENT %in% c("Asia"),]
  #plot(mySHPExt)
  #plot(myHotspotsUP, col = c(NA,"darkgreen"), add=T, box = F, legend = F, axes = F)
  #plot(myHotspots, col = c(NA,terrain.colors(3)[1]), add=T, box = F, legend = F, axes = F)
  #plot(myHotspotsLO, col = c(NA,"lightgreen"), add=T, box = F, legend = F, axes = F)
  #plot(mySHPAsia,add=T)
  #legend(41,12,legend = c("AMR Hotspot (P50 <.4)","Minimum extent","Maximum extent"),fill = c(terrain.colors(3)[1],"lightgreen","darkgreen"), cex = 1.5, bty = "n", bg = "white")


# Calculate Proportion of Animals raised in hotspots 
####################################################
# Proportion of 
PgR = sum((10^myRS[[5]])-1, (10^myRS[[6]])-1,na.rm = T)
ChR = sum((10^myRS[[7]])-1, (10^myRS[[8]])-1,na.rm = T)
CaR = (10^myRS[[9]])

PgRHS = PgR * myHotspots
ChRHS = ChR * myHotspots
CaRHS = CaR * myHotspots

PgRHSUP = PgR * myHotspotsUP
ChRHSUP = ChR * myHotspotsUP
CaRHSUP = CaR * myHotspotsUP

PgRHSLO = PgR * myHotspotsLO
ChRHSLO = ChR * myHotspotsLO
CaRHSLO = CaR * myHotspotsLO

PropPgHS = sum(PgRHS[], na.rm = T) / sum(PgR[],na.rm = T)
PropChHS = sum(ChRHS[], na.rm = T) / sum(ChR[],na.rm = T)
PropCaHS = sum(CaRHS[], na.rm = T) / sum(CaR[],na.rm = T)

PropPgHSUP = sum(PgRHSUP[], na.rm = T) / sum(PgR[],na.rm = T)
PropChHSUP = sum(ChRHSUP[], na.rm = T) / sum(ChR[],na.rm = T)
PropCaHSUP = sum(CaRHSUP[], na.rm = T) / sum(CaR[],na.rm = T)

PropPgHSLO = sum(PgRHSLO[], na.rm = T) / sum(PgR[],na.rm = T)
PropChHSLO = sum(ChRHSLO[], na.rm = T) / sum(ChR[],na.rm = T)
PropCaHSLO = sum(CaRHSLO[], na.rm = T) / sum(CaR[],na.rm = T)

print("Global proportions")
print(paste0("Chicken = ",format(PropChHS, digits = 2),"[",format(PropChHSLO,digits = 2),":",format(PropChHSUP,digits = 2),"]"))
print(paste0("Pigs = ",format(PropPgHS, digits = 2),"[",format(PropPgHSLO,digits = 2),":",format(PropPgHSUP,digits = 2),"]"))
print(paste0("Cattle = ",format(PropCaHS, digits = 2),"[",format(PropCaHSLO,digits = 2),":",format(PropCaHSUP,digits = 2),"]"))


# plot proportion of chicken production carried out in hotspots (no CI here)
CTYID = c("EGY","CHN","IND","TUR","IDN")

# Proportion of chicken raised in hotspots
for (i in 1:length(CTYID)){
  
  mySHPBRAadm0 = mySHP[mySHP@data$ISO3 == CTYID[i],]
  ChRHSBra = crop(ChRHS,extent(mySHPBRAadm0))
  ChRHSBraUP = crop(ChRHSUP,extent(mySHPBRAadm0))
  ChRHSBraLO = crop(ChRHSLO,extent(mySHPBRAadm0))
  
  
  ChRBra = crop(ChR,extent(mySHPBRAadm0))
  PropChHSBra = sum(ChRHSBra[], na.rm = T) / sum(ChRBra[],na.rm = T)
  PropChHSBraUP = sum(ChRHSBraUP[], na.rm = T) / sum(ChRBra[],na.rm = T)
  PropChHSBraLO = sum(ChRHSBraLO[], na.rm = T) / sum(ChRBra[],na.rm = T)
  
  
  print(paste0(CTYID[i]," - ",format(PropChHSBra,digits = 2),"[",format(PropChHSBraUP,digits = 2),";",format(PropChHSBraLO,digits = 2),"]"))  

}

###############################################################
# Figure S11
# Define Country level metrics of exposure for pigs and chicken  
###############################################################
mySHPLMICs@data$ExposureCh = extract(ChR * myUKp,mySHPLMICs, fun = sum, na.rm = T) 
mySHPLMICs@data$ChTOT = extract(ChR,mySHPLMICs, fun = sum, na.rm = T)
mySHPLMICs@data$ExposurePerCH = format(mySHPLMICs@data$ExposureCh / mySHPLMICs@data$ChTOT, digits = 3)
ListRankedCountriesCH = (mySHPLMICs@data[c("NAME","CONTINENT","ExposurePerCH","ChTOT")][rev(order(mySHPLMICs@data$ExposurePerCH)),])
ListRankedCountriesTopCH = ListRankedCountriesCH[c("NAME","CONTINENT","ExposurePerCH")][ListRankedCountriesCH$ChTOT > 10e6,]
ListRankedCountriesTopCH$ExposurePerCH = as.numeric(ListRankedCountriesTopCH$ExposurePerCH)

ListRankedCountriesTopCH$CONTINENTCol = rep(NA,nrow(ListRankedCountriesTopCH))
ListRankedCountriesTopCH$CONTINENTCol[ListRankedCountriesTopCH$CONTINENT == "Africa"] = "black"
ListRankedCountriesTopCH$CONTINENTCol[ListRankedCountriesTopCH$CONTINENT == "Asia"] = "orange"
ListRankedCountriesTopCH$CONTINENT[ListRankedCountriesTopCH$CONTINENT == "North America"] = "Americas"
ListRankedCountriesTopCH$CONTINENT[ListRankedCountriesTopCH$CONTINENT == "South America"] = "Americas"
ListRankedCountriesTopCH$CONTINENTCol[ListRankedCountriesTopCH$CONTINENT == "Americas"] = "red"

mySHPLMICs@data$ExposurePg = extract(PgR * myUKp,mySHPLMICs, fun = sum, na.rm = T) 
mySHPLMICs@data$PgTOT = extract(PgR,mySHPLMICs, fun = sum, na.rm = T)
mySHPLMICs@data$ExposurePerPg = format(mySHPLMICs@data$ExposurePg / mySHPLMICs@data$PgTOT, digits = 3)
ListRankedCountriesPG = (mySHPLMICs@data[c("NAME","CONTINENT","ExposurePerPg","PgTOT")][rev(order(mySHPLMICs@data$ExposurePerPg)),])
ListRankedCountriesTopPG = ListRankedCountriesPG[c("NAME","CONTINENT","ExposurePerPg")][ListRankedCountriesPG$PgTOT > 2e5,]
ListRankedCountriesTopPG$ExposurePerPG = as.numeric(ListRankedCountriesTopPG$ExposurePerPg)

ListRankedCountriesTopPG$CONTINENTCol = rep(NA,nrow(ListRankedCountriesTopPG))
ListRankedCountriesTopPG$CONTINENTCol[ListRankedCountriesTopPG$CONTINENT == "Africa"] = "black"
ListRankedCountriesTopPG$CONTINENTCol[ListRankedCountriesTopPG$CONTINENT == "Asia"] = "orange"
ListRankedCountriesTopPG$CONTINENT[ListRankedCountriesTopPG$CONTINENT == "North America"] = "Americas"
ListRankedCountriesTopPG$CONTINENT[ListRankedCountriesTopPG$CONTINENT == "South America"] = "Americas"
ListRankedCountriesTopPG$CONTINENTCol[ListRankedCountriesTopPG$CONTINENT == "Americas"] = "red"


# Produce Figure S11
par(mar = c(9,5,1,5))
par(mfrow = c(2,1))
barplot(ListRankedCountriesTopCH$ExposurePerCH, col = ListRankedCountriesTopCH$CONTINENTCol, names = ListRankedCountriesTopCH$NAME, las = 2, ylab = "AMR Exposure", cex.names = 1)
legend(17,0.5,legend = c("Asia","Americas","Africa"), fill = c("orange","red","black"), bty = "n", horiz = T, cex = 2)
text(nrow(ListRankedCountriesTopCH),0.3,"A",cex = 5, pos=4)
barplot(ListRankedCountriesTopPG$ExposurePerPG, col = ListRankedCountriesTopPG$CONTINENTCol, names = ListRankedCountriesTopPG$NAME, las = 2, ylab = "AMR Exposure", cex.names = 1)
text(nrow(ListRankedCountriesTopPG),0.3,"B",cex = 5, pos=4)








