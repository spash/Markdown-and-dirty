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
          h2("Customer reviews vs. health inspection scores"),
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
          plotOutput(outputId = "review_plot"), shivani_response
        )
      )
    ),
    tabPanel(
      "Price range",
      
      sidebarLayout(
        sidebarPanel(
          h2("Restaurant prices vs. their health inspection grade"),
          selectInput(
            inputId = "zips", label = "Zip codes of restaurants",
            choices = seattle_zip, selected = "zipcode"
          )
        ),
        
        mainPanel(
          plotOutput(outputId = "price_plot")
        )
      )
    )
  )
)
