library(dplyr)

# Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:
match.data<-read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Postwork/match.data.csv")

str(match.data) #analizamos los tipos de datos del DF y los modificamos para poder manipularlos
# Agrega una nueva columna sumagoles que contenga la suma de goles por partido.
match.data<-mutate(match.data,sumagoles=home.score+away.score,date=as.Date(match.data$date))              

# Obtén el promedio por mes de la suma de goles.

#agregamos columna con año y mes
match.data <- mutate(match.data, Ym = format(date, "%Y-%m"))

#Agregamos datos nulos para completar la frecuencia mensual de los datos
#de los meses junio y julio
ym<-c("2018-06","2018-07")
promedio<-c(NA,NA)
a<-data.frame(ym,promedio)
colnames(a)<-c("Ym","promedios")
ym1<-c("2019-06","2019-07")
a1<-data.frame(ym1,promedio)
colnames(a1)<-c("Ym","promedios")

# data frame de promedios por mes 
promedios<- match.data %>% group_by(Ym) %>% summarise(promedios = mean(sumagoles))
b<-rbind(promedios%>%filter(Ym>="2017-08",Ym<="2018-05"),
      a,
      promedios%>%filter(Ym>="2018-08",Ym<="2019-05"),
      a1,
      promedios%>%filter(Ym>="2019-08",Ym<="2019-12"))


# Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
serie <- ts(b$promedios, st = c(2017, 8), # A partir de agosto 2017
             frequency = 12,end=c(2019,12)) # Hasta diciembre de 2019


# Grafica la serie de tiempo.
ts.plot(serie,main="Goles promedio mensuales",xlab="Periodo",ylab="Promedio",
        col="Purple")
