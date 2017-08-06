#This pragram will work if plot1.R is placed in current working directory

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
mainDir <- getwd()
dir <- "Coursera"
#Check if "Coursera" directory exists or not.
#This will be our working dorectory
#If exists, make it working directory, else create it and then set it
if(file.exists(dir)){
  setwd(file.path(mainDir, dir))
} else{
  dir.create(file.path(mainDir, dir))
  setwd(file.path(mainDir, dir))
}

# "downloader" package needs to be installed
# Checking for already installed package, else will automatically download and install

if("downloader" %in% rownames(installed.packages()) == FALSE){
  install.packages("downloader")  #installing the package
  library(downloader)
} else{
  library(downloader)
}

#check if the source file is present
if(file.exists("dataFile.zip") == FALSE){
  #downloading the source file using downloader package
  download(url, dest = "dataFile.zip", mode = "wb")
}
unzip("dataFile.zip") #unzip the downloaded file

#Now reading data from text file
df4 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE, dec=".")
subsetDF <- subset(df, Date %in% c("1/2/2007", "2/2/2007"))

dateTime <- strptime(paste(subsetDF$Date, subsetDF$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(subsetDF$Global_active_power)
globalReactivePower <- as.numeric(subsetDF$Global_reactive_power)
Voltage <- as.numeric(subsetDF$Voltage)
submetering1 <- as.numeric(subsetDF$Sub_metering_1)
submetering2 <- as.numeric(subsetDF$Sub_metering_2)
submetering3 <- as.numeric(subsetDF$Sub_metering_3)

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

plot(dateTime, globalActivePower, type = "l", xlab="", ylab = "Global Active Power")

plot(dateTime, Voltage, type = "l")

plot(dateTime, submetering1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dateTime, submetering2, type = "l", col = "red")
lines(dateTime, submetering3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=2.5, col=c("black","red","blue"), bty = "o")

plot(dateTime, globalReactivePower, type = "l", cex = 0.2, ylab = "Global_reactive_power")
dev.off()
#Now setting the working directory to original
setwd(mainDir)