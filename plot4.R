# Script Name: plot4.R
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
classes <- sapply(hhConsSample, class)
hhConAll <- read.csv("./data/household_power_consumption.txt", sep = ";" , header = TRUE, colClasses = classes, na.strings="?", 
            nrows=2075259, stringsAsFactors=F, comment.char="", quote='\"')
# set date format
hhConAll$Date <- as.Date(hhConAll$Date, format="%d/%m/%Y")

# get subset by applying date filter & reformat date/time
hhConSubset <- subset(hhConAll, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(hhConSubset$Date), hhConSubset$Time)
# Add date time
hhConSubset$MyDate <- as.POSIXct(datetime)

## set parameters
par( oma=c(0,0,2,0), mfrow=c(2,2), mar=c(4,4,2,1))

# first plot
plot(hhConSubset$Global_active_power~hhConSubset$MyDate, type="l", ylab="Global Active Power", xlab="")

# second plot
plot(hhConSubset$Voltage~hhConSubset$MyDate, type="l", ylab="Voltage", xlab="")

# third plot
plot(hhConSubset$Sub_metering_1~hhConSubset$MyDate, type="l", ylab="Energy sub metering", xlab="")

# add lines for metering 2 & 3
lines(hhConSubset$Sub_metering_2~hhConSubset$MyDate,col='Red')
lines(hhConSubset$Sub_metering_3~hhConSubset$MyDate,col='Blue')
legend("topright", lty=1, lwd=2, bty="n", col=c("black", "red", "blue"), 
legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# fourth plot

plot(hhConSubset$Global_reactive_power~hhConSubset$MyDate, type="l",ylab="Global_reactive_power",xlab="") 

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
