source("data_analysis.R")

my_ui <- fluidPage(
  titlePanel("Health inspection results of restaurants in King County"),
  
  tabsetPanel(
    type = "tabs",
    tabPanel(
      "Introduction",
      
      sidebarLayout(
        sidebarPanel(
          h2("Health Inspection Scores of Restaurants"),
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
          h2("Customer Reviews vs. Health Inspection Scores"),
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
          h2("Restaurant Prices vs. Their Health Inspection Grade"),
          selectInput(
            inputId = "zips", label = "Zip codes of restaurants",
            choices = seattle_zip, selected = "zipcode"
          )
        ),
        
        mainPanel(
          plotOutput(outputId = "price_plot")
        )
      )
    ),
    tabPanel(
      "Number Of User Ratings",
      
      sidebarLayout(
        sidebarPanel(
          h2("Number Of User Rating vs. their health inspection grade"),
          selectInput(
            inputId = "seattle_zips", label = "Zip codes of restaurants",
            choices = seattle_zip, selected = "zipcode"
          )
        ),
        
        mainPanel(
          plotOutput(outputId = "number_plot"), jonathan_response
        )
      )
    ),
    tabPanel(
      "Conclusion", 
      h2("Created by: "),
      p("Jordan Auerbach, Shivani Joshi, Stephen Sherwood, Tyler Treat"),
      h2("Goals"),
      p("As living beings, we experience the tension between having to eat to survive, yet every meal has the potential to make us ill, or in rare cases,
        even kill us. It’s estimated that foodborne illnesses affect 48 million people annually in the United States. The Center for Disease Control and
        Prevention reports that 68% of foodborne illness outbreaks originate from restaurants, yet restaurants remain a large part of our lives: a 2016
        Gallup poll revealed that 61% of Americans eat at least one meal a week at a restaurants. Local governments are tasked with protecting the
        public from these illnesses. They achieve this by routinely investigating all restaurants, recording violations, correcting violations, and then
        publishing the results.
        
        Our goal is to explore how people’s eating behaviors are influenced by health risks by revealing connections between food safety versus price,
        popularity, and location."),
      h2("Data Sources")
      
    )  
  )
)

