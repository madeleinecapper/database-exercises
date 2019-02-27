USE join_example_db;
SHOW TABLES;
-- # 2: simple, left join, right join
SELECT * FROM users
JOIN roles ON users.role_id = roles.id;

SELECT * FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT * FROM users
RIGHT JOIN roles ON users.role_id = roles.id;
DESCRIBE roles;
-- #3: join with a count
SELECT COUNT(*), roles.name from roles
JOIN users ON users.role_id = roles.id
GROUP BY roles.name;

-- employees DATABASE:
USE employees;

SHOW TABLES;
DESCRIBE salaries;
DESCRIBE titles;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE departments;
DESCRIBE employees;
DESCRIBE dept_emp_latest_date;
SELECT * FROM dept_manager;
-- #2: current department managers
SELECT d.dept_name AS Department, CONCAT(e.first_name, ' ', e.last_name) AS full_name
	FROM employees as e
    JOIN dept_emp as de
		ON de.emp_no = e.emp_no
    JOIN departments AS d
		ON d.dept_no = de.dept_no
	JOIN dept_manager AS dm
		ON dm.emp_no = e.emp_no
	WHERE dm.to_date = '9999-01-01';
    
-- #3: departments currently managed by women
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS 'Manager Name'
	FROM employees AS e
    JOIN dept_emp AS de
		ON de.emp_no = e.emp_no
	JOIN departments AS d
		ON d.dept_no = de.dept_no
	JOIN dept_manager AS dm
		ON dm.emp_no = e.emp_no
	WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';

-- #4: Current titles of employees currently in Customer Service Department
SELECT t.title AS Title, COUNT(*)
	FROM titles AS t
    JOIN dept_emp AS de
		ON de.emp_no = t.emp_no
	JOIN departments AS d
		ON d.dept_no = de.dept_no
	WHERE t.to_date = '9999-01-01' AND d.dept_name = 'Customer Service'
    GROUP BY t.title;
-- #5: Current Salary of all Current Managers
SELECT d.dept_name AS Department,
CONCAT(e.first_name, ' ', e.last_name) AS full_name,
s.salary AS Current_Salary
	FROM employees as e
    JOIN dept_emp as de
		ON de.emp_no = e.emp_no
    JOIN departments AS d
		ON d.dept_no = de.dept_no
	JOIN dept_manager AS dm
		ON dm.emp_no = e.emp_no
	JOIN salaries AS s
		ON s.emp_no = dm.emp_no
	WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01';
-- #6 Number of employees in each department
SELECT de.dept_no, d.dept_name, COUNT(*) AS num_employees
	FROM dept_emp AS de
	JOIN departments AS d
		ON d.dept_no = de.dept_no
	WHERE de.to_date = '9999-01-01'
    GROUP BY de.dept_no;
-- #7 Which department has the highest average salary
SELECT d.dept_name AS 'Department Name', AVG(s.salary)
	FROM departments AS d
	JOIN dept_emp AS de
		ON de.dept_no = d.dept_no
	JOIN salaries AS s
		ON s.emp_no = de.emp_no
	WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
    GROUP BY d.dept_name
    ORDER BY AVG(s.salary) DESC
    LIMIT 1;
-- #8 Who is the highest paid employee in Marketing?
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, s.salary
	FROM departments AS d
	JOIN dept_emp AS de
		ON de.dept_no = d.dept_no
	JOIN salaries AS s
		ON s.emp_no = de.emp_no
	JOIN employees AS e
		ON e.emp_no = s.emp_no
	WHERE d.dept_name = 'Marketing'
		AND s.to_date = '9999-01-01'
        AND de.to_date = '9999-01-01'
	ORDER BY s.salary DESC
    LIMIT 1;
-- #9 Which current department manager has the highest salary
SELECT d.dept_name AS Department,
CONCAT(e.first_name, ' ', e.last_name) AS full_name,
s.salary AS Current_Salary
	FROM employees as e
    JOIN dept_emp as de
		ON de.emp_no = e.emp_no
    JOIN departments AS d
		ON d.dept_no = de.dept_no
	JOIN dept_manager AS dm
		ON dm.emp_no = e.emp_no
	JOIN salaries AS s
		ON s.emp_no = dm.emp_no
	WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
    ORDER BY Current_Salary DESC
    LIMIT 1;