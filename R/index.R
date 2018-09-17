rm(list = ls()) # clear everything

# TODO: move this to a config file
# you might need to customise this directory:
# setwd(./.)
setLocalWorkingDirectory <- "~/code/data-science/melbourne-datathon/R"

setwd(setLocalWorkingDirectory)

source('./01-load-packages/install-and-load-packages.R', print.eval = F, encoding = 'UTF-8', local=T)
source('./01-load-packages/packages.R', print.eval=F, encoding = 'UTF-8')
source('./components/index.R', print.eval=F, encoding = 'UTF-8')
# source('./components/sample-dataset.R')
LoadComponents(functionsList)
InstallAndLoadPackages(packages, setLocalWorkingDirectory)
cat("\014") # Clear the console

# Only needs to be run once to convert touch on touch off data to scan_on_sample and scan_off_sample
# source('02-import-data/import-public-transport-data.R', print.eval = F, encoding = 'UTF-8')
# BindAllSamplesIntoDataFrame(mySamp = 0)
# BindAllSamplesIntoDataFrame(mySamp = 1)

# Create a smaller sample of our dataset for efficient testing of the api:
# SampleDataSet('alldata_wStopIDs_version02.csv', 50)

# sample <-
#   read_csv("sample_ptv_data_combined.csv") %>% 
#   as.data.frame()
# head(sample_ptv_data_combined)
# 
# str(sample)
# 
# sample %>%
#   subset(
#     select = c(GPSLat, GPSLong, StopNameLong)
#   )
# sample$stopCharLength <- nchar()
# 
# sample$StopNameLong %<>% nchar()
# 
# sample


# fun1 <- function(x, column){
#   nchar(x[[column]])
# }
# fun1(sample, "StopNameLong")
# # fun1(df, c("B","A"))
# lapply(sample, FUN = fun1 )
# 
# sample_ptv_data_combined %>% head()

# crimes_weighted <- read_csv("~/code/data-science/melbourne-datathon/data/crimes_weighted.csv")
# head(crimes_weighted)

# Setup our router

# r <- plumb('10-r-app/pages/demo-api__json.R')
# r$run(port = 8888, host = '127.0.0.1')


# rm(list = ls()) # clear everything
# cat("\014") # Clear the console
