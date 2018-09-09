######################################################################
## PACKAGES
######################################################################
library(readr)
library(data.table)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
library(beepr)
library(magrittr)
library(ggplot2)
library(ggmap)
library(RColorBrewer)
library(xts)

## set your own working directory 
# setwd("/Users/ellenitoumpas/Dropbox/DATA/DATATHON/datathon/melbourne-datathon/")
setwd("~/code/data-science/melbourne-datathon/datahead(/")



######################################################################
######################################################################
## TOUCH ON TOUCH OFF DATA
######################################################################
######################################################################

all_data <- read_csv(all_data_combined.csv", col_names = TRUE)
all_data_wstopid_v01 <- read_csv(alldata_wStopIDs_version01.csv", col_names = TRUE)
stoplocations <- read.table("stop_locations.txt", sep="|", fill = TRUE, col.names=c("StopLocationID" , "StopNameShort", "StopNameLong", "StopType", "SuburbName", "PostCode", "RegionName", "LocalGovernmentArea", "StatDivision", "GPSLat", "GPSLong"))
calendar <- read.table("calendar.txt", sep="|", header=FALSE, col.names = c("DateSequence", "Date" ,"CalendarYear" ,"FinancialYear" ,"FinancialMonth" ,"CalendarMonth" ,"CalendarMonthSeq" ,"CalendarQuarter" ,"FinancialQuarter" ,"CalendarWeek" ,"FinancialWeek" ,"DayType" ,"DayTypeCategory", "DayTypeCategoryMore","WeekdaySeq" ,"WeekDay" ,"FinancialMonthSeq" ,"FinancialMonthName" ,"MonthNumber" ,"ABSWeek" ,"WeekEnding" ,"QuarterName"))
car_speeds <- read_csv("melbourne_vehicle_traffic.csv")
card_type <- read.table("card_types.txt", sep="|", header=FALSE, col.names = c("Card_SubType_ID" , "Card_SubType_Desc", "Payment_Type", "Fare_Type", "Concession_Type", "MI_Card_Group"))
colnames(stop_locations) <- c("StopLocationID" , "StopNameShort", "StopNameLong", "StopType", "SuburbName", "PostCode", "RegionName", "LocalGovernmentArea", "StatDivision", "GPSLat", "GPSLong")
xml_stops <- read_csv("xml-stopid.csv")

View(all_data)

colnames(all_data)

######################################################################
## UNDERSTANDING MODE COLUMN
######################################################################

# a tally of Mode data
all_data_tallied <- all_data_wstopid_v01 %>% group_by(Mode) %>% tally(sort=FALSE)
percent <- round((all_data_tallied$n/sum(all_data_tallied$n)*100),2)
all_data_tallied <- cbind(all_data_tallied, percent)

# a piechart showing distribution of Mode data
lbls <- paste("Mode ",all_data_tallied$Mode)
lbls <- paste(lbls, percent,sep=" [")
lbls <- paste(lbls,"%]",sep="") # ad % to labels 
pie(all_data_tallied$n, labels = lbls, main="Piechart of Modes for all data")

# can we show anything else with Mode?
mode_01 <- subset(all_data_tallied, Mode=="1")
mode_02 <- subset(all_data_tallied, Mode=="2")
mode_03 <- subset(all_data_tallied, Mode=="3")


alldata_noNA <-subset(all_data_wstopid_v01,all_data_wstopid_v01$GPSLat!="NA") 
View(alldata_noNA)

# map with modes
# mapgilbert <- get_map(location = c(lon = mean(alldata_noNA$GPSLong), lat = mean(alldata_noNA$GPSLat)), zoom = 9,
#                       maptype = "roadmap", scale = 2)
# 
# ggmap(mapgilbert) + geom_point(aes(x = GPSLong, y = GPSLat, size = 3), data = alldata_noNA, alpha = .5)


View(mode_01)
View(mode_02)
View(mode_03)


######################################################################
## UNDERSTANDING DATE COLUMN
######################################################################

# Find the Most Popular travel dates (as a top 10)
popular_dates <- all_data_wstopid_v01 %>% group_by(BusinessDate) %>% tally(sort=TRUE)
popular_dates_top10 <- popular_dates[1:10,]
popular_dates_top10

# Create a 'day of the week' column
all_data_withDay <-  mutate(all_data_wstopid_v01, day = wday(BusinessDate, label = TRUE, abbr = TRUE))

# Add the 'day of the week' to Most Popular Dates top 10
popular_dates_top10_withDay <- mutate(popular_dates_top10, day = wday(BusinessDate, label = TRUE, abbr = TRUE))
head(all_data_withDay)

# The most popular date subset 
subset <- subset(all_data_withDay, BusinessDate=="2015-07-03")

# What Stops were most popular on the most popular date
subset %>% group_by(StopNameShort) %>% tally(sort=TRUE)

# Tally of 'day of the week' 
all_data_withDay %>% group_by(day) %>% tally(sort=FALSE)

# Data split into day of the week
mon_data <- subset(all_data_withDay, day=="Mon")
tue_data <- subset(all_data_withDay, day=="Tue")
wed_data <- subset(all_data_withDay, day=="Wed")
thu_data <- subset(all_data_withDay, day=="Thu")
fri_data <- subset(all_data_withDay, day=="Fri")
sat_data <- subset(all_data_withDay, day=="Sat")
sun_data <- subset(all_data_withDay, day=="Sun")
  

# Aggregate averages for day of the week
date_tally <- all_data_wstopid_v01 %>% group_by(BusinessDate) %>% tally(sort=FALSE)
dim(date_tally)
head(date_tally)
tail(date_tally)


# Can't get this working...attempting to do a simple timeseries
# as.xts(date_tally)
# idx <- as.vector(date_tally[,1])
# X <- xts(date_tally[,2], order.by=idx$BusinessDate)
# head(X)
# plot(date_tally, type="o", col="blue")
# datets <- ts(date_tally[,2], start=c(date_tally[1,1],1), end=c(date_tally[1096,1],1096), frequency=365)

# Any dates even more or even less than other same days of the week


######################################################################
## UNDERSTANDING CARD-ID COLUMN
######################################################################

top_travelled <- all_data_withDay %>% group_by(CardID) %>% tally(sort=TRUE)
top_travelled_top10 <- top_travelled[1:10,]
top_travelled_top10

# Find info about the traveller with ID # xx
traveller_ID <- 13825080

traveller_records_noNA$GPSLat <- as.numeric(traveller_records_noNA$GPSLat)
traveller_records_noNA$GPSLong <- as.numeric(traveller_records_noNA$GPSLong)

traveller_records <- subset(all_data_withDay, CardID == traveller_ID)
traveller_records_noNA <- subset(traveller_records, GPSLong != "NA")
traveller_lat_lon <- traveller_records_noNA[,traveller_records_noNA$GPSLat:traveller_records_noNA$GPSLong]
View(traveller_records_noNA)


View(traveller_records)


# Map where traveller scans off
top_stops_traveller <- traveller_records_noNA %>% group_by(StopID) %>% tally(sort=TRUE)


# Can't get this working...
travellermap <- get_map(location = c(lon = mean(traveller_records_noNA$GPSLong), lat = mean(traveller_records_noNA$GPSLat, na.rm=TRUE)), zoom = 9,
                      maptype = "roadmap", scale = 2)

p <- ggmap(travellermap) 
p <- p + geom_point(data = traveller_records_noNA, aes(x=GPSLat, y=GPSLong), color="red", size=5, alpha=0.5)
p




View(top_touchOff_traveller)


######################################################################
## UNDERSTANDING CARD TYPE COLUMN
######################################################################

card_type_count <- samp0_scanOff %>% group_by(CardType) %>% tally(sort=FALSE)
View(card_type_count)




######################################################################
## UNDERSTANDING VEHICLE ID COLUMN
######################################################################

vehicleID_count <- samp0_scanOff %>% group_by(VehicleID) %>% tally(sort=FALSE)
View(vehicleID_count)




######################################################################
## UNDERSTANDING PARENT ROUTE ID
######################################################################

parentRoute_count <- samp0_scanOff %>% group_by(ParentRoute) %>% tally(sort=FALSE)
View(parentRoute_count)




######################################################################
## UNDERSTANDING ROUTE ID COLUMN
######################################################################



RouteID_count <- samp0_scanOff %>% group_by(RouteID) %>% tally(sort=FALSE)
View(RouteID_count)

# Can we work out which route is attached to what?




######################################################################
## UNDERSTANDING STOP ID COLUMN
######################################################################

StopID_count <- samp0_scanOff %>% group_by(StopID) %>% tally(sort=FALSE)
View(StopID_count)














######################################################################
######################################################################
## SPEED DATA
######################################################################
######################################################################

# where are these latitude and longitudes??
# are some of the max speed locations possible?? A lot of 100+ speeds
######################################################################
# getting the map
mapgilbert <- get_map(location = c(lon = mean(max_dataframe$lon), lat = mean(max_dataframe$lat)), zoom = 9.5,
                      maptype = "roadmap", scale = 2)

# creating a dataframe with lat and lon but max_speed is 'empty' or filled with 0
max_dataframe <- data.frame(lat = car_speeds_separate$lat, lon = car_speeds_separate$lon, max_speed = 0, colour = '0')
max_dataframe$colour <- as.character(max_dataframe$colour)

# now populate the max_speed
cols_to_change = c(1:nrow(car_speeds_separate))


# selects the maximum car speed for that lat/ lon coordinate and then associates a colour for it
for(i in cols_to_change){
  max_dataframe$max_speed[i] <- (max(car_speeds_separate[i,4:123]))
  if (max_dataframe$max_speed[i] < 20) {
    max_dataframe$colour[i] <- "#7a82f9"
    #print("20")
  } else if (20 <= max_dataframe$max_speed[i] & max_dataframe$max_speed[i] < 40) {
    max_dataframe$colour[i] <-  "#9e6bd5"
    #print("40")
  } else if (40 <= max_dataframe$max_speed[i] & max_dataframe$max_speed[i] < 60) {
    max_dataframe$colour[i] <- "#b055ac"
    #print("60")
  } else if (60 <= max_dataframe$max_speed[i] & max_dataframe$max_speed[i] < 80) {
    max_dataframe$colour[i] <-  "#b73f82"
    #print("80")
  } else if (80 <= max_dataframe$max_speed[i] & max_dataframe$max_speed[i] < 100) {
    max_dataframe$colour[i] <- "#b82655"
    #print("100")
  } else if (max_dataframe$max_speed[i] >= 100){
    max_dataframe$colour[i] <- "#b40000"
    #print("more")
  }
}  

# plotting the map with some points on it
ggmap(mapgilbert) + geom_point(data = max_dataframe, aes(x = lon, y = lat, fill = colour, alpha = 0.8), size=1, shape = 21) + guides(fill=guide_legend(title="Maximum speeds", title.position="top",label=TRUE))



# add a legend so you can see what the 'max' speeds are for this area
# labels=(c("0 - 20", "20 - 40", "40 - 60", "60 - 80", "80 - 100", "100 +"))
# export as a jpeg so we can see it larger


## mean speed - time series plot for 1st row
######################################################################

## NOT WORKING YET

# data_temp <- data.frame(time = seq(1, 120), speed = t(car_speeds_separate[1,4:123]))
# 
# # Graph cars using blue points overlayed by a line 
# plot(data_temp, type="o", col="blue")
# 
# # Create a title with a red, bold/italic font
# title(main="Autos", col.main="red", font.main=4)
