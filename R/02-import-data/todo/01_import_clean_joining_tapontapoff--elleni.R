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
library(rvest)


## set your own working directory 
# setwd("/Users/ellenitoumpas/Dropbox/DATA/DATATHON/datathon/melbourne-datathon/")
setwd("~/code/data-science/melbourne-datathon/datahead(/")


######################################################################
## IMPORT FILES (except touch on and touch off)
######################################################################
calendar <- read.delim("calendar.txt", sep="|", header=FALSE, col.names = c("DateSequence", "Date" ,"CalendarYear" ,"FinancialYear" ,"FinancialMonth" ,"CalendarMonth" ,"CalendarMonthSeq" ,"CalendarQuarter" ,"FinancialQuarter" ,"CalendarWeek" ,"FinancialWeek" ,"DayType" ,"DayTypeCategory", "DayTypeCategoryMore","WeekdaySeq" ,"WeekDay" ,"FinancialMonthSeq" ,"FinancialMonthName" ,"MonthNumber" ,"ABSWeek" ,"WeekEnding" ,"QuarterName"))
car_speeds <- read_csv("melbourne_vehicle_traffic.csv")
card_type <- read.delim("card_types.txt", sep="|", header=FALSE, col.names = c("Card_SubType_ID" , "Card_SubType_Desc", "Payment_Type", "Fare_Type", "Concession_Type", "MI_Card_Group"))
stop_locations <- read_delim("stop_locations.txt", "|", escape_double = FALSE, trim_ws = TRUE, col_names = FALSE)
colnames(stop_locations) <- c("StopLocationID" , "StopNameShort", "StopNameLong", "StopType", "SuburbName", "PostCode", "RegionName", "LocalGovernmentArea", "StatDivision", "GPSLat", "GPSLong")


######################################################################
## IMPORT TXT FILES IN SUBFOLDERS - COPIED FROM ORGANISERS NOTES
######################################################################

#tell R where it can find the data
ScanOnFolderMaster <- 'Samp_X/ScanOnTransaction'
ScanOffFolderMaster <- 'Samp_X/ScanOffTransaction'

# define if we want sample 0 or sample 1
mySamp <- 1

ScanOnFolder <- sub("X",mySamp,ScanOnFolderMaster)
ScanOffFolder <- sub("X",mySamp,ScanOffFolderMaster)

#list the files
onFiles <- list.files(ScanOnFolder,recursive = TRUE,full.names = TRUE)
offFiles <- list.files(ScanOffFolder,recursive = TRUE,full.names = TRUE)

#how many touch off files we have
cat("\nthere are", length(offFiles),'files')

# set up an empty dataframe for all of touch off data
scanOff_all_samp1 <- data.frame(Mode=integer(),
                                BusinessDate=character(), 
                                DateTime=character(), 
                                CardID = integer(),
                                CardType = integer(),
                                VehicleID = integer(),
                                ParentRoute = character(),
                                RouteID = integer(),
                                StopID = integer(),
                   stringsAsFactors=FALSE) 

scanOn_all_samp1 <- data.frame(Mode=integer(),
                                BusinessDate=character(), 
                                DateTime=character(), 
                                CardID = integer(),
                                CardType = integer(),
                                VehicleID = integer(),
                                ParentRoute = character(),
                                RouteID = integer(),
                                StopID = integer(),
                                stringsAsFactors=FALSE)

#---------------------------------------------------
#read in all touch off files and collate to one file
#---------------------------------------------------

for (i in 1:157){
  
  # which file are we importing
  myFile <- offFiles[i]
 
  # import file
  cmd <- paste0("gzip -dc ", myFile)
  dt <- fread(cmd,nrow=10000,sep="|",fill=TRUE)
 
  # bind imported file to the main dataframe
  scanOff_all_samp1 <- rbind(as.data.frame(scanOff_all_samp1), as.data.frame(dt))
   
}

colnames(scanOff_all_samp1) <- c('Mode','BusinessDate','DateTime','CardID','CardType','VehicleID','ParentRoute','RouteID','StopID')
head(scanOff_all_samp1)
beep()

#---------------------------------------------------
#read in all touch on files and collate to one file
#---------------------------------------------------

for (i in 1:157){
  # which file are we importing
  myFile <- onFiles[i]
 
  # import file
  cmd <- paste0("gzip -dc ", myFile)
  dt <- fread(cmd,nrow=10000,sep="|",fill=TRUE)
 
  # bind imported file to the main dataframe
  scanOn_all_samp1 <- rbind(as.data.frame(scanOn_all_samp1), as.data.frame(dt))
 
}
colnames(scanOn_all_samp1) <- c('Mode','BusinessDate','DateTime','CardID','CardType','VehicleID','ParentRoute','RouteID','StopID')
head(scanOn_all_samp1)


beep()


write.csv(scanOn_all_samp1, file = all_scanOn_samp1.csv", row.names=FALSE)
write.csv(scanOff_all_samp1, file = all_scanOff_samp1.csv", row.names=FALSE)


######################################################################
## 01. CLEAN FILES 
######################################################################
all_scanOn_samp0 <- read_csv(all_scanOn_samp0.csv", col_names = TRUE)
all_scanOff_samp0 <- read_csv(all_scanOff_samp0.csv", col_names = TRUE)
all_scanOn_samp1 <- read_csv(all_scanOn_samp1.csv", col_names = TRUE)
all_scanOff_samp1 <- read_csv(all_scanOff_samp1.csv", col_names = TRUE)

head(all_scanOn_samp0)
head(all_scanOff_samp0)
head(all_scanOn_samp1)
head(all_scanOff_samp1)




######################################################################
## LOOKING AT SAMP_0 + SAMP_1 DATA
######################################################################


# add ALL touch on and touch off data together
# First step: add columns to keep track of where the data came from
all_scanOn_samp0 <- all_scanOn_samp0 %>% mutate(source='touchon', sample="0")
all_scanOn_samp1 <- all_scanOn_samp1 %>% mutate(source='touchon', sample="1")
all_scanOff_samp0 <- all_scanOff_samp0 %>% mutate(source='touchoff', sample="0")
all_scanOff_samp1 <- all_scanOff_samp1 %>% mutate(source='touchoff', sample="1")

# Second step: combine rows into all_data
all_data <- bind_rows(all_scanOn_samp0,all_scanOn_samp1)
all_data <- bind_rows(all_data,all_scanOff_samp0)
all_data <- bind_rows(all_data,all_scanOff_samp1)

# Third step: checking the dimensions of all the datasets and then checking the all_data
dim(all_scanOn_samp0)
dim(all_scanOn_samp1)
dim(all_scanOff_samp0)
dim(all_scanOff_samp1)
nrow(all_scanOn_samp0)*4
dim(all_data)
head(all_data)

# Fourth step: write to external file just in case
write.csv(all_data, file = all_data_combined.csv", row.names=FALSE)

head(all_data)
head(stop_locations)

