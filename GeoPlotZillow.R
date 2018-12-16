
library(leaflet)
library(data.table)
library(dplyr)
library(htmltools)
df <- fread('/Users/josephseverino/Data_Science/Zillow/all/train_eng_feats.csv')
df <- filter(df, logerror >.15 | logerror < -.15)


df$latitude <- sapply(df$latitude, function(x){x/1000000})
df$longitude <- sapply(df$longitude, function(x){x/1000000})
df$abslog <- sapply(df$logerror, function(x){(x^2)+10})

#View(df)
for(e in seq(1,dim(df)[1])){
 
  if(df$logerror[e] > .5){
    df$label[e] <- "Over Est. Outlier"
    df$color[e] <- "#ff0000"
  }else if(df$logerror[e] > 0){
    df$label[e] <- "Over Est. Inner"
    df$color[e] <- "#ffe6e6"
  }else if(df$logerror[e] > -.5){
    df$label[e] <- "Under Est. Inner"
    df$color[e] <- "#e6f9ff"
  }else{
    df$label[e] <- "Under Est. Outlier"
    df$color[e] <- "#0099cc"
  }
}
#df <- transform(df, color= ifelse(logerror>0,"#ffa500" , "#22F1C9"))
#df <- transform(df, label= ifelse(logerror>0,"Over Priced" , "Under Priced"))






#dim(df)
m <- leaflet(df) %>% addTiles('http://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png', attribution='Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
  setView(-118, 34, zoom = 7.5) %>% 
  addCircles(df$longitude, df$latitude, popup= paste("Elevation: ",df$elevation,"<br>",
                                                 "  Bath: ",df$bathroomcnt,"<br>",
                                                 "  Bed: ",df$bedroomcnt,"<br>",
                                                 "  Tax: ",df$taxvaluedollarcnt,"<br>",
                                                 "  Log Error: ",df$logerror), 
                                    weight = 3, radius=df$abslog, 
                                    color=df$color, stroke = TRUE, 
                                    fillOpacity = 0.5) %>% 
  addLegend("bottomright", colors= c("#ff0000" ,"#ffe6e6",
                                     "#e6f9ff","#0099cc"), 
            labels=c("Over Est. Outlier" ,"Over Est. Inner",
                     "Under Est. Inner","Under Est, Outlier"), title="IN CALIFORNIA")

m

