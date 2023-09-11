--INSERT INTO EmployeeDemograhics VALUES
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32,'Male'),
--(1006, 'Micheal', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kelvin', 'Malone', 31, 'Male')

--insert into EmployeeSalary VALUES
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager',65000),
--(1007, 'Supplier Relations',41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)


--SELECT *
--FROM EmployeeDemograhics

--SELECT *
--FROM EmployeeSalary

--WHERE FirstName <> 'Micheal'
--ORDER BY Salary DESC

--SELECT JobTitle,AVG(Salary) AS Avg_salary
--FROM EmployeeDemograhics
--LEFT JOIN EmployeeSalary
--ON EmployeeDemograhics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE JobTitle = 'Salesman'
--GROUP BY JobTitle


--SELECT *
--FROM EmployeeDemograhics

--SELECT *
--FROM EmployeeSalary

--SELECT FirstName, LastName, Age,
--CASE
--	WHEN Age > 30 THEN 'Old'
--	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
--	ELSE 'Baby'
--END AS Stat
--FROM EmployeeDemograhics
--WHERE Age IS NOT NULL
--ORDER BY Age


--SELECT FirstName, LastName, JobTitle, Salary,
--CASE
--	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
--	WHEN Jobtitle = 'Accountant' THEN Salary + (Salary * .05)
--	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
--	ELSE Salary + (Salary * .03)
--END AS SalaryAfterRaise
--FROM EmployeeDemograhics
--JOIN EmployeeSalary
--	ON EmployeeDemograhics.EmployeeID = EmployeeSalary.EmployeeID


--SELECT JobTitle, AVG(Salary)
--FROM EmployeeDemograhics
--JOIN EmployeeSalary
--	ON EmployeeDemograhics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING AVG(Salary) > 45000
--ORDER BY AVG(Salary)
--HAVING COUNT(JobTitle) > 1

--UPDATE EmployeeDemograhics
--SET EmployeeID = 1012 



 