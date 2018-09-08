#-----------------------------------------
# Datathon Anaylsis v3
#-----------------------------------------

setwd("C:/Users/samgh/Desktop/Datathon")

######################################################################
## HEADERS
#
# Packages
# Import Files
# Group by Analysis
# Joining Data
# Mean/SD of Car Speeds per Hour at a given location
# Categorical Analysis of Time Periods
# Scatterplot/Linear Analysis
# Cluster ML
# GIS Visuals
#
######################################################################
## PACKAGES
######################################################################
library(readr)
library(data.table)
library(stringr)
library(dplyr)
library(mosaic)
library(cluster)
library(tidyr)

######################################################################
## IMPORT FILES
######################################################################
calendar <- read.table("calendar.txt", sep = "|", header = FALSE, col.names = c("DateSequence", "Date" ,"CalendarYear" ,"FinancialYear" ,"FinancialMonth" ,"CalendarMonth" ,"CalendarMonthSeq" ,"CalendarQuarter" ,"FinancialQuarter" ,"CalendarWeek" ,"FinancialWeek" ,"DayType" ,"DayTypeCategory", "DayTypeCategoryMore","WeekdaySeq" ,"WeekDay" ,"FinancialMonthSeq" ,"FinancialMonthName" ,"MonthNumber" ,"ABSWeek" ,"WeekEnding" ,"QuarterName"))
car_speeds <- read_csv("car_speeds/melbourne_vehicle_traffic.csv")
card_type <- read.table("card_types.txt", sep = "|", header = FALSE, col.names = c("Card_SubType_ID" , "Card_SubType_Desc", "Payment_Type", "Fare_Type", "Concession_Type", "MI_Card_Group"))
stoplocations <- read.table("stop_locations.txt", sep = "|", fill = TRUE, col.names = c("StopLocationID" , "StopNameShort", "StopNameLong", "StopType", "SuburbName", "PostCode", "RegionName", "LocalGovernmentArea", "StatDivision", "GPSLat", "GPSLong"))

samp0off <- read_csv('sampData/all_scanOff_samp0.csv')
samp0on <- read_csv('sampData/all_scanOn_samp0.csv')
samp1off <- read_csv('sampData/all_scanOff_samp1.csv')
samp1on <- read_csv('sampData/all_scanon_samp1.csv')

str(samp0off)
str(samp0on)
str(samp1off)
str(samp1on)

# join stoploc to samp0 by StopID and factor CardType from card_type

# left join stoploc lon and lat data to samp dataframe,
# filter by time for both car speeds and samp data (peak traffic?) then group by on and off and col separately

str(calendar)
str(car_speeds)
str(card_type)
str(stoplocations)

head(calendar, 10)
head(car_speeds, 10)
head(card_type, 10)
head(stoplocations, 10)

######################################################################
# Group by analysis
######################################################################

# factorise card types in stop data and look at common use of cards in certain areas of interest

head(tally(CardType~StopID, data = samp0off), 10) # investigate stopIDs whic, 10h contain 644
head(tally(CardType~StopID, data = samp0on), 10)

library(stringr)
head(stoplocations[str_detect(stoplocations$StopLocationID, '200'),], 10)
#so, quite a few missing, if not most, StopID don't match anything
#will have to continue with complete StopID data

######################################################################
# Joining data
######################################################################

samp0off$StopID <- factor(samp0off$StopID)
samp0off_join_stop <- samp0off %>% full_join(stoplocations[c(1,10,11)], by = c("StopID" = "StopLocationID"))


# look into joining by ID for samp0 and stoploc
samID <- samp0off$StopID
stopID <- stoplocations$StopLocationID #there is bloody lon lat data in the ID!!
class(samID)
class(stopID)
str(samID)
str(stopID) # summary() is not helpful
head(tally(samID))   # this provides insight into the most common stoplocation, 10s
head(tally(stopID)) # order desc by X and I found that some of the IDs were pu, 10t in as character strings instead
# there is only four strings, do we bother finding a stop to match? there is also lat lon data

samID2 <- as.numeric((as.character(samID)))
samID2[samID2 == -1] <- NA
samID3 <- unique(samID2)
samp0off$StopID <- factor(samID2)

stop1 <- as.character(stopID)
stringr::str_sort(stop1, na_last = FALSE)

stopID2 <- as.double((as.character(stopID)))
stopID2[stopID2 < 0] <- NA # the coerced NAs are the character strings of entire regions (still yet to decide on proper step for them)

str(samp0off_join_stop) # many NAs forced due to mismatch of join/are these IDs the right ones? wrong join?
head(samp0off_join_stop, 10)



samp0off$CardType <- factor(samp0off$CardType)
samp0off_join_card <- samp0off %>%



######################################################################
# Mean/SD of Car Speeds per Hour at a given location
######################################################################
mean_speed <- car_speeds$mean_speed #grab the char vector
mean_split <- mean_speed %>% str_replace_all("\\[|\\]", "") #remove brackets from start and end of list components (they were coercing NAs)
mean_split2 <- mean_split %>% str_split(pattern = ',') #split values
mean_split3 <- unlist(mean_split2) #unlist the array
mean_num <- as.numeric(mean_split3) %>% round(2) #convert to numeric
mean_num[mean_num == -1] <- 0 #filter out negative values (-1 indicates no values were captured)
summary(mean_num) #before
head(mean_num, 10)
mean_mat <- matrix(mean_num, byrow = TRUE, ncol = 120)
times <- c('0000','0100','0200','0300','0400','0500','0600','0700','0800','0900','1000','1100','1200','1300','1400','1500','1600','1700','1800','1900','2000','2100','2200','2300')
mon_times <- paste('Mon', times)
tue_times <- paste('Tue', times)
wed_times <- paste('Wed', times)
thu_times <- paste('Thu', times)
fri_times <- paste('Fri', times)
week_times <- c(mon_times, tue_times, wed_times, thu_times, fri_times)
mat_col_names <- week_times
colnames(mean_mat) <- mat_col_names
head(mean_mat, 10)
df1 <- car_speeds[,1:3]
mean_df <- cbind(df1, mean_mat)
head(mean_df, 10)

# Standard Deviation of Car Speeds

sd_speed <- car_speeds$std_speed
sd_split <- sd_speed %>% str_replace_all("\\[|\\]", "")
sd_split2 <- sd_split %>% str_split(pattern = ',')
sd_split3 <- unlist(sd_split2)
sd_num <- as.numeric(sd_split3) %>%  round(2)
sd_num[sd_num == -1] <- 0
summary(sd_num)

sd_mat <- matrix(sd_num, byrow = TRUE, ncol = 120)
colnames(sd_mat) <- week_times
sd_df <- cbind(df1, sd_mat)
head(sd_df, 10)

## Creating long data frames
# For Mean df
gath_mean_df <- mean_df %>% gather(Time, Avg_Speed, 4:length(mean_df))
long_mean_df <- gath_mean_df %>%  separate(Time, c('Day','Time'), sep = ' ')
# Factorise Day and Time
long_mean_df$Time <- factor(long_mean_df$Time,
                            levels = times,
                            labels = times,
                            ordered = TRUE)
long_mean_df$Day <- factor(long_mean_df$Day,
                           levels = c('Mon','Tue','Wed','Thu','Fri'),
                           labels = c('Mon','Tue','Wed','Thu','Fri'),
                           ordered = TRUE)
str(long_mean_df)

# Now for SD df
gath_sd_df <- sd_df %>% gather(Time, SD_speed, 4:length(sd_df))
long_sd_df <- gath_sd_df %>%  separate(Time, c('Day','Time'), sep = ' ')
# Factorise Day and Time
long_sd_df$Time <- factor(long_mean_df$Time,
                            levels = times,
                            labels = times,
                            ordered = TRUE)
long_sd_df$Day <- factor(long_mean_df$Day,
                           levels = c('Mon','Tue','Wed','Thu','Fri'),
                           labels = c('Mon','Tue','Wed','Thu','Fri'),
                           ordered = TRUE)
str(long_sd_df)
head(long_sd_df, 10)



#####################################################################
# Categorical Analysis of Time Periods
#####################################################################
# Set 0600 to 1800 as early and night as late
mean_late <- mean_df[,c(1:10, 23:34, 47:58, 71:82, 95:106)]
mean_early <- mean_df[,-(c(4:10, 23:34, 47:58, 71:82, 95:106))]

# Chi-Squared? categorise times into segments (0000-0600 and 0700-1200 and so on?)

sd(colMeans(mean_late[,3:length(mean_late)])) # 12.86
sd(colMeans(mean_early[,3:length(mean_early)])) # 12.62
# variation between night and day data insignificant

x <- mean(colMeans(mean_late[,3:length(mean_late)])) # 51.17
mean(colMeans(mean_early[,3:length(mean_early)])) # 44.93
# means significant change, run t.test to confirm




# Visualise Distribution Curves - Assuming a Normal Distribution
x <- seq(0,100,0.1)
y <- dnorm(x, mean = 51.17, sd = 12.86)
z <- dnorm(x, mean = 44.93, sd = 12.62)

par(mar = c(5,4,4,5) + 0.1)
plot(x, y, col = 'blue', main = 'Early and Late Distribution of Means', ylab = 'Prob Density', pch = 7, type = 'b')
par(new = T)
plot(x, z, col = 'orange', axes = F, ylab = '', pch = 7, type = 'b')
legend()

######################################################################
# Scatterplot/Linear Analysis
######################################################################

# Looking at relationship on the day/hour against the variation in speed

x <- mean_df[,4:length(mean_df)]
y <- sd_df[,4:length(sd_df)]

col_mean <- colMeans(x) %>%  round(2)
head(col_mean, 10)
week_col <- c(rep('blue', 24), rep('green', 24), rep('orange', 24), rep('red', 24), rep('purple', 24))
plot(col_mean,  # seems to follow a pattern, no particular outliers
     main = 'Mean Speed per Hour of a Work Week (Mon to Fri)',
     xlab = '',
     ylab = 'Mean Speed (kph)',
     type = 'b',
     col = week_col,
     pch = 19)

legend(106, 52,
      legend = c('Mon','Tue','Wed','Thu','Fri'),
      col = c('blue','green','orange','red','purple'),
      pch = 19)

col_sdMean <- colMeans(y) %>% round(2)
plot(col_sdMean) # bit more scattered, but somewhat of a pattern
plot(col_sdMean,
     main = 'Mean Standard Deviation per Hour of a Work Week (Mon to Fri)',
     xlab = '',
     ylab = 'Mean Speed (kph)',
     type = 'b',
     col = week_col,
     pch = 19)
legend(106, 12,
       legend = c('Mon','Tue','Wed','Thu','Fri'),
       col = c('blue','green','orange','red','purple'),
       pch = 19)


plot(col_mean, col_sdMean) # investigate relation between average a variation
sd_mean_lm <- lm(col_sdMean ~  col_mean)
summary(sd_mean_lm) # Stat Signif, 33% of the variation explanable by average (as the average goes up, the sd goes down)

plot(col_mean, col_sdMean)
abline(lm(col_sdMean ~ col_mean))

##########################################################################
# CLUSTER ML
##########################################################################

# Clustering Analysis of the SD against the Mean

ms <- cbind(col_mean, col_sdMean)

# Elbow Method
set.seed(6)
wcss <- vector()
for (i in 1:10) wcss[i] <- sum(kmeans(ms, i)$withins)
plot(1:10, wcss, type = 'b') # 2 or 3?

# Cluster - Kmeans
set.seed(7)
kmeans1 <- kmeans(ms, 2, iter.max = 500, nstart = 10)
kmeans1$cluster
plot(kmeans1$cluster) # car_speed sd variation against the average speed decreases when the sun is down (~1900 to ~0400 next day)

# Visualise kmeans1
clusplot(ms,
         kmeans1$cluster,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         plotchar = FALSE,
         span = TRUE,
         main = 'Stand Dev against Mean Speed at Locations',
         xlab = 'Scaled Mean',
         ylab = 'Scaled SD'
)

# Visualise kmeans2 - 3 clusters
set.seed(8)
kmeans2 <- kmeans(ms, 3, iter.max = 500, nstart = 10)
clusplot(ms,
         kmeans2$cluster,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         plotchar = FALSE,
         span = TRUE,
         main = 'Stand Dev against Mean Speed at Locations (3 clusters)',
         xlab = 'Scaled Mean',
         ylab = 'Scaled SD'
)


##########################################################################
# GIS VISUALS
##########################################################################
# Visualise Long Lat Data
# install.packages("rworldmap")
# install.packages('ggmap')
library(ggmap)
lon <- mean_df$lon
lat <- mean_df$lat
row_mean <- rowMeans(x, na.rm = TRUE)
row_sd <- rowMeans(y, na.rm = TRUE)
ms_df <- data.frame(lon, lat, row_mean, row_sd)

head(ms_df, 10)
map <- get_map(location = 'Melbourne', zoom = 10)
mapPoints <- ggmap(map) +
  geom_point(aes(x = lon, y = lat, size = row_mean, col = row_sd), data = ms_df, alpha = .5)
mapPoints

# try with actual lon/lat parameters
map2 <- get_map(location = c(left = 144.1, right = 145.9, bottom = -38.6, top = -37.4))
mapPoints2 <- ggmap(map2) +
  geom_point(aes(x = lon, y = lat, size = row_mean, col = row_sd),data = ms_df, alpha = 0.5) +
  scale_color_gradientn(colors = c('green','yellow','red'))
mapPoints2

# zoom in on POI
map3 <- get_map(location = c(left = 145, bottom = -38.0, right = 145.2, top = -37.8))
mapPoints3 <- ggmap(map3) +
  geom_point(aes(x = lon, y = lat, size = row_mean, col = row_sd),data = ms_df, alpha = 0.5) +
  scale_color_gradientn(colors = c('dark green', 'green','yellow','red'))
mapPoints3

# Clean stoplocations data for overlay
stop_lat <- stoplocations$GPSLat
stop_lat2 <- as.character(stop_lat)
stop_lat3 <- as.numeric(stop_lat2)

stop_lon <- stoplocations$GPSLong
stop_lon2 <- as.character(stop_lon)
stop_lon3 <- as.numeric(stop_lon2)

stop_df <- data.frame(StopLat = stop_lat3, StopLon = stop_lon3)
str(stop_df)

# overlay with stop data
map4 <- get_map(location = c(left = 145, bottom = -38.0, right = 145.2, top = -37.8))
mapPoints4 <- ggmap(map4) +
  geom_point(aes(x = lon, y = lat, size = row_mean, col = row_sd), data = ms_df, alpha = 0.5) +
  scale_color_gradientn(colors = c('dark green', 'green','yellow','red')) +
  geom_point(aes(x = StopLon, y = StopLat, size = 1), data = stop_df, alpha = 0.2)
mapPoints4

# all of Melbourne - with stop locations, heatmapping SD
map5 <- get_map(location = c(left = 144.1, right = 145.9, bottom = -38.6, top = -37.4))
mapPoints5 <- ggmap(map5) +
  geom_point(aes(x = lon, y = lat, size = row_mean, col = row_sd),data = ms_df, alpha = 0.5) +
  scale_color_gradientn(colors = c('dark green','green','yellow','red','dark red')) +
  geom_point(aes(x = StopLon, y = StopLat, size = 1), data = stop_df, alpha = 0.05)
mapPoints5

# all of Melbourne - with stop locations, heatmapping Mean
map6 <- get_map(location = c(left = 144.5, right = 145.6, bottom = -38.4, top = -37.5))
mapPoints6 <- ggmap(map6) +
  geom_point(aes(x = lon, y = lat, size = row_sd, col = row_mean),data = ms_df, alpha = 0.5) +
  scale_color_gradientn(colors = c('dark green','green','yellow','red','dark red')) +
  geom_point(aes(x = StopLon, y = StopLat, size = 1), data = stop_df, alpha = 0.1)
mapPoints6

# POI for Mean Speed
map6 <- get_map(location = c(left = 145, right = 145.2, bottom = -37.9, top = -37.7))
mapPoints6 <- ggmap(map6) +
  geom_point(aes(x = lon, y = lat, size = row_sd, col = row_mean),data = ms_df, alpha = 0.5) +
  scale_color_gradientn(colors = c('dark green','green','yellow','red','dark red')) +
  geom_point(aes(x = StopLon, y = StopLat, size = 1), data = stop_df, alpha = 0.1)
mapPoints6 # this is simply a highway...
