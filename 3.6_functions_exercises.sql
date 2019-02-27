USE employees;

SELECT 
    CONCAT(first_name, last_name) AS full_name
FROM
    employees
WHERE
    last_name LIKE 'E%E';
-- #3 firstnamelastname
SELECT 
    UPPER(CONCAT(first_name, last_name)) AS full_name
FROM
    employees
WHERE
    last_name LIKE 'E%E';
-- #4 days working
SELECT 
    DATEDIFF(NOW(), hire_date) AS days_employed
FROM
    employees
WHERE
    (hire_date BETWEEN '1990-01-01' AND '1999-12-31')
        AND (birth_date LIKE '%12-25')
ORDER BY birth_date ASC , hire_date DESC;
-- #5 min/max salaries
DESCRIBE salaries;
SELECT 
    MAX(salary) AS big_winner, MIN(salary) AS smol_fry
FROM
    salaries;
-- #6 
SELECT 
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
