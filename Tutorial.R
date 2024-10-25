# Install necessary packages if not already installed
required_packages <- c("forcats", "sjlabelled", "dplyr", "ggplot2")
new_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if(length(new_packages)) install.packages(new_packages)

# Load necessary libraries
library(forcats)
library(sjlabelled)
library(dplyr)
library(ggplot2)

# Load the data
cat_breeds <- read.csv("data/cat_breeds_cleaned.csv")

# Inspect the structure of the dataset
str(cat_breeds)

# Task 1: Convert columns to factors
# Check unique values in each column
sapply(cat_breeds, #YOUR CODE)

# Convert columns to factors (with ordered levels where applicable)
cat_breeds$age <- factor(cat_breeds$age, levels = c("Baby", "Young", "Adult", "Senior"), ordered = #YOUR CODE)
cat_breeds$size <- factor(cat_breeds$size, levels = #YOUR CODE, #YOUR CODE)
cat_breeds$gender <- factor(cat_breeds$gender)
cat_breeds$breed <- #YOUR CODE

# Check the structure again after conversions
str(cat_breeds)

# Task 2: Factor Manipulation with `forcats`
# Keep the 10 most frequent breeds, lump the rest into "Other"
cat_breeds$breed <- fct_lump(#YOUR CODE)

# Check the structure again to verify the changes
str(cat_breeds$breed)

# Task 3: Find the monster breed!
# Filter for Extra Large cats
extra_large_cats <- cat_breeds |> 
  filter(size == "Extra Large")

# Summarize the data by breed
extra_large_summary <- extra_large_cats |> 
  group_by(breed) |> 
  summarize(count = n())

# First plot (unordered)
ggplot(extra_large_summary, aes(x = count, y = breed)) +
  geom_point(color = "#3498db", size = 4) +
  labs(title = "Extra Large Cats by Breed (Unordered)",
       x = "Number of Cats",
       y = "Breed")

# Second plot (ordered by count)
ggplot(extra_large_summary, aes(x = count, y = #YOUR CODE)) +
  geom_point(color = "#3498db", size = 4) +
  labs(title = "Extra Large Cats by Breed (Ordered by Count)",
       x = "Number of Cats",
       y = "Breed (Ordered)")

# Task 4: Convert Gender to Binary and Set Labels
# Convert gender to binary (0 = Female, 1 = Male, NA = Unknown)
cat_breeds <- cat_breeds |> 
  mutate(gender_binary = ifelse(gender == "Female", 1, 
                                ifelse(gender == "Male", 0, NA)))

# Optionally, add labels for clarity
cat_breeds$gender_binary <- set_labels(cat_breeds$gender_binary, 
                                       #YOUR CODE)

# Retrieve and check the labels
get_labels(cat_breeds$gender_binary)

# Task 5: Reorder Size Factor Levels
# Reorder the size factor levels for a different perspective
cat_breeds$size <- #YOUR CODE

# Check the new order of the levels
levels(cat_breeds$size)

# Reverse the order to show small cat first
cat_breeds$size <- #YOUR CODE

# Check the reversed order of the levels
levels(cat_breeds$size)