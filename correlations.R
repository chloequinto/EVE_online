library(topicmodels)
library(tm)
library(plyr)
library(sos)
library(xlsx)



#Find date and post 
forums_file[, 8:10]
write.csv(forums_file[,c(8,10)], "forums_date_sep.csv")

read.xlsx ("Forum_Sep.xlsx", sheetIndex=2)

  

#### Bring in File #### 
filenames <- list.files(getwd(), pattern="*.txt") #Load files into corpus 
files <- lapply(filenames, readLines)#read files into a character vector 
docs <- Corpus(VectorSource(files)) #create corpus from vector 

#### PreProcess ##### 
docs <- tm_map(docs, content_transformer(tolower)) #lower case
toSpace <- content_transformer(function(x, pattern) { return (gsub(pattern, " ", x))})
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
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
burnin <- 4000 
iter <- 2000 
thin <- 500 
seed <- list (2003, 5, 63, 100001, 765)
nstart <- 5
best <- TRUE 

#Num of topics 
k <- 5 

#Run LDA 
ldaOut <- LDA (dtm, k, method="Gibbs", control=list(nstart= nstart, seed = seed, best = best, burnin = burnin, iter = iter, thin = thin))

#Write out results 
ldaOut.topics <- as.matrix(topics(ldaOut))
write.csv(ldaOut.topics, file=paste("LDAGibbs", k, "DocsToTopics.csv"))

#write top 4 terms in each topic 
ldaOut.terms <- as.matrix(terms(ldaOut, 4))
write.csv(ldaOut.terms, file=paste("LDAGibbs", k, "TopicsToTerms.csv"))

#probabilities associated with each topic assignment
topicProbabilities <- as.data.frame(ldaOut@gamma)
write.csv(topicProbabilities, file=paste("LDAGibbs", k, "TopicProbabilities.csv"))













