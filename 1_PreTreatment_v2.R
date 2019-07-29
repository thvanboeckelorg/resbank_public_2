################################################################################
# Corrections and pre treatment of the merged resbank data
################################################################################
myT = read.csv("/Users/thomavan/Dropbox/resbank/data/resbank_all.csv", stringsAsFactor = F)

#Restrict Analysis to 2018
##########################
myT = subset(myT, PubDate < 2019)

# Clean DOIs
###########
LastChar = substr(myT$DOI,nchar(myT$DOI),nchar(myT$DOI))
IsSpace = (LastChar == " ")
myT$DOI = ifelse(IsSpace == T,substr(myT$DOI,1,(nchar(myT$DOI)-1)),myT$DOI)

# Clean Country names 
#####################
myT$ISO3[myT$ISO3 == "SEN "] = "SEN"  
myT$ISO3[myT$ISO3 == "REU"] = "FRA"  
myT$ISO3[myT$ISO3 == " USA) for 18 h at 37C.\\"] = "USA) for 18 h at 37C.\\"
myT$ISO3[myT$ISO3 == "PSE"] = "ISR"
myT = myT[-which(myT$ISO3 == ""),]

# Correct Pathogens names
#########################
myT$Pathogens[myT$Pathogens == "Campylobacter jejuni"] = "Campylobacter"
myT$Pathogens[myT$Pathogens == "Salmonella "] = "Salmonella"
myT$Pathogens[myT$Pathogens == "E.coli"] = "Ecoli"
myT$Pathogens[myT$Pathogens == "E. coli"] = "Ecoli"
myT$Pathogens[myT$Pathogens == "Staphylococcus aureus"] = "Staphylococcus"
myT$Pathogens[myT$Pathogens == "Staphylococcus "] = "Staphylococcus"
myT$Pathogens[myT$Pathogens == "Staphyloccoccus"] = "Staphylococcus"
myT$Pathogens[myT$Pathogens == "Enteroccus"] = "Enterococcus"
myT$Pathogens[myT$Pathogens == "CTX-M ESBL Ecoli"] = "Ecoli"
myT$Pathogens[myT$Pathogens == "ESBL/AmpC Ecoli"] = "Ecoli"
myT$Pathogens[myT$Pathogens == "O157:H7 Ecoli"] = "Ecoli"
myT = myT[-which(myT$Pathogens == "E. coli+Staphylococcus"),]


# Correct and pool Sample Type Names 
##################################
myT$SampleType[myT$SampleType %in% c("Faecal","Faecal ","Faecal/envrionmental","LivingAnimal/Faecal/Environmental","LivingAnimal/Faecal","Living Animal","LIiving animal","Living animal","LIving animal","Living animal/Product")] = "LivingAnimal"
myT$SampleType[myT$SampleType %in% c("Meat/faecal/product/killed animal","Living animal/Killed animal","LivingAnimal/KilledAnimal","Living/Killed animal","KilledAnimal/Product","Killed animal","Faecal/Killed animal","Meat/Killed animal","Faecal/KilledAnimal/Meat","Faecal/Killed Animal","Killed animal/Faecal","Living/Killed animal","Meat/Living animal","Living/ killed animal","Meat/Product","Living/ killed animal/product","Product/Killed animal/Faecal","Meat/KilledAnimal","KilledAnimal/Faecal/Meat")] = "KilledAnimal"
myT$SampleType[myT$SampleType %in% c("Feed/Water","Environment","Feed","Water","Environmental","Faecal/envrionmental")] = "Environment"
myT$SampleType[myT$SampleType %in% c("Product/Living animal","Living animal/product","Product (milk)","Product (milk products)","Product (cheese)","Product (ice cream)","Product (mawa)","Product (dahi)","Product (milk product)","Product ","Milk","Product/Faecal")] = "Product"
myT$SampleType[myT$SampleType %in% c("Meat/faecal","Faecal/Meat","Meat","Meat/Faecal","Meat/LivingAnimal")] = "Meat"
myT$SampleType[myT$SampleType %in% c("Unknown","")] = NA

# Remove environemental samples 
myT = myT[-which(myT$SampleType == "Environment")]

print(paste0("Number of PPS in Resbank before any exclusion = ",length(unique(myT$DOI))))
print(paste0("Number of rows in resbank before any exclusion = ",nrow(myT)))

# Clean Species names and pool species in 4 categories: Chicken (all poultry), Cattle, Pigs, Sheep (all small ruminants)
########################################################################################################################
myT$Species[myT$Species == "Goat"] = "Sheep"
myT$Species[myT$Species == "Pork"] = "Pig"
myT$Species[myT$Species == "Cattle/Goat"] = "Cattle"
myT$Species[myT$Species == "Goose"] = "Chicken"
myT$Species[myT$Species == "Diarrheic Duck"] = "Chicken"
myT$Species[myT$Species == "Pigs"] = "Pig"
myT$Species[myT$Species == "Chicken "] = "Chicken"
myT$Species[myT$Species == "Cattle "] = "Cattle"
myT$Species[myT$Species == "Beef"] = "Cattle"
myT$Species[myT$Species == "Yak/Gayal/Cattle"] = "Cattle"
myT$Species[myT$Species == "Diarrheic Cattle"] = "Cattle"
myT$Species[myT$Species == "Non-diarrheic Duck"] = "Chicken"
myT$Species[myT$Species == "Non-diarrheic pig"] = "Pig"
myT$Species[myT$Species == "Cattle w/ mastitis"] = "Cattle"
myT$Species[myT$Species == "Chicken w/ Colibacillosis"] = "Chicken"
myT$Species[myT$Species == "Cattle/Buffalo w/ Mastitis"] = "Cattle"
myT$Species[myT$Species == "Infected Pig"] = "Pig"
myT$Species[myT$Species == "Chicken w/ colibacillosis"] = "Chicken"
myT$Species[myT$Species == "Diarrheic sheep"] = "Sheep"
myT$Species[myT$Species == "Chicken (layer)"] = "Chicken"
myT$Species[myT$Species == "Buffalo"] = "Cattle"
myT$Species[myT$Species == "Cattle/Buffalo"] = "Cattle"
myT$Species[myT$Species == "Diseased Chicken"] = "Chicken"
myT$Species[myT$Species == "Cattle w/ Endometritis"] = "Cattle"
myT$Species[myT$Species == "Non-diarrheic Cattle"] = "Cattle"
myT$Species[myT$Species == "Chicken w/ Salmonellosis"] = "Chicken"
myT$Species[myT$Species == "Buffalo w/ Mastitis"] = "Cattle"
myT$Species[myT$Species == "Diarrheic Buffalo"] = "Cattle"
myT$Species[myT$Species == "Chicken w/ colbacillosis"] = "Chicken"
myT$Species[myT$Species == "Chicken (Septicemic)"] = "Chicken"
myT$Species[myT$Species == "Diarrheic pig"] = "Pig"
myT$Species[myT$Species == "Cattle w/ Mastitis"] = "Cattle"
myT$Species[myT$Species == "Chicken w/ lesions"] = "Chicken"
myT$Species[myT$Species == "Chicken (Hen)"] = "Chicken"
myT$Species[myT$Species == "Chicken (broiler)"] = "Chicken"
myT$Species[myT$Species == "Cow"] = "Cattle"
myT$Species[myT$Species == "Non-diarrheic Duck"] = "Chicken"
myT$Species[myT$Species == "Duck"] = "Chicken"
myT$Species[myT$Species == "Turkey"] = "Chicken"
myT$Species[myT$Species == "Buffalo"] = "Cattle"
myT$Species[myT$Species == "Cattle/Buffalo"] = "Cattle"
myT$Species[myT$Species == "Non-diarrheic Cattle"] = "Cattle"
myT$Species[myT$Species == "Horses"] = "Horse"

# Correct drug names 
####################
myT$Drug[myT$Drug == "OTH "] = "OTH"
myT$Drug[myT$Drug == "FLA"] = "QUI"
myT$Drug[myT$Drug == ""] = NA

# Clean ATC Codes 
#################
myT$ATC.Code = gsub(" ","",myT$ATC.Code)

# Correct incomplete ATC-Code
#############################
myT$ATC.Code[myT$ATC.Code == "J01C"] = "J01CE01" 

# Assign Disc Diffusion for unassigned methods
##############################################
myT$Method[is.na(myT$Method)] = "DD"
myT$Method[myT$Method == ""] = "DD"

# Poold methods in two families of Methods (diffusion vs dilution)
##################################################################
myT$Method2C = myT$Method
myT$Method2C[myT$Method2C %in% c("AD ","AD_WGS","AD_DD","AD_MIC","AD_PCR","BD","BD_PCR","Etest","Etest_PCR","BD_VITEK2_PCR","VITEK2","VITEK2_PCR","ad_MIC","MIC","PCR","Vitek_PCR","BD_WGS","Vitek2","BD/DD","DD/BD","Vitek_WGS","VITEK 2 test","Vitek2_PCR","BD_PCR_WGS","VITEK2_PCR_WGS","AD_PCR_WGS")] = "AD"
myT$Method2C[myT$Method2C %in% c("DD ","DD_Etest","DD_MIC","DD_PCR","DD_WGS","SIRSCAN","dd","dd_MIC","E test","Etest_WGS","Oher")] = "DD"

# Correct incorrect guidelines
###########################################
myT$Guidelines[myT$Guidelines == ""] = "CLSI"
myT$Guidelines[myT$Guidelines == "NCCLS"] = "CLSI"
myT$Guidelines[myT$Guidelines == "NCCL"] = "CLSI"
myT$Guidelines[myT$Guidelines == "CLSI?"] = "CLSI"
myT$Guidelines[myT$Guidelines == "CLSI "] = "CLSI"
myT$Guidelines[myT$Guidelines == "NARMS"] = "CLSI"
myT$Guidelines[myT$Guidelines == "ECOFF"] = "EUCAST"
myT$Guidelines[myT$Guidelines == "ECOFF "] = "EUCAST"
myT$Guidelines[substr(myT$Guidelines,1,5) == "NCCLS"] = "CLSI"
myT$Guidelines[substr(myT$Guidelines,1,3) == "CA-"] = "SFM"
myT$Guidelines[myT$Guidelines == "CLSI\2402011 M100-S21"] = "CLSI 2011"
myT$Guidelines[myT$Guidelines == "CLSI\2402006"] = "CLSI 2006"
myT$Guidelines[myT$Guidelines == "CLSI\2402013 M100-S23"] = "CLSI 2013"
myT$Guidelines[myT$Guidelines == "CLSI\2402017 M100-S27"] = "CLSI 2017"
myT$Guidelines[myT$Guidelines == "CLSI\2402013 M100-S23"] = "CLSI 2013"
myT$Guidelines[myT$Guidelines == "CLSI_2002_2004_2005"] = "CLSI 2002"
myT$Guidelines[myT$Guidelines == "CLSI\2402013"] = "CLSI 2013"
myT$Guidelines[myT$Guidelines == "CLSI\2402009 M100-S19"] = "CLSI 2009"
myT$Guidelines[myT$Guidelines == "CLSI\2402015 M100-S25"] = "CLSI 2015"
myT$Guidelines[myT$Guidelines == " CLSI 2013 M100-S23"] = "CLSI 2013"
myT$Guidelines[myT$Guidelines =="French society"] = "SFM"
myT$Guidelines[myT$Guidelines =="SFM"] = "SFM "
myT$Guidelines[myT$Guidelines =="European Committee on Antimicrobial Susceptibility Testing 2013"] = "EUCAST 2013"
myT$Guidelines[myT$Guidelines =="CLS1 2006"] = "CLSI 2006" 
myT$Guidelines[myT$Guidelines =="NCCL 1999 humans_animals"] = "CLSI 1999"

myT$Guidelines[myT$Guidelines =="Manual of Clinical Microbiology 2002"] = "CLSI 2002"
myT$Guidelines[myT$Guidelines =="EFSA 2012"] = "EUCAST 2002"


# remove studies with breakpoints outside of ANY known guidelines 
#################################################################
xxx = nrow(myT)
myT = myT[-which(myT$Author == "Hossain"),] 
print(paste0("Exclusion absrurd guidelines = ",xxx-nrow(myT)))
# Remove studies without geographic coordinates
###############################################
myT$XCoord = as.numeric(myT$XCoord)
myT$YCoord = as.numeric(myT$YCoord)
xxx = nrow(myT)
myT = myT[-which(is.na(myT$XCoord)==T),] 
print(paste0("Exclusion no coordinates = ",xxx-nrow(myT)))

# Assign median sample size when missing 
myT$Nsamples = ifelse(is.na(myT$Nsamples),median(myT$Nsamples, na.rm = T),myT$Nsamples)

# Correct Rescom values 
#######################
myT$Rescom[myT$Rescom == "10 to 20"] = 15
myT$Rescom[myT$Rescom == ""] = NA
myT$Rescom[myT$Rescom == "NA"] = NA
myT$Rescom = as.numeric(myT$Rescom)

# Remove studies that did not report resistance 
###############################################
xxx = nrow(myT)
myT = myT[-which(is.na(myT$Rescom)),] # PPS with missing Rescom are 'waiting response from Authors'
print(paste0("Exclusion aggregated data waiting for response = ",xxx-nrow(myT)))

# Assign a continent to each PPS
################################
world = read.dbf("/Users/thomavan/Dropbox/AAuse/data/World.dbf", as.is = T)
world$CONTINENT = as.character(world$CONTINENT)
myT$Continent = world$CONTINENT[match(myT$ISO3,world$ISO3)]
myT$Continent[myT$Continent == "North America"] = "Americas"
myT$Continent[myT$Continent == "South America"] = "Americas"

myT$SubRegion = world$SUBREGION[match(myT$ISO3,world$ISO3)]

# Reclassify sub-regions ot match EQAS subdivision 
myT$SubRegion[myT$SubRegion == "Middle Africa"] =  "Africa"
myT$SubRegion[myT$SubRegion == "Western Africa"] =  "Africa"
myT$SubRegion[myT$SubRegion == "Southern Africa"] =  "Africa"
myT$SubRegion[myT$SubRegion == "Northern Africa"] =  "Africa"
myT$SubRegion[myT$SubRegion == "Eastern Africa"] =  "Africa"

myT$SubRegion[myT$SubRegion == "South America"] =  "LatinAmerica"
myT$SubRegion[myT$SubRegion == "Central America"] =  "LatinAmerica"

myT$SubRegion[myT$SubRegion == "Western Asia"] =  "CAsiaME"
myT$SubRegion[myT$SubRegion == "Central Asia"] =  "CAsiaME"
myT$SubRegion[myT$SubRegion == "Southern Asia"] =  "CAsiaME"

myT$SubRegion[myT$SubRegion == "South-Eastern Asia"] =  "ASEAN"
myT$SubRegion[myT$SubRegion == "Eastern Asia"] =  "China"

# Assign median sample size when missing 
#########################################
myT$Nsamples = ifelse(is.na(myT$Nsamples),median(myT$Nsamples, na.rm = T),myT$Nsamples)
print(length(myT$DOI))
print(paste0("Number of rows after cleanning = ",nrow(myT)))

#Restrict analysis to 4 main pathogens, 4 main host species, and the drugs of the WHO list of compounds recommanded for susceptibility testing. 
##################################################################################################
myT = myT[myT$Pathogens %in% c("Ecoli","Salmonella","Campylobacter","Staphylococcus"),]
myT = myT[myT$Species %in% c("Cattle","Chicken","Pig","Sheep"),]

write.csv(myT, file = "/Users/thomavan/Dropbox/resbank/data/resbank_all_PreTreated.csv")

# Load WHO list of foodborne pathogens recommanded for Antimicrobial Susceptibility Testing: 
source("scripts/Import_WHO_list.r") 

myT$combWHO = paste0(myT$ATC.Code,"_",myT$Pathogens)
myT$isWHO = myT$combWHO %in% combWHO
print(paste0("Number of PPS suitable for mapping = ",length(unique(myT$DOI))))
print(paste0("Number of rates suitable for mapping = ",nrow(myT)))

myT = subset(myT, isWHO == T)

print(paste0("Number of PPS AGISAR (Chicken, Cattle and Pig) = ",length(unique(myT$DOI))))
print(paste0("Number of rates AGISAR = ",nrow(myT)))
print(paste0("Number of unique locations = ",length(unique(myT$XCoord))))

# Average number of samples 
myT$SuperUnique = paste0(myT$DOI,myT$Author)
TotalSamples = sum(aggregate(Nsamples ~ SuperUnique, data = myT, FUN = mean)$Nsamples)
print(paste0("Total Number of samples = ",round(TotalSamples)))








