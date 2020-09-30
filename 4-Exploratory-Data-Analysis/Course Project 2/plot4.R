if(!file.exists("household_power_consumption.zip")) {
  tmp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tmp)
  unzip(tmp)
  unlink(tmp)
}

df <- read.csv(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?") #reading data
Colname <- colnames(df)

dat <- read.csv(file = "household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?",
                skip = 66637, nrows = 2880) #reading data
colnames(dat) <- Colname
str(dat)

datetime <- paste(as.Date(dat$Date, format = "%d/%m/%Y"), dat$Time) #coverting to Date
dat$Datetime <- as.POSIXct(datetime) # converting time
str(dat)

png("plot4.png", width = 480, height = 480) #png graphic device

par(mfrow = c(2, 2)) #setting the layout

with(dat, plot(Global_active_power ~ Datetime, type = "l", xlab = "", ylab = "Global Active Power"))

with(dat, plot(Voltage ~ Datetime, type = "l", xlab = "datetime", ylab = "Voltage"))

plot(dat$Datetime, dat$Sub_metering_1, type="l", col = "black", xlab="", ylab = "Energy sub metering") #create plot
lines(dat$Datetime, dat$Sub_metering_2, col = "red") # submetering2
lines(dat$Datetime, dat$Sub_metering_3, col = "blue") # submetering3
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) # legend

with(dat, plot(Global_reactive_power ~ Datetime, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()
