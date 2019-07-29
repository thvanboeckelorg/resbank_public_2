# Regional Uncertainty modulation with EQAS data 
myEQ = read.table("/Users/thomavan/Dropbox/resbank/data/EQAS_accuracy_scores.txt",header = T)

# Calculate average reporting rates per region 
myMEQ = aggregate(Accuracy ~ Year+SubRegion, FUN = mean, data = myEQ)
Pathogen = "Staphylococcus"
myEQStaph = as.data.frame(cbind(myMEQ[1],myMEQ[3],myMEQ[2],Pathogen))

myEQ = rbind(myEQ,myEQStaph)

myEQ$EQASID = paste0(myEQ$SubRegion,"_",myEQ$Pathogen,"_",myEQ$Year)



