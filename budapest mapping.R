#Mapping Budapest using Christian Burkhart's codes
#https://ggplot2tutor.com/streetmaps/streetmaps/
library(tidyverse)
library(osmdata)
library(ggplot2)
available_tags("highway")
available_features()
#getting coordinates for a city
getbb("Budapest Hungary")
#min      max
#x 18.92511 19.33493
#y 47.34969 47.61315

#extract major streets of the city
streets <- getbb("Budapest Hungary")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", 
                            "secondary", "tertiary")) %>%
  osmdata_sf()
streets


small_streets <- getbb("Budapest Hungary")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street", "unclassified", "service", "footway"))%>%
  osmdata_sf()

river <- getbb("Budapest Hungary")%>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river")%>%
  osmdata_sf()
#first streetmaps
ggplot()+
  geom_sf(data = streets$osm_lines, 
          inherit.aes = FALSE,
          color="black",
          size=.4,
          alpha=.8) +
  coord_sf(xlim = c(18.9, 19.35),
           ylim = c(47.35, 47.62),
           expand = FALSE)
#expand=FALSE makes sure that the coordinates are displayed exactly

#add small street and river
ggplot()+
  geom_sf(data = streets$osm_lines, 
          inherit.aes = FALSE,
          color="black",
          size=.4,
          alpha=.8)+
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          size=.4,
          color="black",
          alpha=.6)+
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE, 
          color="black", 
          size=.2,
          alpha=.5)+
  coord_sf(xlim = c(18.9, 19.35),
           ylim = c(47.35,47.62),
           expand = FALSE)

#to remove the x and y axis use theme_void()
#colour it

ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "#7fc0ff",
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .2,
          alpha = .6) +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .2,
          alpha = .5) +
  coord_sf(xlim = c(18.9, 19.35),
           ylim = c(47.35,47.62),
           expand = FALSE) +
  theme_void()+
  theme(
    plot.background = element_rect(fill = "#282828")
  )

ggsave("map.png", width = 6, height = 6)

ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .2,
          alpha = .6) +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "#7fc0ff",
          size = .2,
          alpha = .5) +
  coord_sf(xlim = c(18.9, 19.35),
           ylim = c(47.35,47.62),
           expand = FALSE) +
  theme_void()+
  theme(
    plot.background = element_rect(fill = "#282828")
  )
