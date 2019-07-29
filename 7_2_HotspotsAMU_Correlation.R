# Correlation between hotspots of P50, and hotspots of antimicrobials
library(spatialEco)
library(psych)

# Hotspots of AMU in ASIA

#hotspotsAMUrise  = raster("/Users/thomavan/Dropbox/resbank/data/GrowingAMUhotspots")
hotspotsAMUrise  = raster("/Users/thomavan/Dropbox/resbank/data/IsAMUHotspots2030")
#hotspotsAMUrise  = raster("/Users/thomavan/Dropbox/resbank/data/IsAMUHotspots2030Ch")

# Load P50 map 
myUKp50 = raster("/Users/thomavan/Dropbox/resbank/data/outputs/P50_10k_EQAS_2018")

# Calculate hotspot of P50
myHotspots = myUKp50 > .4


# Restict comparison to Asia 
myHotspotsAsia = crop(myHotspots, extent(hotspotsAMUrise))
mySHPSr = rasterize(mySHPLMICs,crop(hotspotsAMUrise,extent(mySHPLMICs)))


pdf(
  file = "/Users/thomavan/Dropbox/resbank/Figures/hotspots_correlation.pdf",
  width = 8,
  height = 7,
  bg = "white"
)
par(mar = c(0,0,0,0))
plot(mySHPLMICs, lwd = 0.5, xlim = c(80,130), ylim = c(-10,60), col = "white")
plot(hotspotsAMUrise,col = c("white","cornflowerblue"),add=T, box = F, legend = F, axes = F)
plot(myHotspotsAsia,col = c(NA,terrain.colors(3)[1]),add = T, box = F, legend = F, axes = F)
plot(mySHPLMICs, lwd = 0.5, add=T)
legend(57,0,legend = c("Hotspot AMU \n(Van Boeckel et al 2015, 2017)","Hotspot P50"), fill = c("cornflowerblue",terrain.colors(3)[1]), bty ="n", cex = 1.5)
dev.off()

plot(mySHPSr,col = "white", legend = F, axes = F, box = F)
plot(hotspotsAMUrise,col = c("white","cornflowerblue"),add=T, box = F, legend = F, axes = F)
plot(myHotspotsAsia,col = c(NA,terrain.colors(3)[1]),add = T, box = F, legend = F, axes = F)
plot(mySHPLMICs, add=T, lwd = 0.5)
dev.off()



# Cohen's Kappa
kappa = cohen.kappa(cbind(hotspotsAMUrise[],myHotspotsAsia[]))
print(kappa)

# Proportion of AMr hotspots in an AMU hotspot
print("Proportion of AMR hotspots in an AMU hotspot")
print(sum(myHotspotsAsia[] * hotspotsAMUrise[], na.rm = T) / sum(myHotspotsAsia[] == 1, na.rm = T))
