# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

## Load libraries and set working directory

library(tidyverse)
library(janitor)

setwd(dir = "./Module 4")

## Read files

nei <- readRDS("summarySCC_PM25.rds") %>% 
  clean_names()

scc <- readRDS("Source_Classification_Code.rds") %>% 
  clean_names()

## Filter scc object by a text pattern "Vehicle" in column short_name

vehicles<- scc %>% 
  filter(str_detect(short_name, "Vehicle"))

## Filter nei object to get only Baltimore (24510) and LA (06037) observations,
## then do an Inner Join whith vehicules object to get only relevant rows for this sources

df<- nei %>%
  filter(fips == "24510" |
           fips == "06037") %>% 
  inner_join(x= .,
             y= vehicles,
             by= "scc") %>% 
  summarise(.by = c(year, fips),
            value= sum(emissions))

plot6<- df %>%
  mutate(fips= str_replace(fips, "06037", "Los Angeles County"),
         fips= str_replace(fips, "24510", "Baltimore City")) %>% 
  mutate_at(.vars = c("year", "fips"),
            .funs = as.factor) %>% 
  ggplot(mapping = aes(x= year, y= value, fill= fips))+
  geom_col(position = "dodge", show.legend = F)+
  xlab("")+
  ylab("PM2.5 emission")+
  ggtitle("Total emissions from PM2.5 in Baltimore & LA",
          "(Motor Vehicle Sources)")+
  scale_colour_brewer(palette = "Spectral")+
  facet_wrap(~fips)+
  theme_minimal()+
  theme(plot.title = element_text(face = "bold", hjust = 0.5),
        plot.subtitle = element_text(face = "bold", hjust = 0.5))

ggsave(plot = plot6, filename = "Plot 6.png", bg = "white",  width = 8.68, height = 5.08, units = "in", dpi = 300)
