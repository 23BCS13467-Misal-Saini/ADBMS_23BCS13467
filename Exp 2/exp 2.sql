/*MEDIUM LEVEL PROBLEM*/
CREATE TABLE Employee_tbl (
    EmpID INT,
    EmpName VARCHAR(100),
    Dept VARCHAR(100),
    Manager_ID INT
);

INSERT INTO Employee_tbl VALUES
(1, 'Alice', 'HR', NULL),
(2, 'Bob', 'Finance', 1),
(3, 'Charlie', 'IT', 1),
(4, 'David', 'Finance', 2),
(5, 'Eve', 'IT', 3),
(6, 'Frank', 'HR', 1);

SELECT 
    E1.EmpName AS [EMPLOYEE NAME],
    E2.EmpName AS [MANAGER NAME],
    E1.Dept AS [EMPLOYEE DEPARTMENT],
    E2.Dept AS [MANAGER DEPARTMENT]
FROM 
    Employee_tbl AS E1
LEFT OUTER JOIN 
    Employee_tbl AS E2
ON 
    E1.Manager_ID = E2.EmpID;

/*HARD LEVEL PROBLEM*/
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
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

INSERT INTO Queries (ID, YEAR) VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

SELECT 
    Q.ID,
    Q.YEAR,
    ISNULL(Y.NPV, 0) AS NPV
FROM 
    Queries AS Q
LEFT JOIN 
    Year_tbl AS Y
ON 
    Q.ID = Y.ID AND Q.YEAR = Y.YEAR;
