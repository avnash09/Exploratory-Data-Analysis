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
df3 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE, dec=".")
subsetDF <- subset(df, Date %in% c("1/2/2007", "2/2/2007"))

dateTime <- strptime(paste(subsetDF$Date, subsetDF$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
submetering1 <- as.numeric(subsetDF$Sub_metering_1)
submetering2 <- as.numeric(subsetDF$Sub_metering_2)
submetering3 <- as.numeric(subsetDF$Sub_metering_3)
png("plot3.png", width = 480, height = 480)
plot(dateTime, submetering1, type = "l", xlab = "", ylab="Energy Submetering")
lines(dateTime, submetering2, col = "red")
lines(dateTime, submetering3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1, lwd=2.5, bty = "o")
dev.off()

#Now setting the working directory to original
setwd(mainDir)