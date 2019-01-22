library(tidytext)
library(tidyverse)
library(dplyr)
library(readr)
library(glue)
library(stringr)
library(ggplot2)

## uppress Warnings 
options(warn=-1)
###
# Bugs: 
# Current graph is inaccurate due to the failure of removal of special characters
# in the function "GetSentiment" 
###
### Function to get the sentiment ###
GetSentiment <- function(file){
  files <- list.files("FPC_txt/")
  fileName <- glue("FPC_txt/", file, sep="") #Get first text
  fileName <- trimws(fileName) # Trim whitespaces 
  fileText <- glue(read_file(fileName)) #read the file 
  fileText <- gsub("\\$", "", fileText) 
  fileText <- gsub("log\\(", "", fileText)

  
  tokens <- data_frame(text = fileText) %>% unnest_tokens(word,text) # tokenize document
  
  tokens %>% 
    inner_join(get_sentiments("bing")) %>% 
    count(sentiment) %>% 
    spread(sentiment, n, fill = 0 ) %>% 
    mutate(sentiment = positive - negative) %>%#if error of negative, no negative words found 
    mutate(file = file)
}


sentiments <- data_frame()
files <- list.files("FPC_txt/")
### Collect all sentiments ###
for (i in files) { 
  tryCatch ({  
    sentiments <- rbind(sentiments, GetSentiment(i))
    },
  error=function(e){
    print(paste("Error: ", i))
    })
}


### Add Column to Represent Dates ###
sentiments$dates <- 1:nrow(sentiments) 

### Graph ###
ggplot(sentiments, aes(x = sentiments$dates, y=sentiments$sentiment, color=sentiments$sentiment), color="red") + 
  geom_point() + 
  scale_color_continuous(name="") +
  ggtitle("Sentimental Analysis of Forum Posts") + 
  labs(y = "Strength of Sentiment", x = "Date") +
  geom_vline(xintercept=21)+
  geom_vline(xintercept=60)+
  geom_text(aes(x=21, label="\nIncarna Crises", y=1500), color="blue", angle=90, size=3) +
  geom_text(aes(x=60, label="\nNDA Leaks",y=1500), color="blue", angle=90, size=3)

  

### Alternative to fixing the problem 

res <- read.csv("Forum Post Code/sentiment_results.csv", header = TRUE)

### Ignore Warning 
ggplot(res, aes(x = res$dates, y=res$sentiment, color=res$sentiment)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  ggtitle("Sentimental Analysis of Forum Posts") + 
  labs(y = "Strength of Sentiment", x = "Date") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  geom_vline(xintercept=58)+
  geom_text(aes(x=24, label="\nIncarna Crises", y=1500), color="blue", angle=90, size=3) +
  geom_text(aes(x=84, label="\nNDA Leaks",y=1500), color="blue", angle=90, size=3) +
  geom_text(aes(x=52, label="\nSTV",y=1500), color="blue", angle=90, size=3)
