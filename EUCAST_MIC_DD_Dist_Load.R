# Load MIC and DD Distributions from EUCAST

myADDist = read.csv("/Users/thomavan/Dropbox/resbank/MIC_disk_distributions/pathogen_MIC_dist.csv")
myADDist$ATC_Code = gsub(" ","",myADDist$ATC_Code)
myADDist$IDY_EUCA = paste0("AD_",myADDist$ATC_Code,"_",myADDist$Pathogen)

myDDDist = read.csv("/Users/thomavan/Dropbox/resbank/MIC_disk_distributions/pathogen_disk_dist.csv")
myDDDist$ATC_Code = gsub(" ","",myDDDist$ATC_Code)
myDDDist$IDY_EUCA = paste0("DD_",myDDDist$ATC_Code,"_",myDDDist$Pathogen)


#BP = 2
#BPref = 4
#IDY = "AD_J01CA01_Salmonella_EUCA"

#BP = 18
#BPref = 22
#IDY = "DD_J01EA01_Ecoli_EUCA"

# This function takes a breakpoint (BP) and compares it to a reference breakpoint to 
# return a modulation factor for the resistance rates based on a distribution of MIC/DD from EUCAST, 
ModulateFR = function(BP,BPref,IDY_EUCA){

resp = 1
ATC = substr(IDY_EUCA,4,10)
  
  if((ATC %in% c("J01EE01","J01EA01","J01EC01")==F)){
  if(all(is.na(c(BP,BPref))==F) & (BP != BPref)){
    
    if(substr(IDY_EUCA,1,2) == "AD"){ #MIC case
  
      Dist = myADDist[match(IDY_EUCA,myADDist$IDY_EUCA),4:22]
      DistValue = as.numeric(substr(names(Dist),2,nchar(names(Dist))))
      AUC = sum(Dist[1,DistValue <= BP])
      AUCref = sum(Dist[1,DistValue <= BPref])
      resp = AUC/AUCref  
    }
    
    if(substr(IDY_EUCA,1,2) == "DD"){ #Disc Diffusion case
      
      Dist = myDDDist[match(IDY_EUCA,myDDDist$IDY_EUCA),5:49]
      DistValue = as.numeric(substr(names(Dist),2,nchar(names(Dist))))
      AUC = sum(Dist[1,DistValue <= BP])
      AUCref = sum(Dist[1,DistValue <= BPref])
      resp = AUCref/AUC
    }

  }
  }

return(resp)
}

ModulateFR2 = function(BP,BPref,IDY_EUCA){
  
  resp = 1
  ATC = substr(IDY_EUCA,4,10)
  
  if((ATC %in% c("J01EE01","J01EA01","J01EC01")==F)){
    if(all(is.na(c(BP,BPref))==F) & (BP != BPref)){
      
      if(substr(IDY_EUCA,1,2) == "AD"){ #MIC case
        
        Dist = myADDist[match(IDY_EUCA,myADDist$IDY_EUCA),4:22]
        if(all(is.na(Dist)==F)){
        DistValue = as.numeric(substr(names(Dist),2,nchar(names(Dist))))
        AUC = sum(Dist[1,DistValue >= BP])
        AUCref = sum(Dist[1,DistValue >= BPref])
        resp = AUCref/AUC  
        }
      }
      
      if(substr(IDY_EUCA,1,2) == "DD"){ #Disc Diffusion case
        Dist = myDDDist[match(IDY_EUCA,myDDDist$IDY_EUCA),5:49]
        if(all(is.na(Dist)==F)){
        DistValue = as.numeric(substr(names(Dist),2,nchar(names(Dist))))
        AUC = sum(Dist[1,DistValue <= BP], na.rm = T)
        AUCref = sum(Dist[1,DistValue <= BPref])
        resp = AUCref/AUC
        }
      }
      
    }
  }
  
  return(resp)
}





