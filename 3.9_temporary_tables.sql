USE ada_674;
-- 1: create employees_with_departments
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;
-- a: add a full_name column
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);
-- b: update the table to fill the full_name column
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);
-- c: remove the first_name and last_name columns
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
-- d: another way we could end up with this table?
/* 
Instead of going through the process stop-by-step, we can concatinate the two columns of first_anme
and last_name as their own aliased column in our initial table creation.
i.e.:
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, CONCAT(first_name, ' ',last_name) AS full_name, dept_no, dept_name
FROM employees.employees ...
*/
-- #2: Create a temporary table based on the payments table from sakila
CREATE TEMPORARY TABLE sak_payments AS
SELECT *
FROM sakila.payment;
ALTER TABLE sak_payments ADD payment_cents INT(7);
UPDATE sak_payments 
SET payment_cents = amount * 100;
ALTER TABLE sak_payments DROP COLUMN amount;
SELECT payment_cents FROM sak_payments;
ALTER TABLE sak_payments ADD amount INT(7);
UPDATE sak_payments
SET amount = payment_cents;
ALTER TABLE sak_payments DROP COLUMN payment_cents;
-- #3: Find out average pay in each department compares to overall average pay
-- In order to make this easier, use z-score for salries

CREATE TEMPORARY TABLE emp_dep_sals AS
SELECT emp_no, dept_name, salary
FROM employees.dept_emp
	JOIN employees.departments USING(dept_no)
	JOIN employees.salaries USING(emp_no);
WHERE employees.salaries.to_date > NOW()
AND employees.dept_emp.to_date > NOW();
DROP TABLE emp_dep_sals;
SELECT AVG(salary), STDDEV(salary) FROM emp_dep_sals;

SELECT 
(salary 
- (SELECT AVG(employees.salaries.salary)
	FROM employees.salaries 
	WHERE employees.salaries.to_date > NOW()))
 / (SELECT STDDEV(employees.salaries.salary) 
	FROM employees.salaries 
	WHERE employees.salaries.to_date > NOW()) 
 FROM emp_dep_sals;
 
ALTER TABLE emp_dep_sals ADD z_salaries DECIMAL(30,28);
UPDATE emp_dep_sals
SET z_salaries = (salary - (
	SELECT AVG(employees.salaries.salary)
	FROM employees.salaries ))
	WHERE employees.salaries.to_date > NOW()))
 / (SELECT STDDEV(employees.salaries.salary) 
	FROM employees.salaries); 
	WHERE employees.salaries.to_date > NOW());
 
 
 SELECT dept_name AS Department, AVG(z_salaries)
 FROM emp_dep_sals
 GROUP BY dept_name;
/* OPTION FROM LED EXAMPLE
CREATE TEMPORARY TABLE agg AS
SELECT AVG(salary) AS avg_salary, STDDEV(salary) AS stdev_salary
FROM employees.salaries
WHERE to_date > NOW();

SELECT a.dept_name, AVG(a.z_salary) AS avg_z_salary
FROM  (
SELECT d.dept_name, s.emp_no, s.salary, ((s.salary-a.avg_salary)/a.stdev_salary) AS z_salary
	FROM employees.salaries s
	JOIN agg a
	JOIN employees.dept_emp de ON s.emp_no = de.emp_no
	JOIN employees.departments d ON de.dept_no = d.dept_no
	WHERE s.to_date > NOW()
	) a
GROUP BY a.dept_name;*/
 
 
 
 
 -- 4: What is average salary for an employee based on the number of 
 -- years they have been with the company? 
 -- express your answer in terms of the z-score of salary.


