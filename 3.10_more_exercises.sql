USE world;
SHOW TABLES;
DESCRIBE city;
DESCRIBE country;
DESCRIBE countrylanguage;
-- What Languages are spoken in Santa Monica?
SELECT Language, Percentage 
FROM countrylanguage
WHERE CountryCode = (
	SELECT Code 
	FROM country
	WHERE Code = (
		SELECT CountryCode
		FROM city
		WHERE Name = 'Santa Monica'))
ORDER BY Percentage;
-- How many different countries are in each region?
SELECT Region, COUNT(*) AS num_countries
FROM country
GROUP BY Region
ORDER BY COUNT(*);
-- What is the population for each region?
SELECT Region, SUM(Population)
FROM country
GROUP BY Region
ORDER BY SUM(Population) DESC;
-- What is the population for each continent?
SELECT Continent, SUM(Population)
FROM country
GROUP BY Continent
ORDER BY SUM(Population) DESC;
-- What is average life expectancy globally?
SELECT AVG(LifeExpectancy) FROM country;
-- What is the average life expectancy for each region, each continent?
SELECT Continent, AVG(LifeExpectancy)
FROM country
GROUP BY Continent
ORDER BY AVG(LifeExpectancy);

SELECT Region, AVG(LifeExpectancy)
FROM country
GROUP BY Region
ORDER BY AVG(LifeExpectancy);

USE sakila;
SHOW TABLES;
DESCRIBE payment;
-- #1: FIRST NAME last name
SELECT UPPER(first_name), LOWER(last_name) FROM actor;
-- #2: ID, first name, last name allllllll jooooee
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';
-- #3: Actors whose last ends in -gen
SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%gen';
-- #4: last names contain li, ordered by last name then first
SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;
-- #5: IN: display the country_id and country columns for Afghanistan, Bangladesh, China
DESCRIBE country;
SELECT country_id, country FROM country
WHERE country IN('Afghanistan', 'Bangladesh', 'China');
-- #6: last names of all actors, and how many have the same last name
SELECT COUNT(*), last_name FROM actor
GROUP BY last_name;
/*#7: last names of actors and the number of actors that have said name,
 but only for names that are shared by at least two actors*/
SELECT COUNT(*), last_name FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;
-- 8 huh

-- 9 display first and last names, as well as address
