CREATE TABLE employees (
EmployeeID SERIAL PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
Department VARCHAR(50),
Salary DECIMAL(10,2) DEFAULT 20000.00 CHECK(Salary >= 0),
HireDate DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO Employees (FirstName, LastName, Email, Department, Salary, HireDate)
VALUES
('Amit',   'Kumar',   'amit.kumar@gmail.com',   'HR',       28000.00, '2025-06-10'),
('Sita',   'Rai',     'sita.rai@gmail.com',     'Finance',  40000.00, '2024-12-01'),
('Rohan',  'Singh',   'rohan.singh@gmail.com',  'IT',       32000.00, '2025-08-15'),
('Nisha',  'Shrestha','nisha.shrestha@gmail.com','Admin',   25000.00, '2025-01-20'),
('Kiran',  'Thapa',   'kiran.thapa@gmail.com',  'IT',       45000.00, '2023-09-05'),
('Pooja',  'Joshi',   'pooja.joshi@gmail.com',  'Sales',    30000.00, '2025-11-12'),
('Raj',    'Verma',   'raj.verma@gmail.com',    'Marketing',27000.00, '2024-07-28'),
('Mina',   'Gurung',  'mina.gurung@gmail.com',  'Finance',  38000.00, '2024-03-14'),
('Deepak', 'Yadav',   'deepak.yadav@gmail.com', 'HR',       29000.00, '2023-12-30'),
('Anita',  'Bhandari','anita.bhandari@gmail.com','IT',      50000.00, '2022-05-18');


-- Show all employees
SELECT * FROM employees;

-- Show only IT department employees
SELECT * FROM employees
WHERE Department ='IT';

-- Show employees with salary greater than 30000
SELECT * FROM employees
WHERE Salary > 30000;

-- Order employees by salary (high to low)
SELECT * FROM employees
ORDER BY Salary DESC;

-- Find employees whose first name starts with “A”
SELECT * FROM employees
WHERE FirstName LIKE 'A%';

-- Order employee name(A-Z)
SELECT
FirstName,
LastName,
Email,
Department,
Salary,
HireDate
FROM employees
ORDER BY FirstName ASC;

-- Find the totalsalary of employees by department wise (high - low)
SELECT
Department,
SUM(Salary) as ToatalSalary
FROM employees
GROUP BY Department
ORDER BY ToatalSalary DESC;

-- Count employees in each department
SELECT
Department,
COUNT(EmployeeID) as Counts
FROM employees
GROUP BY Department;

-- Find average salary in each department
SELECT
ROUND(AVG(Salary),2) as AvgSalary
FROM employees;

-- Find the highest paid employee
SELECT *
FROM employees
WHERE Salary = (SELECT MAX(Salary) FROM employees);


-- List employees hired in year 2025
SELECT *
FROM employees
WHERE EXTRACT(Year FROM HireDate) = 2025;

-- Show departments having more than 2 employees
SELECT
Department,
COUNT(EmployeeID) as Counts
FROM employees
GROUP BY Department
HAVING COUNT(EmployeeID) > 2;

-- Rank employees by salary (overall)
SELECT 
EmployeeID,
FirstName,
LastName,
Salary,
RANK() OVER(ORDER BY Salary DESC) as Rank
FROM employees;


-- Rank employees by salary inside each department
SELECT
EmployeeID,
FirstName,
lastName,
Department,
Salary,
DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS dept_rank
FROM employees;


-- Show salary difference from department average salary
SELECT
EmployeeID,
FirstName,
lastName,
Department,
Salary,
ROUND(AVG(Salary) OVER (PARTITION BY Department),2) AS Avg_salary,
ROUND(Salary - (AVG(Salary) OVER (PARTITION BY Department)),2)as Salary_Diff
FROM employees;

-- Show running total of salary ordered by hire date
SELECT 
EmployeeID,
FirstName,
LastName,
HireDate,
Salary,
SUM(Salary) OVER(ORDER BY HireDate) as Running_total
FROM employees;

-- Show previous and next employee salary based on hire date
SELECT
EmployeeID,
FirstName,
LastName,
HireDate,
Salary,
LAG(HireDate) OVER(ORDER BY HireDate) as PreviousDate,
LEAD(HireDate) OVER(ORDER BY HireDate) as NextDate
FROM employees;