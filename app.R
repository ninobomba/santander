## app.R ##

## Dash board para el data set 'mtcars'

library(shiny)
library(shinydashboard)
#install.packages("shinythemes")
library(shinythemes)

#Esta parte es el análogo al ui.R
ui <- 
    
    fluidPage(
        
        dashboardPage(
            
            dashboardHeader(title = "Postwork 8"),
            
            dashboardSidebar(
                
                sidebarMenu(
                    menuItem("Número de Goles", tabName = "gol", icon = icon("soccer-ball-o")),
                    menuItem("Probabilidades", tabName = "probimg", icon = icon("bar-chart")),
                    menuItem("Data Table", tabName = "data_table", icon = icon("table")),
                    menuItem("Factores", tabName = "factimg", icon = icon("money"))
                )
                
            ),
            
            dashboardBody(
                
                tabItems(
                    # Histograma
                    tabItem(tabName = "gol",
                            fluidRow(
                                titlePanel(HTML('<h2><center>Goles</h2>')), 
                                selectInput("x", "Seleccione el equipo",
                                            choices = c("HomeScore", "AwayScore")),
                                plotOutput("plot", height = 450, width = 750)
                                
                                
                            )
                    ),
                    
                    tabItem(tabName = "probimg", 
                            fluidRow(
                                titlePanel(HTML('<h2><center>Probabilidad de anotar goles</h2> <br>')),
                                
                                HTML('<center><img src="postwork 3.1.png" ></center>'),
                                br(), 
                                HTML('<center><img src="postwork 3.2.png" ></center>'),
                                br(),
                                HTML('<center><img src="postwork 3.3.png" ></center>')
                                
                            )
                    ),
                    
                    
                    
                    tabItem(tabName = "data_table",
                            fluidRow(        
                                titlePanel(HTML('<h2><center>Data table</h2>')),
                                dataTableOutput ("data_table")
                            )
                    ), 
                    
                    tabItem(tabName = "factimg",
                            fluidRow(
                                titlePanel(HTML('<h2><center>Factores de ganancia</h2>')),
                                titlePanel(HTML('<h4><center><b>Máximo</h4>')),
                                HTML('<center><img src="momios1.png" ></center>'),
                                br(),
                                titlePanel(HTML('<h4><center><b>Promedio</h4>')),
                                HTML('<center><img src="momios2.png" ></center>'),
                            )
                    )
                    
                )
            )
        )
    )

#De aquí en adelante es la parte que corresponde al server

server <- function(input, output) {
    library(ggplot2)
    library(dplyr)
    match.data=read.csv("c:/Users/Ángelica/Desktop/SEMESTRE EN LINEA/bedu/modulo 2/POSTWORK/postwork 8/match.data.csv")
    data = read.csv("c:/Users/Ángelica/Desktop/SEMESTRE EN LINEA/bedu/modulo 2/POSTWORK/postwork 8/data.csv", header = T)
    data<-dplyr::rename(data,HomeScore="FTHG",AwayScore="FTAG")
    
    output$plot <- renderPlot({
        
        x <- data[,input$x]
        
        #summary(data)
        data %>% ggplot(aes(y=x, fill = FTR)) + 
            geom_bar() + 
            facet_wrap("AwayTeam") +
            labs(x =input$x, y = "Goles") + 
            ylim(0,10)
        
        
    })   
    
    #Data Table
    output$data_table <- renderDataTable( {match.data}, 
                                          options = list(aLengthMenu = c(10,20,50),
                                                         iDisplayLength = 10)
    )
    
}


shinyApp(ui, server)
