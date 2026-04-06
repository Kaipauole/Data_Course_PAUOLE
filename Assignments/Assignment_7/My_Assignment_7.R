Utah_religins = read.csv("C:/Users/kaipa/Downloads/Data_Course_PAUOLE/Assignments/Assignment_7/Utah_Religions_by_County.csv")
library('easystats')

Utah_religinsss = Utah_religins %>% 
  pivot_longer(cols = -c(County, Pop_2010), 
               names_to = 'Religion',
               values_to = 'Proportion')

utah_religinss = Utah_religinsss %>% 
  rename('Population 2010' = Pop_2010)

utah_religinss %>% 
  ggplot(aes(x = Religion, 
             y = Proportion))+
  geom_bar(stat = 'identity')+
  theme(axis.text.x = element_text(angle = 90))
  
utah_religinss %>% 
  ggplot(aes(x = `Population 2010`, 
             y = Proportion)) +
  geom_point() +
  facet_wrap(~ Religion)+
  theme(axis.text.x = element_text(angle = 90))
# This is the porportion of these religions with LDS and Religious being the largest 

utah_religinss %>% 
  ggplot(aes(x = `Population 2010`, 
             y = Proportion)) +
  geom_point() +
  geom_smooth(method = "lm")+
  facet_wrap(~ County)+
  theme(axis.text.x = element_text(angle = 90))
#Based on this it is kinda hard to tell if the population contributes to the proportion
#of a specific religion. They all seem to have a relativly high proportion despite
#how large the population is. 

utah_religinss %>% 
  ggplot(aes(x = `Population 2010`, 
             y = Proportion,
             color = Religion)) +
  geom_point() +
  geom_smooth(method = "lm")+
  facet_wrap(~ County)+
  theme(axis.text.x = element_text(angle = 90))
#The porpotion of any specific religion does not seem to corrilate with the porportion
#of non religious people. However, the porpotion of religious people in a population
# does seem to mean there are less or more non religious peole. 

