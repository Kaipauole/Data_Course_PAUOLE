list.files('Data/', pattern='.csv$', recursive=T)
length(list.files('Data/', pattern = '.csv$', recursive =T))
read.csv('Data/wingspan_vs_mass.csv')
head(df, 5)
b_files <- list.files('Data/', pattern='^b', recursive=T)
for (i in b_files) {
  print(i)
  first_line <- readLines(file.path('Data', i), n = 1)
  print(first_line)
}
csv._files <- list.files('data/', pattern='.csv$', recursive=T)
for (i in csv._files){
  print(i)
  other_first_line <- readLines(file.path('data',i ), n = 1)
  print(other_first_line)
}
