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