PM2.5_Emissions_EDA
================
Luis Donaldo
2025-02-16

## Introduction

Fine particulate matter (PM2.5) is an ambient air pollutant for which
there is strong evidence that it is harmful to human health. In the
United States, the Environmental Protection Agency (EPA) is tasked with
setting national ambient air quality standards for fine PM and for
tracking the emissions of this pollutant into the atmosphere.
Approximatly every 3 years, the EPA releases its database on emissions
of PM2.5. This database is known as the National Emissions Inventory
(NEI). You can read more information about the NEI at the EPA National
Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many
tons of PM2.5 were emitted from that source over the course of the
entire year. The data that you will use for this assignment are for
1999, 2002, 2005, and 2008.

## Data

The data for this assignment are available from the course web site as a
single zip file:

Data for Peer Assessment \[29Mb\] The zip file contains two files:

PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data
frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and
2008. For each year, the table contains number of tons of PM2.5 emitted
from a specific type of source for the entire year. Here are the first
few rows.

``` r
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
```

- fips: A five-digit number (represented as a string) indicating the
  U.S. county
- SCC: The name of the source as indicated by a digit string (see source
  code classification table)
- Pollutant: A string indicating the pollutant
- Emissions: Amount of PM2.5 emitted, in tons
- type: The type of source (point, non-point, on-road, or non-road)
- year: The year of emissions recorded

Source Classification Code Table (Source_Classification_Code.rds): This
table provides a mapping from the SCC digit strings int he Emissions
table to the actual name of the PM2.5 source. The sources are
categorized in a few different ways from more general to more specific
and you may choose to explore whatever categories you think are most
useful. For example, source “10100101” is known as “Ext Comb /Electric
Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the readRDS() function in R.
For example, reading in each file can be done with the following code:

This first line will likely take a few seconds. Be patient!

``` r
nei <- readRDS("summarySCC_PM25.rds") %>% 
  clean_names()

scc <- readRDS("Source_Classification_Code.rds") %>% 
  clean_names()
```

as long as each of those files is in your current working directory
(check by calling dir() and see if those files are in the listing).

## Assignment

The overall goal of this assignment is to explore the National Emissions
Inventory database and see what it say about fine particulate matter
pollution in the United states over the 10-year period 1999–2008. You
may use any R package you want to support your analysis.

## Questions

You must address the following questions and tasks in your exploratory
analysis. For each question/task you will need to make a single plot.
Unless specified, you can use any plotting system in R to make your
plot.

- 1.  Have total emissions from PM2.5 decreased in the United States
      from 1999 to 2008? Using the base plotting system, make a plot
      showing the total PM2.5 emission from all sources for each of the
      years 1999, 2002, 2005, and 2008.
- 2.  Have total emissions from PM2.5 decreased in the Baltimore City,
      Maryland (fips == “24510”) from 1999 to 2008? Use the base
      plotting system to make a plot answering this question.
- 3.  Of the four types of sources indicated by the type (point,
      nonpoint, onroad, nonroad) variable, which of these four sources
      have seen decreases in emissions from 1999–2008 for Baltimore
      City? Which have seen increases in emissions from 1999–2008? Use
      the ggplot2 plotting system to make a plot answer this question.
- 4.  Across the United States, how have emissions from coal
      combustion-related sources changed from 1999–2008?
- 5.  How have emissions from motor vehicle sources changed from
      1999–2008 in Baltimore City?
- 6.  Compare emissions from motor vehicle sources in Baltimore City
      with emissions from motor vehicle sources in Los Angeles County,
      California ( fips == “06037”). Which city has seen greater changes
      over time in motor vehicle emissions?

## Making and Submitting Plots

For each plot you should

- Construct the plot and save it to a PNG file.
- Create a separate R code file (plot1.R, plot2.R, etc.) that constructs
  the corresponding plot, i.e. code in plot1.R constructs the plot1.png
  plot. Your code file should include code for reading the data so that
  the plot can be fully reproduced. You should also include the code
  that creates the PNG file. Only include the code for a single plot
  (i.e. plot1.R should only include code for producing plot1.png)
- Upload the PNG file on the Assignment submission page
- Copy and paste the R code from the corresponding R file into the text
  box at the appropriate point in the peer assessment.

## Anwers

*1. Have total emissions from PM2.5 decreased in the United States from
1999 to 2008? *

A: **The graph shows that there has been a decrease in each of the years
analyzed for total PM 2.5 emissions considering all sources in the
USA.**

``` r
## Group df by year and aggregate emissions values
df<- nei %>%
  group_by(year) %>% 
  summarise(value= sum(emissions)/1000000)

with(df, barplot(names.arg=  year, height = value,
                 xlab="Year",
                 ylab="PM2.5 Emissions (10^6 Tons)",
                 main="Total PM2.5 Emissions From All US Sources"))
```

![](README_files/figure-gfm/plot1-1.png)<!-- -->

*2. Have total emissions from PM2.5 decreased in the Baltimore City,
Maryland from 1999 to 2008?*

A: **The graph shows that there has been a global decrease in Baltimore
from 1999 to 2008, the only year that shows an increase in PM2.5
emission levels is 2005.**

``` r
## Group df by year, filter by fips = 24510 and aggregate emissions values

df<- nei %>%
  filter(fips == "24510") %>% 
  group_by(year) %>% 
  summarise(value= sum(emissions))

with(df, barplot(names.arg=  year, height = value,
                 xlab="Year",
                 ylab="PM2.5 Emissions (Tons)",
                 main="Total PM2.5 Emissions From All Baltimore City Sourcers"))
```

![](README_files/figure-gfm/plot2-1.png)<!-- -->

*3. Of the four types of sources indicated by the type (point, nonpoint,
onroad, nonroad) variable, which of these four sources have seen
decreases in emissions from 1999–2008 for Baltimore City? Which have
seen increases in emissions from 1999–2008?*

A: **In general, the “NON-ROAD” and “ON-ROAD” types show the highest
level of decrease and this is also constant. On the other hand,
“NONPOINT” has a decrease from 1999 to 2002 and from that year onwards
the emission levels remain very similar. Finally, “POINT” is the only
one that registers an increase, especially between 2002 and 2005.**

``` r
## Filter df by fips = 24510 and summarise by year and type, then aggregate emission values.

df<- nei %>% 
  filter(fips == "24510") %>% 
  summarise(.by = c(year, type),
            value = sum(emissions, na.rm= T))

df %>%
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
```

![](README_files/figure-gfm/plot3-1.png)<!-- -->

*4. Across the United States, how have emissions from coal
combustion-related sources changed from 1999–2008?*

A: **For Coal Combustion-Related Sources, a decrease is recorded
especially from 2005 to 2008, in the three sectors graphed.**

``` r
## Filter scc object by a text pattern "Coal" in column ei_sector

coal<- scc %>% 
  filter(str_detect(ei_sector, "Coal"))


## Do a Inner Join for the new df (coal) with nei to get only relevant rows for this sources

df<- nei %>% 
  inner_join(x= .,
             y= coal,
             by= "scc") %>% 
  summarise(.by = c(year, ei_sector),
            value= sum(emissions)/1000)


df %>%
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
```

![](README_files/figure-gfm/plot4-1.png)<!-- -->

*5. How have emissions from motor vehicle sources changed from 1999–2008
in Baltimore City?*

A: **For the Motor Vehicle Sources, a general decrease is recorded, even
if we compare vehicles using gasoline or diesel; for other fuels, no
data is recorded for 1999 and 2008.**

``` r
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

df %>% 
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
```

![](README_files/figure-gfm/plot5-1.png)<!-- -->

*6. Compare emissions from motor vehicle sources in Baltimore City with
emissions from motor vehicle sources in Los Angeles County, California.
Which city has seen greater changes over time in motor vehicle
emissions?*

A: **Comparing the total PM2.5 emission levels of both cities, there is
a very large difference, since LA has levels much higher than Baltimore,
however, in both cities a decrease in emission levels has been achieved,
although in LA the decrease has been greater, both in total and
percentage terms..**

``` r
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

df %>%
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
```

![](README_files/figure-gfm/plot6-1.png)<!-- -->
