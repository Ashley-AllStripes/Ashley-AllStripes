
# Install pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# Load contributed packages with pacman
pacman::p_load(pacman, rio, tidyverse, timelineS, 
               vistime, timevis, scales, lubridate, 
               ggplot2, knitr, shiny, xts, dygraphs,
               ggrepel, extrafont, plotly, EBImage,
               ggimage, choroplethr, choroplethrMaps, 
               leaflet, usmap, janitor, rjson, maps,
               sjmisc, stringr, ggmap, devtools, gmapsdistance,
               vtable, googleway, geosphere, purrr)
# devtools::install_github("rodazuero/gmapsdistance")
#define colors to use for groups
color_list <- c("#190A63","#FE5B48","#1868D6",
                "#FFB234","#F98B84","#73B1F6")
allstripes <- palette(c("#190A63","#FE5B48","#1868D6",
                        "#FFB234","#F98B84","#73B1F6",
                        "#212529", "#626A70", "#A7B0B7",
                        "#DCDFE2", "#F8F9FA", "#FFFFFF","#000000"))

palette(allstripes)


# import care center data
amTravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/am-travelBurden.csv") 
battenTravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/batten-travelBurden.csv") 
cystinosisTravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/cystinosis-travelBurden.csv") 
fabryTravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/fabry-travelBurden.csv") 
gm1TravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/gm1-travelBurden.csv") 
gm2TravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/gm2-travelBurden.csv") 
morquioATravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/morquioa-travelBurden.csv") 
npcTravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/npc-travelBurden.csv") 
pompeTravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/pompe-travelBurden.csv") 
sanfilippoTravelBurden <- read.csv("/Volumes/GoogleDrive/My Drive/travelBurden/sanfilippo-travelBurden.csv") 

travelBurden <- list(amTravelBurden, battenTravelBurden, cystinosisTravelBurden, fabryTravelBurden, gm1TravelBurden, gm2TravelBurden, morquioATravelBurden, npcTravelBurden, pompeTravelBurden, sanfilippoTravelBurden) %>%
  reduce(full_join) %>% filter(., completed!="")

overallBurden_tabyl <- tabyl(travelBurden, How.difficult.is.it.on.average.for.the.patient.to.travel.for.clinical.care.for.their.condition.)
overallBurden_tabyl$new_order <- c(5,3,1,4,6,2)
bar_overallBurden <- overallBurden_tabyl %>%
  plot_ly(
    type = "bar",
    x = ~percent*100,
    y = ~reorder(How.difficult.is.it.on.average.for.the.patient.to.travel.for.clinical.care.for.their.condition., -new_order),
    color = I("#A7B0B7")
  ) %>%
  layout(
    title = '<b>Average travel difficulty</b>',
    yaxis=list(
      title = '',
      ticks = "outside",
      tickcolor = "white",
      yaxis = list(categoryorder = "total descending")
    ),
    xaxis=list(
      title = '<b>Percent of respondents</b>',
      ticks = "outside",
      tickcolor = "white",
      zeroline=T
    ),
    font = list(family="Poppins", color="black", size=12)
  )
bar_overallBurden
orca(bar_overallBurden, "/figures/bar_overallBurden.svg")
orca(bar_overallBurden, "/figures/bar_overallBurden.png")


farthestTravel_tabyl <- tabyl(travelBurden, In.your.best.estimate..what.is.the.farthest.distance.the.patient.has.ever.traveled..one.way..for.any.clinical.care.for.their.condition.)
farthestTravel_tabyl$new_order <- c(4,2,5,3,6,7,9,1,8)
bar_farthestTravel <- farthestTravel_tabyl %>%
  plot_ly(
    type = "bar",
    x = ~percent*100,
    y = ~reorder(In.your.best.estimate..what.is.the.farthest.distance.the.patient.has.ever.traveled..one.way..for.any.clinical.care.for.their.condition., -new_order),
    color = I("#A7B0B7")
  ) %>%
  layout(
    title = '<b>Farthest distance traveled</b>',
    yaxis=list(
      title = '',
      ticks = "outside",
      tickcolor = "white",
      yaxis = list(categoryorder = "total descending")
    ),
    xaxis=list(
      title = '<b>Percent of respondents</b>',
      ticks = "outside",
      tickcolor = "white",
      zeroline=T
    ),
    font = list(family="Poppins", color="black", size=12)
  )
bar_farthestTravel
orca(bar_farthestTravel, "/figures/bar_farthestTravel.svg")
orca(bar_farthestTravel, "/figures/bar_farthestTravel.png")


