# Script Name: plot2.R
# Exploratory Analysis (Project 1): Read power consumption data and plots data for two days
# Project: 
# A full description is available at the site where the data was obtained: 
#     UC Irvine Machine Learning Repository
# Data for the project: 
#     https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#

## set working directory
setwd("/Users/rguliani/Documents/RajeevDocs/Coursera/Explore/ExData_Plotting1")

## Step #1: read actLabels labels and format columns
hhConSample <- read.csv("./data/household_power_consumption.txt", sep = ";" , header = TRUE, nrows = 5 )
classes <- sapply(hhConSample, class)
hhConAll <- read.csv("./data/household_power_consumption.txt", sep = ";" , header = TRUE, colClasses = classes, na.strings="?", 
            nrows=2075259, stringsAsFactors=F, comment.char="", quote='\"')
# set date format
hhConAll$Date <- as.Date(hhConAll$Date, format="%d/%m/%Y")

# get subset by applying date filter & reformat date/time
hhConSubset <- subset(hhConAll, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(hhConSubset$Date), hhConSubset$Time)
# Add date time
hhConSubset$MyDate <- as.POSIXct(datetime)

## Plot Global Ative Power (Killowatts) using line type
plot(hhConSubset$Global_active_power~hhConSubset$MyDate, ylab="Global Active Power (kilowatts)", type="l", xlab="")

## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
