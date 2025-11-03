# 📘 Experiment 07 – Advanced Database Management Systems (ADBMS)

## 🎯 Aim

This experiment demonstrates the implementation of **PostgreSQL triggers** to monitor and log database changes automatically.

### Objectives

1. **Student Data Change Monitoring (Medium)**  
   - Display details of each student record whenever an **INSERT** or **DELETE** operation occurs.  
   - Use `RAISE NOTICE` to show changes directly on the PostgreSQL console.

2. **Employee Activity Logging (Hard)**  
   - Automatically log every employee **addition** or **deletion** into an audit table.  
   - Each log includes the employee’s name and timestamp of the operation.

---

## 🧰 Tools Used

- **Database:** PostgreSQL  
- **Language:** PL/pgSQL  
- **Platform:** pgAdmin / SQL Shell (psql)

---

## 🧩 Experiment Details

### 🔹 Part 1 – Student Data Change Monitoring

#### Create Table
```sql
CREATE TABLE student (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(100),
    age INT,
    class VARCHAR(50)
);
```

#### Create Trigger Function
```sql
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
```

#### Create Trigger
```sql
CREATE TRIGGER trg_student_audit 
AFTER INSERT OR DELETE
ON student
FOR EACH ROW
EXECUTE FUNCTION fn_student_audit();
```

---

### 🔹 Part 2 – Employee Activity Logging

#### Create Tables
```sql
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
```

#### Create Trigger Function
```sql
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
```

#### Create Trigger
```sql
CREATE TRIGGER trg_employee_audit 
AFTER INSERT OR DELETE
ON tbl_employee 
FOR EACH ROW
EXECUTE FUNCTION audit_employee_changes();
```

#### Sample Test
```sql
INSERT INTO tbl_employee (emp_name, designation, salary)
VALUES ('Arpit Anand', 'Software Engineer', 55000);

SELECT * FROM tbl_employee_audit;

DELETE FROM tbl_employee WHERE emp_name = 'Arpit Anand';

SELECT * FROM tbl_employee_audit;
```

---

## 🧾 Sample Output

```
NOTICE: Inserted Row -> ID: 1, Name: Arpit Anand, Age: 21, Class: CS101

Employee name Arpit Anand has been added at 2025-10-21 21:02:59.425952+05:30
Employee name Arpit Anand has been deleted at 2025-10-21 21:03:19.998826+05:30
```

---

## 🧠 Learning Outcomes

1. Understood the purpose and functionality of database **triggers**.  
2. Learned how to automate data monitoring using **AFTER INSERT** and **AFTER DELETE** triggers.  
3. Gained practical experience with **PL/pgSQL trigger functions**.  
4. Implemented **audit logging** for real-time tracking of data changes.  
5. Strengthened skills in maintaining **data integrity** and **traceability** in relational databases.

---

**👨‍💻 Author:** Misal Saini  
**Course:** Advanced Database Management Systems (ADBMS)  
**Semester:** 5th  
**Subject Code:** 23CSP-333  
**Institute:** EduSmart Institute  
**Date of Performance:** 09/10/2025  
