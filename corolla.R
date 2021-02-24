library(readr)
library(readxl)
corolla=read.csv("E:/Assignments/Assignment week 11/multi linear/assignment/ToyotaCorolla.csv")
corolla['Model']=NULL
colnames(corolla)
attach(corolla)

cor1=corolla[,3:18]
colnames(cor1)
cor1$Mfg_Month=NULL
cor$Mfg_Month=NULL
cor1$Mfg_Year=NULL
cor1$Fuel_Type=NULL
cor1$Met_Color=NULL
cor1$Color=NULL
cor1$Automatic=NULL
cor1$Cylinders=NULL
plot(cor1)
k=cor1

attach(k)
k$Doors=NULL
cor(cor1)
library(Hmisc)
reg=lm(Price~.,data=k[-81,])
summary(reg)
library(corpcor)
cor(Cars)
cor2pcor(cor(k))
influenceIndexPlot(reg, id.n = 3) # Index Plots of the influence measures
influencePlot(reg, id.n = 3)
avPlots(reg, id.n = 2, id.cex = 0.8, col = "red")


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n <- nrow(cor1)
n1 <- n * 0.7
n2 <- n - n1
train <- sample(1:n, n1)
test <- cor1[-train, ]

# Model Training
model <- lm(Price~.,data=k[-81,])
summary(model)


pred <- predict(model, newdata = test)
pred=data.frame(pred)
actual <- test$Price
error <- actual - pred
test.rmse <- sqrt(mean(error**2))
test.rmse

train.rmse <- sqrt(mean(model$residuals**2))
train.rmse
