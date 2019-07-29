# Load WHO list of recommanded pathogens for susceptibility testing 
DrugIDTable = read.csv("/Users/thomavan/Dropbox/resbank/data/who_list_drugs.csv", sep = "\t", stringsAsFactors = F)
DrugIDTable$ATC_Code[18] = "J01CA17"
DrugIDTable$ATC_Code = gsub(" ","",DrugIDTable$ATC_Code)
names(DrugIDTable) = c("Compound","Name","ATC_Code","WHO_Ecoli","WHO_Salmonella","WHO_Staphylococcus","WHO_Campylobacter")

# First Build a vector of WHO drug/bug combinations 
combWHO = c(
  paste0(DrugIDTable$ATC_Code[DrugIDTable$WHO_Ecoli=="yes"],"_Ecoli"),
  paste0(DrugIDTable$ATC_Code[DrugIDTable$WHO_Salmonella=="yes"],"_Salmonella"),
  paste0(DrugIDTable$ATC_Code[DrugIDTable$WHO_Staphylococcus=="yes"],"_Staphylococcus"),
  paste0(DrugIDTable$ATC_Code[DrugIDTable$WHO_Campylobacter=="yes"],"_Campylobacter")
)