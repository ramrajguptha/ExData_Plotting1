plot4(){

  library(lubridate)
  library(dplyr)
      
  powerdf <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";"
                      ,na.strings = "?", stringsAsFactors=FALSE
                     , comment.char="%")
  powerdf <-powerdf[powerdf$Date == "1/2/2007" | powerdf$Date == "2/2/2007",]
  
  Datetime <- strptime(paste(powerdf$Date, powerdf$Time), "%d/%m/%Y %H:%M:%S")
  powerdf <- cbind(powerdf, Datetime)
  powerdf <- mutate(powerdf, Day = wday(Datetime, label = TRUE, abbr = TRUE))
    
  png(filename="plot4.png", width=480, height=480, type="cairo-png", bg = "transparent") 
  
  par(mfrow = c(2,2))
  
  with(powerdf, {
    plot(Datetime, Global_active_power, ylab = "Global Active Power", type = "l", xlab="")
    
    plot(Datetime, Voltage, xlab = "datetime" , type = "l")
    
    plot(Datetime,Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
    lines(Datetime,Sub_metering_2, col = "red") 
    lines(Datetime,Sub_metering_3, col = "blue")
    legend("topright", col = c("black", "red", "blue"), lwd = .75,cex = .75,
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
    
    plot(Datetime, Global_reactive_power, xlab = "datetime" , type = "l")
    
  })
    
  dev.off()
}