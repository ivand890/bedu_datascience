url <- "https://www.football-data.co.uk/mmz4281/2021/SP1.csv"
soccer_spain <- read.csv(url)
head(soccer_spain)
dim(soccer_spain)

home_away_gol <- soccer_spain[, c("HomeTeam", "AwayTeam", "FTHG", "FTAG")]
head(home_away_gol)

?table

table(home_away_gol$FTHG) / length(home_away_gol$FTHG) * 100

table(home_away_gol$FTAG) / length(home_away_gol$FTAG) * 100

table(home_away_gol$FTHG,
        home_away_gol$FTAG) / sum(table(home_away_gol$FTHG,
                                        home_away_gol$FTAG)) * 100
