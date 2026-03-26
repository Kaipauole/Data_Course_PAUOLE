dat = read.csv('C:/Users/kaipa/Downloads/Data_Course_PAUOLE/Data/BioLog_Plate_Data.csv')

dat_2 = dat %>% 
  pivot_longer(cols = starts_with('HR_'),
               names_to = 'Time',
               values_to = 'Absorbance')

dat_2.0 = dat_2 %>%
  mutate(Time = case_when(Time == 'Hr_24'  ~ 24,
                          Time == 'Hr_48'  ~ 48,
                          Time == 'Hr_144' ~ 144))
dat_3 = dat_2.0 %>%
  mutate(Enviroment = case_when(Sample.ID == 'Clear_Creek' ~ 'Water',
                                Sample.ID == 'Waste_Water' ~ 'Water',
                                Sample.ID == 'Soil_1' ~ 'Soil',
                                Sample.ID == 'Soil_2' ~ 'Soil',
                                TRUE ~ 'Unknown'))

dat_3 %>% 
  filter(Dilution == 0.1) %>% 
  group_by(Enviroment, Substrate, Time) %>% 
  summarise(Absorbance = mean(Absorbance), .groups = "drop") %>%  
  ggplot(aes(x = Time,
             y = Absorbance,
             color = Enviroment,
             group = interaction(Enviroment, Substrate)))+
    geom_line()+
  facet_wrap(~Substrate)+
  labs(x = 'Time',
       y = 'Absorbance',
       title = 'just dilution ==.1')+
  scale_y_continuous(breaks = c(0.0, 0.5, 1.0, 1.5, 2.0))

dat_animate = dat_2.0 %>% 
  filter(Substrate == 'Itaconic Acid') %>% 
  group_by(Sample.ID, Dilution, Time) %>% 
  summarise(mean_absorbance = mean(Absorbance), .groups = "drop") %>% 
  ggplot(aes(x = Time, 
             y = mean_absorbance,
             color = Sample.ID,
             group = Sample.ID))+
  geom_line()+
  facet_wrap(~Dilution)+
  labs(
    x = 'Time',
    y = 'mean_absorbance',
    color = "Sample ID")+
  transition_reveal(Time) +
  ease_aes('linear')
 
animation <- animate(dat_animate, nframes = 100, fps = 10) 
animation 

  

