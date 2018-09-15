SampleDataSet <- function(filename, sampleSize) {
  setwd("~/code/data-science/melbourne-datathon/data/all_scanOff_scanOn")
  
  # TODO: make random sample, rather than from head
  
  # alldata_wStopIDs_version02 <- read_csv("alldata_wStopIDs_version02.csv")
  # str(alldata_wStopIDs_version02)
  
  # sample_ptv_data_combined <- alldata_wStopIDs_version02 %>% head(., 100)
  # sample_ptv_data_combined %>% write.csv(., file = "sample_ptv_data_combined.csv")
  
  df <- read_csv(filename)
  # .default = col_character(),
  # Mode = col_integer(),
  # BusinessDate = col_date(format = ""),
  # DateTime = col_datetime(format = ""),
  # CardID = col_integer(),
  # CardType = col_integer(),
  # VehicleID = col_integer(),
  # RouteID = col_integer(),
  # StopID = col_integer(),
  # sample = col_integer(),
  # GPSLat = col_double(),
  # GPSLong = col_double(),
  # GPSlatTolerence = col_double(),
  # GPSlongTolerence = col_double()
  
  df %<>% head(., sampleSize)
  
  return(df)
  
  # sample
}

samp0ff_late <- read_csv("TimeSubsets/samp0ff_late.csv")
head(samp0ff_late, 5)


