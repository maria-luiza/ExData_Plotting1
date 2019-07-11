# Read Dataset
if (!file.exists("Datasets/household_consumption.txt")) {
    housePower <- read.table(unzip("Datasets/exdata_data_household_power_consumption.zip", files = "household_power_consumption.txt", exdir = 'household_consumption.txt'),
                             sep = ';', header = TRUE, na.strings = '?')
} else {
    housePower <- read.table("household_consumption.txt", sep = ';', header = TRUE, na.strings = '?')
}

housePower$Date <- as.Date(housePower$Date, format = "%d/%m/%Y")

# Filter the dataset between 2007-02-01 and 2007-02-02
filterData <- subset(housePower, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Delete unusued dataset
rm(housePower)

# Concatenate date and time
datetime <- paste(as.Date(filterData$Date), filterData$Time)
filterData$datetime <- as.POSIXct(datetime)

# Open the file
png(filename = "plot3.png", width = 480, height = 480, units = "px")

plot(filterData$datetime, filterData$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering", col = 'black')
lines(filterData$datetime, filterData$Sub_metering_2, col = 'red')
lines(filterData$datetime, filterData$Sub_metering_3, col = 'blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()