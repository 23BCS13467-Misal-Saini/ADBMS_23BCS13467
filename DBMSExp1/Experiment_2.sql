-- MEDIUM
use assessment;

CREATE TABLE Employee (
    EmpID INT,
    Ename VARCHAR(100),
    Department VARCHAR(100),
    ManagerID INT
);

INSERT INTO Employee VALUES
    (1, 'Riya', 'Admin', NULL),
    (2, 'Kunal', 'Accounts', 1),
    (3, 'Meena', 'Tech', 1),
    (4, 'Arjun', 'Accounts', 2),
    (5, 'Sneha', 'Tech', 3),
    (6, 'Varun', 'Admin', 1);

SELECT 
    E1.Ename AS "Employee Name",
    E2.Ename AS "Manager Name",
    E1.Department AS "Employee Department",
    E2.Department AS "Manager Department"
FROM 
    Employee AS E1
LEFT JOIN 
    Employee AS E2
    ON E1.ManagerID = E2.EmpID;

-- HARD
CREATE TABLE Year_tbl (
    ID INT,
    YEAR INT,
    NPV INT
);

CREATE TABLE Queries (
    ID INT,
    YEAR INT
);

INSERT INTO Year_tbl (ID, YEAR, NPV) VALUES
    (2, 2017, 95),
    (4, 2020, 55),
    (6, 2018, 120),
    (2, 2018, 88),
    (3, 2016, 110),
    (5, 2015, 15),
    (4, 2019, 42),
    (6, 2017, 60);

INSERT INTO Queries (ID, YEAR) VALUES
    (2, 2018),
    (3, 2016),
    (4, 2020),
    (4, 2019),
    (6, 2017),
    (6, 2019),
    (1, 2021);

SELECT 
    Q.ID,
    Q.YEAR,
    IFNULL(Y.NPV, 0) AS "NPV"
FROM 
    Queries AS Q
LEFT JOIN 
    Year_tbl AS Y
    ON Q.ID = Y.ID AND Q.YEAR = Y.YEAR;
