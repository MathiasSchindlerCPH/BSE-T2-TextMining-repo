# ============================================================================
# Date:    January 17, 2022
# Course:  Text Mining: Models and Algorithms
# Master:  Data Science for Decision Making 
#          
# Group: - Cristina Susanu
#        - Mathias Schindler
#        - Simón Caicedo
#        - Bjorn Komander
#
# Databases used: - Exercise2.csv
#                 - 
#                 - 
#          
# This program creates different plots for visualizing some exercises in PS1.
#
# Output: - 
# 
#
# ============================================================================

#---- Packages to be used ----
library(ggplot2)
library(scales)
library(tidyverse)

#---- Read Data ----
ex2<-read.csv("Data/Exercise2.csv")

#----- Preprocessing data -----

# Create a database with tweets per days
ex2_day<-ex2[,c(1,3)]
ex2_day$start<-substr(ex2_day$start, 1, 10)
ex2_day<-ex2_day %>%
  group_by(start) %>% 
  mutate(day_count = sum(hour_count)) %>% 
  distinct(start, .keep_all = T) %>% 
  select(start, day_count)

ex2_day$start<-as.Date(ex2_day$start)

# Create a database for counting tweets per hour
ex2_hour<-ex2[,c(1,3)]
ex2_hour$start<-substr(ex2_hour$start, 12, 16)


ex2_hour<-ex2_hour %>%
  group_by(start) %>% 
  mutate(hour_count = sum(hour_count)) %>% 
  distinct(start, .keep_all = T) %>% 
  select(start, hour_count)


#----- Plot tweets per day ----
day_counts_plot<-ggplot(data=ex2_day) +  
  geom_line(aes(start,day_count), color="#121e2a", size=0.3) + 
  ylab("Number of tweets") + 
  xlab("Date")+
  ggtitle("Number of tweets for some hashtags related to the Black Lives Matter movement", 
          subtitle = "From May 25, 2020 to Dec 31, 2020")+
  theme_bw()+ 
  theme(strip.background=element_blank(),
        strip.text=element_text(size=10),
        title=element_text(size=10),
        panel.border=element_blank(),
        panel.grid.major=element_line(size=0.4),
        panel.grid.minor = element_line(size = 0.4),
        axis.text.y = element_text(size=7),
        axis.text.x = element_text(size=10),
        plot.title=element_text(hjust=0.5, face="bold"),
        plot.subtitle=element_text(hjust=0.5, face="italic")) +
  scale_x_date(breaks = "1 month", labels=date_format("%b"))

day_counts_plot


ggsave("LinePlotExercise2.png", width = 11, height = 6)


#----- Plot tweets per hour ----
hour_counts_plot<-ggplot(data=ex2_hour) +  
  geom_col(aes(start,hour_count), color="#1DA1F2", fill="#1DA1F2") + 
  ylab("Number of tweets") + 
  xlab("Hour")+
  ggtitle("Number of tweets per hour for some hashtags related to the Black Lives Matter movement", 
          subtitle = "From May 25, 2020 to Dec 31, 2020")+
  theme_bw()+ 
  theme(strip.background=element_blank(),
        strip.text=element_text(size=10),
        title=element_text(size=10),
        panel.border=element_blank(),
        panel.grid.major=element_line(size=0.4),
        panel.grid.minor = element_line(size = 0.4),
        axis.text.y = element_text(size=7),
        axis.text.x = element_text(size=10),
        plot.title=element_text(hjust=0.5, face="bold"),
        plot.subtitle=element_text(hjust=0.5, face="italic"))+
  scale_y_continuous(labels = comma)

hour_counts_plot

ggsave("BarPlotExercise2.png", width = 13, height = 6)
