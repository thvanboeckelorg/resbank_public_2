library(RColorBrewer)
library(spatialEco)
library(usdm)

# P50 
myUKp = raster("/Users/thomavan/Dropbox/resbank/data/outputs/P50_10k_EQAS_2018")

#Test with our layer 
IND = mySHPLMICs

plot(IND)
IND_r = crop(myUKp,bbox(IND))

xxx= Sys.time()
genGP50 = lisa(IND_r,d1=0,d2=.1,statistic="G") # G statistic # distances should eb expressed in decimal degrees
writeRaster(genGP50, "/Users/thomavan/Dropbox/resbank/data/outputs/generalG_P50", overwrite = T)
print(Sys.time()-xxx)

genGP50_95 = genGP50 > 1.96 #(or 2.05 if p = 0.04)

# Make sure extent are matching
Hotspot04 = crop(myHotspots,extent(genGP50))

# Calculate correlation between hotspots obtained from the threhold method (P50 > 0.4) vs Getis-Ord method. 
CorRCor = cor(Hotspot04[],genGP50_95[],use = "pairwise.complete.obs")
CorRaster = rasterCorrelation(Hotspot04, genGP50, s = 7, type = "spearman", na.rm = T)

# plot Regional 
par(mfrow = c(1,3))
par(mar = c(1,3,3,3))
plot(Hotspot04, box = F, axes = F, legend = F, main = "\nMethod 1\nHotspots defined as P50 > 0.4", xlim = c(65,135), ylim = c(0,50), cex.main = 2)
plot(mySHPLMICs, border = T, lwd = 0.5,add=T, xlim = c(65,135), ylim = c(0,50))
text(69,51,"A", cex = 5, font = 2)

par(mar = c(1,3,3,3))
plot(genGP50_95, box = F, axes = F, legend = F, main = "\nMethod 2\nHotspots caluclated with Getis-Ord G (95%)", xlim = c(65,135), ylim = c(0,50), cex.main = 2)
plot(mySHPLMICs, border = T, lwd = 0.5,add=T, xlim = c(65,135), ylim = c(0,50))
text(69,51,"B", cex = 5, font = 2)

par(mar = c(1,3,3,10))
ColsBu = colorRampPalette(brewer.pal(9,"RdBu")[9:5])(4)
ColsRd = rev(colorRampPalette(brewer.pal(9,"RdBu")[1:5])(8))

plot(CorRaster, col = c(ColsBu,ColsRd), box = F, axes = F, main = "\nCorrelation between methods \nfor hotspot indentification", xlim = c(65,135), ylim = c(0,50), cex.main = 2, legend.width = 6, cex.axis = 2, cex.lab = 2,axis.args=list(cex.axis=2))
plot(mySHPLMICs, border = T, lwd = 0.5,add=T, xlim = c(65,135), ylim = c(0,50))
text(69,51,"C", cex = 5, font = 2)



  



