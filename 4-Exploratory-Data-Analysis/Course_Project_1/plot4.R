
if(!file.exists("exdata_data_NEI_data.zip")) {
  tmp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",tmp)
  unzip(tmp)
  unlink(tmp)
}


NEI <- readRDS("summarySCC_PM25.rds") #reading the data
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)

cl <- SCC[grep("[Cc][Oo][Aa][Ll]", SCC$EI.Sector), "SCC"]

library(dplyr)
dat <- NEI %>% filter(SCC %in% cl) %>% group_by(year) %>% summarise(Emissions = sum(Emissions)) #data preparation
head(dat)
str(dat)

png("plot4.png", width = 480, height = 480) #png graphic device

library(ggplot2)
ggplot(data = dat, aes(x = year, y = Emissions/1000)) + 
  geom_point(size = 4.5) + 
  geom_line(size  = 1.2, col = "red") + 
  ylim(300, 600) +
  labs(x = "Year", y = expression("PM" [2.5]*" (Kilotons)"),
       title = "Emmissions from Coal combustion-related sources in US from 1999-2008") +
  theme_bw()

dev.off()
