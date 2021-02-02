# MongoLite library:
install.packages("mongolite")
library(jsonlite)
library(mongolite)
library(dplyr)

datos<-read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-07/Postwork/data.csv")
#datos<-mutate(datos, Date=as.Date(Date, "%Y-%m-%d"))
#str(datos)

# Se hace la conexión con MongoDB y se crea la base de datos y la colección
mongodb <- mongo(collection = "match", db = "match_games", url = "mongodb+srv://UserBD:<password>@cluster0.gcwaw.mongodb.net/test")


#Alojar el fichero data.csv en una base de datos llamada match_games, nombrando al collection como match
mongodb$insert(datos)

#realizar un count para conocer el número de registros que se tiene en la base
mongodb$count()   #1140

# Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para conocer el número de goles 
# que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

#Se realizó la consulta de la fecha pero no se encontró ningún registro en esa fecha ni en ese año
consulta1<-mongodb$find('{"Date":"2015-12-20"}')
consulta2<-mongodb$find('{"Date":{"$regex":"^2015","$options" : "i"}}')

#Primero se decidió buscar otra fecha en la que haya jugado el Real Madrid
consulta3<-mongodb$find('{"$or":[{"HomeTeam":"Real Madrid"},{"AwayTeam":"Real Madrid"}]}')

#Se eligió el parido del 2017-12-23

consulta4<-mongodb$find('{"Date":"2017-12-23","$or":[{"HomeTeam":"Real Madrid"},{"AwayTeam":"Real Madrid"}]}',fields = '{"X":0, "_id":0}' )

#Perdió contra el Barcelona, fue humillado


#Después, dado que en este caso se conoce la fuente de los datos, se optó por completar los registros faltantes
datos1<-read.csv("https://www.football-data.co.uk/mmz4281/1516/SP1.csv")
datos2<-read.csv("https://www.football-data.co.uk/mmz4281/1617/SP1.csv")

datos3<-rbind(datos1,datos2)
datos3$X<-c(1:760)
datos3<-dplyr::select(datos3,X,Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
datos3<-mutate(datos3, Date=as.Date(Date, "%d/%m/%y"))

datos$X<-datos$X+760

datosdef<-rbind(datos3,datos)
#Se cargaron estos nuevos datos en Mongo, eliminando los datos anteriores
mongodb$drop()
mongodb$insert(datosdef)
mongodb$count() #1900

consulta4<-mongodb$find('{"Date":"2015-12-20","$or":[{"HomeTeam":"Real Madrid"},{"AwayTeam":"Real Madrid"}]}',fields = '{"X":0, "_id":0}' )

#Ganó contra el Vallecano con una diferencia de 8 goles, quedando el marcador 10-2

#No olvides cerrar la conexión con la BDD
mongodb$disconnect()

