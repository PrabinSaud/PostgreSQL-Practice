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

SELECT * FROM employees;