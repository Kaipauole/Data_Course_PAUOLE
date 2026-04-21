library(tidyverse)
library(ggplot2)
unicef_u5mr = read.csv("unicef-u5mr.csv")
head(unicef_u5mr)
str(unicef_u5mr)

child_deaths = unicef_u5mr %>% 
  pivot_longer(cols = starts_with("U5MR"),
               names_to = "Year",
               values_to = "U5MR")

child_deaths_2 = child_deaths %>% 
  mutate(Year = as.numeric(sub("U5MR\\.", "", Year))) %>% 
  view()

child_deaths_2 %>% 
  filter(!is.na(U5MR)) %>% 
  group_by(Continent, Year) %>% 
  ggplot(aes(x = Year,
             y = U5MR))+
  geom_path(size = 0.6)+
  facet_wrap(~ Continent)

ggsave("PAUOLE_Plot_1.png", width = 6, height = 4, dpi = 300)
       
       child_deaths_2 %>% 
         filter(!is.na(U5MR)) %>% 
         group_by(Continent, Year) %>% 
         summarise(mean_U5MR = mean(U5MR)) %>% 
         ggplot(aes(x = Year,
                    y = mean_U5MR,
                    color = Continent))+
         geom_path(size = 2)
       
       ggsave("PAUOLE_Plot_2.png", width = 6, height = 4, dpi = 300)
       
       library(easystats)
       
       
       mod1 = glm(U5MR ~ Year, data = child_deaths_2, family = gaussian())
       mod2 = glm(U5MR ~ Year + Continent, data = child_deaths_2, family = gaussian())
       mod3 = glm(U5MR ~ Year * Continent, data = child_deaths_2, family = gaussian())
       
       compare_performance(mod1, mod2, mod3)
       #Mod3 is the best with a R2 of 0.640 and a low RMSE at 49.933
       
       child_deaths_2$pred1 = predict(mod1, child_deaths_2)
       child_deaths_2$pred2 = predict(mod2, child_deaths_2)
       child_deaths_2$pred3 = predict(mod3, child_deaths_2)
       
       child_deaths_2 %>% 
         pivot_longer(starts_with('pred')) %>% 
         ggplot(aes(x = Year, y = mean_U5MR, color = Continent)) +
         geom_point(aes(y = value)) +
         facet_wrap(~ name)+
         labs(x = 'Year',
              y = 'Predidcted U5MR')