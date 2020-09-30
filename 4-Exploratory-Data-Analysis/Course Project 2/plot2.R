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

png("plot2.png", width = 480, height = 480) #png graphic device

with(dat, plot(Global_active_power ~ Datetime, 
               type="l",
               xlab="",
               ylab = "Global Active Power (kilowatts)")) #create plot
dev.off()
