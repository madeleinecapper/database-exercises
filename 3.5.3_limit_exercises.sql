USE employees;
-- #2 distinct last 10 names
SELECT DISTINCT last_name FROM employees
ORDER BY last_name DESC
LIMIT 10;
-- #3:first 5 birth dates by descending hire dates
SELECT * FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31')
AND (birth_date LIKE '%12-25')
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5;
-- #4: 10th "page" of 5 results for 90's christmas babies ordered by birthday and then hire date
SELECT * FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31')
AND (birth_date LIKE '%12-25')
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5 OFFSET 45;
