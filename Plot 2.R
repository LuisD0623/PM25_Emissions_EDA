# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland?

## Load libraries and set working directory

library(tidyverse)
library(janitor)

setwd(dir = "./Module 4")

## Group df by year, filter by fips = 24510 and aggregate emissions values

df<- nei %>%
  filter(fips == "24510") %>% 
  group_by(year) %>% 
  summarise(value= sum(emissions))

png("Plot 2.png",width=480,height=480,units="px",bg="white")

with(df, barplot(names.arg=  year, height = value,
                 xlab="Year",
                 ylab="PM2.5 Emissions (Tons)",
                 main="Total PM2.5 Emissions From All Baltimore City Sourcers"))
dev.off()
