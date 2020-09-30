
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
dat <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarise(Emissions = sum(Emissions)) #data preparation

png("plot2.png", width = 480, height = 480) #png graphic device

with(dat, 
     barplot(Emissions ~ year, 
             col = terrain.colors(4), 
             space = 0.5,
             ylim = c(0, 3500),
             xlab = "Year", 
             ylab = expression("PM" [2.5]*" (tons)"),
             main = expression("Total PM" [2.5]*" Emmissions in Baltimore City from 1999-2008")
     )
)
dev.off()
