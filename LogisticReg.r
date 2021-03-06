library(readxl)
library(dplyr)
library(caTools)
bank<- read.csv("F:\\ExcelR\\excelRASS\\ass9 logistic Reg\\bank-full.csv", sep =";")
bank$y<- as.factor(revalue(bank$y,c("yes"=1, "no"=0))) #changing categorical value.
bank$default<- as.factor(revalue(bank$default,c("yes"=1, "no"=0)))
bank$housing<- as.factor(revalue(bank$housing,c("yes"=1, "no"=0)))
bank$loan<- as.factor(revalue(bank$loan,c("yes"=1, "no"=0)))
View(bank)
sum(is.na(bank)) #checking for null values.
summary(bank)
set.seed(100)
split<-sample.split(bank$y,SplitRatio = 0.80)
traindata<-subset(bank, split = TRUE)
testdata<-subset(bank, split = FALSE)
model<-glm(y~.,data = traindata,family = "binomial")
exp(coef(model))
pr<-predict(model,type = "response")
summary(model)
confusion<-table(pr>0.5,traindata$y)
confusion
Accuracy<-sum(diag(confusion)/sum(confusion))
Accuracy
library(ROCR)
ROCRpred <- prediction(pr,bank$y)
ROCRperf <- performance(ROCRpred,'tpr','fpr')
plot(ROCRperf,colorize=TRUE,text.adj= c(-0.2,1.7))
