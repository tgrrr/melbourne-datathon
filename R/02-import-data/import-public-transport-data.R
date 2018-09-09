#####################################################
# Some R code to get you going for the 
# 2018 Melbourne Datathon
#####################################################

#install and load required libraries
#install.packages('data.table')
# library(data.table)

setwd("~/code/data-science/melbourne-datathon/data")

#tell R where it can find the data
ScanOnFolderMaster <- '~/code/data-science/melbourne-datathon/data/Samp_X/ScanOnTransaction'
ScanOffFolderMaster <- 
'~/code/data-science/melbourne-datathon/data/Samp_X/ScanOffTransaction'

mySamp <- 0

ScanOnFolder <- sub("X",mySamp,ScanOnFolderMaster)
ScanOffFolder <- sub("X",mySamp,ScanOffFolderMaster)

#list the files
onFiles <- list.files(ScanOnFolder,recursive = TRUE,full.names = TRUE)
offFiles <- list.files(ScanOffFolder,recursive = TRUE,full.names = TRUE)

#how many
allFiles <- union(onFiles,offFiles)
cat("\nthere are", length(allFiles),'files')


#------------------------------------
#read in a file and take a look
#------------------------------------
myFile <- onFiles[1]
cmd <- paste0("gzip -dc ", myFile)
dt <- fread(cmd, nrow=10000)

#these are the column names
colnames(dt) <- c('Mode','BusinessDate','DateTime','CardID','CardType','VehicleID','ParentRoute','RouteID','StopID')

#take a look
dt

#summary stats
summary(dt)



# Make it work for both sample 0 and 1

BindAllSamplesIntoDataFrame <- function(mySamp) {


  scan_off_sample <- paste('scan_off_sample',mySamp, sep = "")
  scan_off_sample
  scan_off_sample_filename <- paste('scan_off_sample',mySamp,'.csv', sep = "")
  scan_off_sample_filename

  scan_on_sample <- paste('scan_on_sample',mySamp, sep = "")
  scan_on_sample
  scan_on_sample_filename <- paste('scan_on_sample',mySamp,'.csv', sep = "")
  scan_on_sample_filename

  # set up an empty dataframe for all of touch off data
  scan_off_sample <- data.frame(
    Mode = integer(),
    BusinessDate = character(),
    DateTime = character(),
    CardID = integer(),
    CardType = integer(),
    VehicleID = integer(),
    ParentRoute = character(),
    RouteID = integer(),
    StopID = integer(),
    stringsAsFactors = FALSE
  )

  scan_on_sample <- data.frame(
    Mode = integer(),
    BusinessDate = character(),
    DateTime = character(),
    CardID = integer(),
    CardType = integer(),
    VehicleID = integer(),
    ParentRoute = character(),
    RouteID = integer(),
    StopID = integer(),
    stringsAsFactors = FALSE
  )

  #---------------------------------------------------
  #read in all touch off files and collate to one file
  #---------------------------------------------------

  for (i in 1:157) {

    # which file are we importing
    myFile <- offFiles[i]
    
    # import file
    # cmd <- paste0("gzip -dc ", myFile)
    cmd <- paste0("gzip -dc ", myFile)
    dt <- 
      fread(
        cmd,
        nrow = 10000,
        sep = "|",
        fill = TRUE)
    
    # bind imported file to the main dataframe
    scan_off_sample <-
      rbind(as.data.frame(scan_off_sample), as.data.frame(dt))
    
  }

  colnames(scan_off_sample) <- c(
    'Mode',
    'BusinessDate',
    'DateTime',
    'CardID',
    'CardType',
    'VehicleID',
    'ParentRoute',
    'RouteID',
    'StopID'
  )
  head(scan_off_sample)

  #---------------------------------------------------
  #read in all touch on files and collate to one file
  #---------------------------------------------------

  # BindSampleDataFrames <-
  #   function(onFiles,
  #            i,
  #            scan_on_sample,
  #            scan_off_sample) {

      for (i in 1:157) {
        # which file are we importing
        myFile <- onFiles[i]
        
        # import file
        cmd <- paste0("gzip -dc ", myFile)
        dt <-
          fread(
            cmd,
            nrow = 10000,
            sep = "|",
            fill = TRUE)
        
        # bind imported file to the main dataframe
        scan_on_sample <-
          rbind(as.data.frame(scan_on_sample), as.data.frame(dt))
        
      }
      colnames(scan_on_sample) <-
        c(
          'Mode',
          'BusinessDate',
          'DateTime',
          'CardID',
          'CardType',
          'VehicleID',
          'ParentRoute',
          'RouteID',
          'StopID'
        )
      
      head(scan_on_sample, 5)
      head(scan_off_sample, 5)
      
      write.csv(
        scan_on_sample, 
        file = scan_on_sample_filename, 
        row.names = FALSE)
      write.csv(
        scan_off_sample, 
        file = scan_off_sample_filename, 
        row.names = FALSE)
}

beep()