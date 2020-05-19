library(readxl)
df<- read.csv("C:/Users/Gabriel/Desktop/usuarios_win_mac_lin.csv")
View(df)

#Checamos la estructura del dataframe.
str(df)

#Eliminar cualquier valor que falte y que pueda estar presente en los datos
df <- na.omit(df)


#Se escalan los datos.
df <- scale(df)


#Subconjuntos aleatorio del conjunto de dato
df.scaled <- scale(df) 

#Calcular la distancia euclidiana
# Otros métodos pueden ser: "euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski".
dist.eucl <- dist(df.scaled, method = "euclidean")

install.packages("factoextra")

library(ggplot2)
library("factoextra") 

fviz_dist(dist.eucl)
 












