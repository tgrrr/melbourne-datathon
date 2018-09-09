setwd("~/code/data-science/melbourne-datathon/data")

getwd()
######################################################################
## IMPORT FILES (except touch on and touch off)
######################################################################
calendar <-
  read.delim(
    "calendar.txt",
    sep = "|",
    header = FALSE,
    col.names = c(
      "DateSequence",
      "Date",
      "CalendarYear",
      "FinancialYear",
      "FinancialMonth",
      "CalendarMonth",
      "CalendarMonthSeq",
      "CalendarQuarter",
      "FinancialQuarter",
      "CalendarWeek",
      "FinancialWeek",
      "DayType",
      "DayTypeCategory",
      "DayTypeCategoryMore",
      "WeekdaySeq",
      "WeekDay",
      "FinancialMonthSeq",
      "FinancialMonthName",
      "MonthNumber",
      "ABSWeek",
      "WeekEnding",
      "QuarterName"
    )
  )

card_type <-
  read.delim(
    "card_types.txt",
    sep = "|",
    header = FALSE,
    col.names = c(
      "Card_SubType_ID" ,
      "Card_SubType_Desc",
      "Payment_Type",
      "Fare_Type",
      "Concession_Type",
      "MI_Card_Group"
    )
  )

stoplocations <-
  read.delim(
    "stop_locations.txt",
    sep = "|",
    fill = TRUE,
    col.names = c(
      "StopLocationID" ,
      "StopNameShort",
      "StopNameLong",
      "StopType",
      "SuburbName",
      "PostCode",
      "RegionName",
      "LocalGovernmentArea",
      "StatDivision",
      "GPSLat",
      "GPSLong"
    )
  )