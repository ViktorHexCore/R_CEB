# ANN

# prepare iris
library(neuralnet)
# install.packages('neuralnet')
irisNN <- iris
set.seed(152)
ind <- sample(2, nrow(irisNN), replace = TRUE, prob = c(0.7, 0.3))
trainData <- irisNN[ind == 1, ]
testData <- irisNN[ind == 2, ]
nnet_iristrain <- trainData

# binarize the categorical output
nnet_iristrain <- cbind(nnet_iristrain, trainData$Species == "setosa")
nnet_iristrain <- cbind(nnet_iristrain, trainData$Species == "versicolor")
nnet_iristrain <- cbind(nnet_iristrain, trainData$Species == "virginica")
names(nnet_iristrain)[6:8] <- c("setosa", "versicolor", "virginica")

nn <- neuralnet(setosa + versicolor + virginica ~
    Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
data = nnet_iristrain, hidden = c(3)
)
plot(nn)

mypredict <- compute(nn, testData[-5])$net.result
# put multiple binary output to categorical output
maxidx <- function(arr) {
    return(which(arr == max(arr)))
}
idx <- apply(mypredict, c(1), maxidx)
idx
prediction <- c("Iris-setosa", "Iris-versicolor", "Iris-virginica")[idx]
table(prediction, testData$Species)

library(caret)
library(lattice)
library(ggplot2)
prediction <- c("setosa", "versicolor", "virginica")[idx]
u <- union(prediction, testData$Species)
xtab <- table(factor(prediction, u), factor(testData$Species, u))
results <- confusionMatrix(xtab)
as.table(results)
as.matrix(results, what = "overall")
as.matrix(results, what = "classes")


# Assignment 3
colonData <- read.table("DataForRpartOne/colon.csv", header = TRUE, sep = ",")
colonData <- factor(colonData$Class)

set.seed(224599)
library(e1071)
ind <- sample(2, nrow(colonData), replace = TRUE, prob = c(0.7, 0.3))
trainData <- colonData[ind == 1, ]
testData <- colonData[ind == 2, ]
nnet_colontrain <- trainData

# binarize the categorical output
nnet_colontrain <- cbind(nnet_colontrain, trainData$Class == -1)
nnet_colontrain <- cbind(nnet_colontrain, trainData$Class == 1)
names(nnet_colontrain)[2002:2003] <- c("cancer", "normal")

col_list <- paste(c(colnames(trainData[1:2000])), collapse = "+")
col_list <- paste(c("cancer+normal", col_list))

nn <- neuralnet(setosa + versicolor + virginica ~
    Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
data = nnet_colontrain, hidden = c(3)
)
plot(nn)

# non linear classification
# KNN

library(class)
irisKNN <- iris
set.seed(152)
ind <- sample(2, nrow(irisKNN), replace = TRUE, prob = c(0.7, 0.3))
trainDataKNN <- irisKNN[ind == 1, ]
testDataKNN <- irisKNN[ind == 2, ]
train_input <- as.matrix(trainDataKNN[, -5])
train_output <- as.vector(trainDataKNN[, 5])
test_input <- as.matrix(testDataKNN[, -5])

prediction <- knn(train_input, test_input, train_output, k = 1)
table(prediction, testDataKNN$Species)

library(caret)
library(lattice)
library(ggplot2)
xtab <- table(prediction, testDataKNN$Species)
results <- confusionMatrix(xtab)
as.table(results)
as.matrix(results, what = "overall")
as.matrix(results, what = "classes")


# linear programming

# Import lpSolvepackage
library(lpSolve)
# install.packages('lpSolve')
# Set coefficients of the objective function:
f.obj <- c(5, 7)
# Set matrix corresponding to coefficients of constraints by rows
# Do not consider the non-negative constraint; it is automatically assumed
f.con <- matrix(c(
    1, 0,
    2, 3,
    1, 1
), nrow = 3, byrow = TRUE)

# Set unequality signs
f.dir <- c(
    "<=",
    "<=",
    "<="
)
# Set right hand side coefficients
f.rhs <- c(
    16,
    19,
    8
)

# Final value (z)
lp("max", f.obj, f.con, f.dir, f.rhs)

# Variables final values
lp("max", f.obj, f.con, f.dir, f.rhs)$solution


# image processing
library(magick)
# install.packages("magick")
str(magick::magick_config())

frink <- image_read("https://jeroen.github.io/images/frink.png")
print(frink)

image_info(frink)

image_write(frink, path = "frink.jpg", format = "jpeg", quality = 75)

frink_jpeg <- image_convert(frink, "jpeg")
image_info(frink_jpeg)

image_border(image_background(frink, "hotpink"), "#000080", "20x10"

image_trim(frink)
