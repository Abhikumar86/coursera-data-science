
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

dat <- NEI %>% filter(SCC %in% vhl & fips == "24510") %>% group_by(year) %>% 
  summarise(Emissions = sum(Emissions)) #data preparation

head(dat)

png("plot5.png", width = 480, height = 480) #png graphic device

ggplot(data = dat, aes(x = year, y = Emissions)) + 
  geom_point(size = 4.5) + 
  geom_line(size  = 1.2, col = "red") +
  labs(x = "Year", y = expression("PM" [2.5]*" (tons)"),
       title = "Emmissions from motor vehicle sources in Baltimore City during 1999-2008") +
  theme_bw()

dev.off()
