# BRT
###################################
BRTAvg = as.data.frame(RelImpV)
names(BRTAvg) = names(myRS)
BRTAvg = colMeans(BRTAvg)

print("BRT - Relative Infeluences")
print(BRTAvg)

# LASSO
###################################
LASSOAvg =  as.data.frame(CoefsLASSOV)
names(LASSOAvg) = names(myRS)
LASSOAvg =  100*colMeans(LASSOAvg)
print("LASSO - Frequency of variable selection")
print(LASSOAvg)

# LASSO - GAM
###################################
CoefsLASSOGAMlinV[is.na(CoefsLASSOGAMlinV)] = 0
LASSOGAMAvg =  as.data.frame(CoefsLASSOGAMlinV)
names(LASSOGAMAvg) = names(myRS)
LASSOGAMAvg =  100*colMeans(LASSOGAMAvg)

print("LASSO GAM - Frequency of variable selection (linear)")
print(LASSOGAMAvg)

CoefsLASSOGAMnlV[is.na(CoefsLASSOGAMnlV)] = 0
LASSOGAMAvgML =  as.data.frame(CoefsLASSOGAMnlV)
names(LASSOGAMAvgML) = names(myRS)
LASSOGAMAvgNL =  100*colMeans(LASSOGAMAvgML)

print("LASSO GAM  - Frequency of variable selection (non-linear)")
print(LASSOGAMAvgNL)


myRiskTable = rbind(format(BRTAvg, digits = 2),LASSOAvg,LASSOGAMAvg,LASSOGAMAvgNL)
write.table(myRiskTable, file = "/Users/thomavan/Dropbox/resbank/data/outputs/RiskFactorsSign.txt", sep = "\t", row.names = F)


