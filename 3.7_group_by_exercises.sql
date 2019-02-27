USE employees;
DESCRIBE titles;
-- #2:
SELECT title from titles GROUP BY title;
-- alternatively: SELECT DISTINCT title FROM titles;
-- #3:
SELECT last_name FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;
-- #4: unique combinations of first&last
SELECT last_name, first_name FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name, first_name;
-- #5: Unique names Q and Not u
SELECT last_name FROM employees
WHERE last_name LIKE '%q%'
AND !(last_name LIKE '%qu%')
GROUP BY last_name;
-- #6: count & order by
SELECT last_name, COUNT(*)
FROM employees
WHERE last_name LIKE '%q%'
AND !(last_name LIKE '%qu%')
GROUP BY last_name
ORDER BY COUNT(*) ASC;
-- least popular last name
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY COUNT(*) ASC;
-- most popular last namne
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC;
-- least popular unique name
SELECT first_name, last_name, COUNT(*)
FROM employees
GROUP BY first_name, last_name
ORDER BY COUNT(*) ASC;
-- most popular unique name
SELECT first_name, last_name, COUNT(*)
FROM employees
GROUP BY first_name, last_name
ORDER BY COUNT(*) DESC;

-- #7: COUNT(*) & Group by for gender
SELECT COUNT(gender), gender FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender
ORDER BY COUNT(gender) DESC;
-- #8: Unique Usernames
SELECT 
	DISTINCT
    LOWER(CONCAT(SUBSTR(first_name, 1, 1),
	SUBSTR(last_name, - 4, 4),
	'_',
	SUBSTR(birth_date, 6, 2),
	SUBSTR(birth_date, 3, 2))) 
    AS username,
    first_name,
    last_name
FROM
    employees;
-- 6 usernames have doppelgangers