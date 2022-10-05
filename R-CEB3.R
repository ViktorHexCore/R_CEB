# Importdata
colonData <- read.table("DataForRpartOne/colon.csv", header = TRUE, sep = ",")
# colonData

x <- data.frame(colonData$H64807, colonData$T62947)
y <- colonData$Class
inweight1 <- rep(0, dim(x)[2] + 1)

head(x, 5)
head(y, 5)
inweight1

# Perceptron

perceptron <- function(x, y, inWeight, eta, niter) {
    weight <- inWeight
    errors <- rep(0, niter)
    for (jj in 1:niter) {
        for (ii in 1:length(y)) {
            z <- sum(weight[2:length(weight)] *
                as.numeric(x[ii, ])) + weight[1]
            if (z < 0) {
                ypred <- -1
            } else {
                ypred <- 1
            }
            weightdiff <- eta * (y[ii] - ypred) *
                c(1, as.numeric(x[ii, ]))
            weight <- weight + weightdiff
            if ((y[ii] - ypred) != 0.0) {
                errors[jj] <- errors[jj] + 1
            }
        }
    }
    print(weight)
    return(errors)
}

err1 <- perceptron(x, y, inweight1, 1, 50)

plot(1:10, err1, type = "o", lwd = 4, col = "red", xlab = "epoch #", ylab = "errors")
title("Errors vs epoch - learning rate eta = 1")

inWeight2 <- data.frame(0, 2, 5)
err2 <- perceptron(x, y, inWeight2, 0.15, 50)
plot(1:50, err1, type = "o", lwd = 2, col = "red", xlab = "epoch #", ylab = "errors")
lines(err2, type = "o", col = "blue")
title("Errors vs epoch - learning rate eta = 0.15")
legend("bottomright", c("err1", "err2"), fill = c("red", "blue"))

# SVM

library(e1071)
library(MASS)
data(cats)
catstrain <- cats
catstest <- cats
tune <- tune.svm(Sex ~ ., data = catstrain, gamma = 10^(-6:-1), cost = 10^(1:4))
summary <- summary(tune)
summary


model <- svm(Sex ~ .,
    data = catstrain, method = "C-classification", kernel = "linear", probability = T,
    gamma = 0.01, cost = 100
)
prediction <- predict(model, catstest, probability = T)
table(catstest$Sex, prediction)
plot(model, cats)

# change kernel to radial

model <- svm(Sex ~ .,
    data = catstrain, method = "C-classification", kernel = "radial", probability = T,
    gamma = 0.01, cost = 100
)
prediction <- predict(model, catstest, probability = T)
table(catstest$Sex, prediction)
plot(model, cats)

help(tune.svm)

# random sampling
catsData <- cats
set.seed(224599)
ind <- sample(2, nrow(catsData), replace = TRUE, prob = c(0.7, 0.3))
catstrain <- catsData[ind == 1, ]
catstest <- catsData[ind == 2, ]

tune <- tune.svm(Sex ~ ., data = catstrain, gamma = 10^(-6:-1), cost = 10^(1:4))
summary(tune)

model <- svm(Sex ~ .,
    data = catstrain, method = "C-classification", kernel = "linear", probability = T,
    gamma = 0.000001, cost = 10
)
prediction <- predict(model, catstest, probability = T)
table(catstest$Sex, prediction)
plot(model, cats)

# install.packages("caret")
library(caret)
confusionMatrix(catstrain$Sex, predict(model))

confusionMatrix(catstest$Sex, prediction)

####### Assignment 2

# Importdata
colonData <- read.table("DataForRpartOne/colon.csv", header = TRUE, sep = ",")
# colonData

datasvm <- colonData[c("Class", "H64807", "T62947")]
datasvm$Class <- factor(colonData$Class)
# (colonData$H64807, colonData$T62947, colonData$Class)
# x <- data.frame(colonData$H64807, colonData$T62947)
# y <- colonData$Class

set.seed(224599)
library(e1071)
ind <- sample(2, nrow(datasvm), replace = TRUE, prob = c(0.7, 0.3))
colon_train <- datasvm[ind == 1, ]
colon_test <- datasvm[ind == 2, ]

tune <- tune.svm(Class ~ ., data = colon_train, gamma = 10^(-6:-1), cost = 10^(1:4))
summary(tune)

model <- svm(Class ~ .,
    data = colon_train, method = "C-classification", kernel = "linear", probability = T,
    gamma = 0.01, cost = 100
)
prediction <- predict(model, colon_test, probability = T)
table(colon_test$Class, prediction)
plot(model, datasvm)


# Hierarchical Clustering

set.seed(101)
# get samples from iris data
sampleiris <- iris[sample(1:150, 40), ]
# each observation has 4 variables, ie. They are interpreted as 4-Dimension
distance <- dist(sampleiris[, -5], method = "euclidean")
cluster <- hclust(distance, method = "average")
plot(cluster, hang = -1, label = sampleiris$Species)

# prune the tree by 3 cluster
group.3 <- cutree(cluster, k = 3)
# compare with known classes
table(group.3, sampleiris$Species)

plot(sampleiris[, c(1, 2)], col = group.3, pch = 19, cex = 2.5, main = "3
clusters")
points(sampleiris[, c(1, 2)], col = sampleiris$Species, pch = 19, cex = 1)


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
