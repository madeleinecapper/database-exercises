SHOW DATABASES;
-- #2:
USE albums_db;
SHOW TABLES;
-- #3:
DESCRIBE albums;
SELECT * FROM albums;
-- #4:
SELECT name FROM albums WHERE artist = 'Pink Floyd';
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';
SELECT genre FROM albums WHERE name = 'Nevermind';
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;
SELECT name AS 'Lower Selling Albums (Less than 20 mil)'
FROM albums
WHERE sales < 20.0;
SELECT name AS 'Rock Albums' FROM albums
WHERE genre = 'Rock';
-- queries require exact string matches.  If we wanted to include hard and progressive rock albums we could write the following:
SELECT name AS 'Inclusive Rock Albums' FROM albums
WHERE genre = 'Rock' OR genre = 'Hard rock' OR genre = 'Progressive rock';
SELECT name AS 'ALL ROCK PLS', genre, release_date FROM albums
WHERE genre LIKE '%rock%';