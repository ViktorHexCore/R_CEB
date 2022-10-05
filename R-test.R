# install.packages("languageserver")
"Hello World!"
5 + 5
1 + 1 
plot(1:10)
for (x in 1:10) {
  print(x)
}
print("Hello World!")
# This is a comment
name <- 'john'
name
var1 <- var2 <- var3 <- 'testvar'
var1
var2
var3

changeTypeVal <- 30
changeTypeVal
class(changeTypeVal)
changeTypeVal <- 'now it str'
changeTypeVal
class(changeTypeVal)

# numeric
x <- 10.5
class(x)
x
# integer
x <- 1000L
class(x)
x
a <- as.numeric(x)
a
class(a)
# complex
x <- 9i + 3
class(x)
x
# character/string
x <- "R is exciting"
class(x)
x
# logical/boolean
x <- TRUE
class(x)
x



x <- 1L # integer
class(x)
# convert from integer to numeric:
a <- as.numeric(x)
a
class(a)

max(1,2,3)
min(1,2,3)
sqrt(16)
abs(-4.7)
ceiling(1.7)
floor(1.7)

str <- "Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."
cat(str)
nchar(str)
grepl("L",str)
grepl("Loraze",str)
str2 <- "New str for concat :"
paste(str2,str)
