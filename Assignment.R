dat <- read.table("DataForRpartOne/imputeExample.csv",header = TRUE,sep=",")
head(dat)

#Check the data for missing values.
sapply(dat, function(x) sum(is.na(x)))

#Add some missing in few variables.
original <- dat
head(original)

data2 <- original
set.seed(10)
# set na with random
data2[sample(1:nrow(data2), 20), "Cholesterol"] <- NA
data2[sample(1:nrow(data2), 20), "Smoking"] <- NA
data2[sample(1:nrow(data2), 20), "Education"] <- NA
data2[sample(1:nrow(data2), 5), "Age"] <- NA
data2[sample(1:nrow(data2), 5), "BMI"] <- NA
sapply(data2, function(x) sum(is.na(x)))


imputed <- data2

# insert smoking mode val
val <- unique(data2$Smoking[!is.na(data2$Smoking)])
my_mode <- val[which.max(tabulate(match(data2$Smoking,val)))]
imputed$Smoking[is.na(imputed$Smoking)] <- my_mode

# insert education mode val
val <- unique(data2$Education[!is.na(data2$Education)])
my_mode <- val[which.max(tabulate(match(data2$Education,val)))]
imputed$Education[is.na(imputed$Education)] <- my_mode

sapply(imputed,function(x) sum(is.na(x)))

# Smoking
actual <- original$Smoking[is.na(data2$Smoking)]
predicted <- original$Smoking[is.na(data2$Smoking)]
table(actual)
table(predicted)

# Education
actual <- original$Education[is.na(data2$Education)]
predicted <- original$Education[is.na(data2$Education)]
table(actual)
table(predicted)
