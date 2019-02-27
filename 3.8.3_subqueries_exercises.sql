USE employees;
SHOW TABLES;
DESCRIBE employees;
DESCRIBE current_dept_emp;
-- #1 Find all the employees with the same hire date as employee 101010 using a sub-query.
SELECT first_name, last_name, emp_no
FROM employees
WHERE hire_date IN(
	SELECT hire_date
    FROM employees
    WHERE emp_no = '101010');
-- #2 Find all the titles held by all employees with the first name Aamod.
SELECT title, COUNT(*)
FROM titles
WHERE emp_no IN(
	SELECT emp_no
    FROM employees
	WHERE first_name = 'Aamod')
GROUP BY title;
-- #3 How many people in the employees table are no longer working for the company?
SELECT COUNT(*) AS nonactive
FROM employees
WHERE emp_no IN(
	SELECT emp_no
    FROM titles
    WHERE to_date != '9999-01-01');
-- #4 Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees
WHERE gender = 'F' 
AND emp_no IN(
	SELECT emp_no
    FROM dept_manager
    WHERE to_date = '9999-01-01');
-- #5 Employees that currently have a higher than average salary
SELECT e.first_name, e.last_name, s.salary
FROM employees AS e
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE s.to_date = '9999-01-01' AND
s.salary > (
SELECT AVG(salary) FROM salaries);
-- #6 
SELECT (COUNT(*) / (SELECT COUNT(*) FROM salaries WHERE to_date = '9999-01-01') * 100) AS percent
FROM salaries
WHERE to_date = '9999-01-01' AND
salary >= (SELECT MAX(salary) - STDDEV(salary) FROM salaries);
-- y u no run -_-
SELECT MAX(salary) - STDDEV(salary) FROM salaries;
SELECT MAX(salary) FROM salaries;
-- Bonus #1: Find all department names that currently have female managers
SELECT dept_name
FROM departments
WHERE dept_no IN(
	SELECT dept_no
    FROM dept_emp
    WHERE to_date = '9999-01-01' 
    AND emp_no IN(
		SELECT emp_no
        FROM dept_manager
        WHERE to_date = '9999-01-01' 
        AND emp_no IN(
			SELECT emp_no FROM employees
			WHERE emp_no IN(
				SELECT emp_no
				FROM employees
				WHERE gender = 'F'))));

-- BONUS #2 First and last name of employee with highest salary
SELECT first_name, last_name
FROM employees
WHERE emp_no = (
	SELECT emp_no
    FROM salaries
    WHERE to_date = '9999-01-01'
    ORDER BY salary DESC
    LIMIT 1);
    
-- BONUS #3 Find department name that the employee with highest salary works in
SELECT dept_name 
FROM departments
WHERE dept_no IN(
	SELECT dept_no 
    FROM dept_emp
    WHERE to_date = '9999-01-01' 
    AND emp_no =(
		SELECT emp_no
        FROM salaries
        WHERE to_date = '9999-01-01'
        ORDER BY salary DESC
        LIMIT 1));
