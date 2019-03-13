library("shiny")
library("ggplot2")
library("dplyr")
library("leaflet")


source("data_analysis.R")

my_ui <- fluidPage(
  titlePanel("Health inspection results of restaurants in King County"),

  tabsetPanel(
    type = "tabs",
    tabPanel(
      "Introduction",

      sidebarLayout(
        sidebarPanel(
          h2("Health inspection scores of restaurants"),
          selectInput(
            inputId = "zip", label = "Zip codes of restaurants",
            choices = seattle_zip, selected = "zipcode"
          )
        ),

        mainPanel(
          plotOutput(outputId = "health_plot")
        )
      )
    ),
    tabPanel(
      "Customer reviews",
      sidebarLayout(
        sidebarPanel(
          h2("Customer reviews vurses health inspection scores"),
          sliderInput(
            inputId = "review", label = "Customer reviews",
            min = review_range[1], max = review_range[2], value = review_range
          ),
          sliderInput(
            inputId = "inspection", label = "Health Inspection Score",
            min = health_inspection_range[1], max = health_inspection_range[2], value = health_inspection_range
          )
          
        ),
        
        mainPanel(
          plotOutput(outputId = "review_plot")
        )
      )
    )
  )
)

my_server <- function(input, output) {
  output$health_plot <- renderPlot({
    filtered_inspection <- reviews_Vs_safety %>%
      filter(location.zipcode == input$zip)

    inspection_graph <- ggplot(data = filtered_inspection, aes(x = name, y = Inspection.Score, fill = location.zipcode)) +
      geom_bar(stat = "identity") +
      coord_flip() +
      labs(
        title = "Health inspection score for Restaurants in Seattle",
        x = "Restaurant Name",
        y = "Inspection Score",
        color = "zip code"
      )

    inspection_graph
  })
  
  output$review_plot <- renderPlot({
    filtered_review <- reviews_Vs_safety %>% 
      filter(user_rating.aggregate_rating > input$review[1] & user_rating.aggregate_rating < input$review[2]) %>% 
      filter(Inspection.Score > input$inspection[1] & Inspection.Score < input$inspection[2])
    
    
    review_graph <- ggplot(data = filtered_review) +
      geom_point(mapping = aes(x = Inspection.Score, y = user_rating.aggregate_rating, color = location.zipcode)) +
      labs(
        title = "Customer reviews vurses health inspection score",
        x = "Inspection Score",
        y = "Customer review (out of 5)",
        color = "zip code"
      )
    
    review_graph
    
  })
}

shinyApp(ui = my_ui, server = my_server)
