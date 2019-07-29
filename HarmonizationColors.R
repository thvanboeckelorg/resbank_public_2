AllNames = NULL
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
  AllNames = c(AllNames,NamesCompounds)
}

UNames = unique(AllNames)
LUNames = length(UNames)

# Create a categorical color scheme unique to each compound

SequentialPal = colorRampPalette(brewer.pal(8,"Set1"))(LUNames)
RandomPal = sample(SequentialPal,LUNames,replace=FALSE)


