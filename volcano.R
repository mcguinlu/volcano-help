# Load packages
library(rio)
library(ggplot2)

# Import dataset
mr_results <- rio::import("FGFP mr results table.xlsx")

# Convert variables in dataset
# Previously, you were creating two new objects (log_odds/pval_num) but not
# changing the variables within the dataset to numeric
mr_results$pval <- as.numeric(mr_results$pval)
mr_results$log_odds <- as.numeric(mr_results$log_odds)

# Pass to ggplot2
# ggplot2 pastes together the variable location from the dataset and the variable name
# So while you are saying x = log_odds, what ggplot2 is interpreting is x = mr_results$log_odds
# which is why it wasn't working, as you hadn't converted mr_results$log_odds to numeric.
ggplot(mr_results, aes(x = log_odds, y = -log10(pval))) +
geom_point() +
  theme_minimal() +
  geom_hline(yintercept = -log10(0.05),
             col = "red",
             linetype = "dashed")

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-
# Plotting two datasets on same plot

# Create a random variable that indicates which dataset (e.g. 1/2) the data point is from
set.seed(42)
mr_results$indicator <- as.factor(round(runif(13,1,2)))

# Pass to ggplot2, specifying that the 
ggplot(mr_results, aes(x = log_odds, y = -log10(pval), color = indicator)) +
  geom_point() +
  theme_minimal() +
  geom_hline(yintercept = -log10(0.05),
             col = "red",
             linetype = "dashed") +
  labs(color = "Datasets")
  
