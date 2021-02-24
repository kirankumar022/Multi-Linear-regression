library(readr)
library(readxl)
computer=read.csv("E:/Assignments/Assignment week 11/multi linear/assignment/Computer_Data.csv")
summary(computer)
computer=data.frame(computer)
model.matrix(computer$multi)
computer$X=NULL
library(caret)
dmy <- dummyVars(" ~ .", data = computer, fullRank = T)
comp<- data.frame(predict(dmy, newdata = computer))
plot(comp)
cor(comp)
#************************
library(Hmisc)
k=comp
attach(k)
k["ram"]=log(ram)
model=lm(price~.,data = k)
summary(model)

n <- nrow(comp)
n1 <- n * 0.75
n2 <- n - n1
train <- sample(1:n, n1)
test <- comp[-train, ]

# Model Training

model1=lm(price~.,data = comp)
summary(model1)

pred <- predict(model1, newdata = test)
pred=data.frame(pred)
actual <- test$price
error <- actual - pred
test.rmse <- sqrt(mean(error**2))
test.rmse
train.rmse <- sqrt(mean(model$residuals**2))
train.rmse

