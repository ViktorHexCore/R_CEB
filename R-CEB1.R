x <- 5
x
y <- c(5,9,3)
y

meany <- mean(y)
meany

help(stats)

help(kmeans)

help.search("kmeans")

help.start()

getAnywhere("kmeans")

example("kmeans")

a <- c("kolkata","Rome","New York", "London", "Melbourne")
a

b <- c(2,3,4,5)
b

c <- matrix(list(1,"a",1+2i,TRUE),2,2)
c

d <- list(2,"london","yes")
d

list_data <- list("red","green",c(21,32,11),TRUE,51.23,119.1)
list_data

# list number should be equal
emp.data <-data.frame(
emp_id = c(1:5), 
emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
salary = c(623.3,515.2,611.0,729.0,843.25), 
start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
"2015-03-27")),
stringsAsFactors = FALSE
)
emp.data

a <- emp.data[1]
a

# get first row
b <- emp.data[1,]
b
# get third row
b <- emp.data[3,]
b

# show first col in list
c <- emp.data[,1]
c
# show second col in list
c <- emp.data[,2]
c
# link by col name
d <- emp.data$emp_name
d

e <- emp.data[1:3]
e

t <- emp.data[emp.data[,1]<4]
t

df1 <- subset(emp.data, select = emp_id)
df1

ans1 <- emp.data[1:3]
ans1

ans2 <- emp.data[1:2,]
ans2

# funstion module
fahr_to_cel <- function(temp_F){
 temp_C <- (temp_F -32)*5/9
 return(temp_C)
}

fahr_to_cel(90)

irisData <- iris
summary(irisData)

stem(irisData$Sepal.Length)

table(iris$Species)

dataCar = cars
carReg <- lm(speed~dist, data = dataCar)
summary(carReg)
coef(carReg)

# test library install
library(foreign)

# Importdata
colonData <- read.table("DataForRpartOne/colon.csv",header = TRUE, sep=",")
colonData

install.packages("readxl")
library(readxl)
colonExcelData <- read_xlsx("DataForRpartOne/colon.xlsx",sheet="colon")
colonExcelData

colonData$Class
colonData$Class <- factor(colonData$Class)
colonData$Class

colonData$Class <- as.numeric(colonData$Class)
colonData$Class

# export data
write.csv(colonData,"colonSaveTest.csv",row.names=FALSE)

install.packages("writexl")
library(writexl)
write_xlsx(list(colonSheet = colonData),"colonSaveTest.xlsx")

write.table(colonData,"colonTestSaveText.txt", sep="\t")

library(foreign)
write.dta(colonData,"stata.dta")

myPlot <- data.frame(
    x1 = c(175,166,181,168,177),
    x2 = c(65.4,45.3,95.01,65,800),
    stringsAsFactors = FALSE
)
plot(myPlot)

# cretae histogram
hist(colonData$H64807, prob=T)

# add line curve
lines(density(colonData$H64807))

# bar chart
categories <- table(colonData$Class)
barplot(categories, col = c('red','green'))

# boxplot
boxplot(H64807~Class, data=colonData)

#complex plot
install.packages("ggplot2")
library(ggplot2)

p <- ggplot(colonData, aes(colonData$H64807,colonData$T62947)) +
geom_point(aes(colour = factor(colonData$Class)))
p + scale_colour_manual(values = c('red','green'))

install.packages("GGally")
library(GGally)
library(ggplot2)
ggpairs(iris, title = "Scatterplot Matrix of the Features of the iris Data Set")
