# Importdata
colonData <- read.table("DataForRpartOne/colon.csv",header = TRUE, sep=",")
colonData

# install.packages("readxl")
library(readxl)
colonExcelData <- read_xlsx("DataForRpartOne/colon.xlsx",sheet="colon")
colonExcelData

colonData$Class
colonData$Class <- factor(colonData$Class)
colonData$Class

colonData$Class <- as.numeric(colonData$Class)
colonData$Class


set.seed(11)
indexR <- sample(1:nrow(colonData), 20, replace=T)
indexC <- sample(1:ncol(colonData), 10, replace=T) 
colonSample <-colonData[indexR, indexC]
indexR
indexC
colonSample

colonSample[15,3] <- NA
colonSample

# install.packages("e1071")
library(e1071)
fixColonSample1 <- impute(colonSample[,1:10], what='mean')
fixColonSample1

colonSample[,1] <-cut(colonSample[,1], breaks=3, labels=c('1','2','3'))
colonSample[,1] <-as.numeric(colonSample[,1])

colonSample[15,1] <- NA
colonSample[2,1] <- NA


#impute missing data with median
fixColonSample2 <- impute(colonSample[,1:10], what="median")
fixColonSample2
#or use this code with specific column
colonSample[,1][is.na(colonSample[,1])] <- median(colonSample[,1],na.rm=TRUE)
colonSample



###MICE


dat <- read.table("DataForRpartOne/imputeExample.csv",header = TRUE,sep=",")
head(dat)

#Check the data for missing values.
sapply(dat, function(x) sum(is.na(x)))

#Add some missing in few variables.
original <- dat
head(original)
set.seed(10)
dat[sample(1:nrow(dat), 20), "Cholesterol"] <- NA
dat[sample(1:nrow(dat), 20), "Smoking"] <- NA
dat[sample(1:nrow(dat), 20), "Education"] <- NA
dat[sample(1:nrow(dat), 5), "Age"] <- NA
dat[sample(1:nrow(dat), 5), "BMI"] <- NA
sapply(dat, function(x) sum(is.na(x)))


library(dplyr)
library(magrittr)
dat <- dat %>%
mutate(Smoking = as.factor(Smoking)) %>% 
mutate(Education = as.factor(Education)) %>% 
mutate(Cholesterol = as.numeric(Cholesterol))
# head(dat)

#MICE
# install.packages("mice")
library(mice)
init = mice(dat,maxit = 0)
meth = init$method
predM = init$predictorMatrix



#If you want to skip a variable from imputation use the code below.
meth[c("ID")]=""

#specify the methods for imputing the missing values.
meth[c("Cholesterol")]="norm"
meth[c("Smoking")]="logreg"
meth[c("Education")]="polyreg"
meth
#Now it is time to run the multiple (m=5) imputation
set.seed(103) 
imputed = mice(dat, method=meth,predictorMatrix = predM ,m=5)

imputed <- comlete(imputed)

sapply(imputed,function(x) sum(is.na(x)))

# Cholesterol
actual <- original$Cholesterol[is.na(dat$Cholesterol)]
predicted <- original$Cholesterol[is.na(dat$Cholesterol)]
mean(actual)
mean(predicted)

# Smoking
actual <- original$Smoking[is.na(dat$Smoking)]
predicted <- original$Smoking[is.na(dat$Smoking)]
table(actual)
table(predicted)

# Education
actual <- original$Education[is.na(dat$Education)]
predicted <- original$Education[is.na(dat$Education)]
table(actual)
table(predicted)

# transform

#scale the columns
# mean of x / standard deivationof x
scaleColonSample <- scale(fixColonSample1[,1:10])
scaleColonSample

segments <-5
maxL <- max(colonData$H62245)
minL <- min(colonData$H62245)
theBreaks <- seq(minL, maxL, by=(maxL-minL)/segments)
cutPoints <-cut(colonData$H62245, breaks=theBreaks, include.lowest = T)
newData <-data.frame(original=colonData$H62245, myCut=cutPoints)
head(newData)

a <- iris
a[,5] <- sapply(a[,5], switch,"setosa"=1,"versicolor"=2,"virginica"=3)

dataset1 <-data.frame(
brand = c("EROSE","Neuroplus"), 
num_models = c(63,10),
stringsAsFactors = FALSE
)
dataset1

dataset2 <-data.frame(
brand = c("Virgo","Contec"), 
num_models = c(26,4),
stringsAsFactors = FALSE
)
dataset2


models <- rbind(dataset1, dataset2)
models

reordered_dataset1 <-dataset1[, c(2, 1)]
reordered_dataset1

# rely on first dataset
rbind(reordered_dataset1, dataset2)

# Sales datasets
sales <-data.frame(
brand = c("Virgo","Neuroplus","Contec","EROSE"), 
sales = c(19157, 25908, 188328, 29975),
stringsAsFactors = FALSE
)
sales

# Add datasets horizontally
cbind(models, sales)

results <- merge(x = models,y = sales, by = "brand", all.x = TRUE)
results

# Create new datasets
salesTemp <-data.frame(
brand = c("Guangzhou","Hunan"), 
sales = c(500, 13467),
stringsAsFactors = FALSE
)
# add more row into Sales
sales <- rbind(sales, salesTemp)
sales

resultsRightJoin <-merge(x=models,y=sales,by="brand",all.y=TRUE)
resultsRightJoin

results<-merge(x=models,y=sales,by="brand",all.x=TRUE)
results

#inner join
modelsTemp <-data.frame(
brand = c("Emotiv","NeuroSky"), 
num_models = c(15,9),
stringsAsFactors = FALSE
)
models <- rbind(models, modelsTemp)
models

resultsInnerJoin <-merge(x=models,y=sales,by="brand",all.x=FALSE,all.y=FALSE)
resultsInnerJoin

resultsFullJoin <-merge(x=models,y=sales,by="brand",all.x=TRUE,all.y=TRUE)
resultsFullJoin

#prepare data 
modelsTemp <-data.frame(
brand = c("Emotiv","NeuroSky"), 
num_models = c(33,16),
stringsAsFactors = FALSE
)
groupbyData <- rbind(models, modelsTemp)
groupbyData

countGroup <-groupbyData %>%
count(brand)
countGroup

library(dplyr)
groupbyData %>%
group_by(brand) %>%
summarise(mean_num = mean(num_models))

sumGroup <-groupbyData %>%
group_by(brand) %>%
summarise(total_num = sum(num_models))
