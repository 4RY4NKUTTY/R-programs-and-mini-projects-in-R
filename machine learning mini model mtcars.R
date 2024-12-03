install.packages("caret")
install.packages("ggplot2")

library(caret)
library(ggplot2)

# Load the mtcars dataset
data("mtcars")
head(mtcars)

# Summary of the dataset
summary(mtcars)

# Set seed for reproducibility
set.seed(123)

# Split the data: 80% training, 20% testing
trainIndex <- createDataPartition(mtcars$mpg, p = 0.8, list = FALSE)
trainData <- mtcars[trainIndex, ]
testData <- mtcars[-trainIndex, ]

# Train the linear regression model
linearModel <- train(mpg ~ ., data = trainData, method = "lm")

# View the model summary
summary(linearModel$finalModel)

# Make predictions on the test set
predictions <- predict(linearModel, testData)

# View the first few predictions
head(predictions)

# Calculate RMSE and R²
rmse <- RMSE(predictions, testData$mpg)
r2 <- R2(predictions, testData$mpg)

cat("RMSE:", rmse, "\n")
cat("R²:", r2, "\n")

# Combine actual and predicted values into a data frame
results <- data.frame(Actual = testData$mpg, Predicted = predictions)

# Plot actual vs. predicted values
ggplot(results, aes(x = Actual, y = Predicted)) +
  geom_point() +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Actual vs. Predicted MPG",
       x = "Actual MPG",
       y = "Predicted MPG") +
  theme_minimal()

