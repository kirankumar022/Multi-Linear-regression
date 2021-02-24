library(readr)
library(readxl)
startups=read.csv("E:/Assignments/Assignment week 11/multi linear/assignment/50_Startups.csv")
summary(startups)
plot(startups)

for(unique_value in unique(startups$State)){
  
  startups[paste("State", unique_value, sep = ".")] <- ifelse(startups$State== unique_value, 1, 0)
}
startups$State=NULL
plot(startups)
cor(startups)
attach(startups)
plot(R.D.Spend,Profit)
cor(Marketing.Spend,Profit)
pairs(startups)
 
library(GGally)
ggpairs(startups)
colnames(startups)

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
library(Hmisc)
model1=lm(Profit~ .,data=startups)
summary(model1)
plot(model1)

vif(model1)
library(corpcor)
cor(startups)

cor2pcor(cor(startups))

plot(model1)

qqPlot(model1, id.n = 5)
influenceIndexPlot(model1, id.n = 3)
influencePlot(model1, id.n = 3)
attach(startups)
model2=lm(Profit~.,data=startups[1:45,])

summary(model2)
plot(model2)
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n <- nrow(startups)
n1 <- n * 0.7
n2 <- n - n1
train <- sample(1:n, n1)
test <- startups[-train, ]

# Model Training
model <- lm(Profit ~.,startups[train, ])
summary(model)


pred <- predict(model, newdata = test)
actual <- test$Profit
error <- actual - pred

test.rmse <- sqrt(mean(error**2))
test.rmse

train.rmse <- sqrt(mean(model$residuals**2))
train.rmse


#$$$$$$$$$$$$$
install.packages("leaps")
library(leaps)
lm_best <- regsubsets(Profit ~ ., data = startups, nvmax = 15)
summary(lm_best)
?regsubsets
summary(lm_best)$adjr2
which.max(summary(lm_best)$adjr2)
coef(lm_best, 3)

lm_forward <- regsubsets(Profit ~ ., data = startups, nvmax = 20, method = "backward")
summary(lm_forward)
