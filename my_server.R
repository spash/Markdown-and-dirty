source("data_analysis.R")


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
        title = "Customer reviews vs. health inspection score",
        x = "Inspection Score",
        y = "Customer review (out of 5)",
        color = "zip code"
      )
    
    review_graph
    
  })
  
  output$price_plot <- renderPlot({
    
    filtered_price <- price_vs_health %>% 
      filter(location.zipcode == input$zips)
    
    price_graph<- ggplot(data = filtered_price) +
      aes(x = Grade, y = average_cost_for_two) +
      geom_jitter(alpha = .5, height = 0, width = .25) +
    labs(title = "Food Safety vs Price",
         x = "Food safety grade (lower is safer)",
         y = "average cost of food for two") +
      theme_light()
    
    price_graph
  })
  
  output$number_plot <- renderPlot({
    
    filtered_number <- num_ratings_vs_health %>% 
      filter(location.zipcode == input$seattle_zips)
      
      number_graph <- ggplot(data = filtered_number) +
        geom_point(mapping = aes(x = Inspection.Score, y= user_rating.votes, color = Inspection.Result)) +
        labs(title = "number of user reviews vs health inspection score",
             x = "health inspection score",
             y = "number of user reviews")
      
      number_graph
      
  })
}