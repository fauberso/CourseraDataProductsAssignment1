library(dplyr)
library(leaflet)
library(jsonlite)

picnic <- data.world::query(
  data.world::qry_sql("Select * from picknickplatz"), 
  dataset = "https://data.world/fauberso/picnic-areas-in-the-city-of-zurich"
)

# Parse the coordinates
coords <- sapply(picnic$geometry_coordinates, function(x) head(fromJSON(x), 2))

popup <- paste("<strong>", picnic$properties_name, "</strong><br>", picnic$properties_kontakt, "<br>", picnic$properties_infrastruktur, "<br>", picnic$properties_anlageelemente)
icon <- makeIcon("picnic_area.png", iconWidth = 24, iconHeight = 24)

# Create the Leaflet map
m <- leaflet() %>% addTiles() %>% addMarkers(lng = coords[1,], lat = coords[2,], icon = icon, popup = popup)
m