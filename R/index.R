rm(list = ls()) # clear everything
# setwd(./.)
setwd("~/code/data-science/melbourne-datathon/R")
source('components/install-and-load-packages.R', print.eval = F, encoding = 'UTF-8')
source('components/packages.R', print.eval=F, encoding = 'UTF-8')
source('components/index.R', print.eval = F, encoding = 'UTF-8')
LoadComponents(functionsList)
InstallAndLoadPackages(packages)

source('components/code_headers.R', print.eval = F, encoding = 'UTF-8')

# Setup our router
r <- plumb('pages/demo-api__json.R')
r$run(port = 8888, host = '127.0.0.1')
