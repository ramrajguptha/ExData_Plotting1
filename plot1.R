plot1(){

  library(lubridate)
  library(dplyr)
      
  powerdf <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";"
                      ,na.strings = "?", stringsAsFactors=FALSE
                     , comment.char="%")
  powerdf <-powerdf[powerdf$Date == "1/2/2007" | powerdf$Date == "2/2/2007",]
  
  Datetime <- strptime(paste(powerdf$Date, powerdf$Time), "%d/%m/%Y %H:%M:%S")
  
  powerdf <- cbind(powerdf, Datetime)
  
  powerdf <- mutate(powerdf, Day = wday(Datetime, label = TRUE, abbr = TRUE))
    
  png(filename="plot1.png", width=480, height=480, type="cairo-png", bg = "transparent") 
    
  hist(powerdf$Global_active_power, 
       main="Global Active Power" ,
       xlab="Global Active Power (kilowatts)",
       col = "red", breaks=14
       ,axes = FALSE
       )
  axis(1, at = seq(0,6, by = 2), labels=seq(0,6, by=2))
  axis(2, at = seq(0,1200, by = 200), labels=seq(0,1200, by=200) )
  dev.off() 
}