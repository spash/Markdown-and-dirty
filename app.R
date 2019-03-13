library("shiny")
library("ggplot2")
library("dplyr")
library("leaflet")


source("data_analysis.R")

my_ui <- fluidPage(
  
  titlePanel("Health inspection results of restaurants in King County"),
  
  tabsetPanel(type = "tabs",
              tabPanel("Introduction",
  
  sidebarLayout(    
    sidebarPanel(
      h2("health inspection scores of restaurants"),
      selectInput(inputId = "zip", label = "Zip codes of restaurants", 
                  choices = seattle_zip, selected = "zipcode")
    ),
    
    mainPanel(  
      plotOutput(outputId = "health_plot")
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
     geom_bar(stat="identity") +
     coord_flip() +
     labs(title = "Health inspection score for Restaurants in Seattle",
          x = "Restaurant Name", 
          y = "Inspection Score",
          color = "zip code") 
   
  inspection_graph
})
}

shinyApp(ui = my_ui, server = my_server) 

  

