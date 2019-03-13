library("httr")
library("jsonlite")
source("apikeys.R")
library("dplyr")
library("ggplot2")
library("tidyr")


# Find restaurants and review by cuisine

# https://developers.zomato.com/api/v2.1/search?entity_id=279&entity_type=city&q=98105&count=10&cuisines=55&sort=rating
# https://developers.zomato.com/api/v2.1/search?entity_id=279&entity_type=city&q=98105&count=100&sort=rating


# Italian 55
# American 1
# Thai 95
# Mexican 73
# Chinese 25
cuisine <- 55

# zip codes in Seattle
zip_codes <- c(98104, 98105, 98107, 98108, 98109,
               98116, 98118, 98119, 98122, 98125, 98144)

# start with this zip code in order to initialize the data frame
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
  end_point <- paste0("entity_id=279&entity_type=city&q=", zip_code, 
                      "&count=", count ,"&cuisines=", cuisine)
  
  response <- GET(paste0(base_url, end_point), add_headers("user_key" = zomato_api_key))
  body <- content(response, "text")
  data <- fromJSON(body)
  
  restaurants <- data$restaurants$restaurant
  flatten <- flatten(restaurants)
  
  zomato_flatten <- rbind(zomato_flatten, flatten)
  
}

# Creates data frame containg the restaurants of the chosen cuisine
# in each of the remaining zip codes
for(zip in zip_codes) {
  for (start in c(0, 20, 40, 60, 80))  {
    end_point <- paste0("entity_id=279&entity_type=city&q=", zip, 
                        "&count=", count ,"&cuisines=", cuisine)
    
    response <- GET(paste0(base_url, end_point), add_headers("user_key" = zomato_api_key))
    body <- content(response, "text")
    data <- fromJSON(body)
    
    restaurants <- data$restaurants$restaurant
    flatten <- flatten(restaurants)
    
    zomato_flatten <- rbind(zomato_flatten, flatten)
    
  }
  
}


zomato_reviews <- zomato_flatten %>% 
  select(name, user_rating.aggregate_rating, user_rating.rating_text, user_rating.votes, 
         cuisines, location.zipcode, location.address) %>% 
  distinct(location.address, .keep_all = TRUE) %>% 
  filter(user_rating.aggregate_rating > 0)
  

View(zomato_reviews)


health_ratings <- read.csv("Food_safety_2018_zipcodes.csv", stringsAsFactors = FALSE)

health_ratings <- distinct(health_ratings, Address, .keep_all = TRUE)


health_ratings$Name <- tolower(health_ratings$Name)
zomato_reviews$name <- tolower(zomato_reviews$name)


cuisine_review_health <- left_join(zomato_reviews, health_ratings, by = c("name" = "Name"))

cuisine_review_health <- na.omit(cuisine_review_health)

cuisine_review_health <- select(cuisine_review_health, name, location.zipcode,name, user_rating.aggregate_rating, 
                                user_rating.rating_text, user_rating.votes, Inspection.Score )

cuisine_review_health$user_rating.votes <- as.numeric(cuisine_review_health$user_rating.votes)

View(cuisine_review_health)


ggplot(data = cuisine_review_health) +
  geom_point(mapping = aes(x = location.zipcode, y = user_rating.aggregate_rating, 
                           color = user_rating.votes))

# Italian <- cuisine_review_health
# American <- cuisine_review_health
# Thai <- cuisine_review_health
# Mexican <- cuisine_review_health
# Chinese <- cuisine_review_health

# write.csv(Mexican, file = "Mexican.csv",row.names=FALSE)

