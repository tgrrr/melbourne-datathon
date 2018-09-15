source('./01-load-packages/install-and-load-packages.R', print.eval = F, encoding = 'UTF-8', local=T)
source('./01-load-packages/packages.R', print.eval=F, encoding = 'UTF-8')
source('./components/index.R', print.eval=F, encoding = 'UTF-8')
# source('./components/sample-dataset.R')
LoadComponents(functionsList)
InstallAndLoadPackages(packages, setLocalWorkingDirectory)
cat("\014") # Clear the console

# install.packages("jsonlite")
library(readr)
library(jsonlite)


setwd("~/code/data-science/melbourne-datathon/data/")

wd <- "~/code/data-science/melbourne-datathon/data/crimes_weightedJSON.js"
  
  # "crimes_weightedJSON.js"
crimes_weighted <- read_csv("crimes_weighted.csv")
head(crimes_weighted)

crimes_weighted <- crimes_weighted[,c("lat", "lon", "Severity Total Score" )]

crimes_weighted %<>% rename(lng = lon, weight = "Severity Total Score" )

head(crimes_weighted)

# toJSON(setNames(crimes_weighted))

crimes_weightedJSON <- jsonlite(crimes_weighted)

crimes_weightedJSON <- jsonlite::toJSON(crimes_weighted)

head(crimes_weightedJSON)

write_file(crimes_weightedJSON, path = wd )
# write_file()


