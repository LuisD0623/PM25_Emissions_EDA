# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## Load libraries and set working directory

library(tidyverse)
library(janitor)

setwd(dir = "./Module 4")

## Read files

nei <- readRDS("summarySCC_PM25.rds") %>% 
  clean_names()

scc <- readRDS("Source_Classification_Code.rds") %>% 
  clean_names()


## Filter scc object by a text pattern "Coal" in column ei_sector

coal<- scc %>% 
  filter(str_detect(ei_sector, "Coal"))


## Do a Inner Join the new df (coal) with nei to get only relevant rows for this sources

df<- nei %>% 
  inner_join(x= .,
             y= coal,
             by= "scc") %>% 
  summarise(.by = c(year, ei_sector),
            value= sum(emissions)/1000)


plot4<- df %>%
  mutate(year= as.factor(year)) %>% 
  ggplot(mapping=aes(x= year, y= value, fill= ei_sector))+
  geom_col(show.legend = F, position = "dodge")+
  xlab("")+
  ylab("PM2.5 emission (10^5 Tons)")+
  ggtitle("Total emissions from PM2.5 in USA",
          "By Coal Combustion-Related Sources")+
  scale_colour_brewer(palette = "Spectral")+
  theme_minimal()+
  facet_wrap(~ei_sector, scales= "free", nrow= 2)+
  theme(plot.title = element_text(face = "bold", hjust = 0.5),
        plot.subtitle = element_text(face = "bold", hjust = 0.5))

ggsave(plot = plot4, filename = "Plot 4.png", bg = "white",  width = 8.68, height = 5.08, units = "in", dpi = 300)

