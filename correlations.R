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
Prob<- read.csv("LDAGibbs 15 TopicProbabilities.csv", header = TRUE)
head(Prob_Dev)

Prob_Dev <- read.csv("LDAGibbs 15 TopicProbabilities_one.csv", header = TRUE)
head(Prob_Dev$Title)

df_ships <- data.frame(Prob$Title,Prob$V10)
df_ships_dev <- data.frame(Prob_Dev$Title, Prob_Dev$V10)


ggplot(df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V10)) + geom_point(color = "red") +
  ggtitle("Topic: Ships") + labs(y = "Probability of Topic", x = "Date") +  scale_x_discrete(name="Dates", breaks= c("2008-03.csv", "2017-07.csv",c("2010-06.csv", "2014-12.csv") ))


ggplot(df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V10)) + geom_point(color = "blue") +
  ggtitle("Topic: Ships") + labs(y = "Probability of Topic", x = "Date") + 
  scale_x_discrete(name="Dates", breaks= c("2015_01_dev.txt", "2017_03_dev.txt",c("2015_09_dev.txt", "2016_06_dev.txt") ))

ggplot() + 
  geom_line(data =df_ships, aes(x = df_ships$Prob.Title, y=df_ships$Prob.V10), color="black", group=1) + 
  geom_line(data = df_ships_dev, aes(x = df_ships_dev$Prob_Dev.Title, y=df_ships_dev$Prob_Dev.V10), color="blue", group=1) +
  ggtitle("Topic: Ships") + 
  labs(y = "Probability of Topic", x = "Date") +  
  scale_x_discrete(name="Dates", breaks= c("2014-09.csv", "2017-01.csv",c("2015-05.csv",  "2016-05.csv")))






