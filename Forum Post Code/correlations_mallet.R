library(ggplot2)
library(ggpmisc)
### Get Files ###
files <- read.csv("Forum Post Code/FPC_comp.csv", header=FALSE)



### Forumula for Regression Line ### 
formula <- y ~ poly(x, 12, raw=TRUE)

## Topic 0 ### 
# csm players eve game player vote ccp community highsec content null space ganking war member candidate sov groups questions
ggplot(files, aes(x = files$V1, y=files$V3, color=files$V3)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  #annotate("rect", xmin = 80, xmax = 113, ymin = 0, ymax = 0.48,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.3), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks", y=0.3), color="blue", angle=90, size=3)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.4, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.3), color = "#009E73", angle=90, size=3)+
  ggtitle("Topic: 0") + labs(y = "Probability of Topic", x = "Date")+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)


### Topic 1 ###
ggplot(files, aes(x = files$V1, y=files$V4, color=files$V4)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  #annotate("rect", xmin = 55, xmax = 80, ymin = 0, ymax = 0.22,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.10), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.10), color="blue", angle=90, size=3)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.12, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.09), color = "#009E73", angle=90, size=3)+
  ggtitle("Topic: 1") + labs(y = "Probability of Topic", x = "Date")+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=y ~ poly(x, 6, raw=TRUE),colour="red")+
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)


### Topic 2 ###
ggplot(files, aes(x = files$V1, y=files$V5, color=files$V5)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  #annotate("rect", xmin = 0, xmax = 15, ymin = 0, ymax = 0.23,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.15), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.15), color="blue", angle=90, size=3)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.3, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.2), color = "#009E73", angle=90, size=3)+
  ggtitle("Topic: 2") + labs(y = "Probability of Topic", x = "Date")+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)


### Topic 3 ###
ggplot(files, aes(x = files$V1, y=files$V6, color=files$V6)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  #annotate("rect", xmin = 65, xmax = 96, ymin = 0, ymax = 0.32,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.15), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.15), color="blue", angle=90, size=3)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.18, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.12), color = "#009E73", angle=90, size=3)+
  ggtitle("Topic: 3") + labs(y = "Probability of Topic", x = "Date")+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)
  


### Topic 4 ###
ggplot(files, aes(x = files$V1, y=files$V7, color=files$V7)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  #annotate("rect", xmin = 10, xmax = 20, ymin = 0, ymax = 0.2,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.4), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.4), color="blue", angle=90, size=3)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.5, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.3), color = "#009E73", angle=90, size=3)+
  ggtitle("Topic: 4") + labs(y = "Probability of Topic", x = "Date")+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)

### Topic 5 ###
ggplot(files, aes(x = files$V1, y=files$V8, color=files$V8)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.25), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.25), color="blue", angle=90, size=3)+
  ggtitle("Topic: 5") + labs(y = "Probability of Topic", x = "Date")+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.3, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.2), color = "#009E73", angle=90, size=3)+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)



### Topic 6 ###
ggplot(files, aes(x = files$V1, y=files$V9, color=files$V9)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  #annotate("rect", xmin = 40, xmax = 80, ymin = 0, ymax = 0.3,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.25), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.25), color="blue", angle=90, size=3)+
  ggtitle("Topic: 6") + labs(y = "Probability of Topic", x = "Date") +
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.25, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.2), color = "#009E73", angle=90, size=2)+
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)

### Topic 7 ###
ggplot(files, aes(x = files$V1, y=files$V10, color=files$V10)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  #annotate("rect", xmin = 40, xmax = 55, ymin = 0, ymax = 0.15,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.08), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.08), color="blue", angle=90, size=3)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.15, alpha =0.3)+
  geom_text(aes(x = 46, label="\n\nReplacement Period", y=0.1), color = "#009E73", angle=90, size=3)+
  ggtitle("Topic: 7") + labs(y = "Probability of Topic", x = "Date")+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)

### Topic 8 (Topics are general and so are distributions)###
ggplot(files, aes(x = files$V1, y=files$V11, color=files$V11)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.10), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.10), color="blue", angle=90, size=3)+
  ggtitle("Topic: 8") + labs(y = "Probability of Topic", x = "Date")+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.17, alpha =0.3)+
  geom_text(aes(x = 46, label="\n\nReplacement Period", y=0.1), color = "#009E73", angle=90, size=3)+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)


### Topic 9 (Topics are general amd so are the distributions) ###
ggplot(files, aes(x = files$V1, y=files$V12, color=files$V12)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.30), color="blue", angle=90,  size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.30), color="blue", angle=90,  size=3)+
  ggtitle("Topic: 9") + labs(y = "Probability of Topic", x = "Date")+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.30, alpha =0.3)+
  geom_text(aes(x = 46, label="\n\nReplacement Period", y=0.10), color = "#009E73", angle=90, size=3)+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)


### Topic 10  ###
ggplot(files, aes(x = files$V1, y=files$V13, color=files$V13)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.33, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.15), color = "#009E73", angle=90, size=3)+
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.20), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.20), color="blue", angle=90, size=3)+
  ggtitle("Topic: 10") + labs(y = "Probability of Topic", x = "Date") +
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)


### Topic 11  ###
ggplot(files, aes(x = files$V1, y=files$V14, color=files$V14)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  #annotate("rect", xmin = 40, xmax = 70, ymin = 0, ymax = 0.20,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.1), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks",y=0.1), color="blue", angle=90, size=3)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.14, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.10), color = "#009E73", angle=90, size=3)+
  ggtitle("Topic: 11") + labs(y = "Probability of Topic", x = "Date") +
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)




### Topic 12 ###
ggplot(files, aes(x = files$V1, y=files$V15, color=files$V15)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
 # annotate("rect", xmin = 25, xmax = 40, ymin = 0, ymax = 0.10,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.2), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks", y=0.2), color="blue", angle=90, size=3)+
  ggtitle("Topic: 12") + labs(y = "Probability of Topic", x = "Date") +
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.28, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.15), color = "#009E73", angle=90, size=3)+
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)

### Topic 13###
ggplot(files, aes(x = files$V1, y=files$V16, color=files$V16)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
  #annotate("rect", xmin = 0, xmax = 32, ymin = 0, ymax = 0.20,alpha = .3) +
  geom_text(aes(x=32, label="\n\nIncarna Crises", y=0.16), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks", y=0.17), color="blue", angle=90, size=3)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.2, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.15), color = "#009E73", angle=90, size=3)+
  ggtitle("Topic: 13") + labs(y = "Probability of Topic", x = "Date") +
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red") +
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula=formula)


### Topic 14 ###
ggplot(files, aes(x = files$V1, y=files$V17, color=files$V17)) + 
  geom_point() + 
  scale_color_continuous(name="") +
  geom_vline(xintercept=32)+
  geom_vline(xintercept=90)+
 # annotate("rect", xmin = 17, xmax = 33, ymin = 0, ymax = 0.24,alpha = .3) +
  geom_text(aes(x=32, label="\nIncarna Crises", y=0.1), color="blue", angle=90, size=3) +
  geom_text(aes(x=90, label="\nNDA Leaks", y=0.1), color="blue", angle=90, size=3)+
  annotate("rect", xmin = 46, xmax = 53, ymin= 0, ymax = 0.11, alpha =0.3)+
  geom_text(aes(x = 46, label="\nReplacement Period", y=0.08), color = "#009E73", angle=90, size=3)+
  ggtitle("Topic: 14") + labs(y = "Probability of Topic", x = "Date") +
  stat_smooth(method="lm", se=TRUE, fill=NA,formula=formula,colour="red")+
  stat_poly_eq(parse=T, aes(label = ..rr.label..), formula = formula)

### Get Values of data points ### 
smooth_vals = predict(loess(files$V17~files$V1,files), files$V1)
