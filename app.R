library(shiny)
library(ggplot2)

# Load and clean the data
data <- read.csv("../data/analysis_data/analyis_data.csv")

data$Number_of_deportees <- as.numeric(gsub(",", "", data$Number_of_deportees))
data$Number_of_victims <- as.numeric(gsub(",", "", data$Number_of_victims))
max_value <- max(max(data$Number_of_deportees), max(data$Number_of_victims))

# Define the UI
ui <- fluidPage(
  titlePanel("Deportees and Victims by Nationality"),
  fluidRow(
    column(6, 
           checkboxGroupInput("nationality_selector", "Select Nationality:",
                              choices = unique(data$Nationality),
                              selected = unique(data$Nationality)),
           plotOutput("deportees_plot")),
    column(6, 
           checkboxGroupInput("nationality_selector_victims", "Select Nationality:",
                              choices = unique(data$Nationality),
                              selected = unique(data$Nationality)),
           plotOutput("victims_plot"))
  )
)

# Define the server logic
server <- function(input, output) {
  
  # Function to filter data based on selected nationalities
  filtered_data <- reactive({
    data[data$Nationality %in% input$nationality_selector, ]
  })
  
  # Plot for deportees
  output$deportees_plot <- renderPlot({
    filtered <- filtered_data()
    ggplot(filtered, aes(x = Nationality, y = Number_of_deportees)) +
      geom_bar(stat = "identity", fill = "blue") +
      scale_y_continuous(labels = scales::comma, limits = c(0, max_value)) +  # Format y-axis labels with commas
      coord_flip() +
      theme_minimal()
  })
  
  # Function to filter data based on selected nationalities for victims
  filtered_data_victims <- reactive({
    data[data$Nationality %in% input$nationality_selector_victims, ]
  })
  
  # Plot for victims
  output$victims_plot <- renderPlot({
    filtered <- filtered_data_victims()
    ggplot(filtered, aes(x = Nationality, y = Number_of_victims)) +
      geom_bar(stat = "identity", fill = "red") +
      scale_y_continuous(labels = scales::comma, limits = c(0, max_value)) +  # Format y-axis labels with commas
      coord_flip() +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
