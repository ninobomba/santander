# Use MongoLite library:
install.packages("mongolite")
library(jsonlite)
library(mongolite)
datos<-read.csv("data.csv")
#datos<-mutate(datos, Date=as.Date(Date, "%Y-%m-%d"))
#str(datos)

# Se hace la conexión con MongoDB y se crea la base de datos y la colección
mongodb <- mongo(collection = "match", db = "match_games", url = "mongodb+srv://UserBD:<password>@cluster0.gcwaw.mongodb.net/test")


#Alojar el fichero data.csv en una base de datos llamada match_games, nombrando al collection como match
mongodb$insert(datos)

#realizar un count para conocer el número de registros que se tiene en la base
mongodb$count()

# Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para conocer el número de goles 
# que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

consulta<-mongodb$find('{"Date":"2017-12-23","$or":[{"HomeTeam":"Real Madrid"},{"AwayTeam":"Real Madrid"}]}',fields = '{"X":0, "_id":0}' )
consulta
#Perdió contra el Barcelona, fue humillado

#No olvides cerrar la conexión con la BDD
mongodb$disconnect()
