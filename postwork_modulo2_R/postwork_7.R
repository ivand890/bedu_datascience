library(mongolite)
soccer <- read.csv("./data_postwork/data.csv")

database <- data.table::fread("./data_postwork/data.csv")

my_collection <- mongo(collection = "database", db = "match_games")

my_collection$count()

my_collection$find()

my_collection$find('{"HomeTeam":"Real Madrid"}')
my_collection$find('{"HomeTeam":"Real Madrid", "Date": "2015-12-20"}')

my_collection$find('{"HomeTeam":"Real Madrid", "Date": "2020-06-18"}')

rm(my_collection)

rm(my_collection)
gc()