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

# chart 3

png(filename = "plot3.png")

# initialize graph with first line

plot(
    miniPowerCons$DateTime, 
    miniPowerCons$Sub_metering_1, 
    type = "l",
    ylab = "Energy sub metering",
    xlab = ""
)

# add second line

lines(miniPowerCons$DateTime,miniPowerCons$Sub_metering_2, col="red")

# add third line

lines(miniPowerCons$DateTime,miniPowerCons$Sub_metering_3, col="blue")

# add legend

legend("topright", lty = "solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()