weight <- c(60, 70, 80, 90, 55, 65)
height <- c(150, 160, 170, 180, 140, 155)
sex <- c("M", "F", "M", "F", "F", "M")
db <- data.frame(weight, height, sex)
db
plot(db$weight, db$height,
     col = ifelse(db$sex == "M", "blue", "red"),
     pch = ifelse(db$sex == "M", 15, 17),
     xlab = "Weight", ylab = "Height",
     main = "Height vs Weight")
legend("topleft", legend = c("Male", "Female"),
       col = c("blue", "red"),
       pch = c(15, 17))