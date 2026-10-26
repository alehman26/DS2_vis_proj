
#
##tab 1 (numerical relationship)graph of data where user picks two numrical variables and a plot of the two are provided 
##    add option to color by region 

##tab 2 (regional relationships) histogram of region where the user picks a numerical varible for the y axis 
#install.packages("tidymodels")
library("tidymodels")
library(shiny)
library(readr)

clean_countries<-read_csv("clean_countries.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Countries' Economic Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
      sidebarPanel(
      selectInput(inputId = "x_var", 
                    label = "numerical vaiable", 
                    choices = c("inflation", "GDP_capita","Population","change_pop")),
      selectInput(inputId = "y_var", 
                    label = "numerical vaiable", 
                    choices = c("inflation", "GDP_capita","Population","change_pop"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({

        ggplot(clean_countries, aes(
          x = .data[[input$x_var]],
          y = .data[[input$y_var]]))+
          geom_point()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
