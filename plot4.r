rm (list = ls()) # clean up the table

# Dowload the dataset
fileURL= "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./household_power_consumption.zip", method = "curl" , mode = "wb")
# unzip dataset
unzip(zipfile = "./household_power_consumption.zip")

mycolClasses <- c("character", "character" , "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
# createw datafram from file
pc <- read.table(file ="./household_power_consumption.txt" , sep = ";" , header = TRUE , colClasses  = mycolClasses ,  na.strings = "?" )

# create new, necessary  columns
library(lubridate)
pc$Date <- dmy(pc$Date)
pc$Time <- hms(pc$Time)
pc.feb$DateTime <- pc.feb$Date + pc.feb$Time # concatenate Date and Time
pc$weekday <- wday(pc$Date , label = TRUE) # create vector with weekdays


# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
pc.feb <- subset( x= pc, Date >= "2007-02-01" & Date <= "2007-02-02")

## create plot 4 ##
png("plot4.png", width = 480, height= 480)
# par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(1,0,2,1))
with ( data = pc.feb ,
       {
         # upper left diagram ( == plot 2 )
         plot(pc.feb$DateTime , pc.feb$Global_active_power
              , ylab = "Global Active Power"
              , xlab = ""
              , type="l"
         )
         # lower left diagram ( == plot 3)
         plot( DateTime, Sub_metering_1 , type="l" 
               , ylab="Energy sub metering"
               , xlab=""
         )
         lines (DateTime , Sub_metering_2 ,col="red")
         lines (DateTime , Sub_metering_3 ,col="blue")
         
         legend ("topright"
                 , col=c("black", "red", "blue")
                 , lty=1 # lines
                 , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
                 , bty ="n"
         )
         # upper right diagram
         plot(DateTime , Voltage , type = "l" , xlab = "datetime" , ylab = "Voltage")
         # lower right diagram
         plot(DateTime , Global_reactive_power , type = "l" , xlab = "datetime" , ylab = "Global_Reactive_Power")
       })
dev.off()  
