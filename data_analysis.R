library("dplyr")
library("tidyr")

source("zomato_join_food_safety.R")

reviews_Vs_safety <- combined_df %>% 
  select(c(name, location.zipcode, user_rating.aggregate_rating, Inspection.Score))
#View(reviews_Vs_safety)

seattle_zip <- c("98102","98104","98105","98107","98108","98109",
               "98116","98118","98119","98122","98125","98144")
