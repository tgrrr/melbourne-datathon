
# install.packages("jsonlite")
library(readr)
library(jsonlite)
library(dplyr)
library(magrittr)

setwd("~/code/data-science/melbourne-datathon/data/")

wd <- "~/code/data-science/melbourne-datathon/data/crimes_unweightedJSON.js"

crimes_unweighted <- read_csv("crime_tram_model_notNormalised.csv")
head(crimes_unweighted, 100)

  
#   # "crimes_weightedJSON.js"
# crimes_weighted <- read_csv("crimes_weighted.csv")
# head(crimes_weighted)

# crimes_unweighted <- crimes_unweighted[,c("lat", "lon", "Severity.Total.Score" )]

head(crimes_unweighted)

crimes_unweighted %<>% rename(lng = Longitude, lat = Latitude, weight = "Severity.Total.Score" )

head(crimes_unweighted)

# head(crimes_weighted)

# toJSON(setNames(crimes_weighted))

# crimes_weightedJSON <- jsonlite(crime_unweighted)

crimes_unweightedJSON <- jsonlite::toJSON(crimes_unweighted)

head(crimes_unweightedJSON)

write_file(crimes_unweightedJSON, path = wd )
# write_file()


