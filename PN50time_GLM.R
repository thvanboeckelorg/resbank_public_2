# Descriptive stats 
pdf(
  file = "/Users/thomavan/Dropbox/resbank/Figures/Figure_2.pdf",
  width = 18,
  height = 6,
  bg = "white"
)
par(mfrow = c(1,3))
par(mar = c(5,5,5,5))

for (i in 1:length(SpeciesID)){
  
  SDF = subset(XYTable, Species == SpeciesID[i])
  #if(i == 2){SDF = SDF[SDF$PubDate > 2005,]}
  tmp = boxplot(PN50 ~ PubDate, data = SDF, plot = F)
  
  ColsBP = rep("red",length(tmp$n))
  ColsBPG = rep("black",length(tmp$n))
  
  ColsBP = addalpha(ColsBP,tmp$n/max(tmp$n))
  ColsBPG = addalpha(ColsBPG,tmp$n/max(tmp$n)) 
  

  boxplot(PN50 ~ PubDate, data = SDF, col = ColsBP, border = ColsBPG, ylim = c(0,1), main = paste0(SpeciesID[i]," (n = ",nrow(SDF),")"), axes = T, cex.names = 2, cex.axis = 2,cex.main = 2, ylab = "Proportion of drugs with 50% resistance", cex.lab = 2)

  SDF$PubDateSq = SDF$PubDate^2
  
  NDF = as.data.frame(min(SDF$PubDate):max(SDF$PubDate))
  names(NDF) = "PubDate"
  NDF$PubDateSq = NDF$PubDate^2
  
  ## On raw data 
  #myGLMtime = glm(PN50~PubDate, data = SDF, weights = log10(SDF$NMsamples+1))
  #PredsGLM = predict(myGLMtime, newdata = NDF)
  #summary(myGLMtime)
  
  #myGAMtime = gam(PN50~s(PubDate,k=3,fx = TRUE,bs = "ts"), data = SDF,weights = log10(SDF$NMsamples+1))
  #PredsGAM = predict(myGAMtime, newdata = NDF)
  #summary(myGAMtime)
  
  # On Midpoints
  # GLM
  MSDF = as.data.frame(cbind(tmp$stats[3,],as.numeric(tmp$names),as.numeric(tmp$names)^2,tmp$n))
  names(MSDF) = c("PN50mids","Year","YearSq","n")
  myGLMtimeMids = glm(PN50mids~Year, data = MSDF, weights = MSDF$n)
  summary(myGLMtimeMids)
  PredsGLMMids = predict(myGLMtimeMids, newdata = MSDF)
  
  # GAM
  #myGAMtimeMids = gam(PN50mids~s(Year,k=3,fx = TRUE,bs = "ts"), data = MSDF,weights = MSDF$n)
  #PredsGAMMids = predict(myGAMtimeMids, newdata = MSDF)
  #summary(myGAMtime)
  
  #if(summary(myGLMtime)$coefficients[2,4] < 0.05){LTYglm=1} else {LTYglm = 3}
  #if(summary(myGAMtime)$s.pv < 0.05){LTYgam=1} else {LTYgam = 3}
  if(summary(myGLMtimeMids)$coefficients[2,4] < 0.05){LTYglmMids=1} else {LTYglmMids = 3}
  #if(summary(myGAMtimeMids)$s.pv < 0.05){LTYgamMids=1} else {LTYgamMids = 3}
  
  #lines(NDF$PubDate-min(NDF$PubDate),as.vector(PredsGAM), lwd = 4, col = "darkred", lty = LTYgam)
  #lines(NDF$PubDate-min(NDF$PubDate),as.vector(PredsGLM), lwd = 4, col = "navyblue", lty = LTYglm)
  lines(MSDF$Year-min(MSDF$Year),as.vector(PredsGLMMids), lwd = 4, col = "darkred", lty = LTYglmMids)
  #lines(MSDF$Year-min(MSDF$Year),as.vector(PredsGAMMids), lwd = 4, col = "orange", lty = LTYglmMids)
  
  
  #print(paste0("GLM : ",SpeciesID[i]," from ",format(PredsGLM[1],digits = 2)," to ",format(PredsGLM[length(PredsGLM)], digits = 2)))
  #print(paste0("GAM : ",SpeciesID[i]," from ",format(PredsGAM[1],digits = 2)," to ",format(PredsGAM[length(PredsGAM)], digits = 2)))
  print(paste0("GLMMids : ",SpeciesID[i]," from ",format(PredsGLMMids[1],digits = 2)," to ",format(PredsGLMMids[length(PredsGLMMids)], digits = 2), " Yearly Increase (P50) = ",format(summary(myGLMtimeMids)$coefficients[2,1], digits = 2)))
  #print(paste0("GAMMids : ",SpeciesID[i]," from ",format(PredsGAMMids[1],digits = 2)," to ",format(PredsGAMMids[length(PredsGAMMids)], digits = 2)))
  
}
dev.off()


