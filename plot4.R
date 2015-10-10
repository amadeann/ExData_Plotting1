# The dataset has 2,075,259 rows and 9 columns
# It will toughly take 2mln x 9 x 8bytes = 144mln bytes = 144 MB of memory to load the data set 


fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "power.zip",  mode = "wb")
unzip("power.zip")


filePath <- "household_power_consumption.txt"
powerCons <- read.csv2(
    filePath,
    header = TRUE, 
    na.strings = "?",
    as.is = TRUE
)
miniPowerCons <- powerCons[powerCons$Date == "1/2/2007" | powerCons$Date == "2/2/2007",]
miniPowerCons$DateTime <- strptime(paste(miniPowerCons$Date,miniPowerCons$Time), "%d/%m/%Y %H:%M:%S")
miniPowerCons <- miniPowerCons[,c(10,3:9)]
# change the class of numeric columns to numeric
for (i in 2:8) {
    miniPowerCons[,i] <- as.double(miniPowerCons[,i])
}

# chart 4

png(filename = "plot4.png")

par(mfrow = c(2,2)) # set the plotting area to 2x2

# chart 4.1

plot(
    miniPowerCons$DateTime, 
    miniPowerCons$Global_active_power, 
    type = "l",
    ylab = "Global Active Power",
    xlab = ""
)

# chart 4.2

plot(
    miniPowerCons$DateTime, 
    miniPowerCons$Voltage, 
    type = "l", 
    xlab = "datetime", 
    ylab = "Voltage"
)

# chart 4.3

plot(
    miniPowerCons$DateTime, 
    miniPowerCons$Sub_metering_1, 
    type = "l",
    ylab = "Energy sub metering",
    xlab = ""
)
lines(miniPowerCons$DateTime,miniPowerCons$Sub_metering_2, col="red")
lines(miniPowerCons$DateTime,miniPowerCons$Sub_metering_3, col="blue")
legend(
    "topright", 
    lty = "solid", 
    bty = "n",
    col = c("black", "red", "blue"), 
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

# chart 4.4

plot(
    miniPowerCons$DateTime, 
    miniPowerCons$Global_reactive_power, 
    type = "l", 
    xlab = "datetime", 
    ylab = "Global_reactive_power"
)

dev.off()