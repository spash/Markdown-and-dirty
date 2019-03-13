library("ggplot2")

#import csv of joined King County Food Safety and 
combined_df <- read.csv("combined_zomato_and_FS.csv", stringsAsFactors = FALSE)

#stephen
price_vs_health <- combined_df %>% 
  select(c(price_range, Grade, location.zipcode))
#stephen ggplot
ggplot(data = combined_df) +
  aes(x = Grade, y = price_range) +
  geom_jitter(alpha = .5, height = 0, width = .25) +
  labs(title = "Food Safety vs Price") +
  theme_light()
