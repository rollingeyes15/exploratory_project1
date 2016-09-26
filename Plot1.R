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

png("Plot1.png", width=480, height=480)
hist(as.numeric(myData$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

#plot(c(beginDate:endDate),as.numeric(myData$Global_active_power), type = "l", xlab = "Global Active Power (kilowatts)")
