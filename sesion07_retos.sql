CREATE DATABASE IF NOT EXISTS bedu_test;
DROP TABLE movies;
DROP TABLE ratings;
USE bedu_test;

CREATE TABLE IF NOT EXISTS users(
    id      INT PRIMARY KEY,
    gender  VARCHAR(1),
    age     INT,
    occu    INT,
    zcode   VARCHAR(20) 
);

CREATE TABLE IF NOT EXISTS movies(
    id      INT PRIMARY KEY,
    title   VARCHAR(90),
    generes VARCHAR(90)
);

CREATE TABLE IF NOT EXISTS ratings(
    user_id     INT,
    movie_id    INT ,
    rating      INT,
    dates       BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id), 
    FOREIGN KEY (movie_id) REFERENCES movies(id) 
);