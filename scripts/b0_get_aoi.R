aoi   <- getData('GADM',
                 path=aoi_dir,
                 country= countrycode,
                 level=0)

print(countrycode)

aoi   <- spTransform(aoi,CRS('+init=epsg:4326'))


aoi@data[,aoi_field] <- row(aoi)[,1]

writeOGR(obj = aoi,
         dsn = aoi_shp,
         layer = aoi_name,
         driver = "ESRI Shapefile",
         overwrite_layer = T)
