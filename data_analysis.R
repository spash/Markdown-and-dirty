
library("dplyr")
library("tidyr")
library("dplyr")

source("apikeys.R")
source("zomato_join_food_safety.R")


# Read csv file with all our raw data of the user reviews
# and health ratings


# Jordan
# Creates data frame with name, zipcode, number of user ratings
# per restaurant, the inspection score, and the inspection result
# Filters for inspections that are either "Unsatisfactory" or "Satisfactory"
num_ratings_vs_health <- combined_df %>% 
  select(name, location.zipcode, user_rating.votes, Inspection.Score, Inspection.Result) %>% 
  filter(Inspection.Result == "Unsatisfactory" | Inspection.Result == "Satisfactory")



jonathan_response <- p("
 My question: In King County, do people speak out about restaurants that have unsatisfactory health ratings
 by leaving a review?

 The visuals above show the number of user reviews by the inspection score, which ranges from 0-80.
 The lower the inspection score, the better, as you get points for every violation.
 For the most part, it appears that restaurants receive an inspection result of unsatisfactory
 if it has an inspection score of 15 or more, while those receive an inspection result
 of satisfactory if they are less than 15. However, there are some outliers who go against this
 observation. For those that have an inspection score that is 15 or more but are satisfactory,
 these restaruants must have a lot of minor violations that add up to a higher score, but in the end
 are too minor for the restaurant to be unsatisfactory. Contrarily, those that have less than 15
 but are considered unsatisfactory must have a few major violations that lead to them 
 being unsatisfactory, regardless of their low score. 

 To answer my question, on average, each unsatisfactory restaurant has about 93 user reviews,
 while each satisfactory restaurant has about 77 user reviews. Because there is an outlier
 in the 98122 data, checking the median might be a better option, as the median is less affected
 by outliers. The median for unsatisfactory restaurants is about 44 user reviews and
 the median for satisfactory restaurants is about 35 user reviews. From both these values,
 we can clearly see that unsatisfactory restaurants receive more user reviews than 
 satisfactory restaurants do. Thus, this proves that people in King County do indeed
 speak out more about restaurants that have unsatisfacoty health ratings by leaving a review.")




#Shivani

reviews_Vs_safety <- combined_df %>% 
  select(c(name, location.zipcode, user_rating.aggregate_rating, Inspection.Score))

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
                      Looking at the data above, it seems that for the most part, restaurants with higher food ratings seem to have lower inspection scores. 
                      This is because a lower inspection result means that the restaurant had lesser faults (thus less points for wrongs). 
                      But, looking at the data, we can see that there are a lot of restaurants that have an above average rating (> 3.0) 
                      yet have 20 or more points in their inspection scores. This means that customers might not either be aware of the health 
                      inspection scores resulting in them only critiquing the restaurant based on the taste of the food, apparant quality
                      of the food, ambiance of the restaurant. This shows us that a restaurant may have great food with a pretty exterior yet 
                      still be unsatisfactory in terms of health ratings. This is because customers do not know what goes on in the kitchen 
                      and so a restaurant might serve great tasting food but the ingredients they use might not be healthy or their cooking
                      condtions might be unhygenic. Therefore, we need to make more people aware of health inspection scores, what they mean, 
                      and how eating at a restaurant with a high inspection score can effect a person's health")

tyler_response <- p("Overview:

Our question was on whether the safety of an area can determine the health rating of a restaurant and or food establishment. We developed a crime map to showcase the overall crime rate for each zip code located in the King County area of Washington by using a color scale. We also developed a bar graph that allows the users to select the desired zip code and view the results of the inspections score. Both those visuals together allow the viewer to interpret and view the data in combination with each other to locate the pattern between safety and health. 

Findings:

While for the most part, the safety of an area does tend to somewhat predict the potential health inspection score of a restaurant and or food establishment, however, upon closer review, there are certain areas that have higher crime rates but tend to have generally satisfactory inspection results, such as the zip codes 98125 and 98108. And then there are others which are the opposite such as our very own 98105 with has slightly lower rates, but very mixed responses in terms of health inspection ratings.")


url <- a("dataset", href="https://data.kingcounty.gov/Health-Wellness/Food-Establishment-Inspection-Data/f29f-zza5")
url1 <- a("here", href="https://data.kingcounty.gov/Health-Wellness/Food-Establishment-Inspection-Data/f29f-zza5")
url2 <- a("Zomato", href="https://developers.zomato.com/api#headline1")











