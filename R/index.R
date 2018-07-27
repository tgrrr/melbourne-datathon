rm(list = ls()) # clear everything
# setwd(./.)
setwd("~/code/data-science/melbourne-datathon/R")
source('components/install-and-load-packages.R', print.eval = F, encoding = 'UTF-8')
source('components/packages.R', print.eval=F, encoding = 'UTF-8')
source('components/index.R', print.eval = F, encoding = 'UTF-8')
LoadComponents(functionsList)
InstallAndLoadPackages(packages)

# routes
r <- plumb('pages/test__echo.R')
r <- plumb('pages/test__json.R')
r <- plumb('pages/test__text.R')
r$run(port = 8888, host = '127.0.0.1')
