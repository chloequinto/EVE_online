library(tidytext)
library(tidyverse)
library(dplyr)
library(readr)
library(glue)
library(stringr)
library(ggplot2)
library(ggpmisc)

## uppress Warnings 
options(warn=-1)

## function to remove unneccessary parenthesis and brackets ####
Remove_SC <- function (file){ 
  files <- list.files("FPC_txt/")
  fileName <- glue("FPC_txt/", file, sep="") #Get first text
  txt_file  <- readLines(fileName)
  fileText  <- gsub("log\\(", "", txt_file)
  fileText <- gsub("log\\)", "", fileText)
  fileText <- gsub('[[:punct:]]', '', fileText)
  writeLines(fileText, con = fileName)
  
  }

### Function to get the sentiment ###
GetSentiment <- function(file){
  files <- list.files("FPC_txt/")
  fileName <- glue("FPC_txt/", file, sep="") #Get first text
  fileName <- trimws(fileName) # Trim whitespaces 
  fileText <- glue(read_file(fileName)) #read the file 
  fileText <- gsub("log\\(", "", fileText)
  fileText <- gsub("log\\)", "", fileText)
  fileText <- gsub("\\[|\\]", "", fileText)
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
    Remove_SC(i)
    sentiments <- rbind(sentiments, GetSentiment(i))
    },
  error=function(e){
    print(paste("Error: ", i))
    })
}



### Add Column to Represent Dates ###
sentiments$dates <- 1:nrow(sentiments) 


### Polynomial Formula ###
formula <- y ~ poly(x, 6, raw=TRUE)

### Graph ###
ggplot(sentiments, aes(x = sentiments$dates, y=sentiments$sentiment, color=sentiments$sentiment), color="red") + 
  geom_point() + 
  scale_color_continuous(name="") +
  ggtitle("Sentiment Analysis of Forum Posts") + 
  labs(y = "Strength of Sentiment", x = "Date") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  annotate("rect", xmin = 46, xmax = 53, ymin= -500, ymax = 5000, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=3500), color = "#009E73", angle=90, size=3)+
  geom_text(aes(x=32, label="\nIncarna Crises", y=3500), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=3500), color="blue", angle=90, size=3)+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)

### early regulars left, while nearly all the "regulars" who remained,
###largely began posting regularly during and after the crisis
###when the prior group had left


  

