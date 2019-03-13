#Shivani
library("dplyr")
library("tidyr")

source("zomato_join_food_safety.R")

reviews_Vs_safety <- combined_df %>% 
  select(c(name, location.zipcode, user_rating.aggregate_rating, Inspection.Score))
#View(reviews_Vs_safety)

seattle_zip <- c("98102","98104","98105","98107","98108","98109",
               "98116","98118","98119","98122","98125","98144")

review_range <- range(reviews_Vs_safety$user_rating.aggregate_rating)
health_inspection_range <- range(reviews_Vs_safety$Inspection.Score)


#stephen
price_vs_health <- combined_df %>% 
  select(c(name, average_cost_for_two, Grade, location.zipcode))


#stephen_response <- p("")


shivani_response <- p(" The plot above shows customer reviews (out of 5) plotted against health inspection ratings. The purpose of this is to 
                      answer the following questions: 
                      Do customers care about health inspections when they go to restaurants?
                      Do they look at the hygenic conditions of the restaurant where the food is made or do they only care about the taste of the food?
                      Looking at the data above, it seems that for the most part, restaurants with higher food ratings seem to have lower inspection scores")












