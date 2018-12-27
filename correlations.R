library(topicmodels)
library(tm)
library(plyr)
library(sos)
library(openxlsx)
library(ggplot2)


#### Seperating Forum Posts #### 
#Find date and post 
#forums_file[, 8:10]
#write.csv(forums_file[,c(8,10)], "forums_date_sep.csv")

#Y8M3<-read.csv("Forum Posts Sep/2008-03.csv", header = FALSE, sep="\t")
#Y8M3 <- Y8M3$V2


### Grab Forum Posts & Dev Blogs ####
setwd("C:/R Projects/LDA_Correlations/Combined Data/")
filenames <- list.files(getwd()) #get everything
files <- lapply(filenames, readLines)#read files into a character vector 
docs <- Corpus(VectorSource(files)) #create corpus from vector 



#### Pre-Process ##### 

#Combine stop words with personal stop words 
myStopWords <- read.csv("C:/R Projects/LDA_Correlations/myStopWords.csv", header = FALSE) 
myStopWords <- as.character(myStopWords$V1)
stopwords <- c(myStopWords, stopwords())


docs <- tm_map(docs, content_transformer(tolower)) #lower case because stopwords are all in lowercase 
toSpace <- content_transformer(function(x, pattern) { return (gsub(pattern, " ", x))})
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map (docs, removeWords, stopwords)
docs <- tm_map(docs, stripWhitespace)


docs <- tm_map(docs, stemDocument)
#Create a document-term matrix 
dtm <- DocumentTermMatrix(docs)
#convert rownames to filenames
rownames(dtm) <- filenames
#collapse matrix by summing over columns
freq <- colSums(as.matrix(dtm))
#length should be total number of terms
length(freq)
#create sort order (descending)
ord <- order(freq,decreasing=TRUE)
#List all terms in decreasing order of freq and write to disk
freq[ord]
write.csv(freq[ord], "word_freq.csv")


#### Topic Modeling #### 

#Setting parameters for Gibbs sampling
burnin <- 0 #number of omitted Gibs iterations at beginning 
iter <- 30 # number of iterations 
thin <- 5 #number of omitted in between iterations 
seed <- list (5,  101) 
nstart <- 2 #repeated number of stars 
best <- TRUE  

#Num of topics 
k <- 15  #num of topics 

#Run LDA 
ldaOut <- LDA (dtm, k, method="Gibbs", control=list(nstart= nstart, seed = seed, best = best, burnin = burnin, iter = iter, thin = thin))

#Write out results 
ldaOut.topics <- as.matrix(topics(ldaOut))
write.csv(ldaOut.topics, file=paste("LDAGibbs", k, "DocsToTopics.csv"))

#write top 4 terms in each topic 
ldaOut.terms <- as.matrix(terms(ldaOut, 15))
write.csv(ldaOut.terms, file=paste("LDAGibbs", k, "TopicsToTerms.csv"))

#probabilities associated with each topic assignment
topicProbabilities <- as.data.frame(ldaOut@gamma)
write.csv(topicProbabilities, file=paste("LDAGibbs", k, "TopicProbabilities_one.csv"))

#### Creating graphs ####


# You will need to fix the dates into numbers for linear reg
# i.e.
# 20014-05.csv  = 1 
# 20014-06.csv = 2 
# keep the legend 


Prob<- read.csv("LDAGibbs 15 TopicProbabilities.csv", header = TRUE)
head(Prob_Dev)

Prob_Dev <- read.csv("LDAGibbs 15 TopicProbabilities_one.csv", header = TRUE)
head(Prob_Dev$V10)

df_ships <- data.frame(Prob$Title,Prob$V10)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V10)

theme_set(theme_bw())

#### Plot for Forum #### 
ggplot(df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V10)) + 
  geom_point() + 
  geom_smooth(method=lm) +
  ggtitle("Topic: Ships") + labs(y = "Probability of Topic", x = "Date") +
  scale_x_discrete(name="Dates", breaks= c(1, 40, 20))

#### Plot for Dev ####
ggplot(df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V10)) +
  geom_point() +
  geom_smooth(method=lm) +
  ggtitle("Topic: Ships") + labs(y = "Probability of Topic", x = "Date") + 
  scale_x_discrete(name="Dates", breaks= c(1, 40, 20)) 

### Other scale 
#plot(df_ships$Prob.Title, df_ships$Prob.V10, col = "red")
#points(df_ships_dev$Prob_Dev.Title, df_ships_dev$Prob_Dev.V10, col = "blue")
#abline(lsfit(df_ships$Prob.Title,df_ships$Prob.V10),col="black")

### Combined Plot####
###################v1#####################

df_ships <- data.frame(Prob$Title,Prob$V1)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V1)

plot_for_V1 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V1, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V1, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V1") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V1, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V1, color ="Regression for dev" ), linetype ="dashed") 


###################v2#####################

df_ships <- data.frame(Prob$Title,Prob$V2)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V2)

plot_for_V2 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V2, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V2, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V2") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V2, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V2, color ="Regression for dev" ), linetype ="dashed") 


###################V3#####################

df_ships <- data.frame(Prob$Title,Prob$V3)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V3)

plot_for_V3 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V3, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V3, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V3") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V3, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V3, color ="Regression for dev" ), linetype ="dashed") 


###################V4#####################

df_ships <- data.frame(Prob$Title,Prob$V4)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V4)

plot_for_V4 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V4, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V4, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V4") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V4, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V4, color ="Regression for dev" ), linetype ="dashed") 

###################V5#####################

df_ships <- data.frame(Prob$Title,Prob$V5)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V5)

plot_for_V5 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V5, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V5, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V5") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V5, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V5, color ="Regression for dev" ), linetype ="dashed") 


###################V6#####################

df_ships <- data.frame(Prob$Title,Prob$V6)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V6)

plot_for_V6 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V6, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V6, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V6") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V6, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V6, color ="Regression for dev" ), linetype ="dashed") 


###################V7#####################

df_ships <- data.frame(Prob$Title,Prob$V7)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V7)

plot_for_V7 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V7, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V7, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V7") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V7, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V7, color ="Regression for dev" ), linetype ="dashed") 


###################V8#####################

df_ships <- data.frame(Prob$Title,Prob$V8)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V8)

plot_for_V8 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V8, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V8, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V8") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V8, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V8, color ="Regression for dev" ), linetype ="dashed") 



###################V9#####################

df_ships <- data.frame(Prob$Title,Prob$V9)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V9)

plot_for_V9 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V9, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V9, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V9") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V9, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V9, color ="Regression for dev" ), linetype ="dashed") 


###################V10#####################

df_ships <- data.frame(Prob$Title,Prob$V10)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V10)


plot_for_V10 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V10, group = 1, color = "forum")) + 
 geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V10, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V10") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V10, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V10, color ="Regression for dev" ), linetype ="dashed") 

###################V11##################### 

df_ships <- data.frame(Prob$Title,Prob$V11)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V11)

plot_for_V11 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V11, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V11, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V11") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V11, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V11, color ="Regression for dev" ), linetype ="dashed") 

###################V12##################### 

df_ships <- data.frame(Prob$Title,Prob$V12)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V12)

plot_for_V12 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V12, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V12, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V12") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V12, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V12, color ="Regression for dev" ), linetype ="dashed") 

###################V13##################### 

## Good Regression ## 

df_ships <- data.frame(Prob$Title,Prob$V13)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V13)

plot_for_V13 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V13, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V13, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V13") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V13, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V13, color ="Regression for dev" ), linetype ="dashed") 

###################V14##################### 


df_ships <- data.frame(Prob$Title,Prob$V14)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V14)

plot_for_V14 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V14, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V14, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V14") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V14, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V14, color ="Regression for dev" ), linetype ="dashed") 

###################V15##################### 


df_ships <- data.frame(Prob$Title,Prob$V15)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V15)

plot_for_V15 <-ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V15, group = 1, color = "forum")) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V15, group=1, color = "dev")) +
  scale_colour_manual("", breaks = c("forum", "dev", "Regression for forum", "Regression for dev"), values = c("red", "blue", "red", "blue")) +
  ggtitle("Topic: V15") + 
  labs(y = "Probability of Topic", x = "Date") +
  geom_smooth(method=lm, aes(x=df_ships$Prob.Title, y=df_ships$Prob.V15, color = "Regression for forum"), linetype="dashed" ) +
  geom_smooth(method=lm, aes(x=df_ships_dev$Prob_Dev.Title,  y=df_ships_dev$Prob_Dev.V15, color ="Regression for dev" ), linetype ="dashed") 




