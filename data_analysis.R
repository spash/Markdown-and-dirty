# Jordan

source("apikeys.R")
library("dplyr")

# Read csv file with all our raw data of the user reviews
# and health ratings
combined_zomato_fs <- read.csv("combined_zomato_and_FS.csv", stringsAsFactors = FALSE)


# Creates data frame with name, zipcode, number of user ratings
# per restaurant, the inspection score, and the inspection result
# Filters for inspections that are either "Unsatisfactory" or "Satisfactory"
num_ratings_vs_health <- combined_zomato_fs %>% 
  select(name, location.zipcode, user_rating.votes, Inspection.Score, Inspection.Result) %>% 
  filter(Inspection.Result == "Unsatisfactory" | Inspection.Result == "Satisfactory")

