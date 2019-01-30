### Markov Switching ###

library(ggplot2)
library(MSwM)

### Dectect Regimes ###
files <- read.csv("Forum Post Code/FPC_comp.csv", header=FALSE) #read file

Y = files$V10
X = files$V1

ggplot(files, aes(x = X, y=Y, color=files$V3)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  ggtitle("Topic: 0") + labs(y = "Probability of Topic", x = "Date")



# A linear model to relate x to y 
mod=lm(Y~X,files)
summary(mod)
plot(ts(Y)) #plot the time series of Topic 


### Autoagressive Markov Switching Model ###
mod.mswm=msmFit(mod,k=2,p=1,sw=c(TRUE,TRUE,TRUE,TRUE),control=list(parallel=FALSE))
summary(mod.mswm)
## Detect structural changes in a time series 

## if the transition matrix shows high numbers between regimes
## the model detects pefectly the period of each state 

plot(mod.mswm)
plotProb(mod.mswm,which=1)

## plots which observations are for regime 1
plotProb(mod.mswm,which=2)


plotReg(mod.mswm,expl="X")


