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

png("Plot4.png")
par(mfcol=c(2,2))
plot(weekday, as.numeric(myData$Global_active_power), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
weekday <- as.POSIXct( paste(myData$Date, myData$Time, sep = " "), "%Y-%m-%d %H:%M:%S", tz="GMT")
plot(weekday, as.numeric(myData$Sub_metering_1), col = "black", type = "l", ylab = "Energy sub-metering", xlab = "")
with(myData, lines(weekday, myData$Sub_metering_2, col="red", type="l"))
with(myData, lines(weekday, myData$Sub_metering_3, col="blue", type="l"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(weekday, myData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(weekday, myData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()