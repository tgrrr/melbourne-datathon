######################################################################
## PACKAGES
######################################################################
library(readr)
library(data.table)
library(tidyr)
library(lubridate)
library(stringr)

## set your own working directory 
# setwd("/Users/ellenitoumpas/Dropbox/DATA/DATATHON/datathon/melbourne-datathon/")
setwd("~/code/data-science/melbourne-datathon/datahead(/")



######################################################################
## IMPORT FILES (except touch on and touch off)
######################################################################
calendar <- read.delim("calendar.txt", sep="|", header=FALSE, col.names = c("DateSequence", "Date" ,"CalendarYear" ,"FinancialYear" ,"FinancialMonth" ,"CalendarMonth" ,"CalendarMonthSeq" ,"CalendarQuarter" ,"FinancialQuarter" ,"CalendarWeek" ,"FinancialWeek" ,"DayType" ,"DayTypeCategory", "DayTypeCategoryMore","WeekdaySeq" ,"WeekDay" ,"FinancialMonthSeq" ,"FinancialMonthName" ,"MonthNumber" ,"ABSWeek" ,"WeekEnding" ,"QuarterName"))
car_speeds <- read_csv("melbourne_vehicle_traffic.csv")
card_type <- read.delim("card_types.txt", sep="|", header=FALSE, col.names = c("Card_SubType_ID" , "Card_SubType_Desc", "Payment_Type", "Fare_Type", "Concession_Type", "MI_Card_Group"))
stoplocations <- read.delim("stop_locations.txt", sep="|", fill = TRUE, col.names=c("StopLocationID" , "StopNameShort", "StopNameLong", "StopType", "SuburbName", "PostCode", "RegionName", "LocalGovernmentArea", "StatDivision", "GPSLat", "GPSLong"))



######################################################################
## IMPORT TXT FILES IN SUBFOLDERS - COPIED FROM ORGANISERS NOTES
######################################################################

whichSamp_on <- function(samp){
  #tell R where it can find the data
  ScanOnFolderMaster <- 'Samp_X/ScanOnTransaction'
  ScanOnFolder <- sub("X",samp,ScanOnFolderMaster)
  FolderType <- 'On'
  
  #list the files
  onFiles <- list.files(ScanOnFolder,recursive = TRUE,full.names = TRUE)
  
  CreateDataFrame(offFiles, samp, FolderType)
}

whichSamp_off <- function(samp){
  
  #tell R where it can find the data
  ScanOffFolderMaster <- 'Samp_X/ScanOffTransaction'
  ScanOffFolder <- sub("X",samp,ScanOffFolderMaster)
  FolderType <- 'Off'
  
  #list the files
  offFiles <- list.files(ScanOffFolder,recursive = TRUE,full.names = TRUE)
  
  CreateDataFrame(offFiles, samp, FolderType)
}


CreateDataFrame <- function(offFiles, samp, FolderType){
  # set up an empty dataframe for all of touch off data
  EmptyDataFrame <- data.frame(Mode=integer(),
                                BusinessDate=character(), 
                                DateTime=character(), 
                                CardID = integer(),
                                CardType = integer(),
                                VehicleID = integer(),
                                ParentRoute = character(),
                                RouteID = integer(),
                                StopID = integer(),
                                stringsAsFactors=FALSE) 
  
  DataFrameName <- paste('scan',FolderType,'_all_samp',samp)
  }






whichSamp_on(samp)
whichSamp_off(samp)



?whichSamp_off





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

# TODO: @ellenitoumpas ERROR
# gzip: can't stat: NA (NA.gz): No such file or directory
# Error in fread(cmd, nrow = 10000, sep = "|", fill = TRUE) : 
#   File is empty: /var/folders/34/xdfrxr7n08ngg98wdw92fdt40000gn/T//RtmpvumBiO/fileb1bc6fa4edb9

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

write.csv(scanOn_all_samp0, file = "all_scanOn_samp0.csv", row.names=FALSE)

write.csv(scanOff_all_samp0, file = "all_scanOff_samp0.csv", row.names=FALSE)

######################################
## Writing a test function
######################################

printsum <- function(sum) {
  print(paste0("The sum is: ",sum))
}

sum.of.squares <- function(x,y) {
  sum <- x^2 + y^2
  printsum(sum)
}

sum.of.squares(3,9)


######################################################################
## 01. CLEAN FILES 
######################################################################

all_scanOn_samp0 <- read_csv(all_scanOn_samp0.csv", col_names = TRUE)
all_scanOff_samp0 <- read_csv(all_scanOff_samp0.csv", col_names = TRUE)
head(all_scanOn_samp0)
head(all_scanOff_samp0)

# looking at calender 
head(calendar)








######################################
## FOR EACH DATASET
######################################
# check all datatypes of each column 
# mutate/split any columns that are incorrect (each value should be in its own column)
# checking typos/ data entry errors or data import errors
# check extra whitespace on values
# check text upper/ lower case
# check sanity checks
# check and replace missing values
# check and replace outliers 




str(calendar)

