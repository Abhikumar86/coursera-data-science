if(!file.exists("household_power_consumption.zip")) {
  tmp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tmp)
  unzip(tmp)
  unlink(tmp)
}

df <- read.csv(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?") #reading data
str(df)

dat <- subset(df, Date  %in% c("1/2/2007","2/2/2007")) #subsetting
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y") #converting to the date format
str(dat)

png("plot1.png", width = 480, height = 480) #png graphic device

hist(dat$Global_active_power, # preparing histogram
     col = "red",
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")

dev.off()
