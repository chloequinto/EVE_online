# Forum Posts Analysis
An analysis on the forum posts for EVE online.

## Motivation
Previous work included checking if Forum Posts influence the prevalence of the same topics in the dev blogs. Also, a comparison of word distributions were done on the Developer Blog and the Forum Posts


## Installation 
Install R 

```Terminal 
brew install r 
```

Install Rstudio

```Terminal 
brew cask install --apendir=/Applications rstudio
```
Install Mallet 
```Git
git clone https://github.com/mimno/Mallet.git
```

Install Apache Ant 
```Terminal 
brew install ant 
```


### Usage 
Instead of the LDA library in Rstuio, Mallet (java package) was used. Run the following commands 

To convert text file into mallets input run:
```java 
./bin/mallet import-dir --input File/Directory  --output FPC.mallet --keep-sequence --remove-stopwords
```

To Train Topics: 
```java
./bin/mallet train-topics  --input FPC.mallet --num-topics 15 --num-iterations 330 --optimize-interval 15 --output-state topic-state.gz --output-topic-keys FPC_keys.txt --output-doc-topics FPC_comp.txt
```
(Number of topics, iterations, and optimize intervals vary depending on preference)

Topic Models and Sentimental Analysis 
1. To run topic model analysis, run correlations_mallet.R. 
2. To run sentiment analysis, run sentiment.R

### Bugs
- [ ] Sentiment.R has issues with reading some files 
