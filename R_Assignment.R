
# A

autismData <- read.csv("DataForRpartOne/Autism-Adolescent-Data.csv")
# leukemiaData <- read.csv("DataForRpartOne/leukemiaData.csv")

head(autismData, 5)

summary(autismData)
# stem(autismData$result)

# colSums(is.na(autismData))
sapply(autismData, function(x) sum(is.na(x)))
# colSums(is.na(leukemiaData))
# colnames(autismData)[colSums(is.na(autismData)) > 0]


# C

400 x1 + 200 x2 + 150 x3 + 500 x4 >= 500 kcal

3 x1 + 2 x2 + 0 x3 + 0 x4 >= 6 g protien

2 x1 + 2 x2 + 4 x3 + 4 x4 >= 10 g carb

2 x1 + 4 x2 + 1 x3 + 5 x4 >= 8 g fat

get min prize bath
500 x1 + 200 x2 + 300 x3 + 800 x4

library(lpSolve)

f.obj <- c(500, 200, 300, 800)

f.con <- matrix(c(400, 200, 150, 500,
3, 2, 0, 0,
2, 2, 4, 4,
2, 4, 1, 5), nrow = 4, byrow = TRUE)

f.dir <-c(">=",
">=",
">=",
">=")

f.rhs <-c(500,
6,
10,
8)

lp("min", f.obj, f.con, f.dir, f.rhs)

lp("min", f.obj, f.con, f.dir, f.rhs)$solution

# D

library(magick)
str(magick::magick_config())

xray1 <- image_read("DaraForRpartTwo/x-ray01.jpg")
image_info(xray1)
print(xray1)

# image_trim(xray1)

xrayAug = image_crop(xray1,"100x200+100")

xrayAug = image_scale(xray1,"500")

xrayAug = image_scale(xray1,"x150")

xrayAug = image_rotate(xray1, 30)

xrayAug = image_rotate(xray1, 270)

xrayAug = image_flip(xray1)

xrayAug = image_modulate(xray1, brightness = 150, saturation = 111, hue = 77)

# xrayAug = image_fill(xray1, "blue", point = "+100+200", fuzz = 10)

image_write(xrayAug, path = "show.jpg", format = "jpeg", quality = 75)

# repeat it with another images
