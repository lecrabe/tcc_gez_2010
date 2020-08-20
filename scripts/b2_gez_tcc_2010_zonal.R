#################### SKIP IF OUTPUTS EXISTS ALREADY
if(!file.exists(tcc_stats_file)){
  
  
  #############################################################
  ### RASTERIZE COUNTRY BOUNDARIES ON TCC2010 PRODUCT
  #############################################################
  system(sprintf("oft-rasterize_attr.py -v %s -i %s -o %s -a %s",
                 aoi_shp,
                 tcc_country_file,
                 aoi_tif,
                 aoi_field
  ))
  
  
  #############################################################
  #################### COMBINATION BOUNDARIES AND TCC2010
  #############################################################
  system(sprintf("gdal_calc.py -A %s -B %s --co COMPRESS=LZW --overwrite --outfile=%s --calc=\"%s\"",
                 tcc_country_file,
                 aoi_tif,
                 tcc_clip_file,
                 paste0("(B==0)*123+(B>0)*A")
  ))
  
  
  #############################################################
  ################### REPROJECT IN EA PROJECTION
  #############################################################
  system(sprintf("gdalwarp -t_srs \"%s\" -overwrite -ot Byte -dstnodata none -co COMPRESS=LZW %s %s",
                 proj_ea ,
                 tcc_clip_file,
                 tcc_proj_file
  ))
  
  #plot(raster(tcc_country_clip_file))
  
  
  #############################################################
  #################### TAKE TCC2010 AS ALIGNMENT GRID
  #############################################################
  mask   <- tcc_proj_file
  proj   <- proj4string(raster(mask))
  extent <- extent(raster(mask))
  res    <- res(raster(mask))[1]
  
  
  #############################################################
  #################### ALIGN GEZ WITH TCC2010
  #############################################################
  input  <- all_gez
  ouput  <- country_gez
  
  system(sprintf("gdalwarp -co COMPRESS=LZW -t_srs \"%s\" -te %s %s %s %s -tr %s %s %s %s -overwrite",
                 proj4string(raster(mask)),
                 extent(raster(mask))@xmin,
                 extent(raster(mask))@ymin,
                 extent(raster(mask))@xmax,
                 extent(raster(mask))@ymax,
                 res(raster(mask))[1],
                 res(raster(mask))[2],
                 input,
                 ouput
  ))
  
  
  #############################################################
  ### COMPUTE ZONAL STATISTICS
  #############################################################
  system(sprintf("oft-zonal_large_list.py -um %s -i %s -o %s -a %s",
                 country_gez,
                 tcc_proj_file,
                 tcc_stats_file,
                 aoi_field
  ))
  
 
 }


