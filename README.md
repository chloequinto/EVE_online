# EVE_online

## Overview
### Previous Work
- [X] Sentimental Analysis for whole data set
- [X] Correlation between specific topics and forum posts with time lag
  - [ ] Run Topic Model on combined data set, qualitative reasoning for number of topics, evaluate correlation for matched topics between both, use sentiments for specific identified stories to compare before/after update
  - [ ] Run Topic Model on each data set, qualitative reasoning for number of topics, match topics between dev blogs and forum posts, evaluate the correlation for matched topics, use sentiments for specific identified stories to compare before/after update
  - [ ] Run Topic Model on combined data set, quantitative calculation on number of topics, evaluate the correlation for matched topics

### Current Work
- [X] Learned topics from forum posts and used that to check the prevalence of the same topics in dev blogs
- [X] Learned topics from dev blogs and compare the word distributions of the two sets of topics

### Approach
- [ ] Learned topics from dev blogs and used that to check the prevalence of the same topics in the forum posts
- [ ] Correlation Tokenization to see if there's a correlation to the words said in the dev blogs and the words said in forum posts


## Contents
* one - initial text files
* reserach_18_caps_folder - result folder for texts separated by capitalized sentences
* research_18_spaces - result folder for texts separated if a texts
file contains two consecutive blank lines
* research_18_less_than_5 - result folder for texts separated by sentences that is less than 5 words
* research_eve_online - contains py file to segment the texts

## Legend for Dev_Blog_Sections
* dev_blog_sectioned_0: 0-19
* dev_blog_sectioned_1: 20-45
* dev_blog_sectioned_2: 46-80
* dev_blog_sectioned_3: 81-90
* dev_blog_sectioned_4: 91-116
* dev_blog_sectioned_5: 117-125
