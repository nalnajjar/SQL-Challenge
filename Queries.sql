----DATA ENGINEERING----

--CSV Imports--

--table drops
drop table departments;
drop table dept_emp;
drop table dept_manager;
drop table employees;
drop table salaries;
drop table titles;

--table construction
create table departments (
	dept_no VARCHAR (30),
	dept_name VARCHAR (30),
	constraint "prky_departments" primary key (dept_no)
);

create table dept_emp (
	emp_no INT,
	dept_no VARCHAR (30),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no)
);

create table dept_manager (
	dept_no VARCHAR (30),
	emp_no INT,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no)
);

create table employees (
	emp_no INT,
	birth_date DATE NOT NULL,
	first_name VARCHAR (30),
	last_name VARCHAR (30),
	gender VARCHAR (10),
	hire_date DATE,
	constraint "prky_employees" primary key (emp_no)
);

create table salaries (
	emp_no INT,
	salary INT,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	foreign key (emp_no) references employees(emp_no)
);

create table titles (
	emp_no INT,
	title VARCHAR (30),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	foreign key (emp_no) references employees (emp_no)
);

----DATA ANALYSIS----

--List Employee Details--

select employees.emp_no, 
	employees.last_name,
	employees.first_name,
	employees.gender,
	salaries.salary
from employees
inner join salaries on
employees.emp_no = salaries.emp_no;

--Employees Hired in 1986--

SELECT employees.emp_no, 
	employees.last_name,
	employees.first_name,
	employees.hire_date
from employees
WHERE extract(year from hire_date) = '1986'; 

--Department Managers--

select employees.emp_no, 
	employees.last_name,
	employees.first_name,
	dept_manager.from_date,
	dept_manager.to_date,
	dept_manager.dept_no,
	departments.dept_name
from employees
inner join dept_manager on
employees.emp_no = dept_manager.emp_no
inner join departments on
dept_manager.dept_no = departments.dept_no;

--Employee Departments--

select employees.emp_no, 
	employees.last_name,
	employees.first_name,
	departments.dept_name
from employees
inner join dept_emp on
employees.emp_no = dept_emp.emp_no
inner join departments on
dept_emp.dept_no = departments.dept_no;

--Employees named Hercules and last names start with B--

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name like 'B%';

--Sales Department Employees--

select employees.emp_no, 
	employees.last_name,
	employees.first_name,
	departments.dept_name
from employees
inner join dept_emp on
employees.emp_no = dept_emp.emp_no
inner join departments on
dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales';

--Sales and Development Department Employees--

select employees.emp_no, 
	employees.last_name,
	employees.first_name,
	departments.dept_name
from employees
inner join dept_emp on
employees.emp_no = dept_emp.emp_no
inner join departments on
dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales'

UNION

select employees.emp_no, 
	employees.last_name,
	employees.first_name,
	departments.dept_name
from employees
inner join dept_emp on
employees.emp_no = dept_emp.emp_no
inner join departments on
dept_emp.dept_no = departments.dept_no
where dept_name = 'Development';

--Last Name Frequency--

SELECT last_name, COUNT(last_name) AS "Count" FROM employees
Group By last_name
Order By "Count" DESC;












