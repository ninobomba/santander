# Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles 
# (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. 
# Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de 
# las probabilidades marginales correspondientes.

#Estabecemos el directorio donde guardamos los datos y los cargamos
setwd("c:/Users/Ángelica/Desktop/SEMESTRE EN LINEA/bedu/modulo 2/POSTWORK/")
datos<-read.csv("datos.csv")

#probas marginales y conjunta
marginal.fthg<-table(datos[,"FTHG"])/dim(datos)[1] #8
marginal.ftag<-table(datos[,"FTAG"])/dim(datos)[1] #6
conjunta<-table(datos[,"FTHG"],datos[,"FTAG"])/dim(datos)[1] #8X6

a<-matrix(1:63,nrow=9) #Matriz para guardar el cociente
#HAcemos el cociente entrada por entrada, i<-rengón j<-columna
for (i in 1:9){
  for (j in 1:7){
    a[i,j]<-conjunta[i,j]/(marginal.fthg[i]*marginal.ftag[j])
  }
 }

 
# Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la
# tabla del punto anterior. Esto para tener una idea de las distribuciones de la cual vienen
# los cocientes en la tabla anterior. Menciona en cuáles casos le parece razonable suponer que
# los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia
# de las variables aleatorias X y Y).

#fijamos una semilla para poder reproducir la muestra
set.seed(2020)
#10,000 muestras con reemplazo de tamaño 63
muestras.boostrap<-sapply(X = rep(63,10000), FUN = sample,x=a,replace=T)
#obtenemos las medias de las muestras creadas
medias<-apply(muestras.boostrap,2,mean)
#media estimada
xbarra<-mean(medias)

#Comparamos la media de la muestra contra la media estimada
mean(a);xbarra

#histograma de la distribución de la media
library(ggplot2)
ggplot()+geom_histogram(aes(x = medias), bins = 50, color = "black", fill ="yellow")+
  geom_vline(xintercept = xbarra, size =1, color = "darkred")

#desviación estimada
desviacion<-sqrt(sum((medias-xbarra)^2)/(nrow(muestras.boostrap)-1)) #desviación de la media
desviacion

library(moments)
skewness(medias)#Coeficiente de asimetria
kurtosis(medias)#Kurtosis

#Podemos concluir con los valores obtenidos en la media,la curtosis y el coeficiente
#de asimetria asi como por el histograma obtenido que la media sigue una distribución
#normal.

#En general observamos que los cocientes obtenidos tienen un comportamiento extraño, sin embargo
#estableciendo un rango de .1 podríamos suponer que los valores tienden a 1 y asi suponer 
#que las variables son independientes.
