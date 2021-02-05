
library(dplyr)
library(lubridate)

data <- read.csv("./data_postwork/match.data.csv")

data <- mutate(data, sumagoles = home.score+ away.score, date = as.Date(date, "%Y-%m-%d"))

gol_mean_by_month <- data %>% group_by(year = year(date) , month = month(date)) %>%
      summarise(mean = mean(sumagoles))

gol_mean_by_month <- as.data.frame(gol_mean_by_month) %>% filter(year < 2020)
gol_mean_by_month

gol_mean_by_month <- gol_mean_by_month %>% filter(month != 6)

gol_promedio_ts <- ts(gol_mean_by_month[, 3], start = 1, freq = 10)

plot(gol_promedio_ts)