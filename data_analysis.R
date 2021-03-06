library("dplyr")
library("tidyr")
library("dplyr")
library("shiny")

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

average_customer <- mean(reviews_Vs_safety$user_rating.aggregate_rating)


#stephen
price_vs_health <- combined_df %>% 
  select(c(name, average_cost_for_two, Grade, location.zipcode))


stephen_response <- p("The graphics show consistent groupings around various food safety grades. This pattern is due to technical quirks that cause 
                      food grades to fall into common numeric amounts. There are some outliers in price (some restaurants are very expensive!) 
                      but the overall trend is that there is little correlation between the food safety violations recorded by investigators and the 
                      cost of a meal: customers cannot buy their way into safety with much confidence. ")


shivani_response <- p(" The plot above shows customer reviews (out of 5) plotted against health inspection ratings. The purpose of this is to 
                      answer the following questions: 
                      Do customers care about health inspections when they go to restaurants?
                      Do they look at the hygenic conditions of the restaurant where the food is made or do they only care about the taste of the food?
                      Looking at the data above, it seems that for the most part, restaurants with higher food ratings seem to have lower inspection scores. 
                      This is because a lower inspection result means that the restaurant had lesser faults (thus less points for wrongs). 
                      But, looking at the data, we can see that there are a lot of restaurants that have an above average rating (> 3.0) 
                      yet have 20 or more points in their inspection scores. The mean score of customer review is 3.22. This shows that
                      the restaurants are generally rated above average, further proving our point. In a perfect data, as the health inspection
                      score increases, the customer review scores would decrease. But looking at our data, we can see that the line of 
                      correlation is a horizontal line - meaning that there is no correlation between the health inspection scores and the 
                      customer reviews.This means that customers might not either be aware of the health 
                      inspection scores resulting in them only critiquing the restaurant based on the taste of the food, apparant quality
                      of the food, ambiance of the restaurant. This shows us that a restaurant may have great food with a pretty exterior yet 
                      still be unsatisfactory in terms of health ratings. This is because customers do not know what goes on in the kitchen 
                      and so a restaurant might serve great tasting food but the ingredients they use might not be healthy or their cooking
                      condtions might be unhygenic. Therefore, we need to make more people aware of health inspection scores, what they mean, 
                      and how eating at a restaurant with a high inspection score can effect a person's health")

overview <- p("Foodborne illnesses affect 48 million people in the United States annually, with over 68% of outbreaks originating from 
              restaurants. Because this is such a serious issue, we wondered how much people consider what they consume.
              Our data is constrained to food safety violations conducted by the King County health records, and Seattle area restaurants social data. 
              Data specific to health inspection scores ordered by zip code is seen at left, which depicts the variance between food safety 
              scores (lower is better: each number is a count of health code violations). Customer review analysis can be found under the 
              'Customer Reviews' tab, with price range and number of listings analysis within their respective tabs. Data sources are under the'Conclusion' tab.
              From our analysis, it appears there is little correlation between people’s consumption preferences and food safety. 
              This could be because, over all, the local government prioritizes food safety and performs its job well. However, it could also
              be that food-borne illnesses are difficult to track to their sources.")







