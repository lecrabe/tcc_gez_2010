tiles <- calc_gfc_tiles(aoi)

proj4string(tiles) <- proj4string(aoi)

tiles <- tiles[aoi,]
plot(tiles)
plot(aoi,add=T)

### Find the suffix of the associated GFC data for each tile
tmp         <- data.frame(1:length(tiles),rep("nd",length(tiles)))
names(tmp)  <- c("tile_id","gfc_suffix")

for (n in 1:length(tiles)) {
  gfc_tile <- tiles[n, ]
  min_x <- bbox(gfc_tile)[1, 1]
  max_y <- bbox(gfc_tile)[2, 2]
  if (min_x < 0) {min_x <- paste0(sprintf("%03i", abs(min_x)), "W")}
  else {min_x <- paste0(sprintf("%03i", min_x), "E")}
  if (max_y < 0) {max_y <- paste0(sprintf("%02i", abs(max_y)), "S")}
  else {max_y <- paste0(sprintf("%02i", max_y), "N")}
  tmp[n,2] <- paste0("_", max_y, "_", min_x, ".tif")
}

### Store the information into a SpatialPolygonDF
df_tiles <- SpatialPolygonsDataFrame(tiles,tmp,match.ID = F)
rm(tmp)

prefix <- "https://glad.umd.edu/Potapov/TCC_2010/treecover2010_"
suffix <- ".tif"
tilesx <- substr(df_tiles@data$gfc_suffix,2,nchar(df_tiles@data$gfc_suffix)-4)

tile <- tilesx[1]

### DOWNLOAD GLAD 2010 data
for(tile in tilesx){
  print(tile)
  to_down <- paste0(prefix,tile,suffix)
  tile_file <- paste0(tcc_dwn_dir,"tcc_2010_",tile,suffix)
  
  if(!file.exists(tile_file)){
  system(sprintf("wget -O %s %s",
                 tile_file,
                 to_down
                 )
  )
  }else{print("skipping")}
}


### MERGE THE TILES TOGETHER and CLIP TO THE BOUNDING BOX OF THE COUNTRY
(bb    <- extent(aoi))

if(!file.exists(tcc_proj_file)){
  if(!file.exists(tcc_country_file)){

  system(sprintf("gdalbuildvrt -te %s %s %s %s %s %s",
                 floor(bb@xmin),
                 floor(bb@ymin),
                 ceiling(bb@xmax),
                 ceiling(bb@ymax),
                 paste0(tmp_dir,"tmp_merge.vrt"),
                 paste0(tcc_dwn_dir,"tcc_2010_",tilesx,suffix,collapse = " ")
  ))

  system(sprintf("gdal_translate -ot Byte -projwin %s %s %s %s -co COMPRESS=LZW %s %s",
                 floor(bb@xmin),
                 ceiling(bb@ymax),
                 ceiling(bb@xmax),
                 floor(bb@ymin),
                 paste0(tmp_dir,"tmp_merge.vrt"),
                 tcc_country_file
  ))

 
} #### END OF EXISTS MERGE
}
system(sprintf("rm -f -r %s",
               paste0(tmp_dir,"tmp_merge.vrt")
               ))

