-- Step 1: Create Department Table
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);

-- Step 2: Create Course Table with Foreign Key
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Step 3: Insert Departments
INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'Biology'),
(2, 'Civil Engineering'),
(3, 'Chemistry'),
(4, 'Statistics'),
(5, 'Environmental Science');

-- Step 4: Insert Courses (7 total; Biology has 3)
INSERT INTO Course (course_id, course_name, dept_id) VALUES
(201, 'Genetics', 1),
(202, 'Microbiology', 1),
(203, 'Cell Biology', 1), -- 3 courses for Biology
(204, 'Structural Analysis', 2),
(205, 'Organic Chemistry', 3),
(206, 'Probability Theory', 4),
(207, 'Climate Change', 5);

-- Step 5: Subquery - Departments with more than 2 courses
SELECT dept_name
FROM Department
WHERE dept_id IN (
    SELECT dept_id
    FROM Course
    GROUP BY dept_id
    HAVING COUNT(course_id) > 2
);

-- Step 6: Grant SELECT access on Course to readonly_user
--GRANT SELECT ON Course TO readonly_user;
