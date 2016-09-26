zipFile <- "./Electric_power_consumption.zip"

if(!file.exists(zipFile)){
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL, zipFile, quiet = FALSE)
}
textFile <- "household_power_consumption.txt"
if(!file.exists(textFile)) unzip("Electric_power_consumption.zip")

if(!exists("fullData"))
  fullData <- read.table(textFile, header = TRUE, sep =";", na.strings = "?")

names(fullData)
beginDate <- as.Date("2/1/2007", format = "%m/%d/%Y")
endDate <- as.Date("2/2/2007", format = "%m/%d/%Y")

fullData$Date <- as.Date(fullData$Date, format = "%d/%m/%Y")
if(!exists("myData"))
  myData <- subset(fullData, fullData$Date>=beginDate & fullData$Date<=endDate)

png("Plot2.png", width=480, height=480)


weekday <- as.POSIXct( paste(myData$Date, myData$Time, sep = " "), "%Y-%m-%d %H:%M:%S", tz="GMT")
plot(weekday, as.numeric(myData$Global_active_power), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
title(main="Global Active Power Vs Time")
dev.off()