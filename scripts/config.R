####################################################################################################
root <- paste0(normalizePath("~"),"/") 

tcc_dwn_dir <- paste0(root,"downloads/tcc2010/")
rootdir     <- paste0(root,"tcc2010/")
scriptdir   <- paste0(rootdir,"scripts/")
data_dir    <- paste0(rootdir,"data/")
tmp_dir     <- paste0(rootdir,"tmp/")
tcc_dir       <- paste0(data_dir,"tcc/")
aoi_dir       <- paste0(data_dir,"aoi/")
stt_dir       <- paste0(data_dir,"stat/")
gez_dir       <- paste0(data_dir,"gez/")

dir.create(scriptdir,showWarnings = F)
dir.create(tcc_dwn_dir,recursive=T,showWarnings = F)
dir.create(data_dir,showWarnings = F)
dir.create(tcc_dir,showWarnings = F)
dir.create(gez_dir,showWarnings = F)
dir.create(aoi_dir,showWarnings = F)
dir.create(stt_dir,showWarnings = F)
dir.create(tmp_dir,showWarnings = F)

all_gez   <- paste0(root,"/gez_2010/gez_2010_wgs84.tif")
gez_codes <- paste0(root,"/gez_2010/gez_codes.csv")

####################################################################################################
#################### load packages
source(paste0(scriptdir,'packages.R'))

####################################################################################################

## Get List of Countries 
print(gadm_list  <- data.frame(getData('ISO3')))


