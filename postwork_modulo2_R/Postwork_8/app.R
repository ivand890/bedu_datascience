###########################################################-
# Objective: Postwork Sesion 8
# Authors: Team 11
#          - Gabriel Sainz V�zquez
#          - Edgar Arellano Ruelas
#          - Aldo Omar Enriquez Velazquez
#          - Iv�n Delgado de la paz
# Date Modified: 03/02/2021
###########################################################-

library(shiny)
library(shinydashboard)
library(shinythemes)
library(ggplot2)

ui <-
    fluidPage(
        dashboardPage(
            dashboardHeader(title = "Predicción de Resultados"),
            dashboardSidebar(
                sidebarMenu(
                    menuItem("Gráficos de barras", tabName = "Dashboard", icon = icon("dashboard")),
                    menuItem("Goles casa - visitante", tabName = "goles", icon = icon("area-chart")),
                    menuItem("Data Table", tabName = "data_table", icon = icon("table")),
                    menuItem("Factores de ganancia", tabName = "momios", icon = icon("file-picture-o"))
                )
            ),
            dashboardBody(
                tabItems(
                    # Aqui se graficar� el histograma
                    tabItem(tabName = "Dashboard",
                            fluidRow(
                                titlePanel("Goles a favor y en contra por equipo"),
                                selectInput("x", "Seleccione el valor de X",
                                            choices = c("home.score", "away.score")),
                                plotOutput("plot1", height = 450, width = 750)
                            )
                    ),
                    # Aqu� se generar�n las im�genes del postwork 3
                    tabItem(tabName = "goles",
                            fluidRow(
                                titlePanel(h3("Probabilidad de goles en casa y visitante")),

                                img(src = "casa.png") ,
                                img(src = "visitante.png"),
                                img(src = "conjunta.png")
                            )
                    ),
                    # Aqu� se generar� el el fichero
                    tabItem(tabName = "data_table",
                            fluidRow(
                                titlePanel(h3("Data Table")),
                                dataTableOutput ("data_table")
                            )
                    ),
                    # Aqu� se generar�n las  im�genes de las gr�ficas de factores fe ganancia minimo y m�ximo
                    tabItem(tabName = "momios",
                            fluidRow(
                                titlePanel(h3("Imágen de calor para la correlaci�n de las variables")),
                                h3("Factor de ganancia Máximo"),
                                img( src = "Rplot.png",
                                     height = 350, width = 550),
                                h3("Factor de ganancia Promedio"),
                                img( src = "Rplot01.png",
                                     height = 350, width = 550)
                            )
                    )
                )
            )
        )
    )

server <- function(input, output) {
    library(ggplot2)
    #Gr�fico de barras
    output$plot1 <- renderPlot({
        data <-  read.csv("match.data.csv", header = T)
        data <- mutate(data, FTR = ifelse(home.score > away.score, "H", ifelse(home.score < away.score, "A", "D")))
        x <- data[,input$x]
        #summary(data)
        data %>% ggplot(aes(x, fill = FTR)) +
            geom_bar() +
            facet_wrap("away.team") +
            labs(x =input$x, y = "Goles") +
            ylim(0,50)
    })

    # Gr�ficas de dispersi�n
    output$output_momios <- renderPlot({

        ggplot(mtcars, aes(x =  mtcars[,input$a] , y = mtcars[,input$y],
                           colour = mtcars[,input$z] )) +
            geom_point() +
            ylab(input$y) +
            xlab(input$x) +
            theme_linedraw() +
            facet_grid(input$z)  #selecci�n del grid

    })
    #Data Table
    output$data_table <- renderDataTable( {data},
                                          options = list(aLengthMenu = c(10,25,50),
                                                         iDisplayLength = 10)
    )
}

# Run the application
shinyApp(ui = ui, server = server)
