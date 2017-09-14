# ======================================
# N736 Lesson 06 R Code
# 09/13/2017
#
# Melinda Higgins, PhD
# ======================================

# ======================================
# read in datasets and add a descriptive
# comment for the datasets
# ======================================

library(readr)
library(knitr)
dataA <- read_csv("dataA.csv")
dataB <- read_csv("dataB.csv")

comment(dataA) <- "This is a comment on dataset dataA"
comment(dataB) <- "This is a comment on dataset dataB"

# ======================================
# once you have a comment applied
# you can see it/retrieve it using the
# attributes() function
# ======================================

attributes(dataA)
attributes(dataB)

# ======================================
# specifically the $comment attribute
# will pull this text description up
# and you can then use it in other functions
# like print() and paste()
# ======================================

print(paste("Here are the details on dataset dataA:",
            attributes(dataA)$comment))

# ======================================
# use the class(), typeof(), and is.numeric()
# functions to get info on the dataA$var1 variable
# ======================================

class(dataA$var1)
typeof(dataA$var1)
is.numeric(dataA$var1)

# ======================================
# change dataA$var1 into a factor with labels
# ======================================

dataA$var1 <- factor(dataA$var1,
                     levels=c(1,2,3,4,5),
                     labels=c("strongly disagree",
                              "disagree", "neutral",
                              "agree","strongly agree")) 

# ======================================
# notice that var1 is now a factor type
# variable and is NOT numeric type anymore
# ======================================

class(dataA$var1)
typeof(dataA$var1)
is.numeric(dataA$var1)

# ======================================
# similar process for var2 which was
# a character variable initially
# and then becomes a factor type
# ======================================

class(dataA$var2)
typeof(dataA$var2)
is.numeric(dataA$var2)

dataA$var2 <- factor(dataA$var2,
                     levels=c("m","f"),
                     labels=c("male","female")) 

class(dataA$var2)
typeof(dataA$var2)
is.numeric(dataA$var2)

# ======================================
# recoding
# ======================================

# create a numeric vector x with values 1,2,3,4,5

x <- c(1,2,3,4,5)

# run a logic statement - this returns TRUE/FALSE
# confirm this is a logic type variable

x > 3
typeof(x > 3)

# to recode var1 which is a factor, we first make it
# numeric, ask if the number is > 3, and then convert the
# resulting logic variable to numeric 0/1 instead of TRUE/FALSE

dataA$var1r <- as.numeric(
  as.numeric(dataA$var1) > 3
)

typeof(dataA$var1r)

# we can then convert the 0/1 to a factor
# and add labels

dataA$var1r <- factor(dataA$var1r,
                      levels=c(0,1),
                      labels=c("NO var1 <= 3",
                               "YES var1 > 3")) 

dataA



