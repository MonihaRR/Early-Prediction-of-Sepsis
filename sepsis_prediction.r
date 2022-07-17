# setwd("G:/bme-files/sem-7/project/data5")
setwd("G:/bme-files/sem-7/project/extracted dataset/training")
library(stringi)
library(rapportools)

#Creating blank data frames
df_zero<-data.frame(matrix(ncol=41,nrow=0))
df_one<-data.frame(matrix(ncol=41,nrow=0))
df_all<-data.frame(matrix(ncol=41,nrow=0))


#Reading files one by one in a folder
c<-list.files()
for (i in c){
a=read.csv(i,sep='|')
b=nrow(a)
x=0
for(j in seq(1,b,1))
{
  if(is.empty(a[j,]$SepsisLabel))
  {x=x+1}
}
print(x)

#Checking for presence of one
if(x==b)
{ y = "only zeroes"
 print(y)
 } else {
   y = "Presence of one"
   print(y)
 } 

#Grouping into single  separate files

if (!(stri_cmp(y,"only zeroes")))
{df_zero<-rbind(df_zero,a)}

if (!(stri_cmp(y,"Presence of one")))
{
  t<- which(a$SepsisLabel == 1)
  h<- t[1]-5
   if (h<=0)
  {df_one<-rbind(df_one,a[-(1:b),])
   } else {
     df_one<-rbind(df_one,a[-(h:b),])
     
     }}
  
}

#Replace 0 with 1 in df_one

df_one$SepsisLabel<-replace(df_one$SepsisLabel,is.empty(df_one$SepsisLabel),1)

#Binding to a single data frame

df_all<-rbind(df_zero,df_one)

#to remove less % NAN attributes
df_all=df_all[,-(8:34)]

#Replace NAN
df_all$HR<-replace(df_all$HR,is.nan(df_all$HR),84.98)
df_all$O2Sat<-replace(df_all$O2Sat,is.nan(df_all$O2Sat),97.27)
df_all$Temp<-replace(df_all$Temp,is.nan(df_all$Temp),37.06)
df_all$SBP<-replace(df_all$SBP,is.nan(df_all$SBP),120.96)
df_all$MAP<-replace(df_all$MAP,is.nan(df_all$MAP),78.77)
df_all$DBP<-replace(df_all$DBP,is.nan(df_all$DBP),59.98)
df_all$Resp<-replace(df_all$Resp,is.nan(df_all$Resp),18.77)
df_all$Unit1<-replace(df_all$Unit1,is.nan(df_all$Unit1),0.51)
df_all$Unit2<-replace(df_all$Unit2,is.nan(df_all$Unit2),0.49)
df_all$HospAdmTime<-replace(df_all$HospAdmTime,is.nan(df_all$HospAdmTime),-52.02)
df_all$Age<-replace(df_all$Age,is.nan(df_all$Age),63.01)
df_all$Gender<-replace(df_all$Gender,is.nan(df_all$Gender),0.58)
df_all$ICULOS<-replace(df_all$ICULOS,is.nan(df_all$ICULOS),27.2)

#Standardisation
range01<-function(x){(x-min(x))/(max(x)-min(x))}
df_all$HR<-range01(df_all$HR)
df_all$O2Sat<-range01(df_all$O2Sat)
df_all$Temp<-range01(df_all$Temp)
df_all$SBP<-range01(df_all$SBP)
df_all$MAP<-range01(df_all$MAP)
df_all$DBP<-range01(df_all$DBP)
df_all$Resp<-range01(df_all$Resp)
df_all$Age<-range01(df_all$Age)
df_all$Gender<-range01(df_all$Gender)
df_all$Unit1<-range01(df_all$Unit1)
df_all$Unit2<-range01(df_all$Unit2)
df_all$HospAdmTime<-range01(df_all$HospAdmTime)
df_all$ICULOS<-range01(df_all$ICULOS)
# df_all<-apply(df_all,2,range01)

#building logistic regression

library(caret)
set.seed(100)
trainindices<-sample(1:nrow(df_all),0.7*nrow(df_all))
train1<-df_all[trainindices,]
test1<-df_all[-trainindices,]

logistic<-glm(formula = train1$SepsisLabel~., family = 'binomial', data = train1)
#pre<-predict(logistic,test1[-14])
pre <- predict(logistic, newdata = test1[-14], type = "response")
pre<-round(pre,digits = 0)
tab<-table(pre,test1$SepsisLabel)
tab
accuracy<-sum(diag(tab))/nrow(test1)
accuracy
sen<-sensitivity(tab)
sen
spe<-specificity(tab)
spe
cor(pre,test1$SepsisLabel)
summary(logistic)

#building KNN
library(class)
predicted<-knn(train=train1[,-14],test=test1[,-14],cl=train1$SepsisLabel,k=250)
tab1<-table(predicted,test1$SepsisLabel)
tab1
accuracy1<-sum(diag(tab1))/nrow(test1)
accuracy1
sen1<-sensitivity(tab1)
sen1
spe1<-specificity(tab1)
spe1
