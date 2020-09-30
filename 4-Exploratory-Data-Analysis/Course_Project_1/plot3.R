
if(!file.exists("exdata_data_NEI_data.zip")) {
  tmp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",tmp)
  unzip(tmp)
  unlink(tmp)
}


NEI <- readRDS("summarySCC_PM25.rds") #reading the data
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)

library(dplyr)
dat <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% summarise(Emissions = sum(Emissions)) #data preparation
head(dat)
str(dat)

png("plot3.png", width = 480, height = 480) #png graphic device

library(ggplot2)
ggplot(data = dat, aes(x = year, y = Emissions, col = type)) + 
  geom_point(size = 3) + 
  geom_line(size  = 1.2) + 
  labs(x = "Year", y = expression("PM" [2.5]*" (tons)"),
             title = expression("Total PM" [2.5]*" Emmissions in Baltimore City from 1999-2008")) +
  theme_bw()

dev.off()
