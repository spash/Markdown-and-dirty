library("httr")
library("jsonlite")
source("apikeys.R")
library("dplyr")
library("ggplot2")


# Find restaurants and review by cuisine

# https://developers.zomato.com/api/v2.1/search?entity_id=279&entity_type=city&q=98105&count=10&cuisines=55&sort=rating
# https://developers.zomato.com/api/v2.1/search?entity_id=279&entity_type=city&q=98105&count=100&sort=rating


# Italian 55
# American 1
cuisine <- 55

# zip codes in Seattle
zip_code <- 98102

# num of restaurants to return
count = 20

base_url <- "https://developers.zomato.com/api/v2.1/search?"

# Includes zip_code, count, and cuisine
end_point <- paste0("entity_id=279&entity_type=city&q=", zip_code, 
                    "&count=", count ,"&cuisines=", cuisine)

# Includes zip_code, and count
# end_point <- paste0("entity_id=279&entity_type=city&q=", zip_code, 
#                    "&count=", count, "&sort=rating")

query_zomato <- list("user_key" = zomato_api_key)

zomato_response <- GET(paste0(base_url, end_point), add_headers("user_key" = zomato_api_key))
zomato_body <- content(zomato_response, "text")
zomato_data <- fromJSON(zomato_body)

# https://developers.zomato.com/api/v2.1/search?entity_id=279&entity_type=city&q=98105&start=20&count=20&sort=rating

zomato_restaurants <- zomato_data$restaurants$restaurant
zomato_flatten <- flatten(zomato_restaurants)

for (start in c(20, 40, 60, 80))  {
  end_point <- paste0("entity_id=279&entity_type=city&q=", zip_code, "&start=",
                      start, "&count=", count, "&sort=rating")
  
  response <- GET(paste0(base_url, end_point), add_headers("user_key" = zomato_api_key))
  body <- content(zomato_response, "text")
  data <- fromJSON(zomato_body)
  
  restaurants <- zomato_data$restaurants$restaurant
  flatten <- flatten(zomato_restaurants)
  
  zomato_flatten <- rbind(zomato_flatten, flatten)
  
}


zomato_reviews <- zomato_flatten %>% 
  select(id, name, user_rating.aggregate_rating, user_rating.rating_text, user_rating.votes, 
         cuisines, average_cost_for_two, price_range, location.locality, location.city, location.zipcode,
         location.address) %>% 
  distinct(location.address, .keep_all = TRUE) %>% 
  filter(user_rating.aggregate_rating > 0)
  

View(zomato_reviews)

health_ratings <- read.csv("Food_safety_2018_zipcodes")




ggplot(data = zomato_reviews) +
  geom_point(mapping = aes(x = id, y = user_rating.aggregate_rating, color = name))
