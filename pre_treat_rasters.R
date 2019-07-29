### step 0 Load shapefile to get extent
mySHP = shapefile("/Users/thomavan/Dropbox/AAuse/data/World.shp")
mySHPLMICs = mySHP[(mySHP@data$ISO3 %in% c("USA","CAN","RUS","KOR","JPN","AUS","NZL","GRL") == F),]
mySHPLMICs = mySHPLMICs[(mySHPLMICs@data$CONTINENT != "Europe"),]
mySHPLMICs = mySHPLMICs[mySHPLMICs@data$CONTINENT %in% c("North America","South America","Africa","Asia"),]

### step 1. Create Spatial Objects 
myLPS = raster("/Users/thomavan/Dropbox/resbank/data/ps_cmb")
myABX = raster("/Users/thomavan/Dropbox/AAuse/data/output/GISlayers/GISlayers/tot_L10p.tif")

myACC =  raster("/Users/thomavan/Dropbox/resbank/data/accessibility_to_cities_2015_v1.0.tif")
myACC[][myACC[] == -9999] = NA 

myVeg = raster("/Users/thomavan/Dropbox/resbank/data/Hansen_treecover_1km.tif") # wait to get it from Jief !!!

# Read livestock data 
Ca = raster("/Users/thomavan/Dropbox/resbank/data/Ct2013.tif")
Ca[][Ca[] == -9999] = NA 
PgInt = raster("/Users/thomavan/Dropbox/resbank/data/PgIntInd2013.tif")
PgInt[][PgInt[] == -9999] = NA 
PgExt = raster("/Users/thomavan/Dropbox/resbank/data/PgExt2013.tif")
PgExt[][PgExt[] == -9999] = NA 
ChInt = raster("/Users/thomavan/Dropbox/resbank/data/ChInt2013.tif")
ChInt[][ChInt[] == -9999] = NA 
ChExt = raster("/Users/thomavan/Dropbox/resbank/data/ChExt2013.tif")
ChExt[][ChExt[] == -9999] = NA 

# Read Human dPopulation Dataset 
hpop = raster("/Users/thomavan/Dropbox/resbank/data/gpw_v4_population_density_rev10_2015_30_sec.tif")

# Read GLC toe xtact urban areas
GLC = raster("/Users/thomavan/Dropbox/resbank/data/GLOBCOVER_L4_200901_200912_V2.3.tif")

# Read Climate variables
T1 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_01.tif")  
T2 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_02.tif")  
T3 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_03.tif")  
T4 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_04.tif")  
T5 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_05.tif")  
T6 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_06.tif")  
T7 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_07.tif")  
T8 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_08.tif")  
T9 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_09.tif")  
T10 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_10.tif")  
T11 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_11.tif")  
T12 = raster("/Users/thomavan/Dropbox/resbank/data/worldclim/wc2.0_2.5m_tmin_12.tif")  

myRSTempAvg = mean(stack(T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12),na.rm = T) 

# Read Irrigation Areas 
irigation = raster("/Users/thomavan/Dropbox/resbank/data/gmia_v5_aei_pct.asc")

myAB_mySHPLMICs = crop(myABX,extent(mySHPLMICs))
myLPS_mySHPLMICs = crop(myLPS,extent(mySHPLMICs))
myACC_mySHPLMICs = crop(myACC,extent(mySHPLMICs))
myTMP_mySHPLMICs = crop(myRSTempAvg,extent(mySHPLMICs))
myIRG_mySHPLMICs = crop(irigation,extent(mySHPLMICs))
myHPOP_mySHPLMICs = crop(hpop,extent(mySHPLMICs))
myGLC_mySHPLMICs = crop(GLC,extent(mySHPLMICs))
myVeg_mySHPLMICs = crop(myVeg,extent(mySHPLMICs))


CaLMICs = crop(Ca,extent(mySHPLMICs))
PgExtLMICs = crop(PgExt,extent(mySHPLMICs))
PgIntLMICs = crop(PgInt,extent(mySHPLMICs))
ChIntLMICs = crop(ChInt,extent(mySHPLMICs))
ChExtLMICs = crop(ChExt,extent(mySHPLMICs))

# Resample everything at 10K resolution
#myAB_mySHPLMICs_10K = aggregate(myAB_mySHPLMICs, fact=5, fun=mean, expand=TRUE, na.rm=TRUE)
#proj4string(myAB_mySHPLMICs_10K) = CRS("+proj=longlat +datum=WGS84")

use = myAB_mySHPLMICs
# Define mask 
myMaskAll = rasterize(mySHP, use)
myMaskALL = myMaskAll>0
myMask = rasterize(mySHPLMICs, use)
myMask = myMask > -1
myMaskNone = myMaskAll-myMask
myMask_p = projectRaster(myMask, crs = CRS("+proj=longlat +datum=WGS84"))
myMask_p = resample(myMask_p,use)

CentroidsX = xFromCell(use, 1:length(use[]))
CentroidsY = yFromCell(use, 1:length(use[]))

XCoord = YCoord = use

XCoord[] = CentroidsX
YCoord[] = CentroidsY

XCoord = XCoord * myMask_p
YCoord = YCoord * myMask_p

# Resample everything at 'use' resolution and characterictics
lps = round(raster::resample(myLPS_mySHPLMICs,use))
acc = raster::resample(myACC_mySHPLMICs,use)
tmp = raster::resample(myTMP_mySHPLMICs,use)
irg = raster::resample(myIRG_mySHPLMICs,use)
PgExt = raster::resample(PgExtLMICs,use)
PgInt = raster::resample(PgIntLMICs,use)
ChExt = raster::resample(ChExtLMICs,use)
ChInt = raster::resample(ChIntLMICs,use)
Ca = raster::resample(CaLMICs,use)
XCoord = raster::resample(XCoord,use)
YCoord = raster::resample(YCoord,use)
hpop = raster::resample(myHPOP_mySHPLMICs,use)
glc = raster::resample(myGLC_mySHPLMICs,use,method = 'ngb')
veg = raster::resample(myVeg_mySHPLMICs,use,method = 'ngb')

hpop = hpop * myMask_p

# create urban extent mask 
urb = glc
urb[][urb[] == 190] = NA
urb[][is.na(urb[]) == F] = 1

# create rural population density 
rhpop = (hpop * urb)

L1plps = lps
L1pacc = log10(acc+1)
L1ptmp = log10(tmp+273.15) #express in Kelvin degree to avoid to creation of zeros 
L1pirg = log10(irg+1)
L1pPgExt = log10(PgExt+1)
L1pPgInt = log10(PgInt+1)
L1pChExt = log10(ChExt+1)
L1pChInt = log10(ChInt+1)
L1pCa = log10(Ca+1)
L1prhpop = log10(rhpop+1)
L1pveg = log10(veg+1)

myRSLog10 = stack(use,L1plps,L1pacc,L1ptmp,L1pirg,L1pPgExt,L1pPgInt,L1pChExt,L1pChInt,L1pCa,L1pveg)

# Define plotting mask 
mySHPnoGr = mySHP[-which(mySHP@data$NAME == "Greenland"),]
myPMask  = crop(myABX,mySHP)
myPMaskE = extent(myPMask)
myPMaskc = crop(myPMask, extent(c(-167.15,myPMaskE[2],myPMaskE[3],77.06158)))


writeRaster(myPMaskc, "/Users/thomavan/Dropbox/resbank/data/plot_mask", overwrite=T)
writeRaster(myMask_p, "/Users/thomavan/Dropbox/resbank/data/mask", overwrite=T)
writeRaster(L1prhpop, "/Users/thomavan/Dropbox/resbank/data/L1prhpop", overwrite=T)
writeRaster(myRSLog10, "/Users/thomavan/Dropbox/resbank/data/predStackl10", overwrite=T)


