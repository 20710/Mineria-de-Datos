
#practica 06a
#El data set consiste en el conteo de usuario de windows, mac y linux que utilizan internet

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
 

#-------------------------
#Practica 06b

packages <- c("stats", "cluster", "factoextra")
lapply(packages, library, character.only = TRUE)

df<- read.csv("C:/Users/Gabriel/Desktop/usuarios_win_mac_lin.csv")

head(df)

kmeans(df, 3, iter.max = 10, nstart = 1)


#Determinando el número óptimo de clústers

df2 <- scale(df) 
head(df2)

#El bow method

fviz_nbclust(df, kmeans, method = "wss") + geom_vline(xintercept = 4, linetype = 2) + labs(subtitle = "Elbow method")


# Silhouette method
fviz_nbclust(df, kmeans, method = "silhouette") + labs(subtitle = "Silhouette method")



#La Regla de la mayoria. Liberia nbClust()
installed.packages("NbClust")
library("NbClust")


nb <- NbClust(df2, distance = "euclidean", min.nc = 2, max.nc = 10, method = "kmeans")


library("factoextra") 
fviz_nbclust(nb)




#-------------------------
#Practica 06c.


library(factoextra) 
install.packages("clusterCrit")
library(clusterCrit)

# Estandarizamos
df2 <- scale(df)


data <- as.matrix(df2)

range_k = 2:10
dunn_kmeans <- c()
set.seed(123)

for (k in range_k) {
  set.seed(123)
  
  kmeans <- stats::kmeans(x = data, centers = k, nstart = 25)
  
  index_internal_kmeans <- clusterCrit::intCriteria(traj = data,
                                                    part = as.integer(kmeans$cluster), 
                                                    crit = "dunn")
  dunn_kmeans[k-1] <- index_internal_kmeans$dunn
}

#++++


plot_dunn_kmeans <- ggplot2::qplot(x = range_k, 
                                   y = dunn_kmeans, 
                                   geom = 'line', 
                                   main = 'k-means', 
                                   xlab = 'k', 
                                   ylab = 'Distance Ratio')

plot_dunn_kmeans <- plot_dunn_kmeans  + 
  theme_bw() + #ylim(0,0.3) + 
  geom_vline(xintercept = range_k[which.max(dunn_kmeans)],
             linetype = 2, color='red')   
#ggsave(filename = "../../images/enh/dunn_kmeans_2_15.png", dpi = 300)

plot_dunn_kmeans



kmeans <- stats::kmeans(x = data, 
                        centers = range_k[which.max(dunn_kmeans)], 
                        nstart = 25)

#++++++++++++++++++

plot_kmeans <- factoextra::fviz_cluster(object = kmeans,
                                        data = data,
                                        stand = F, 
                                        geom =  'point', 
                                        ellipse.type = 'convex',
                                        ellipse = T,
                                        main = paste('Clustering: k-means k:', range_k[which.max(dunn_kmeans)]),
                                        outlier.color = 'black',
                                        show.clust.cent = T)

plot_kmeans <- plot_kmeans + 
  theme_bw() +
  theme(legend.position = 'bottom')  

plot_kmeans