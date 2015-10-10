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
# chart 1

png(filename = "plot1.png")

hist(
    miniPowerCons$Global_active_power, 
    xlab = "Global Active Power (kilowatts)", 
    main = "Global Active Power", 
    col = "red"
)

dev.off() 