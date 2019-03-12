library("jsonlite")
source("apikeys.R")
library("dplyr")

# working zipcodes
zipcodes <- c(98102,98104,98105,98107,98108,98109,98116,98118,98119,98122,98125,98144)

# set up base url and endpoint
base_url <- "https://developers.zomato.com/api/v2.1/search?"

# initialize all_restaurants dataframe with columns
#### NOTE: YOU MIGHT BE ABLE TO DELETE THIS BLOCK
end_point <- paste0("entity_id=279&entity_type=city&q=", "98105", 
                    "&start=", start,
                    "&count=", count)
zomato_response <- GET(paste0(base_url, end_point), add_headers("user_key" = zomato_api_key))
zomato_body <- content(zomato_response, "text")
zomato_data <- fromJSON(zomato_body)
zomato_restaurants <- zomato_data$restaurants$restaurant
zomato_flatten <- flatten(zomato_restaurants)
all_restaurants <- zomato_flatten        #give all_restaurants columns (with values)
all_restaurants <- all_restaurants[c(),] #keep columns, remove values
####

# loop through zipcodes, run 5 times per zipcode
# save results to all_restaurants
for (zipcode in zipcodes){
  for (start in c(0,20,40,60,80)) {
    #print status to console
    print("Start loop")
    
    #insert zomato parameters
    count = "20"              #zomato max. count
    end_point <- paste0("entity_id=279&entity_type=city&q=", zipcode, 
                        "&start=", start,
                        "&count=", count)
    #Get zomato data on restaurants from current working zipcode
    #update restaurants
    zomato_response <- GET(paste0(base_url, end_point), add_headers("user_key" = zomato_api_key))
    zomato_body <- content(zomato_response, "text")
    zomato_data <- fromJSON(zomato_body)
    zomato_restaurants <- zomato_data$restaurants$restaurant
    zomato_flatten <- flatten(zomato_restaurants)
    all_restaurants <- rbind(all_restaurants, zomato_flatten)
  }
}

#drop columns: 
all_restaurants <- all_restaurants %>% 
  select(-apikey, -switch_to_order_menu, -offers, -opentable_support, 
         -is_zomato_book_res, -mezzo_provider, -is_book_form_web_view, 
         -book_again_url, -book_form_web_view_url, -has_online_delivery, 
         -is_delivering_now, has_fake_reviews, -is_table_reservation_supported,
         -has_table_booking, -establishment_types, -user_rating.has_fake_reviews)

# write all_restaurants to .csv
write.csv(all_restaurants, file = "zomato_restaurants_in_zipcodes")



########Zipcodes
#98102	Capitol Hill / Eastlake
#98104 	Downtown / International District
#98105 	University District
#98107 	Ballard
#98108 	Georgetown
#98109 	South Lake Union
#98116	West Seattle
#98118	Columbia City / Rainier Valley
#98119	Interbay
#98122	S. Capitol Hill / First Hill
#98125	Northgate
#98144 	N. Beacon Hill / Central District