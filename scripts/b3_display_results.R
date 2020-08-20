#############################################################
### READ TABLE
#############################################################
df        <- read.table(tcc_stats_file)
names(df) <- c("gez_code","total",paste0("tc_",0:(ncol(df)-3)))

#############################################################
### READ GEZ CODES AND MERGE
#############################################################
gez <- read.csv(gez_codes)
dd  <- merge(df,gez,by.x="gez_code",by.y="gez_code",all.x=T)

#############################################################
### DISPLAY AREAS PER ECOZONE PER TREECOVER 2010 CLASS
#############################################################
melt <- melt(dd,
             "gez_name",
             paste0("tc_",0:100),
             variable.name = 'tc_class',
             value.name = 'pixels')

res    <- res(raster(tcc_proj_file))[1]

melt$treecover <- as.numeric(gsub("tc_","", melt$tc_class))
melt$areas_ha  <- melt$pixels*res*res/10000000

p<-ggplot(data=melt, aes(x=treecover, y=areas_ha)) +
  geom_bar(stat="identity")

p+facet_wrap( gez_name ~ .,ncol=1 )+ labs(x = "Tree cover (%)",y="Area (1000 ha)")

out <- dd[,c("gez_name","gez_code","total",paste0("tc_",0:100))]
print(out[,1:3])
write.csv(out,stt_file,row.names = F)
