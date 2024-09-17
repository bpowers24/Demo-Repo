# demo R script

# load libraries
library(ggplot2)

# create fake data
set.seed(123)
df <- data.frame(
  ID = 1:20,
  Category = rep(c("A", "B", "D", "F"), each = 5),
  Value = sample(10:100, 20)
)

# make plot
ggplot(df, aes(x = factor(ID), y = Value, fill = ID)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Value by ID and Category",
    x = "ID",
    y = "Value",
    fill = "Category"
  )
