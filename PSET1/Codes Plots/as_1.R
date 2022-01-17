library(ggplot2)
library(tidyverse)
library(ggthemes)
count_2018 = read.csv("C:/Users/lenovo/Documents/BSE/SEM_2/text_mining/as_1/counts2018.csv")
week_2018 = aggregate(count_2018[4], by = count_2018[2], sum)

count_2017 = read.csv("C:/Users/lenovo/Documents/BSE/SEM_2/text_mining/as_1/counts2017.csv")
week_2017 = aggregate(count_2017[4], by = count_2017[2], sum)

week_2018$day_count_2017 = week_2017$day_count
week_2018$start = gsub("T.*", "", week_2018$start)
week_2018$day =  format(as.Date(week_2018$start), "%d.%m")


week_2018 %>%
  ggplot(aes(x = day, group = 1)) +
  geom_line(aes(y = day_count, color = '2018'), size = 1.25) +
  geom_line(aes(y = day_count_2017, color = '2017'), size = 1.25) + 
  labs(x = 'Day',
        y = 'Activity Count',
        color = 'Year') + 
  geom_vline(xintercept = '27.05', linetype = 'dashed', size = 1.25, colour = 'gray45') + 
  geom_text(aes(x='27.05', label="\nElection 1st Round 2018", y=900), angle=90, size= 5, colour= 'gray45') +
  theme_hc()

