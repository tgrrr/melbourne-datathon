rm(list = ls()) # clear everything

# TODO: move this to a config file
# you might need to customise this directory:
# setwd(./.)
setLocalWorkingDirectory <- "~/code/data-science/melbourne-datathon/R"

setwd(setLocalWorkingDirectory)

source('./01-load-packages/install-and-load-packages.R', print.eval = F, encoding = 'UTF-8', local=T)
source('./01-load-packages/packages.R', print.eval=F, encoding = 'UTF-8')
source('./components/index.R', print.eval=F, encoding = 'UTF-8')
LoadComponents(functionsList)
InstallAndLoadPackages(packages, setLocalWorkingDirectory)
cat("\014") # Clear the console

# Only needs to be run once to convert touch on touch off data to scan_on_sample and scan_off_sample
# source('02-import-data/import-public-transport-data.R', print.eval = F, encoding = 'UTF-8')
# BindAllSamplesIntoDataFrame(mySamp = 0)
# BindAllSamplesIntoDataFrame(mySamp = 1)


# setwd(setLocalWorkingDirectory)
setDataDirectory <- "~/code/data-science/melbourne-datathon/data/all_scanOff_scanOn"

# Setup our router

# r <- plumb('10-r-app/pages/demo-api__json.R')
# r$run(port = 8888, host = '127.0.0.1')


# rm(list = ls()) # clear everything
# cat("\014") # Clear the console
