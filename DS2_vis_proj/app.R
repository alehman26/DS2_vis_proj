
##clean countries data visualization

library("tidymodels")
library("shiny")
library("readr")

##read in data 
clean_countries<-read_csv("DS2_clean_countries.csv")

##clean countries variable description 

##country - Name of the country 

##inflation - The annual percentage change in the Consumer Price Index in 2024 

##gdp_capita - 2024 GDP per capita, adjusted for purchasing-power difference

##pop - The 2023 population in millions from each country as of 2023, sourced form the UN 

##per_chg_pop - The percent change in population from 2022 to 2023

##region - The continent that contains each nation

##subregion - UN defined subregion assigned to each nation

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Countries' Economic Data"),

    tabsetPanel(
      
      tabPanel(
        "Numerical Relationships",
        
        sidebarLayout(
          sidebarPanel(
            selectInput(inputId = "x_var", 
                    label = "numerical vaiable", 
                    choices = c("inflation", "gdp_capita","pop_2023","per_chg_pop")),
            selectInput(inputId = "y_var", 
                    label = "numerical vaiable", 
                    choices = c("inflation", "gdp_capita","pop_2023","per_chg_pop"))
          ),

        # Show a plot of the generated distribution
          mainPanel(
           plotOutput("scatter_plot")
          )
        )
      ),
      
      tabPanel("regional relationships",
        sidebarLayout(
                      sidebarPanel(
                                    selectInput(inputId = "bar_var", 
                                                label = "numerical vaiable", 
                                                choices = c("inflation", "gdp_capita","pop_2023","per_chg_pop"))
                                  ),
                 
                 # Show a plot of the generated distribution
                      mainPanel(
                                plotOutput("bar")
                      )
                  )
    )
    )  
    )

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$scatter_plot <- renderPlot({

        ggplot(clean_countries, aes(
          x = .data[[input$x_var]],
          y = .data[[input$y_var]]))+
          geom_point()
    })
    output$bar <- renderPlot({
      
      ggplot(clean_countries, aes(
        x = region,
        y = .data[[input$bar_var]]))+
        geom_col()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
