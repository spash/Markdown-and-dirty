library("dplyr")
library("tidyr")

#this file combines the zomato dataframe with the king county food safety
#dataframe

#add zomato data frame
zomato_df <- read.csv("zomato_restaurants_in_zipcodes", stringsAsFactors = FALSE)

#zomato_df <- zomato_df %>% select(-X) #remove row.names # NOTE: if starting from scractch .csv, run this

#add food safety data frame
food_safety_df <- read.csv("Food_safety_2018_zipcodes", stringsAsFactors = FALSE)
food_safety_df <- food_safety_df %>% 
  distinct(Address, .keep_all = TRUE)

#prepare zomato df for join
zomato_df$name <- toupper(zomato_df$name) #change col to upper
food_safety_df$Name <- toupper(food_safety_df$Name) #change name to upper

combined_df <- inner_join(zomato_df, food_safety_df, by = c(
  "name" = "Name",
  "location.zipcode" = "Zip.Code"
))

write.csv(combined_df, "combined_zomato_and_FS.csv")



###################Previously Used###################

#zomato_df <- zomato_df %>% 
#  separate(location.address, c("Address", "delete"), sep=",") %>% 
#  select(-delete)
#newAddress <- toupper(zomato_df$Address) # prepare Address column to match food safety df
#zomato_df <- zomato_df %>% mutate("Address" = newAddress) #change column to match food safety df

###################FUTURE OPTIONS###################
#food_safety_df %>% 
#  mutate(Name = ifelse(str_contain(Name, "STARBUCKS"), "STARBUCKS", Name)) #Name = col. | test, if testTrue, if testFalse
#
#stopwords <- c("98102","98104","98105","98107","98108","98109",
#               "98116","98118","98119","98122","98125","98144")
#for(stop_word in stopwords) {
#  zomato_df$Address <- str_replace_all(zomato_df$Address, stop_word, "")
#}

#search_words <- c("WEST", "EAST")
#replace_words <- c("W", "E")

#for(index in 1:length(search_words)) {
#  zomato_df$Address <- str_replace_all(zomato_df$Address, search_words[index], replace_words[index])
#}

#zomato_df$Address <- trimws(zomato_df$Address)
#combined_df <- inner_join(zomato_df,food_safety_df, by = "Address")

