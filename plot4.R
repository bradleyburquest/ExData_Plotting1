library(dplyr)
#load the data
epc_data <- read.table( "../../data/household_power_consumption.txt", header=TRUE, sep=";")

# filter and mutate the data to make it usable
epc_data <- filter(epc_data, Date == "1/2/2007" | Date == "2/2/2007")
epc_data <- mutate(epc_data, Date=as.POSIXlt( paste(epc_data[, 'Date'], epc_data[, 'Time']), format="%d/%m/%Y %H:%M:%S"), Time=NULL)
epc_data <- mutate(epc_data, Global_active_power=as.numeric(Global_active_power))
epc_data <- mutate(epc_data, Global_reactive_power=as.numeric(Global_reactive_power))
epc_data <- mutate(epc_data, Voltage=as.numeric(Voltage))

# create the four plots
par( mfrow= c(2, 2) )
with( epc_data, {
      plot( Date, Global_active_power, type="l", ylab="Global Actice Power (kilowatts)", xlab="")
      plot( Date, Voltage, xlab="datetime", type="l")
      plot( Date, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
      lines( Date, Sub_metering_2, type="l", col="red")
      lines( Date, Sub_metering_3, type="l", col="blue")
      legend( "topright", col=c("black", "red", "blue"), 
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, box.lty = 0, inset=c(0.17, 0.02))
      plot( Date, Global_reactive_power, xlab="datetime", type="l")
})

# create the png file
dev.print( png, file="plot4.png", width=480, height=480)
dev.off()