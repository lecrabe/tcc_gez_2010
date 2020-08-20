## Dont change the parameters
aoi_name   <- paste0(aoi_dir,'GADM_',countrycode)
aoi_shp    <- paste0(aoi_name,".shp")
aoi_tif    <- paste0(aoi_name,".tif")
aoi_field  <- "id_aoi"

tcc_country_file  <- paste0(tcc_dir,"tmp_tcc2010_",countrycode,".tif")
tcc_clip_file     <- paste0(tcc_dir,"tmp_tcc2010_clip_",countrycode,".tif")
tcc_proj_file     <- paste0(tcc_dir,"tcc2010_",countrycode,".tif")
tcc_stats_file    <- paste0(tcc_dir,"gez_tcc_stats_",countrycode,".txt")

country_gez       <- paste0(gez_dir,"gez_",countrycode,".tif")

stt_file          <- paste0(stt_dir,"stats_tcc_gez_",countrycode,".csv")
