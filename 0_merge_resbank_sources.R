# Resistance Rates in Africa accross all species/drugclasses/dates

# Africa
myTAF = read.xls("resbankDB_Africa.xls",stringsAsFactors = F)

# India Region 
myTIND = read.xls("/Users/thomavan/Dropbox/MARI/resbank_IND_Animals_2_tvb.xlsx",stringsAsFactors = F)

  # Add Reshma's contribution from non-published
  myTTINDunpublished = read.xls("/Users/thomavan/Dropbox/MARI/Reshma_Silvester/resbank-IND-ANIMALS_Reshma.xlsx",stringsAsFactors = F)
  myTTIND = rbind(myTIND,myTTINDunpublished)
  nrow(myTTIND)

# South America
myTSA = read.xls("/Users/thomavan/Dropbox/resbank/resbankDB_South_America.xlsx",stringsAsFactors = F)
nrow(myTSA)

# Central America
myTCA = read.xls("/Users/thomavan/Dropbox/resbank/resbankDB_Central_America.xlsx",stringsAsFactors = F)
nrow(myTCA)

# China/Users/thomavan/Dropbox/MARI/CUmanzor
#myTCH = read.xls("/Users/thomavan/Dropbox/MARI/CUmanzor/ChinaresbankDB_template_26_07_2018.xlsx", stringsAsFactors = F, verbose = F) # Chris
myTCH = read.xls("/Users/thomavan/Dropbox/resbank/resbankDB_China_Chris_curated.xls", stringsAsFactors = F, verbose = F) # Joao corrected Chris

myTCH2 = read.xls("/Users/thomavan/Dropbox/resbank/resbankDB_China_Jp.xlsx", stringsAsFactors = F) # Joao

myTCHG = read.xls("/Users/thomavan/Dropbox/resbank_China/xujingyi/resbank_grey_litterature_China.xlsx", stringsAsFactors = F)
nrow(myTCH)

# ASEAN Countries
myTAS = read.xls("/Users/thomavan/Dropbox/MARI/resbank_ASEAN_Animals_tvb.xlsx", stringsAsFactors = F) # Reshma's part
myTAS2 = read.xls("/Users/thomavan/Dropbox/resbank/resbankDB_ASEAN_Indian_Subcontinent.xlsx")# joao's part
names(myTAS2) = names(myTAS)

  # Addition for revision of Manuscript 2018 - this should be turn as comments for debugging of latest data inclusion
  myTAf2018 = read.csv("/Users/thomavan/Dropbox/resbank/resbank_new_2018/resbank_Africa2018_new.csv", stringsAsFactors = F)
  myTASEAN2018 = read.csv("/Users/thomavan/Dropbox/resbank/resbank_new_2018/resbank_ASEAN2018_new.csv", stringsAsFactors = F)
  myTME2018 = read.csv("/Users/thomavan/Dropbox/resbank/resbank_new_2018/resbank_MiddleEast2018_new.csv", stringsAsFactors = F)
  myTINCH2018 = read.csv("/Users/thomavan/Dropbox/resbank/resbank_new_2018/resbank_China_Indian_SubContinent2018_new.csv", stringsAsFactors = F)
  myTAM2018 = read.csv("/Users/thomavan/Dropbox/resbank/resbank_new_2018/resbank_Americas2018_new.csv", stringsAsFactors = F)
  
  # Check names consistency accross columns  
  myT = rbind(myTAF,myTTIND,myTSA,myTCA,myTCH,myTCH2,myTCHG,myTAS,myTAS2)
  myT = myT[,-which(names(myT) == "Resav")] # we dropped this column for 2018
  
  # Merge with data from 2018 
  myT2018 = rbind(myTAf2018,myTASEAN2018,myTME2018,myTINCH2018,myTAM2018)
  myT = rbind(myT,myT2018)
  
write.csv(myT, file = "/Users/thomavan/Dropbox/resbank/data/resbank_all.csv")



