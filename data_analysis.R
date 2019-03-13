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
  select(c(price_range, Grade, location.zipcode))
#stephen ggplot
#ggplot(data = combined_df) +
 # aes(x = Grade, y = price_range) +
#  geom_jitter(alpha = .5, height = 0, width = .25) +
 # labs(title = "Food Safety vs Price") +
#theme_light()
