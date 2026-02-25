df_covid = read.csv('cleaned_covid_data.csv')
A_states = df_covid %>% 
  filter(grepl('^A',df_covid$Province_State))
A_states %>% 
  ggplot(aes(x = Last_Update,
             y = Deaths)) +
  geom_point() + 
  geom_smooth(method = 'loess', se = F, color = 'lightorange') +
  facet_wrap(~ Province_State, scales = 'free')
state_max_fatality_rate = df_covid %>% 
  filter(!is.na(Case_Fatality_Ratio)) %>% 
  group_by(Province_State) %>% 
  summarise(Maximun_Fatality_Ratio = max(Case_Fatality_Ratio)) %>% 
  arrange(desc(Maximun_Fatality_Ratio))
state_max_fatality_rate %>% 
  mutate(Province_State = factor(Province_State, levels = Province_State)) %>% 
  ggplot(aes(x = Province_State,
             y = Maximun_Fatality_Ratio)) +
    geom_bar(stat = 'identity', position = 'dodge') +
  labs(title = 'Max Fatalities ratio by state',
       x = 'State',
       y = 'Max Fatality ratio') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, color = 'darkblue'))
df_covid %>% 
  group_by(Last_Update) %>% 
  summarise(Total_Death = sum(Deaths)) %>% 
  arrange(Last_Update) %>% 
  ggplot(aes(x = Last_Update,
             y = Total_Death)) +
  geom_point() +
  labs(title = 'Total Deaths in US',
       x = 'Time',
       y = 'Deaths') +
  geom_point() +
  labs(title = 'Total Deaths in US',
       x = 'Time',
       y = 'Deaths')
  

  

