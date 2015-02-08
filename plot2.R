plot2(){

  library(lubridate)
  library(dplyr)
      
  powerdf <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";"
                      ,na.strings = "?", stringsAsFactors=FALSE
                     , comment.char="%")
  powerdf <-powerdf[powerdf$Date == "1/2/2007" | powerdf$Date == "2/2/2007",]
  
  Datetime <- strptime(paste(powerdf$Date, powerdf$Time), "%d/%m/%Y %H:%M:%S")
  
  powerdf <- cbind(powerdf, Datetime)
  
  powerdf <- mutate(powerdf, Day = wday(Datetime, label = TRUE, abbr = TRUE))
    
  png(filename="plot2.png", width=480, height=480, type="cairo-png", bg = "transparent") 
  
  with(powerdf, plot(Datetime, Global_active_power, type = "l",
                     ylab ="Global Active Power (kilowatts)", xlab = "") )
  
  dev.off() 
}