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

ym<-c("2011-06","2011-07")
promedio<-c(NA,NA)
a<-data.frame(ym,promedio)
colnames(a)<-c("Ym","promedios")
ym<-c("2012-06","2012-07")
promedio<-c(NA,NA)
b<-data.frame(ym,promedio)
colnames(b)<-c("Ym","promedios")
ym<-c("2013-06","2013-07")
promedio<-c(NA,NA)
c<-data.frame(ym,promedio)
colnames(c)<-c("Ym","promedios")
ym<-c("2014-06","2014-07")
promedio<-c(NA,NA)
d<-data.frame(ym,promedio)
colnames(d)<-c("Ym","promedios")
ym<-c("2015-06","2015-07")
promedio<-c(NA,NA)
e<-data.frame(ym,promedio)
colnames(e)<-c("Ym","promedios")
ym<-c("2016-06","2016-07")
promedio<-c(NA,NA)
f<-data.frame(ym,promedio)
colnames(f)<-c("Ym","promedios")
ym<-c("2017-06","2017-07")
promedio<-c(NA,NA)
g<-data.frame(ym,promedio)
colnames(g)<-c("Ym","promedios")
ym<-c("2018-06","2018-07")
promedio<-c(NA,NA)
h<-data.frame(ym,promedio)
colnames(h)<-c("Ym","promedios")
ym1<-c("2019-06","2019-07")
i<-data.frame(ym1,promedio)
colnames(i)<-c("Ym","promedios")

# data frame de promedios por mes 
promedios<- match.data %>% group_by(Ym) %>% summarise(promedios = mean(sumagoles))
j<-rbind(promedios%>%filter(Ym>="2010-08",Ym<="2011-05"),
         a,
         promedios%>%filter(Ym>="2011-08",Ym<="2012-05"),
         b,
         promedios%>%filter(Ym>="2012-08",Ym<="2013-05"),
         c,
         promedios%>%filter(Ym>="2013-08",Ym<="2014-05"),
         d,
         promedios%>%filter(Ym>="2014-08",Ym<="2015-05"),
         e,
         promedios%>%filter(Ym>="2015-08",Ym<="2016-05"),
         f,
         promedios%>%filter(Ym>="2016-08",Ym<="2017-05"),
         g,
         promedios%>%filter(Ym>="2017-08",Ym<="2018-05"),
         h,
         promedios%>%filter(Ym>="2018-08",Ym<="2019-05"),
         i,
         promedios%>%filter(Ym>="2019-08",Ym<="2019-12"))

class(b)
# Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
serie <- ts(j$promedios, st = c(2010, 8), 
            frequency = 12,end=c(2019,12)) # Hasta diciembre de 2019


# Grafica la serie de tiempo.
ts.plot(serie,main="Goles promedio mensuales",xlab="Periodo",ylab="Promedio",
        col="Purple")


#Originalmente habiamos hecho esta porque venian especificadas unas fechas de corte
# Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
#serie <- ts(j$promedios, st = c(2017, 8), # A partir de agosto 2017
#             frequency = 12,end=c(2019,12)) # Hasta diciembre de 2019


# Grafica la serie de tiempo.
#ts.plot(serie,main="Goles promedio mensuales",xlab="Periodo",ylab="Promedio",
#       col="Purple")
