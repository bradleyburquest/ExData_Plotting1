library(dplyr)

#load the data
epc_data <- read.table( "../../data/household_power_consumption.txt", header=TRUE, sep=";")

# filter and mutate the data to make it usable
epc_data <- filter(epc_data, Date == "1/2/2007" | Date == "2/2/2007")
epc_data <- mutate(epc_data, Date=as.POSIXlt( paste(epc_data[, 'Date'], epc_data[, 'Time']), format="%d/%m/%Y %H:%M:%S"), Time=NULL)
epc_data <- mutate(epc_data, Global_active_power=as.numeric(Global_active_power),
                   Sub_metering_1=as.numeric(Sub_metering_1),
                   Sub_metering_2=as.numeric(Sub_metering_2),
                   Sub_metering_3=as.numeric(Sub_metering_3))

# plot the data with a legend
plot( epc_data$Date, epc_data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines( epc_data$Date, epc_data$Sub_metering_2, type="l", col="red")
lines( epc_data$Date, epc_data$Sub_metering_3, type="l", col="blue")
legend("topright",  col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

# create the png file
dev.print( png, file="plot3.png", width=480, height=480)
dev.off()