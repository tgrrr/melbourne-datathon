######################################################################
## PACKAGES
######################################################################
library(readr)
library(data.table)
library(tidyr)
library(lubridate)
library(stringr)

## set your own working directory 
setwd("/Users/ellenitoumpas/Dropbox/DATA/DATATHON/datathon/melbourne-datathon/")


######################################################################
## IMPORT FILES (except touch on and touch off)
######################################################################
calendar <- read.table("calendar.txt", sep="|", header=FALSE, col.names = c("DateSequence", "Date" ,"CalendarYear" ,"FinancialYear" ,"FinancialMonth" ,"CalendarMonth" ,"CalendarMonthSeq" ,"CalendarQuarter" ,"FinancialQuarter" ,"CalendarWeek" ,"FinancialWeek" ,"DayType" ,"DayTypeCategory", "DayTypeCategoryMore","WeekdaySeq" ,"WeekDay" ,"FinancialMonthSeq" ,"FinancialMonthName" ,"MonthNumber" ,"ABSWeek" ,"WeekEnding" ,"QuarterName"))
car_speeds <- read_csv("car_speeds/melbourne_vehicle_traffic.csv")
card_type <- read.table("card_types.txt", sep="|", header=FALSE, col.names = c("Card_SubType_ID" , "Card_SubType_Desc", "Payment_Type", "Fare_Type", "Concession_Type", "MI_Card_Group"))
stoplocations <- read.table("stop_locations.txt", sep="|", fill = TRUE, col.names=c("StopLocationID" , "StopNameShort", "StopNameLong", "StopType", "SuburbName", "PostCode", "RegionName", "LocalGovernmentArea", "StatDivision", "GPSLat", "GPSLong"))


######################################################################
## IMPORT TXT FILES IN SUBFOLDERS - COPIED FROM ORGANISERS NOTES
######################################################################

#tell R where it can find the data
ScanOnFolderMaster <- 'Samp_X/ScanOnTransaction'
ScanOffFolderMaster <- 'Samp_X/ScanOffTransaction'

# define if we want sample 0 or sample 1
mySamp <- 0

ScanOnFolder <- sub("X",mySamp,ScanOnFolderMaster)
ScanOffFolder <- sub("X",mySamp,ScanOffFolderMaster)

#list the files
onFiles <- list.files(ScanOnFolder,recursive = TRUE,full.names = TRUE)
offFiles <- list.files(ScanOffFolder,recursive = TRUE,full.names = TRUE)

#how many touch off files we have
cat("\nthere are", length(offFiles),'files')

# set up an empty dataframe for all of touch off data
scanOff_all_samp0 <- data.frame(Mode=integer(),
                                BusinessDate=character(), 
                                DateTime=character(), 
                                CardID = integer(),
                                CardType = integer(),
                                VehicleID = integer(),
                                ParentRoute = character(),
                                RouteID = integer(),
                                StopID = integer(),
                   stringsAsFactors=FALSE) 

scanOn_all_samp0 <- data.frame(Mode=integer(),
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
  scanOff_all_samp0 <- rbind(as.data.frame(scanOff_all_samp0), as.data.frame(dt))
  
}

colnames(scanOff_all_samp0) <- c('Mode','BusinessDate','DateTime','CardID','CardType','VehicleID','ParentRoute','RouteID','StopID')
head(scanOff_all_samp0)

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
  scanOn_all_samp0 <- rbind(as.data.frame(scanOn_all_samp0), as.data.frame(dt))
  
}

colnames(scanOn_all_samp0) <- c('Mode','BusinessDate','DateTime','CardID','CardType','VehicleID','ParentRoute','RouteID','StopID')
head(scanOn_all_samp0)

write.csv(scanOn_all_samp0, file = "all_scanOff_scanOn/all_scanOn_samp0.csv", row.names=FALSE)
write.csv(scanOff_all_samp0, file = "all_scanOff_scanOn/all_scanOff_samp0.csv", row.names=FALSE)

######################################################################
## 01. CLEAN FILES 
######################################################################

all_scanOn_samp0 <- read_csv("all_scanOff_scanOn/all_scanOn_samp0.csv", col_names = TRUE)
all_scanOff_samp0 <- read_csv("all_scanOff_scanOn/all_scanOff_samp0.csv", col_names = TRUE)

head(all_scanOn_samp0)
head(all_scanOff_samp0)

