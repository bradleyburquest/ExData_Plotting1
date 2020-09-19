library(dplyr)

# load the data
epc_data <- read.table( "../../data/household_power_consumption.txt", header=TRUE, sep=";")

# filter and mutate the data to make it usable
epc_data <- filter(epc_data, Date == "1/2/2007" | Date == "2/2/2007")
epc_data <- mutate(epc_data, Date=as.POSIXlt( paste(epc_data[, 'Date'], epc_data[, 'Time']), format="%d/%m/%Y %H:%M:%S"), Time=NULL)
epc_data <- mutate(epc_data, Global_active_power=as.numeric(Global_active_power))

# plot the data
plot( epc_data$Date, epc_data$Global_active_power, type="l", ylab="Global Actice Power (kilowatts)", xlab="")

# create the png file
dev.print( png, file="plot2.png", width=480, height=480)
dev.off()
