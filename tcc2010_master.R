####################################################################################
#######          TCC 2010 and GEZ 2010  ZONAL                   ####################
#######          FAO Open Foris SEPAL project                   ####################
#######          Contact: remi.dannunzio@fao.org                ####################
#######          Last update: 2020/08/19
####################################################################################

####################################################################################
###### RUN THIS FIRST
####################################################################################
source(paste0(normalizePath("~"),"/tcc_gez_2010/scripts/","config.R"))


####################################################################################
###### EDIT THE INPUTS
####################################################################################
code_list
(countrycode <- code_list[1])
countrycode <- "BEL"
####################################################################################
###### RUN THE SCRIPTS
####################################################################################
#for(countrycode in code_list[1:2]){

source(paste0(scriptdir,'variables.R'))
source(paste0(scriptdir,"b0_get_aoi.R")           ,echo = T)
source(paste0(scriptdir,"b1_download_tcc2010.R")  ,echo = T)
source(paste0(scriptdir,"b2_gez_tcc_2010_zonal.R"),echo = T)
source(paste0(scriptdir,"b3_display_results.R")   ,echo = T)

#  }

source(paste0(scriptdir,"cleans.R"))



####################################################################################
# FAO declines all responsibility for errors or deficiencies in the database or
# software or in the documentation accompanying it, for program maintenance and
# upgrading as well as for any # damage that may arise from them. FAO also declines
# any responsibility for updating the data and assumes no responsibility for errors
# and omissions in the data provided. Users are, however, kindly asked to report any
# errors or deficiencies in this product to FAO.
####################################################################################