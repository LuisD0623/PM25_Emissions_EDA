# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

## Load libraries and set working directory

library(tidyverse)
library(janitor)

setwd(dir = "./Module 4")

## Read files

nei <- readRDS("summarySCC_PM25.rds") %>% 
  clean_names()

scc <- readRDS("Source_Classification_Code.rds") %>% 
  clean_names()

## Group df by year and aggregate emissions values

df<- nei %>%
  group_by(year) %>% 
  summarise(value= sum(emissions)/1000000)

png("Plot 1.png",width=480,height=480,units="px",bg="white")

with(df, barplot(names.arg=  year, height = value,
                 xlab="Year",
                 ylab="PM2.5 Emissions (10^6 Tons)",
                 main="Total PM2.5 Emissions From All US Sources"))
dev.off()


