# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#    variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?

## Load libraries and set working directory

library(tidyverse)
library(janitor)

setwd(dir = "./Module 4")

## Read files

nei <- readRDS("summarySCC_PM25.rds") %>% 
  clean_names()

scc <- readRDS("Source_Classification_Code.rds") %>% 
  clean_names()

## Filter df by fips = 24510 and summarise by year and type, then aggregate emission values.

df<- nei %>% 
  filter(fips == "24510") %>% 
  summarise(.by = c(year, type),
            value = sum(emissions, na.rm= T))

plot3<- df %>%
  mutate(year= as.factor(year)) %>% 
  ggplot(mapping=aes(x= year, y= value, fill= type))+
  geom_col(show.legend = T, position = "dodge")+
  xlab("")+
  ylab("PM2.5 emission")+
  ggtitle("Total emissions from PM2.5 in Baltimore City, Mariland",
          "By Types Of Sources")+
  scale_colour_brewer(palette = "Spectral")+
  theme_minimal()+
  facet_wrap(~type, scales= "free")+
  theme(plot.title = element_text(face = "bold", hjust = 0.5),
        plot.subtitle = element_text(face = "bold", hjust = 0.5))

ggsave(plot = plot3, filename = "Plot 3.png", bg = "white",  width = 8.68, height = 5.08, units = "in", dpi = 300)
