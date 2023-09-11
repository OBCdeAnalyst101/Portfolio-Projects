SELECT * 
FROM EmployeeDemograhics

SELECT *
FROM EmployeeSalary


--Joining two tables

SELECT dem.EmployeeID, dem.Firstname + ' ' + dem.LastName as FullName, JobTitle, Salary, AVG(Salary) AS AVGSAL
FROM EmployeeDemograhics As dem
JOIN EmployeeSalary As sal
ON dem.EmployeeID = sal.EmployeeID
GROUP BY dem.EmployeeID, dem.FirstName, dem.LastName, JobTitle, Salary
ORDER BY 3,4 DESC

SELECT AVG(Salary) AvgSal
FROM EmployeeSalary

SELECT MAX(Salary) MaxSal
FROM EmployeeSalary

SELECT MIN(Salary) MinSal
FROM EmployeeSalary

--Looking at the employee with the hightest salary
SELECT dem.EmployeeID, dem.Firstname + ' ' + dem.LastName as FullName, JobTitle, Salary
FROM EmployeeDemograhics As dem
JOIN EmployeeSalary As sal
ON dem.EmployeeID = sal.EmployeeID
WHERE Salary IN (
SELECT MAX(Salary)
FROM EmployeeSalary)
GROUP BY dem.EmployeeID, dem.FirstName, dem.LastName, JobTitle, Salary



--Looking at the employee with the lowest salary
SELECT dem.EmployeeID, dem.Firstname + ' ' + dem.LastName as FullName, JobTitle, Salary
FROM EmployeeDemograhics As dem
JOIN EmployeeSalary As sal
ON dem.EmployeeID = sal.EmployeeID
WHERE Salary IN (
SELECT MIN(Salary)
FROM EmployeeSalary)
GROUP BY dem.EmployeeID, dem.FirstName, dem.LastName, JobTitle, Salary



--