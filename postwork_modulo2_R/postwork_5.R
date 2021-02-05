library(dplyr)
library(ggplot2)
library(fbRanks)

url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv" # CSV 2017/2018
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv" # CSV 2018/2019
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv" # CSV 2019/2020

list.url <- list(url1, url2, url3)

lista <- lapply(list.url, read.csv) # Guardamos los archivos en lista

lista1 <- lapply(lista, select, date = Date, home.team = HomeTeam,
                    home.score = FTHG, away.team = AwayTeam,  away.score = FTAG)
lista1 <- lapply(lista1, mutate, date = as.Date(date, "%d/%m/%y"))
SmallData <- do.call(rbind, lista1)

write.csv(SmallData, file = "./data_postwork/soccer.csv", row.names = FALSE)

listasoccer <- create.fbRanks.dataframes("./data_postwork/soccer.csv")

listasoccer$scores
listasoccer$teams

rank.teams(scores = listasoccer$scores, teams = listasoccer$teams)

dates <- unique(SmallData$date)
n <- length(dates)

ranking <- rank.teams(scores = listasoccer$scores, teams = listasoccer$teams,
                        max.date = dates[n - 1], min.date = min(dates))

predict(ranking, min.date = dates[n], max.date = dates[n])