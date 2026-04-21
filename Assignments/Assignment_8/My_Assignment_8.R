install.packages('modelr')
install.packages('easystats')
install.packages('broom')
install.packages('fitdistrplus')
library(modelr)
library(easystats)
library(broom)
library(fitdistrplus)
library(tidyverse)
library(ggplot2)
library(performance)

Mushrooms = read.csv("mushroom_growth.csv")
Mushrooms %>% 
  ggplot(aes(x = Temperature,
             y = GrowthRate))+
  geom_point()+
  geom_smooth(method = 'lm')+
  theme_minimal()

Mushrooms %>%
  ggplot(aes(x = GrowthRate,
             y = Nitrogen))+
  geom_point()+
  geom_smooth(method = 'lm')+
  theme_minimal()

Mushrooms %>% 
  ggplot(aes(x = Light,
             y = GrowthRate))+
  geom_point()+
  geom_smooth(method = 'lm')+
  theme_minimal()

Mushrooms %>% 
  ggplot(aes(x = Humidity,
             y = GrowthRate))+
  geom_boxplot()+
  theme_minimal()

mod1 = lm(GrowthRate ~ Temperature, dat = Mushrooms)
mod2 = lm(GrowthRate ~ Temperature + Light, dat = Mushrooms) 
mod3 = lm(GrowthRate ~ Temperature + Light + Nitrogen, dat = Mushrooms)
mod4 = lm(GrowthRate ~ Light + Nitrogen, dat = Mushrooms)
mod5 = lm(GrowthRate ~ Temperature + Light, dat = Mushrooms)
mod6 = mod3 = lm(GrowthRate ~ Temperature + Light + Nitrogen + Humidity, dat = Mushrooms)


performance(mod1)
performance(mod2)
performance(mod3)
performance(mod4)
performance(mod5)
performance(mod6)

predict(mod3, Best = Mushrooms)
Predicited_growth = predict(mod3, newdata = Mushrooms)

Mushrooms %>% 
  ggplot(aes(y = Nitrogen))+
  geom_point(aes(x = GrowthRate,
             color = 'Actual'))+
  geom_point(aes(x = Predicited_growth,
             color = 'Predicited'))+
  theme_minimal()

Mushrooms %>% 
  ggplot(aes(y = Temperature))+
  geom_point(aes(x = GrowthRate,
                 color = 'Actual'))+
  geom_point(aes(x = Predicited_growth,
                 color = 'Predicited'))+
  theme_minimal()

Mushrooms %>% 
  ggplot(aes(y = Light))+
  geom_point(aes(x = GrowthRate,
                 color = 'Actual'))+
  geom_point(aes(x = Predicited_growth,
                 color = 'Predicited'))+
  theme_minimal()

list.files()

