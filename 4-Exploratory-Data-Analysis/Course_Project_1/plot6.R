
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
library(ggplot2)

vhl <- SCC[grep("[Vv]ehicle", SCC$EI.Sector), "SCC"]

dat.baltimore <- NEI %>% filter(SCC %in% vhl & fips == "24510") %>% group_by(year) %>% 
  summarise(Emissions = sum(Emissions)) #data preparation
dat.losangeles <- NEI %>% filter(SCC %in% vhl & fips == "06037") %>% group_by(year) %>% 
  summarise(Emissions = sum(Emissions)) #data preparation
dat <- rbind(dat.baltimore, dat.losangeles)
dat$County <- c(rep("Baltimore City", 4), rep("Los Angeles", 4)) 
head(dat)

png("plot6.png", width = 480, height = 480) #png graphic device

ggplot(data = dat, aes(x = year, y = Emissions, col = County)) + 
  geom_point(size = 4.5) + 
  geom_line(size  = 1.2) +
  labs(x = "Year", y = expression("PM" [2.5]*" (tons)"),
       title = "Emmissions from motor vehicle sources during 1999-2008") +
  theme_bw()

dev.off()
