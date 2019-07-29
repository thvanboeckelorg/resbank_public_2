#############################
# Load Layers
############################
# Shapefiles
mySHP = shapefile("/Users/thomavan/Dropbox/AAuse/data/World.shp")
mySHPLMICs = mySHP[(mySHP@data$ISO3 %in% c("USA","CAN","RUS","KOR","JPN","AUS","NZL","GRL") == F),]
mySHPLMICs = mySHPLMICs[(mySHPLMICs@data$CONTINENT != "Europe"),]
mySHPLMICs = mySHPLMICs[mySHPLMICs@data$CONTINENT %in% c("North America","South America","Africa","Asia"),]
# Read Points
XYTable = read.csv("/Users/thomavan/Dropbox/resbank/data/XYTable.csv")

# Mask
myPMaskc = raster("/Users/thomavan/Dropbox/resbank/data/plot_mask")

# P50
myUKp50 = raster("/Users/thomavan/Dropbox/resbank/data/outputs/P50_10k_EQAS_2018")

# P50 Uncertainty
Uncertainty = raster("/Users/thomavan/Dropbox/resbank/data/outputs/P50_ci_10k_EQAS_2018")

# P10
myUKp10 = raster("/Users/thomavan/Dropbox/resbank/data/outputs/P10_10k_EQAS_2018")

# Difference in P10 and P50
#myUKp10 = resample(myUKp10,myUKp50) # necessary fro different extent
myUKp10min50 = myUKp10-myUKp50
myUKp10min50[][myUKp10min50[] > .60] = .60

# Define LMIC mask 
myPMaskcLMICs = crop(myPMaskc,extent(c(-118,140,-57,57)))

# Define color scales 
ColsRes = colorRampPalette(brewer.pal(9,"Reds"))(120)[1:100]

LS = ColsRes

ColsRes = c(LS[seq(1,40,2)],LS[seq(40,60,6)],LS[seq(60,100,2)])

ColDiv = colorRampPalette(rev(brewer.pal(9,"RdYlGn")))(110)[1:100]
ColsDiff = rev(colorRampPalette(brewer.pal(9,"RdYlBu"))(100))
LS = ColsDiff

ColsDiff = c(LS[seq(1,40,2)],LS[seq(40,60,6)],LS[seq(60,100,2)])
plot(1:length(ColsDiff),1:length(ColsDiff), col = ColsDiff)

pdf(
  file = "/Users/thomavan/Dropbox/resbank/Figures/Figure_3.pdf",
  width = 7.1,
  height = 7,
  bg = "white"
)

par(mfrow = c(3,1))
par(mar = c(0,0,0,0))

# 1. Kriging predictions
plot(myPMaskcLMICs, col = "white", axes = F, legend = F, box = F)
plot(mySHP, col = "grey90", border = "white", lwd = 0.5,add=T)
r.range = c(minValue(myUKp50), maxValue(myUKp50))
plot(myUKp50, col = ColsRes, axes = F, box = F, add = T, legend = T, axis.args=list(at=c(0.7,0.6,0.5,0.4,0.3,0.2,0.1,0),labels=c(0.7,0.6,0.5,0.4,0.3,0.2,0.1,0), cex.axis = 1.5))
plot(mySHPLMICs, add = T, lwd = 0.5)
text(180,45, "P50%", font = 2,cex = 1.5)
text(-103,-33,"A",font = 2, cex = 4)

# 2. Kriging variance 
plot(myPMaskcLMICs, col = "white", axes = F, legend = F, box = F)
plot(mySHP, col = "grey90", border = "white", lwd = 0.5,add=T)
r.range = c(minValue(Uncertainty), maxValue(Uncertainty))
plot(Uncertainty, col = ColDiv, axes = F, box = F, add = T, legend = T,axis.args=list(at=c(0.35,0.3,0.25,0.20,0.15,0.10),labels=c(">0.35","0.3","0.25","0.20","0.15","0.10"), cex.axis = 1.5))
plot(mySHPLMICs, add = T, lwd = 0.5)
points(XYTable$XCoord,XYTable$YCoord, pch = 16, col = "darkgreen", cex = 0.1)
text(180,45, "95% C.I.", font = 2,cex = 1.5)
text(-103,-33,"B",font = 2, cex = 4)

# 3. Diffrence in P10 an d50
plot(myPMaskcLMICs, col = "white", axes = F, legend = F, box = F)
plot(mySHP, col = "grey90", border = "white", lwd = 0.5,add=T)
r.range = c(minValue(myUKp10min50), maxValue(myUKp10min50))
plot(myUKp10min50, col = ColsDiff, axes = F, box = F, add = T, legend = T,axis.args=list(at=seq(0,.6,.1),labels=c(0,0.1,.2,0.3,.4,0.5,">0.6"), cex.axis = 1.5))
plot(mySHPLMICs, add = T, lwd = 0.5)
text(180,45, "P10%-P50%", font = 2,cex = 1.5)
text(-103,-33,"C",font = 2, cex = 4)

dev.off()

# Export P50 layer as Google Earth Object 
#########################################
KML(myUKp50, file='/Users/thomavan/Dropbox/resbank/data/outputs/P50.kml', maxpixels = ncell(myUKp50),col = ColsRes, overwrite = T, zip = '')



