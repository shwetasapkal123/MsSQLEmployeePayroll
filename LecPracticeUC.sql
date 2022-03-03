-------------------UC1-Create Payroll Service database------------------
create database Payroll_Service;
use Payroll_Service;

----------------UC2-create employee payroll table-----------------------
CREATE TABLE EPLOYEE_PAYROLL(
Id int identity(1,1) primary key,
Name varchar(200),		--varchar for stringswith strings limit 200
Salary float,
Start_Date date
);
---------------UC3-CRUD Operation------------------------------------
INSERT INTO EPLOYEE_PAYROLL(Name,Salary,Start_Date,Gender) VALUES('Shweta',25000,getdate(),'F');----add data in the table
INSERT INTO EPLOYEE_PAYROLL(Name,Salary)VALUES('Snehal',35000);
INSERT INTO EPLOYEE_PAYROLL(Name,Salary,Start_Date) VALUES('Bill',50000,getdate());
INSERT INTO EPLOYEE_PAYROLL(Name,Salary,Start_Date) VALUES('Bill',50000,CAST('2020-01-01' as Date));

---------------UC4-retrieve all data-------------
select *from EPLOYEE_PAYROLL;-------------show all data in the table
select Id,Name,Salary from EPLOYEE_PAYROLL;------show data id name salary in the employee payroll table


----------------UC5-Retrieve salary data of particular employee--------------
select Id,Name,Salary from EPLOYEE_PAYROLL where Name='Bill';
select Salary,Name from EPLOYEE_PAYROLL where Start_Date between CAST('2020-01-01' as Date) and getdate();

---------------UC6-Add gender and update the rows---------------------
ALTER TABLE EPLOYEE_PAYROLL ADD Gender char(1);

update EPLOYEE_PAYROLL set Salary=45890 WHERE Id=1; 
update EPLOYEE_PAYROLL set Gender='F' WHERE Id=1;
update EPLOYEE_PAYROLL set Gender='F' WHERE Id=2;
update EPLOYEE_PAYROLL set Gender='M' WHERE Id=3;   

------------------UC7-find sum,min,max,number of male and female----------
select sum(Salary) as TotalSalary,Gender from EPLOYEE_PAYROLL group by Gender;
select Max(Salary) as MaxSalary,Gender from EPLOYEE_PAYROLL group by Gender;
select Min(Salary) as MaxSalary,Gender from EPLOYEE_PAYROLL group by Gender;
select Avg(Salary) as  AvgSalary,Gender from EPLOYEE_PAYROLL group by Gender;
select Avg('Gender') as NumOfEmp ,Gender from EPLOYEE_PAYROLL group by Gender; 
select Gender, COUNT(Gender) from EPLOYEE_PAYROLL group by Gender;

----------------UC8-Extend Table to add phone , Address ,Department------------
ALTER TABLE EPLOYEE_PAYROLL ADD Phone bigint;
ALTER TABLE EPLOYEE_PAYROLL ADD Address varchar(200);
ALTER TABLE EPLOYEE_PAYROLL ADD Department varchar(100) not null default 'BridgeLabz';
select *from EPLOYEE_PAYROLL;
---------------------UC9-Extend Table to have bsicPay,deductions,taxablepay,...etc------------
Exec sp_rename  'EPLOYEE_PAYROLL.Salary','BasicPay','COLUMN';
ALTER TABLE EPLOYEE_PAYROLL ADD Deductions float,Taxable float,IncomeTax float,NetPay float;
Update EPLOYEE_PAYROLL set Deductions=500 where Id IN (3,5);
Update EPLOYEE_PAYROLL set Deductions=1000 where Id IN (1,2);
Update EPLOYEE_PAYROLL set Deductions=1500 where Id =4;
select *from EPLOYEE_PAYROLL;
Update EPLOYEE_PAYROLL set Taxable=4999.99 where Id IN (1,3,5);
Update EPLOYEE_PAYROLL set IncomeTax=1599.76 where Id IN (2,4,5);
Update EPLOYEE_PAYROLL set NetPay=25000 where Id IN (1,2,3,4,5);
-----------------UC-10-Creating Unneccesssary redundancy----------------
----Already created two redundancy so added new one person
INSERT INTO EPLOYEE_PAYROLL (Name,BasicPay,Start_Date,Gender,Phone,Address,Department,Deductions,Taxable,IncomeTax,NetPay)
VALUES('Suresh',50000,'1998-03-14','M',9876543219,'Benglore','Infosys',500,3500,3000,50000);
---------Recreate Using Er Diagram(UC11)
---------Creating Company Table
CREATE TABLE Company(
	CompanyId INT IDENTITY(1,1) PRIMARY KEY,
	CompanyName VARCHAR(100)
	);

---------Creating Deptartment table
CREATE TABLE Department(
	DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
	DepartmentName VARCHAR(50));

---------Creating Employee Table
CREATE TABLE Employee(
	EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
	CompanyId INT FOREIGN KEY REFERENCES Company(CompanyId),
	EmployeeName VARCHAR(30),
	PhoneNumber BIGINT,
	EmployeeAddress VARCHAR(50),
	StartDate date,
	Gender CHAR(1)
);

---------Creating Payroll Table
CREATE TABLE Payroll(
	EmployeeId INT FOREIGN KEY REFERENCES Employee(EmployeeId),
	BasicPay FLOAT,
	TaxablePay FLOAT,
	IncomeTax FLOAT,
	NetPay FLOAT,
	Deductions FLOAT
);

---------Creating Employee Department Table
create table EmployeeDepartment(
	EmployeeId int FOREIGN KEY REFERENCES Employee(EmployeeId),
	DepartmentId int FOREIGN KEY REFERENCES Department(DepartmentId),
);

---------Inserting Value Into Company Table
INSERT INTO Company VALUES('TCS'),('Capgemini'),('WIPRO');
SELECT * FROM Company;

---------Inserting Value Into Department Table
INSERT INTO Department VALUES('HR'),('IT Developer'),('QA'),('Testing'),('Finance'),('Account'),('Marketing');
SELECT * FROM Department;

---------Inserting Value Into Employee Table
INSERT INTO Employee VALUES(1,'Shweta',9820456123,'Mumbai','2022-02-27','F');
INSERT INTO Employee VALUES(2,'Snehal',9874185296,'Pune',' ','F');
INSERT INTO Employee VALUES(3,'Bill',9745612587,'Mumbai','2022-02-27','M'),
						(1,'Bill',9587463214,'Gujarat','2020-01-01',' '),
						(2,'Shweta',9845687321,'Chennai','2022-02-27','F'),
						(3,'Suresh',9685475645,'Karnataka','1998-03-14','M');
						
SELECT * FROM Employee;
----------Insert values into payroll table-----------
INSERT INTO Payroll(EmployeeId ,BasicPay, TaxablePay ,IncomeTax ,NetPay ,Deductions )
VALUES(1,25000,4999.99 ,24 ,25000 , 1000),
		(3,25000,4999.99 ,1599.76 ,25000 , 1000),
		(6,35000,3999.99 ,1599.76 ,25000 ,500),
		(7,50000,4999.99 ,1599.76 ,25000 , 1500),
		(8,5000,4999.99 ,1599.76 ,25000 , 500),
		(9,25000,2999.99 ,2456.56 ,35000 ,500),
		(10,50000 , 3500,3000 ,50000 ,500);

select *from  Payroll;

-----------Insert values into Employee department----
INSERT INTO EmployeeDepartment(EmployeeId,DepartmentId)
VALUES(1,1 ),
	  (3,2 )	,
	  (6, 3),
	  (7,4 ),
	  (8,5 ),
	  (9, 6),
	  (10,7 );
select *from EmployeeDepartment;

------------UC12-Remove and retrieve from payroll---------
DELETE From Payroll WHERE EmployeeId=3;
select *from Payroll;
	--------------Retrieve using Name(UC5)------------------
SELECT comp.CompanyID,comp.CompanyName,emp.EmployeeId,emp.EmployeeName,emp.PhoneNumber,emp.StartDate,emp.Gender
FROM Company AS comp 
INNER JOIN Employee AS emp 
ON comp.CompanyId = emp.CompanyId AND emp.StartDate BETWEEN ('2020-01-01') AND getdate();

---------Aggregate Function Sum-----------------------
SELECT SUM(pay.BasicPay) as TotalEmpSalary,emp.Gender
FROM Employee AS emp 
INNER JOIN Payroll as pay ON emp.EmployeeId = pay.EmployeeId GROUP BY Gender ORDER BY Gender DESC;

-----------Max Function ------------------------------
SELECT MAX(pay.BasicPay) as MaxEmpSalary,emp.Gender 
FROM Employee AS emp 
INNER JOIN Payroll as pay ON emp.EmployeeId = pay.EmployeeId GROUP BY Gender;
-------------Min Function-----------------------------
SELECT MIN(pay.BasicPay) as MinEmpSalary,emp.Gender 
FROM Employee AS emp 
INNER JOIN Payroll as pay ON emp.EmployeeId = pay.EmployeeId GROUP BY Gender ORDER BY Gender DESC;
------------Avg Salary--------------------------
SELECT CAST(AVG(pay.BasicPay) as decimal(10,2)) as AverageEmpSalary,emp.Gender
FROM Employee AS emp 
INNER JOIN Payroll as pay ON emp.EmployeeId = pay.EmployeeId GROUP BY Gender;

--------------Count Employee----------------
SELECT COUNT(EmployeeName) as NumOfEmployee,Gender FROM Employee GROUP BY Gender ORDER BY Gender DESC;
---------Retrieving All Records(UC4)
SELECT comp.CompanyID,comp.CompanyName,emp.EmployeeId,emp.EmployeeName,emp.PhoneNumber,emp.StartDate,emp.Gender,emp.EmployeeAddress,
pay.BasicPay,pay.TaxablePay,pay.IncomeTax,pay.NetPay,pay.Deductions,dep.DepartmentId,dep.DepartmentName
FROM Company AS comp
INNER JOIN Employee AS emp ON comp.CompanyId=emp.CompanyId
INNER JOIN Payroll AS pay ON pay.EmployeeId = emp.EmployeeId	
INNER JOIN EmployeeDepartment as empDep ON empDep.EmployeeId = emp.EmployeeId
INNER JOIN Department as dep ON dep.DepartmentId = empDep.DepartmentId;