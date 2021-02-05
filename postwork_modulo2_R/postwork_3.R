library(dplyr)
library(ggplot2)

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

data <- do.call(rbind, lista1)

table(data$FTHG) / dim(data)[1]

table(data$FTAG) / dim(data)[1]

table(data$FTHG, data$FTAG) / dim(data)[1]

prob_marg <- as.data.frame(table(data$FTHG) / dim(data)[1])
prob_marg$prob_away <- c(table(data$FTAG) / dim(data)[1], 0, 0)

names(prob_marg) <- c("goles", "prob_home", "prob_away")

ggplot(prob_marg, aes(x = goles, y = prob_home)) +
        geom_bar(stat = "identity", col = "black", fill = "blue") +
        ggtitle("Probabilid Marginal Equipo de Casa") +
        theme_light()

ggplot(prob_marg, aes(x = goles, y = prob_away)) +
        geom_bar(stat = "identity", col = "black", fill = "blue") +
        ggtitle("Probabilid Marginal Equipo de Visitante") +
        theme_light()

prob_conjunta <- as.data.frame(table(data$FTHG, data$FTAG) / dim(data)[1])
names(prob_conjunta) <- c("home", "away", "prob")

ggplot(prob_conjunta, aes(x = home, y = away, fill = prob)) +
        geom_tile() +
        ggtitle("Probabilidad conjunta")
