x <- "2"
class(x)
y <- 3
x+y

# This is a comment
x <- c(10.1,12.3,13.5)
x*10

x[1]
x[2]
x[3]
x[2:3]
x[c(1,3)]

y <- c(1,"a",2,"b")

y <- list(1,"a",2,"b")

y[[3]]


a <- seq(1,100,5)

x <- seq(1,10,3)
y <- seq(10,20,3)

d <- data.frame(col1 = x, col2 = y)
class(d)
d
d[3,]
d[c(1,4),]
d[3:4,]

d[,2]
d
print(d)

d <- data.frame(col1 = x, col2 = y)
class(d)

m <- cbind(x,y)
class(m)

country <- c("SEN", "NGA", "TZA", "KEN", "TZA")
id <- c(20, 23, 21, 24, 27)

m <- cbind(id, country)
m
d <- data.frame(id, country)
d

as.character(d[3,2])

x <- d[d$country == "TZA",]
x

m <- as.data.frame(m)


myfunc <- function(x,y){
  z <- x+y
  z1 <- sqrt(z)
  return(z1)
}

myfunc(10,20)

x1 <- seq(1,20,5)
x2 <- seq(11,30,5)

myfunc(x1,x2)

data(cars)


data(cars)

plot(cars[,1], cars[,2], 
     xlab = 'Speed (miles/hr)', 
     ylab='Distance (feet)',
     xlim = c(0,20),
     ylim = c(0,100),
     main = "Speed-distance relation",
     cex = 2, pch = 17, col = "red",
     axes=FALSE, xaxs = "i", yaxs = "i")
axis(1)
axis(2, las=2)
text(x=5, y=50, 'More Cars!', cex=2, col='blue')


head(InsectSprays)
?InsectSprays

dim(InsectSprays)
table(InsectSprays$spray)

hist(InsectSprays$count)

x <- aggregate(InsectSprays[,1,drop=F], 
               InsectSprays[,2,drop=F], 
               sum)
barplot(x[,2], names=x[,1], horiz=T, las=1)

boxplot(count ~ spray, 
        data = InsectSprays, 
        col = "lightgray",
        main = "Insect-Spray relation")


# install.packages("raster")
library(raster)
indir <- "C:/Users/anibi/Documents/test"
dir.create(indir)
setwd(indir)
v0 <- getData("GADM", country = "NGA", level = 0)


plot(v0, border = "red", col = gray(0.8))
title(main = "Nigeria national boundary", 
      sub = "source GADM")

v1 <- getData("GADM", country = "NGA", level = 1)
plot(v1)

n <- length(v1$NAME_1)

plot(v1,
     main = 'Administrative boundary: level 1')
# Now add name of the indiviudal regions to the map
text(v1, v1$NAME_1, cex=0.75)

class(v1)
head(v1)

dim(v1)
names(v1)
v1$NAME_1

v2 <- v1[v1$NAME_1 == "Oyo",]
plot(v2, col = "red", add = TRUE)

v1$NAME_1[v1$NAME_1 == "Federal Capital Territory"] <- "FCT"

i <- nchar(v1$NAME_1)
j <- i[i>5]

shortName <- function(x, n){
  if (nchar(x) > n){
    return(substr(x,1,n))
  } else {
    return(x)
  }
}

newstates <- as.character(sapply(v1$NAME_1, shortName, 3))

newstates <- substr(v1$NAME_1, 1, 3)

v1$new_states <- newstates

plot(v1)
text(v1, v1$new_states)

url <- "https://data.humdata.org/dataset/741c6f20-6956-420d-aae4-37015cdd1ad4/resource/0c6a29a7-0815-48b2-a637-ea2a3ddb9ebe/download/nga_river_line_esri.zip"

download.file(url, dest = "nga_rivers.zip")

unzip("nga_rivers.zip")

ff <- list.files(pattern = ".shp$")

# install.packages("rgdal")
rv <- shapefile("NGA_rvrsl_1m_esri.shp")

# plot rivers
plot(v0, border = "red", lwd = 2, axes = TRUE)
plot(rv, col='blue', add = TRUE)
title(main = "Nigeria rivers")
# Add some more details
legend('bottomright', legend = 'River', 
       lty = 1, lwd = 2, col = 'blue', bty = "n")



# flood boundary
url <- "https://data.humdata.org/dataset/bd3b4ef6-0a96-4346-b229-2c410d9c6c6d/resource/3c6a77da-be1a-4437-b04f-9e1a47a601a7/download/nga-floods-2012-shp.zip"
download.file(url, dest = 'nga_flood.zip')
unzip('nga_flood.zip')
# read flood extent
fld <- shapefile("NGA_Flood_Modis_250_nasa.shp")


plot(v0, lwd = 1, axes = TRUE)
# flood extent
plot(fld, col='lightblue', border = 'transparent', 
     add = TRUE)
# river
plot(rv, col='darkblue', add = TRUE, lwd = 0.5)
# title and legends
title(main = "Nigeria flood extent and river network")

alt <- getData('alt', country='NGA', mask=TRUE)
plot(alt, col = terrain.colors(20), axes=FALSE)
title(main = "Elevation (in m)")


alt[alt > 1500] = 1500
plot(alt, col = terrain.colors(20), axes=FALSE)
title(main = "Elevation (in m)")
plot(rv, col = "blue", lwd = 2, add = TRUE) 


wc <- getData('worldclim', var='bio',
              res=0.5, lon=8, lat=9)
