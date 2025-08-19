-- Easy
 CREATE TABLE Employeee (
    EmpID INT ,
   
);
INSERT INTO Employeee (EmpID) VALUES
(2),
(4 ),
(4),
(6),
(6),
(7),
(8),
(8);
Select Max(EmpID) as [Maximum ID] from (Select EmpID from Employeee Group by EmpID having Count(*) < 2)as Subquery;



--Medium
CREATE TABLE departmentt (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
CREATE TABLE employeeee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departmentt(id)
);
INSERT INTO departmentt (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');
INSERT INTO employeeee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);
Select d.dept_name,e.name,e.salary from departmentt as d Join employeeee as e on d.id = e.department_id where e.salary in (
Select max(e2.salary) from employeeee as e2 where e2.department_id = e.department_id);



--Hard
create table A1 (ID int , Ename varchar(50), Salary int);
Create Table B1(ID int, Ename varchar(50), Salary int );
Insert into A1 values(1,'AA',1000);
Insert into A1 values(2,'BB',300);
Insert into B1 values(2,'BB',400);
Insert into B1 values(3,'CC',100);

Select ID, EName, Min(Salary) as Min_Salary from 
(Select * from A1 Union All Select* from  B1) as combined Group by Ename,ID;
