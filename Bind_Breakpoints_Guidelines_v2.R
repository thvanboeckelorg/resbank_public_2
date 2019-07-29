# Bind guidelines ot build a breakpoinst vector

# Disc Diffusion - CLSI
#######################

myGT_CLSI_dd_1997 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_1997.csv", stringsAsFactors = F)
myGT_CLSI_dd_1997$Year = rep(1997,nrow(myGT_CLSI_dd_1997))
myGT_CLSI_dd_1998 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_1998.csv", stringsAsFactors = F)
myGT_CLSI_dd_1998$Year = rep(1998,nrow(myGT_CLSI_dd_1998))
myGT_CLSI_dd_1999 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_1999.csv", stringsAsFactors = F)
myGT_CLSI_dd_1999$Year = rep(1999,nrow(myGT_CLSI_dd_1999))
myGT_CLSI_dd_2000 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2000.csv", stringsAsFactors = F)
myGT_CLSI_dd_2000$Year = rep(2000,nrow(myGT_CLSI_dd_2000))
myGT_CLSI_dd_2001 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2001.csv", stringsAsFactors = F)
myGT_CLSI_dd_2001$Year = rep(2001,nrow(myGT_CLSI_dd_2001))
myGT_CLSI_dd_2002 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2002.csv", stringsAsFactors = F)
myGT_CLSI_dd_2002$Year = rep(2002,nrow(myGT_CLSI_dd_2002))
myGT_CLSI_dd_2003 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2003.csv", stringsAsFactors = F)
myGT_CLSI_dd_2003$Year = rep(2003,nrow(myGT_CLSI_dd_2003))
myGT_CLSI_dd_2004 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2004.csv", stringsAsFactors = F)
myGT_CLSI_dd_2004$Year = rep(2004,nrow(myGT_CLSI_dd_2004))
myGT_CLSI_dd_2005 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2005.csv", stringsAsFactors = F)
myGT_CLSI_dd_2005$Year = rep(2005,nrow(myGT_CLSI_dd_2005))
myGT_CLSI_dd_2006 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2006.csv", stringsAsFactors = F)
myGT_CLSI_dd_2006$Year = rep(2006,nrow(myGT_CLSI_dd_2006))
myGT_CLSI_dd_2007 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2007.csv", stringsAsFactors = F)
myGT_CLSI_dd_2007$Year = rep(2007,nrow(myGT_CLSI_dd_2007))
myGT_CLSI_dd_2008 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2008.csv", stringsAsFactors = F)
myGT_CLSI_dd_2008$Year = rep(2008,nrow(myGT_CLSI_dd_2008))
myGT_CLSI_dd_2009 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2009.csv", stringsAsFactors = F)
myGT_CLSI_dd_2009$Year = rep(2009,nrow(myGT_CLSI_dd_2009))
myGT_CLSI_dd_2010 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2010.csv", stringsAsFactors = F)
myGT_CLSI_dd_2010$Year = rep(2010,nrow(myGT_CLSI_dd_2010))
myGT_CLSI_dd_2011 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2011.csv", stringsAsFactors = F)
myGT_CLSI_dd_2011$Year = rep(2011,nrow(myGT_CLSI_dd_2011))
myGT_CLSI_dd_2012 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2012.csv", stringsAsFactors = F)
myGT_CLSI_dd_2012$Year = rep(2012,nrow(myGT_CLSI_dd_2012))
myGT_CLSI_dd_2013 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2013.csv", stringsAsFactors = F)
myGT_CLSI_dd_2013$Year = rep(2013,nrow(myGT_CLSI_dd_2013))
myGT_CLSI_dd_2014 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2014.csv", stringsAsFactors = F)
myGT_CLSI_dd_2014$Year = rep(2014,nrow(myGT_CLSI_dd_2014))
myGT_CLSI_dd_2015 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2015.csv", stringsAsFactors = F)
myGT_CLSI_dd_2015$Year = rep(2015,nrow(myGT_CLSI_dd_2015))
myGT_CLSI_dd_2016 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2016.csv", stringsAsFactors = F)
myGT_CLSI_dd_2016$Year = rep(2016,nrow(myGT_CLSI_dd_2016))
myGT_CLSI_dd_2017 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2017.csv", stringsAsFactors = F)
myGT_CLSI_dd_2017$Year = rep(2017,nrow(myGT_CLSI_dd_2017))
myGT_CLSI_dd_2018 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_dd_2018.csv", stringsAsFactors = F)
myGT_CLSI_dd_2018$Year = rep(2018,nrow(myGT_CLSI_dd_2018))

myGT_CLSI_dd = rbind(
myGT_CLSI_dd_1997,
myGT_CLSI_dd_1998,
myGT_CLSI_dd_1999,
myGT_CLSI_dd_2000,
myGT_CLSI_dd_2001,
myGT_CLSI_dd_2002,
myGT_CLSI_dd_2003,
myGT_CLSI_dd_2004,
myGT_CLSI_dd_2005,
myGT_CLSI_dd_2006,
myGT_CLSI_dd_2007,
myGT_CLSI_dd_2008,
myGT_CLSI_dd_2009,
myGT_CLSI_dd_2010,
myGT_CLSI_dd_2011,
myGT_CLSI_dd_2012,
myGT_CLSI_dd_2013,
myGT_CLSI_dd_2014,
myGT_CLSI_dd_2015,
myGT_CLSI_dd_2016,
myGT_CLSI_dd_2017,
myGT_CLSI_dd_2018
)

myGT_CLSI_dd$GDType = "CLSI"

# Disc Diffusion - EUCA
#######################
myGT_EUCA_dd_2009 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2009.csv", stringsAsFactors = F)
myGT_EUCA_dd_2009$Year = rep(2009,nrow(myGT_EUCA_dd_2009))
myGT_EUCA_dd_2010 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2010.csv", stringsAsFactors = F)
myGT_EUCA_dd_2010$Year = rep(2010,nrow(myGT_EUCA_dd_2010))
myGT_EUCA_dd_2011 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2011.csv", stringsAsFactors = F)
myGT_EUCA_dd_2011$Year = rep(2011,nrow(myGT_EUCA_dd_2011))
myGT_EUCA_dd_2012 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2012.csv", stringsAsFactors = F)
myGT_EUCA_dd_2012$Year = rep(2012,nrow(myGT_EUCA_dd_2012))
myGT_EUCA_dd_2013 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2013.csv", stringsAsFactors = F)
myGT_EUCA_dd_2013$Year = rep(2013,nrow(myGT_EUCA_dd_2013))
myGT_EUCA_dd_2014 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2014.csv", stringsAsFactors = F)
myGT_EUCA_dd_2014$Year = rep(2014,nrow(myGT_EUCA_dd_2014))
myGT_EUCA_dd_2015 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2015.csv", stringsAsFactors = F)
myGT_EUCA_dd_2015$Year = rep(2015,nrow(myGT_EUCA_dd_2015))
myGT_EUCA_dd_2016 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2016.csv", stringsAsFactors = F)
myGT_EUCA_dd_2016$Year = rep(2016,nrow(myGT_EUCA_dd_2016))
myGT_EUCA_dd_2017 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2016.csv", stringsAsFactors = F)
myGT_EUCA_dd_2017$Year = rep(2017,nrow(myGT_EUCA_dd_2017))
myGT_EUCA_dd_2018 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_dd_2016.csv", stringsAsFactors = F)
myGT_EUCA_dd_2018$Year = rep(2018,nrow(myGT_EUCA_dd_2018))

myGT_EUCA_dd = rbind(
myGT_EUCA_dd_2009,
myGT_EUCA_dd_2010,
myGT_EUCA_dd_2011,
myGT_EUCA_dd_2012,
myGT_EUCA_dd_2013,
myGT_EUCA_dd_2014,
myGT_EUCA_dd_2015,
myGT_EUCA_dd_2016,
myGT_EUCA_dd_2017,
myGT_EUCA_dd_2018)

myGT_EUCA_dd$GDType = "EUCA"

# Disc Diffusion - SFM
#######################
myGT_SFM_dd_2005 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2005.csv", sep = "\t",stringsAsFactors = F)
myGT_SFM_dd_2005$Year = rep(2005,nrow(myGT_SFM_dd_2005))
  
myGT_SFM_dd_2006 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2006.csv", sep = "\t",stringsAsFactors = F)
myGT_SFM_dd_2006$Year = rep(2006,nrow(myGT_SFM_dd_2006))
names(myGT_SFM_dd_2006) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2007 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2007.csv", sep = ",",stringsAsFactors = F)
myGT_SFM_dd_2007$Year = rep(2007,nrow(myGT_SFM_dd_2007))
names(myGT_SFM_dd_2007) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2008 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2008.csv",sep = ",",stringsAsFactors = F, header = T)
myGT_SFM_dd_2008$Year = rep(2008,nrow(myGT_SFM_dd_2008))
names(myGT_SFM_dd_2008) = names(myGT_SFM_dd_2005)
  
myGT_SFM_dd_2009 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2009.csv", sep = ",",stringsAsFactors = F)
myGT_SFM_dd_2009$Year = rep(2009,nrow(myGT_SFM_dd_2009))
names(myGT_SFM_dd_2009) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2010 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2010.csv", sep = "\t",stringsAsFactors = F)
myGT_SFM_dd_2010$Year = rep(2010,nrow(myGT_SFM_dd_2010))
names(myGT_SFM_dd_2010) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2011 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2011.csv", sep = ",",stringsAsFactors = F)
myGT_SFM_dd_2011$Year = rep(2011,nrow(myGT_SFM_dd_2011))
names(myGT_SFM_dd_2011) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2012 = read.table("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2012.csv", sep = ",",stringsAsFactors = F, header = T)
myGT_SFM_dd_2012$Year = rep(2012,nrow(myGT_SFM_dd_2012))
names(myGT_SFM_dd_2012) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2013 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2013.csv", sep = ",",stringsAsFactors = F)
myGT_SFM_dd_2013$Year = rep(2013,nrow(myGT_SFM_dd_2013))
names(myGT_SFM_dd_2013) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2014 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2014.csv", sep = "\t",stringsAsFactors = F)
myGT_SFM_dd_2014$Year = rep(2014,nrow(myGT_SFM_dd_2014))
names(myGT_SFM_dd_2014) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2015 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2015.csv", sep = "\t",stringsAsFactors = F)
myGT_SFM_dd_2015$Year = rep(2015,nrow(myGT_SFM_dd_2015))
names(myGT_SFM_dd_2015) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2016 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2016.csv", sep = "\t",stringsAsFactors = F)
myGT_SFM_dd_2016$Year = rep(2016,nrow(myGT_SFM_dd_2016))
names(myGT_SFM_dd_2016) = names(myGT_SFM_dd_2005)

myGT_SFM_dd_2017 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_dd_2017.csv", sep = "\t",stringsAsFactors = F)
myGT_SFM_dd_2017$Year = rep(2017,nrow(myGT_SFM_dd_2017))
names(myGT_SFM_dd_2017) = names(myGT_SFM_dd_2005)

myGT_SFM_dd = rbind(
myGT_SFM_dd_2005,
myGT_SFM_dd_2006,
myGT_SFM_dd_2007,
myGT_SFM_dd_2008,
myGT_SFM_dd_2009,
myGT_SFM_dd_2010,
myGT_SFM_dd_2011,
myGT_SFM_dd_2012,
myGT_SFM_dd_2013,
myGT_SFM_dd_2014,
myGT_SFM_dd_2015,
myGT_SFM_dd_2016,
myGT_SFM_dd_2017)

myGT_SFM_dd$GDType = "SFM"

names(myGT_CLSI_dd) = c("Drug","DrugName","Compound","CompoundName","ATC_Code","disk_content","Ecoli","Salmonella","Staphylococcus","Campylobacter","Enterococcus","Remark","Year","GDType")
names(myGT_EUCA_dd) = c("Drug","DrugName","Compound","CompoundName","ATC_Code","disk_content","Ecoli","Salmonella","Staphylococcus","Campylobacter","Enterococcus","Remark","Year","GDType")
names(myGT_SFM_dd) = c("Drug","DrugName","Compound","CompoundName","ATC_Code","disk_content","Ecoli","Salmonella","Staphylococcus","Campylobacter","Enterococcus","Remark","Year","GDType")

myGT_dd = rbind(myGT_CLSI_dd,myGT_EUCA_dd,myGT_SFM_dd)
myGT_dd$Method2C = rep("DD",nrow(myGT_dd))
#######################################################################################################################################################
# MIC - CLSI
#######################
Names =  c("Drug","DrugName","Compound","CompoundName","ATC_Code","Ecoli","Salmonella","Staphylococcus","Campylobacter","Enterococcus","Remark","Year")
myGT_CLSI_mic_1997 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_1997.csv", stringsAsFactors = F)
myGT_CLSI_mic_1997$Year = rep(1997,nrow(myGT_CLSI_mic_1997))
names(myGT_CLSI_mic_1997) = Names
myGT_CLSI_mic_1998 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_1998.csv", stringsAsFactors = F, sep = "\t")
myGT_CLSI_mic_1998$Year = rep(1998,nrow(myGT_CLSI_mic_1998))
names(myGT_CLSI_mic_1998) = Names
myGT_CLSI_mic_1999 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_1999.csv", stringsAsFactors = F, sep = "\t")
myGT_CLSI_mic_1999$Year = rep(1999,nrow(myGT_CLSI_mic_1999))
names(myGT_CLSI_mic_1999) = Names
myGT_CLSI_mic_2000 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2000.csv", stringsAsFactors = F, sep = "\t")
myGT_CLSI_mic_2000$Year = rep(2000,nrow(myGT_CLSI_mic_2000))
names(myGT_CLSI_mic_2000) = Names
myGT_CLSI_mic_2001 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2001.csv", stringsAsFactors = F, sep = "\t")
myGT_CLSI_mic_2001$Year = rep(2001,nrow(myGT_CLSI_mic_2001))
names(myGT_CLSI_mic_2001) = Names
myGT_CLSI_mic_2002 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2002.csv", stringsAsFactors = F, sep = "\t")
myGT_CLSI_mic_2002$Year = rep(2002,nrow(myGT_CLSI_mic_2002))
names(myGT_CLSI_mic_2002) = Names
myGT_CLSI_mic_2003 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2003.csv", stringsAsFactors = F, sep = "\t")
myGT_CLSI_mic_2003$Year = rep(2003,nrow(myGT_CLSI_mic_2003))
names(myGT_CLSI_mic_2003) = Names
myGT_CLSI_mic_2004 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2004.csv", stringsAsFactors = F, sep = "\t")
myGT_CLSI_mic_2004$Year = rep(2004,nrow(myGT_CLSI_mic_2004))
names(myGT_CLSI_mic_2004) = Names
myGT_CLSI_mic_2005 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2005.csv", stringsAsFactors = F)
myGT_CLSI_mic_2005$Year = rep(2005,nrow(myGT_CLSI_mic_2005))
names(myGT_CLSI_mic_2005) = Names
myGT_CLSI_mic_2006 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2006.csv", stringsAsFactors = F)
myGT_CLSI_mic_2006$Year = rep(2006,nrow(myGT_CLSI_mic_2006))
names(myGT_CLSI_mic_2006) = Names
myGT_CLSI_mic_2007 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2007.csv", stringsAsFactors = F)
myGT_CLSI_mic_2007$Year = rep(2007,nrow(myGT_CLSI_mic_2007))
names(myGT_CLSI_mic_2007) = Names
myGT_CLSI_mic_2008 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2008.csv", stringsAsFactors = F)
myGT_CLSI_mic_2008$Year = rep(2008,nrow(myGT_CLSI_mic_2008))
names(myGT_CLSI_mic_2008) = Names
myGT_CLSI_mic_2009 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2009.csv", stringsAsFactors = F)
myGT_CLSI_mic_2009$Year = rep(2009,nrow(myGT_CLSI_mic_2009))
names(myGT_CLSI_mic_2009) = Names
myGT_CLSI_mic_2010 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2010.csv", stringsAsFactors = F)
myGT_CLSI_mic_2010$Year = rep(2010,nrow(myGT_CLSI_mic_2010))
names(myGT_CLSI_mic_2010) = Names
myGT_CLSI_mic_2011 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2011.csv", stringsAsFactors = F)
myGT_CLSI_mic_2011$Year = rep(2011,nrow(myGT_CLSI_mic_2011))
names(myGT_CLSI_mic_2011) = Names
myGT_CLSI_mic_2012 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2012.csv", stringsAsFactors = F)
myGT_CLSI_mic_2012$Year = rep(2012,nrow(myGT_CLSI_mic_2012))
names(myGT_CLSI_mic_2012) = Names
myGT_CLSI_mic_2013 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2013.csv", stringsAsFactors = F)
myGT_CLSI_mic_2013$Year = rep(2013,nrow(myGT_CLSI_mic_2013))
names(myGT_CLSI_mic_2013) = Names
myGT_CLSI_mic_2014 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2014.csv", stringsAsFactors = F)
myGT_CLSI_mic_2014$Year = rep(2014,nrow(myGT_CLSI_mic_2014))
names(myGT_CLSI_mic_2014) = Names
myGT_CLSI_mic_2015 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2015.csv", stringsAsFactors = F)
myGT_CLSI_mic_2015$Year = rep(2015,nrow(myGT_CLSI_mic_2015))
names(myGT_CLSI_mic_2015) = Names
myGT_CLSI_mic_2016 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2016.csv", stringsAsFactors = F)
myGT_CLSI_mic_2016$Year = rep(2016,nrow(myGT_CLSI_mic_2016))
names(myGT_CLSI_mic_2016) = Names
myGT_CLSI_mic_2017 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/CLSI_mic_2017.csv", stringsAsFactors = F)
myGT_CLSI_mic_2017$Year = rep(2017,nrow(myGT_CLSI_mic_2017))
names(myGT_CLSI_mic_2017) = Names
  
  myGT_CLSI_mic = rbind(
  myGT_CLSI_mic_1997, 
  myGT_CLSI_mic_1998, 
  myGT_CLSI_mic_1999, 
  myGT_CLSI_mic_2000, 
  myGT_CLSI_mic_2001, 
  myGT_CLSI_mic_2002,
  myGT_CLSI_mic_2003, 
  myGT_CLSI_mic_2004, 
  myGT_CLSI_mic_2005, 
  myGT_CLSI_mic_2006, 
  myGT_CLSI_mic_2007, 
  myGT_CLSI_mic_2008,
  myGT_CLSI_mic_2009, 
  myGT_CLSI_mic_2010, 
  myGT_CLSI_mic_2011, 
  myGT_CLSI_mic_2012, 
  myGT_CLSI_mic_2013, 
  myGT_CLSI_mic_2014, 
  myGT_CLSI_mic_2015, 
  myGT_CLSI_mic_2016, 
  myGT_CLSI_mic_2017
  ) 
  
  myGT_CLSI_mic$GDType = "CLSI"
  
  # MIC - EUCA
  #######################
  myGT_EUCA_mic_2009 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_mic_2009.csv", stringsAsFactors = F)
  myGT_EUCA_mic_2009$Year = rep(2009,nrow(myGT_EUCA_mic_2009))
  names(myGT_EUCA_mic_2009) = Names
  myGT_EUCA_mic_2010 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_mic_2010.csv", stringsAsFactors = F)
  myGT_EUCA_mic_2010$Year = rep(2010,nrow(myGT_EUCA_mic_2010))
  names(myGT_EUCA_mic_2010) = Names
  myGT_EUCA_mic_2011 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_mic_2011.csv", stringsAsFactors = F)
  myGT_EUCA_mic_2011$Year = rep(2011,nrow(myGT_EUCA_mic_2011))
  names(myGT_EUCA_mic_2011) = Names
  myGT_EUCA_mic_2012 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_mic_2012.csv", stringsAsFactors = F)
  myGT_EUCA_mic_2012$Year = rep(2012,nrow(myGT_EUCA_mic_2012))
  names(myGT_EUCA_mic_2012) = Names
  myGT_EUCA_mic_2013 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_mic_2013.csv", stringsAsFactors = F)
  myGT_EUCA_mic_2013$Year = rep(2013,nrow(myGT_EUCA_mic_2013))
  names(myGT_EUCA_mic_2013) = Names
  myGT_EUCA_mic_2014 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_mic_2014.csv", stringsAsFactors = F)
  myGT_EUCA_mic_2014$Year = rep(2014,nrow(myGT_EUCA_mic_2014))
  names(myGT_EUCA_mic_2014) = Names
  myGT_EUCA_mic_2015 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_mic_2015.csv", stringsAsFactors = F)
  myGT_EUCA_mic_2015$Year = rep(2015,nrow(myGT_EUCA_mic_2015))
  names(myGT_EUCA_mic_2015) = Names
  myGT_EUCA_mic_2016 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_mic_2016.csv", stringsAsFactors = F)
  myGT_EUCA_mic_2016$Year = rep(2016,nrow(myGT_EUCA_mic_2016))
  names(myGT_EUCA_mic_2016) = Names
  myGT_EUCA_mic_2017 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/EUCA_mic_2017.csv", stringsAsFactors = F)
  myGT_EUCA_mic_2017$Year = rep(2017,nrow(myGT_EUCA_mic_2017))
  names(myGT_EUCA_mic_2017) = Names
  
  myGT_EUCA_mic = rbind(
    myGT_EUCA_mic_2009, 
    myGT_EUCA_mic_2010, 
    myGT_EUCA_mic_2011, 
    myGT_EUCA_mic_2012, 
    myGT_EUCA_mic_2013, 
    myGT_EUCA_mic_2014, 
    myGT_EUCA_mic_2015, 
    myGT_EUCA_mic_2016, 
    myGT_EUCA_mic_2017
  )

  myGT_EUCA_mic$GDType = "EUCA"
  # MIC- SFM
  #######################
  myGT_SFM_mic_2005 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2005.csv",stringsAsFactors = F)
  myGT_SFM_mic_2005$Year = rep(2005,nrow(myGT_SFM_mic_2005))
  names(myGT_SFM_mic_2005) = Names
  
  myGT_SFM_mic_2006 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2006.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2006$Year = rep(2006,nrow(myGT_SFM_mic_2006))
  names(myGT_SFM_mic_2006) = Names
  
  myGT_SFM_mic_2007 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2007.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2007$Year = rep(2007,nrow(myGT_SFM_mic_2007))
  names(myGT_SFM_mic_2007) = Names
  
  myGT_SFM_mic_2008 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2008.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2008$Year = rep(2008,nrow(myGT_SFM_mic_2008))
  names(myGT_SFM_mic_2008) = Names
  
  myGT_SFM_mic_2009 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2009.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2009$Year = rep(2009,nrow(myGT_SFM_mic_2009))
  names(myGT_SFM_mic_2009) = Names
  
  myGT_SFM_mic_2010 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2010.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2010$Year = rep(2010,nrow(myGT_SFM_mic_2010))
  names(myGT_SFM_mic_2010) = Names
  
  myGT_SFM_mic_2011 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2011.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2011$Year = rep(2011,nrow(myGT_SFM_mic_2011))
  names(myGT_SFM_mic_2011) = Names
  
  myGT_SFM_mic_2012 = read.table("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2012.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2012$Year = rep(2012,nrow(myGT_SFM_mic_2012))
  names(myGT_SFM_mic_2012) = Names
  
  myGT_SFM_mic_2013 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2013.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2013$Year = rep(2013,nrow(myGT_SFM_mic_2013))
  names(myGT_SFM_mic_2013) = Names
  
  myGT_SFM_mic_2014 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2014.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2014$Year = rep(2014,nrow(myGT_SFM_mic_2014))
  names(myGT_SFM_mic_2014) = Names
  
  myGT_SFM_mic_2015 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2015.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2015$Year = rep(2016,nrow(myGT_SFM_mic_2015))
  names(myGT_SFM_mic_2015) = Names
  
  myGT_SFM_mic_2016 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2016.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2016$Year = rep(2016,nrow(myGT_SFM_mic_2016))
  names(myGT_SFM_mic_2016) = Names
  
  myGT_SFM_mic_2017 = read.csv("/Users/thomavan/Dropbox/resbank/Breakpoints/csv/SFM_mic_2017.csv", sep = ",",stringsAsFactors = F)
  myGT_SFM_mic_2017$Year = rep(2017,nrow(myGT_SFM_mic_2017))
  names(myGT_SFM_mic_2017) = Names
  
  myGT_SFM_mic = rbind(myGT_SFM_mic_2005,myGT_SFM_mic_2006,myGT_SFM_mic_2007,myGT_SFM_mic_2008,myGT_SFM_mic_2009,myGT_SFM_mic_2010,myGT_SFM_mic_2011,myGT_SFM_mic_2012,myGT_SFM_mic_2013,myGT_SFM_mic_2014,myGT_SFM_mic_2015,myGT_SFM_mic_2016,myGT_SFM_mic_2017)
  myGT_SFM_mic$GDType = "SFM"
  
  myGT_mic = rbind(myGT_CLSI_mic,myGT_EUCA_mic,myGT_SFM_mic)
  
  myGT_mic = as.data.frame(cbind(myGT_mic[1:5],rep(NA,nrow(myGT_mic)),myGT_mic[6:ncol(myGT_mic)]))
  names(myGT_mic) = c("Drug","DrugName","Compound","CompoundName","ATC_Code","disk_content","Ecoli","Salmonella","Staphylococcus","Campylobacter","Enterococcus","Remark","Year","GDType")
  
  myGT_mic$Method2C = rep("AD",nrow(myGT_mic))
  
  ##################################
  # Bind all 
  myGT = rbind(myGT_dd,myGT_mic)

  # re arrange pathogens 
  EcoliDF = as.data.frame(cbind(myGT[1:6],myGT[12:15],rep("Ecoli",nrow(myGT)),myGT[7]), stringsAsFactors = F)
  names(EcoliDF) = c(names(myGT[1:6]),names(myGT[12:15]),"Pathogens","Breakpoints")
  
  SalmonellaDF = as.data.frame(cbind(myGT[1:6],myGT[12:15],rep("Salmonella",nrow(myGT)),myGT[8]))
  names(SalmonellaDF) = c(names(myGT[1:6]),names(myGT[12:15]),"Pathogens","Breakpoints")
  
  StaphylococcusDF = as.data.frame(cbind(myGT[1:6],myGT[12:15],rep("Staphylococcus",nrow(myGT)),myGT[9]))
  names(StaphylococcusDF) = c(names(myGT[1:6]),names(myGT[12:15]),"Pathogens","Breakpoints")
  
  CampylobacterDF = as.data.frame(cbind(myGT[1:6],myGT[12:15],rep("Campylobacter",nrow(myGT)),myGT[10]))
  names(CampylobacterDF) = c(names(myGT[1:6]),names(myGT[12:15]),"Pathogens","Breakpoints")
  
  myGTT = rbind(EcoliDF,SalmonellaDF,StaphylococcusDF,CampylobacterDF)
  myGTT$Pathogens = as.character(myGTT$Pathogens)
  myGTT$Breakpoints = as.numeric(myGTT$Breakpoints)
  
  # Clean Variables NAmes 
  myGTT$ATC_Code = gsub(" ","",myGTT$ATC_Code)
  
  # clean mistake from reading funny csv format 
  myGTT$ATC_Code[myGTT$ATC_Code == "J01CA17\303\212"] = "J01CA17"
  myGTT$ATC_Code[myGTT$ATC_Code == "J01CA17\346"] = "J01CA17"
  
  myGTT$ID = paste(myGTT$Method2C,myGTT$ATC_Code,myGTT$Pathogens,myGTT$Year,myGTT$GDType,sep = "_")
  myGTT$IDY = paste(myGTT$Method2C,myGTT$ATC_Code,myGTT$Pathogens,myGTT$GDType,sep = "_")
  myGTT$IDYAGD = paste(myGTT$Method2C,myGTT$ATC_Code,myGTT$Pathogens,sep = "_")
  
  BPs = NULL
    
  for (i in 1:length(unique(myGTT$IDYAGD))){
    
  mySST = subset(myGTT, IDYAGD == unique(myGTT$IDYAGD)[i] & GDType == "EUCA")  
  Method2Ctag = substr(myGTT$IDYAGD[i],1,2)
  
  if(Method2Ctag == "AD"){
  tmp = min(mySST$Breakpoints, na.rm = T)
  } else {
  tmp = max(mySST$Breakpoints, na.rm = T)  
  }
  
  tmpDF = cbind(unique(myGTT$IDYAGD)[i],tmp)
  BPs = rbind(BPs,tmpDF)
  
  }

  MinBP = as.data.frame(BPs,stringsAsFactors = F)
  names(MinBP) = c("IDYAGD","MinBP")
  MinBP$MinBP = as.numeric(MinBP$MinBP)
  MinBP$MinBP[is.finite(MinBP$MinBP)==F] = NA

  #############################################################################################################
  # Illustration of breakpoints variations over time. 
  #############################################################################################################
  par(mfrow = c(3,1))
  # E Coli cefepime
  #################
  myEcoliDF = subset(myGTT, Pathogens == "Ecoli" & Compound == "FEP" & Method2C == "AD" & GDType == "CLSI")
  par(mar = c(3,5,3,5))
  plot(myEcoliDF$Year,myEcoliDF$Breakpoints, type = "l", ylim = c(0,64), col = "navyblue", 
       xlab = "", ylab = "MIC (mg/L)", main = "E. coli / Cefepime (Cephalosporins)", cex.axis = 2, cex.lab = 2, axes = F, lwd = 2.5)
  axis(1, at = 1997:2017, srt = 45, cex.axis = 1.5)
  axis(2, at = c(2,4,8,16,32,64))
  abline(h = c(2,4,8,16,32,64), col = "grey", lty = 3)
  
  myEcoliDF = subset(myGTT, Pathogens == "Ecoli" & Compound == "FEP" & Method2C == "AD" & GDType == "EUCA")
  lines(myEcoliDF$Year,myEcoliDF$Breakpoints, type = "l", col = "green3", lwd = 2.5)
  
  myEcoliDF = subset(myGTT, Pathogens == "Ecoli" & Compound == "FEP" & Method2C == "AD" & GDType == "SFM")
  lines(myEcoliDF$Year,myEcoliDF$Breakpoints, type = "l", col = "red3", lwd = 2.5)
  
  legend(1998,60,legend = c("CLSI","EUCA","SFM"), fill = c("navyblue","green3","red3"), bty = "n", horiz = T,cex = 2)
  
  #################
  Bug = "Staphylococcus"
  DrugC = "VAN"
  
  myEcoliDF = subset(myGTT, Pathogens == Bug & Compound == DrugC & Method2C == "AD" & GDType == "CLSI")
  plot(myEcoliDF$Year,myEcoliDF$Breakpoints, type = "l", col = "navyblue", xlab = "", ylab = "MIC (mg/L)", main = paste0("Staphylococcus / Vancomycin (Glycopeptide)"),ylim = c(0,32), cex.axis = 2, cex.lab = 2, axes = F, lwd = 2.5)
  axis(1, at = 1997:2017, srt = 45, cex.axis = 1.5)
  axis(2, at = c(2,4,8,16,32,64))
  abline(h = c(2,4,8,16,32,64), col = "grey", lty = 3)
  
  myEcoliDF = subset(myGTT, Pathogens == Bug & Compound == DrugC & Method2C == "AD" & GDType == "EUCA")
  lines(myEcoliDF$Year,myEcoliDF$Breakpoints, type = "l", col = "green3", lwd = 2.5)
  
  myEcoliDF = subset(myGTT, Pathogens == Bug & Compound == DrugC & Method2C == "AD" & GDType == "SFM")
  lines(myEcoliDF$Year,myEcoliDF$Breakpoints, type = "l", col = "red3", lwd = 2.5)
  
  #################
  myEcoliDF = subset(myGTT, Pathogens == "Campylobacter" & Compound == "CIP" & Method2C == "DD" & GDType == "CLSI")
  plot(myEcoliDF$Year,myEcoliDF$Breakpoints, type = "l", col = "navyblue", 
       xlab = "", ylab = " radius (mm)", main = "Campylobacter / Ciprofloxacin (Quinolonne)",ylim = c(0,25), cex.axis = 2, cex.lab = 2, axes = F, lwd = 2.5)
  axis(1, at = 1997:2017, srt = 45, cex.axis = 1.5)
  axis(2, at =  c(0,5,10,15,20,25))
  abline(h = c(0,5,10,15,20,25), col = "grey", lty = 3)
  
  myEcoliDF = subset(myGTT, Pathogens == "Campylobacter" & Compound == "CIP" & Method2C == "DD" & GDType == "EUCA")
  lines(myEcoliDF$Year,myEcoliDF$Breakpoints, type = "l", col = "green3", lwd = 2.5)
  
  myEcoliDF = subset(myGTT, Pathogens == "Campylobacter" & Compound == "CIP" & Method2C == "DD" & GDType == "SFM")
  lines(myEcoliDF$Year,myEcoliDF$Breakpoints, type = "l", col = "red3", lwd = 2.5)
  
 
  

  
  
  
  
  
  
  
 
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  
 
  





