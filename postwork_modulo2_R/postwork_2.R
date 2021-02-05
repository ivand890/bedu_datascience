library(dplyr)

url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv" # CSV 2017/2018
url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv" # CSV 2018/2019
url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv" # CSV 2019/2020

download.file(url = url1, destfile = "./data_postwork/SP1-1718.csv", mode = "wb")
download.file(url = url2, destfile = "./data_postwork/SP1-1819.csv", mode = "wb")
download.file(url = url3, destfile = "./data_postwork/SP1-1920.csv", mode = "wb")

lista <- lapply(c("./data_postwork/SP1-1718.csv",
                    "./data_postwork/SP1-1819.csv",
                    "./data_postwork/SP1-1920.csv"), read.csv)

lista1 <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

lista1 <- lapply(lista1, mutate, Date = as.Date(Date, "%d/%m/%y"))

lapply(lista1, str)

data <- do.call(rbind, lista1)

summary(data)