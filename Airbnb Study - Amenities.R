# Libraries
library(dplyr)
library(tidyr)
library(stringr)
library(tidytext)
library(tidytuesdayR)

# import dataset
airbnb <- read.csv("C:/Users/yasca/OneDrive/Documentos/Hult/Data Extraction and Visualization/listings_listings.csv")

# Select relevant features
amenities <- airbnb[, c("Amenities", "Id", "Price", "Review.Scores.Rating")]



# Cleaning the amenities feature
amenities <- amenities %>%
  mutate(Amenities = str_replace_all(Amenities, "\\[|\\]|\\\\|\"", "")) %>% # Remove special chacacters
  separate_rows(Amenities, sep = ", ") # Separate in lines

# Checking if the amenities set has the same amount of na values as the airbnb set
amenities_group <- amenities %>% 
                   select("Id","Price") %>%
                   group_by(Id) %>%
                   summarise(total_price = sum(Price, na.rm = TRUE))  

# Print to check results
print(amenities_group) 

# Comparing null values to be sure both of them have the same amount of null values
sum(is.na(airbnb$Price))
sum((amenities_group$total_price)==0)

# Export the dataset
write.csv(amenities, "C:/Users/yasca/OneDrive/Área de Trabalho/amenities.csv" ,row.names = FALSE)

