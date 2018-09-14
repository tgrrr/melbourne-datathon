
library(plyr)
library(tidyr)

crimedata = read.csv("Data_tables_Criminal_Incidents_Visualisation_year_ending_March_2018.csv", header = TRUE, fileEncoding="UTF-8-BOM")
head(crimedata, n=5)

# Remove "," in Incidence.Recorded column

crimedata[7] <- lapply(crimedata[7], gsub, pattern = ",", replacement = "", fixed = TRUE)
crimedata[7] <- sapply(crimedata[7], as.integer)

# Sort offenses by Offence Division to identify targeted crimes that take place in public

crimedata = subset(crimedata, Offence.Division == "A Crimes against the person" | Offence.Division == "D Public order and security offences")
head(crimedata, n=5)

count(crimedata, 'Offence.Division')

crimedata = subset(crimedata, Offence.Subdivision!="A50 Robbery")
crimedata = subset(crimedata, Offence.Subdivision!="D10 Weapons and explosives offences")
crimedata = subset(crimedata, Offence.Subdivision!="Other crimes against the person")

head(crimedata, n=5)

count(crimedata, 'Offence.Subdivision')

crimedata = separate(data = crimedata, col = Offence.Subgroup, into = c("Offence.Subgroup.Code", "Offence.Subgroup.Name"), sep = " ", extra = "merge", remove = FALSE)

head(crimedata, n=5)

crimedata = subset(crimedata, Offence.Subgroup.Code!="A231")
crimedata = subset(crimedata, Offence.Subgroup.Code!="A211")
crimedata = subset(crimedata, Offence.Subgroup.Code!="A731")
crimedata = subset(crimedata, Offence.Subgroup.Code!="A711")
crimedata = subset(crimedata, Offence.Subgroup.Code!="A721")

count(crimedata, 'Offence.Subgroup')

crimedata = subset(crimedata, Offence.Subgroup.Code!="D12")
crimedata = subset(crimedata, Offence.Subgroup.Code!="D11")
crimedata = subset(crimedata, Offence.Subgroup.Code!="A22")
crimedata = subset(crimedata, Offence.Subgroup.Code!="D25")
crimedata = subset(crimedata, Offence.Subgroup.Code!="A82")
crimedata = subset(crimedata, Offence.Subgroup.Code!="D33")
crimedata = subset(crimedata, Offence.Subgroup.Code!="D43")
crimedata = subset(crimedata, Offence.Subgroup.Code!="D31")
crimedata = subset(crimedata, Offence.Subgroup.Code!="D44")
crimedata = subset(crimedata, Offence.Subgroup.Code!="D41")
crimedata = subset(crimedata, Offence.Subgroup.Code!="D34")
crimedata = subset(crimedata, Offence.Subgroup.Code!="D42")

count(crimedata, 'Offence.Subgroup')

crime_processed<-data.frame(crimedata)

head(crime_processed, n=5)

for (row in 1:nrow(crime_processed)) {
    crime <- crime_processed[row, "Offence.Subgroup.Code"]    
    if (crime == "A212") {
    result <- 10
    } else if (crime == "A232") {
    result <- 10
    } else if (crime == "D22") {
    result <- 4
    } else if (crime == "A89") {
    result <- 7
    } else if (crime == "D23") {
    result <- 5
    } else if (crime == "A732") {
    result <- 7
    } else if (crime == "D35") {
    result <- 4
    } else if (crime == "A712") {
    result <- 10
    } else if (crime == "A83") {
    result <- 7
    } else if (crime == "D24") {
    result <- 3
    } else if (crime == "A722") {
    result <- 8
    } else if (crime == "A81") {
    result <- 7
    } else if (crime == "D21") {
    result <- 10
    } else if (crime == "D13") {
    result <- 6
    } else if (crime == "D26") {
    result <- 5
    } else if (crime == "D32") {
    result <- 7
    } else if (crime == "D36") {
    result <- 7
    } else {
    result <- 7
    }
    crime_processed[row, "Crime.Severity"] = result
}

head(crime_processed, n=5)

crime_processed = subset(crime_processed, Year.ending.March==2018)
crime_list = crime_processed

# Function to calculate severity score per postcode

for (row in 1:nrow(crime_processed)) {
    crime_processed[row, "Severity.Total.Score"] = crime_processed[row, "Incidents.Recorded"] * crime_processed[row, "Crime.Severity"]
}

keeps <- c("Postcode", "Severity.Total.Score")
crime_processed = crime_processed[keeps]
head(crime_processed, n=5)

crime_processed = aggregate(Severity.Total.Score ~ Postcode, crime_processed, sum)
colnames(crime_processed)[2] <- "Severity.Total.Score"
head(crime_processed, n=5)

postcode_loc = read.csv("Australian_Post_Codes_Lat_Lon.csv", header = TRUE, fileEncoding="UTF-8-BOM")
head(postcode_loc, n=5)

keeps <- c("postcode", "lat", "lon")
postcode_loc = postcode_loc[keeps]
colnames(postcode_loc)[1] <- "Postcode"
head(postcode_loc, n=5)

crime_processed = merge(postcode_loc, crime_processed, by = "Postcode")
head(crime_processed, n=5)

keeps <- c("lat", "lon", "Severity.Total.Score")
crime_processed = crime_processed[keeps]
colnames(crime_processed)[1] <- "c_lat"
colnames(crime_processed)[2] <- "c_lon"
head(crime_processed, n=5)

#write.csv(crime_processed, file = "crime_processed_unweighted_r.csv")

tramdata = read.csv('stop_locations.txt', header = FALSE, sep = "|", fileEncoding="UTF-8-BOM")
names(tramdata) <- c("StopLocationID","StopNameShort","StopNameLong","StopType","SuburbName","PostCode","RegionName", "LocalGovernmentArea","StatDivision","lat","lon")
head(tramdata, n=5)

keeps <- c("StopNameShort", "lat", "lon")
tramdata = tramdata[keeps]
head(tramdata, n=5)

keeps <- c("lat", "lon")
tramdata_pos = tramdata[keeps]
colnames(tramdata_pos)[1] <- "t_lat"
colnames(tramdata_pos)[2] <- "t_lon"
head(tramdata_pos, n=5)

# Install required packages

#install.packages("sp")

#install.packages("sf")

#install.packages("geosphere")

library(tidyverse)
library(sp)
library(sf)
library(geosphere)


# Create ID for my_df_1 and my_df_2 based on row id
# This step is not required, just help me to better distinguish each point
tramdata_pos <- tramdata_pos %>% mutate(ID1 = row.names(.))
crime_processed <- crime_processed %>% mutate(ID2 = row.names(.))

# Create spatial point data frame
my_df_1_sp <- tramdata_pos
coordinates(my_df_1_sp) <- ~t_lon + t_lat

my_df_2_sp <- crime_processed
coordinates(my_df_2_sp) <- ~c_lon + c_lat

# Convert to simple feature
my_df_1_sf <- st_as_sf(my_df_1_sp)
my_df_2_sf <- st_as_sf(my_df_2_sp)

# Set projection based on the epsg code
st_crs(my_df_1_sf) <- 4326
st_crs(my_df_2_sf) <- 4326

# Calculate the distance
m_dist <- st_distance(my_df_1_sf, my_df_2_sf)

# Filter for the nearest
near_index <- apply(m_dist, 1, order)[1, ]

# Based on the index in near_index to select the rows in my_df_2
# Combine with my_df_1
my_df_final <- cbind(tramdata_pos, crime_processed[near_index, ])

my_df_final

keeps <- c("t_lat", "t_lon", "Severity.Total.Score")
tramdata_final = my_df_final[keeps]
colnames(tramdata_final)[1] <- "Latitude"
colnames(tramdata_final)[2] <- "Longitude"
head(tramdata_final, n=5)

tramdata_final_normalized = tramdata_final
tramdata_final_normalized$Severity.Total.Score.Normalised=scale(tramdata_final_normalized$Severity.Total.Score, center = FALSE, scale = TRUE)
keeps <- c("Latitude", "Longitude", "Severity.Total.Score.Normalised")
tramdata_final_normalized = tramdata_final_normalized[keeps]
head(tramdata_final_normalized, n=5)

#Create Crime and Severity Score list
keeps <- c("Offence.Subgroup", "Offence.Subgroup.Code", "Offence.Subgroup.Name", "Incidents.Recorded", "Crime.Severity")
crime_list = crime_list[keeps]

#Remove duplicates
crime_list = crime_list[!duplicated(crime_list$Offence.Subgroup), ]
head(crime_list, n=5)

#Non normalised
write.csv(tramdata_final, file = "crime_tram_model_notNormalised.csv", row.names=FALSE)

#Normalised
write.csv(tramdata_final_normalized, file = "crime_tram_model_Normalised.csv", row.names=FALSE)

#Normalised
write.csv(crime_list, file = "crime_list.csv", row.names=FALSE)



