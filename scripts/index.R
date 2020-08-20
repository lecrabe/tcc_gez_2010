gdaltindex index_tcc.shp tcc_2010_*.tif

plot(readOGR(paste0(tcc_dwn_dir,"index_tcc.shp")))