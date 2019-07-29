library(gdata)
library(raster)
library(RColorBrewer)
library(gstat)
library(foreign)
library(rgeos)
library(dplyr)
library(mgcv)
library(dismo)
library(glmnet)
library(pROC)
library(fields)
library(gamsel)
library(spatialEco)
library(usdm)
setwd("/Users/thomavan/Dropbox/resbank/")

# Mapping P50
P10Bin = F
source("scripts/00_library.r")

# Merge All resbank Data Sources collected for different region by different Analysts 
#source("scripts/0_merge_resbank_sources.r")

# Import resbank(s)
source("scripts/1_PreTreatment_v2.r")

# HArmonize Resistance Rates
source("scripts/Harmonization_RR_v5.r")

# Descriptive statistics of AMR datasets
source("scripts/2_Descriptive_Stats_v3_CI.r")

# Build Metric of Resistance 
source("scripts/3_ResistanceSummaryMetric_v2_EQAS.r") 

# Spatial Interpolation of Resistance 
source("scripts/4_GeospatialModelling_v5_signVar_EQAS.r")

# Risk factors analysis of each Child-model
source("scripts/5_PostProcessingRiskFactors.r")

# Plot output maps 
source("scripts/6_Map_P50_p10_contrasts_EQAS.r")

# Calculate proportion of the global production of meat occuring in hotspots of resistance. 
source("scripts/7_AnimalsExposed_EQAS_CI.r")

# Export outputs as Google Earth objects 
source('scripts/9_Google_Exports.r')

# 


