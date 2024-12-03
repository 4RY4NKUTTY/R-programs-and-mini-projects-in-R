install.packages("shiny")
install.packages("ggplot2")
install.packages("dplyr")

library(shiny)
library(ggplot2)
library(dplyr)


#PROGRAM 1

# 1. Define UI
ui <- fluidPage(
  titlePanel("Basic Data Visualization Dashboard"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    sidebarPanel(
      # Dropdown to select a variable for visualization
      selectInput("variable", "Variable:",
                  choices = c("mpg", "hp", "wt")),
      
      # Dropdown to select a dataset
      selectInput("dataset", "Dataset:",
                  choices = c("mtcars", "iris"))
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      plotOutput("distPlot"),
      tableOutput("summaryTable")
    )
  )
)

# 2. Define Server logic
server <- function(input, output) {
  # Reactive expression to get the selected dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "mtcars" = mtcars,
           "iris" = iris)
  })
  
  # Render the plot based on user input
  output$distPlot <- renderPlot({
    data <- datasetInput()
    ggplot(data, aes_string(x = input$variable)) +
      geom_histogram(binwidth = 5, fill = "red", color = "black") +
      theme_minimal() +
      labs(title = paste("Distribution of", input$variable))
  })
  
  # Render a summary table based on user input
  output$summaryTable <- renderTable({
    data <- datasetInput()
    summary(data[[input$variable]])
  })
}

# 3. Run the application 
shinyApp(ui = ui, server = server)








# PROGRAM 2

ui <- fluidPage(
  titlePanel("Interactive Scatter Plot"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", "X-axis variable:", choices = names(mtcars)),
      selectInput("yvar", "Y-axis variable:", choices = names(mtcars)),
      sliderInput("hpRange", "Horsepower range:",
                  min = min(mtcars$hp), max = max(mtcars$hp),
                  value = c(min(mtcars$hp), max(mtcars$hp)))
    ),
    mainPanel(
      plotOutput("scatterPlot")
    )
  )
)

server <- function(input, output) {
  output$scatterPlot <- renderPlot({
    filteredData <- mtcars %>%
      filter(hp >= input$hpRange[1], hp <= input$hpRange[2])
    
    ggplot(filteredData, aes_string(x = input$xvar, y = input$yvar)) +
      geom_point() +
      theme_minimal() +
      labs(title = paste(input$yvar, "vs", input$xvar))
  })
}

shinyApp(ui = ui, server = server)


