# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

## Do a Inner Join for the new df (vehicles) with nei to get only relevant rows for this sources and filter by fips = 24510 

df<- nei %>%
  filter(fips == "24510") %>% 
  inner_join(x= .,
             y= vehicles,
             by= "scc") %>% 
  summarise(.by = c(year, scc_level_two),
            value= sum(emissions))

plot5<- df %>% 
  mutate(year= as.factor(year)) %>% 
  ggplot(mapping=aes(x= year, y= value, fill= scc_level_two))+
  geom_col(show.legend = F, position = "dodge")+
  xlab("")+
  ylab("PM2.5 emission")+
  ggtitle("Total emissions from PM2.5 in Baltimore",
          "By Motor Vehicle Sources")+
  scale_colour_brewer(palette = "Spectral")+
  theme_minimal()+
  facet_wrap(~scc_level_two, scales= "free_y", nrow= 2)+
  theme(plot.title = element_text(face = "bold", hjust = 0.5),
        plot.subtitle = element_text(face = "bold", hjust = 0.5))


ggsave(plot = plot5, filename = "Plot 5.png", bg = "white",  width = 8.68, height = 5.08, units = "in", dpi = 300)


