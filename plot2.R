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
df2 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE, dec=".")
subsetDF <- subset(df, Date %in% c("1/2/2007", "2/2/2007"))

dateTime <- strptime(paste(subsetDF$Date, subsetDF$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(subsetDF$Global_active_power)
png("plot2.png", width = 480, height = 480)
plot(dateTime, globalActivePower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

#Now setting the working directory to original
setwd(mainDir)