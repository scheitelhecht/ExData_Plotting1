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

## create plot 3 ##
png("plot3.png", width = 480, height= 480)
with ( data = pc.feb ,
       {
         plot( DateTime, Sub_metering_1 , type="l" 
               , ylab="Energy sub metering"
               , xlab=""
         )
         lines (DateTime , Sub_metering_2 ,col="red")
         lines (DateTime , Sub_metering_3 ,col="blue")
         
       })

legend ("topright"
        , col=c("black", "red", "blue")
        , lty=1 # lines
        , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)
dev.off()  
