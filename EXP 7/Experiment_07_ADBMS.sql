-- Experiment 07 – Advanced Database Management Systems (ADBMS)
-- Author: Misal Saini
-- Date: 09/10/2025
-- Subject Code: 23CSP-333

-- =============================================
-- Part 1: Student Data Change Monitoring (Medium)
-- =============================================

-- Creating the student table
CREATE TABLE student (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(100),
    age INT,
    class VARCHAR(50)
);

-- Creating the trigger function for student audit
CREATE OR REPLACE FUNCTION fn_student_audit() 
RETURNS TRIGGER
LANGUAGE plpgsql 
AS
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        RAISE NOTICE 'Inserted Row -> ID: %, Name: %, Age: %, Class: %', 
        NEW.id, NEW.name, NEW.age, NEW.class;
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        RAISE NOTICE 'Deleted Row -> ID: %, Name: %, Age: %, Class: %', 
        OLD.id, OLD.name, OLD.age, OLD.class;
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;

-- Creating the trigger for student table
CREATE TRIGGER trg_student_audit 
AFTER INSERT OR DELETE
ON student
FOR EACH ROW
EXECUTE FUNCTION fn_student_audit();


-- =============================================
-- Part 2: Employee Activity Logging (Hard)
-- =============================================

-- Creating employee and audit tables
CREATE TABLE tbl_employee ( 
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100), 
    designation VARCHAR(50), 
    salary NUMERIC(10,2)
);

CREATE TABLE tbl_employee_audit ( 
    audit_id SERIAL PRIMARY KEY, 
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creating trigger function for employee audit
CREATE OR REPLACE FUNCTION audit_employee_changes() 
RETURNS TRIGGER
LANGUAGE plpgsql 
AS
$$ 
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO tbl_employee_audit(message)
        VALUES ('Employee name ' || NEW.emp_name || ' has been added at ' || NOW()); 
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO tbl_employee_audit(message)
        VALUES ('Employee name ' || OLD.emp_name || ' has been deleted at ' || NOW()); 
        RETURN OLD;
    END IF;

    RETURN NULL; 
END;
$$;

-- Creating the trigger for employee table
CREATE TRIGGER trg_employee_audit 
AFTER INSERT OR DELETE
ON tbl_employee 
FOR EACH ROW
EXECUTE FUNCTION audit_employee_changes();


-- =============================================
-- Testing Section
-- =============================================

-- Insert a student record
INSERT INTO student (name, age, class)
VALUES ('Arpit Anand', 21, 'CS101');

-- Delete a student record (for testing)
DELETE FROM student WHERE name = 'Arpit Anand';

-- Insert an employee record
INSERT INTO tbl_employee (emp_name, designation, salary) 
VALUES ('Arpit Anand', 'Software Engineer', 55000);

-- View audit table after insertion
SELECT * FROM tbl_employee_audit;

-- Delete the employee record
DELETE FROM tbl_employee WHERE emp_name = 'Arpit Anand';

-- View audit table after deletion
SELECT * FROM tbl_employee_audit;
