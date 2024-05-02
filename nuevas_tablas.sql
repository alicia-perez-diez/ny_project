-- Creamos la estructura para el primer dataset de las reviews de airbnb
CREATE DATABASE IF NOT EXISTS ny_project;
USE ny_project;
DROP TABLE IF EXISTS airbnb;
CREATE TABLE airbnb (
id INT PRIMARY KEY,
barrio VARCHAR(50),
precio INT,
numero_de_reviews INT,
ultima_review VARCHAR(10)
);

-- Creamos la estructura para el segundo dataset de los crímenes en NY
DROP TABLE IF EXISTS crimenes;
CREATE TABLE crimenes (
id INT AUTO_INCREMENT PRIMARY KEY,
barrio VARCHAR(50),
numero_de_delitos INT,
numero_de_faltas INT,
numero_de_violaciones INT,
diferencia_2017 INT,
diferencia_2018 INT
);