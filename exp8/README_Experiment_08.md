# 📘 Experiment 08 – Advanced Database Management Systems (ADBMS)

## 🎯 Aim

This experiment focuses on understanding **transactions** and **savepoints** in PostgreSQL to maintain data integrity and implement partial rollbacks efficiently.

---

## 🧠 Objectives

### i) Understanding Transactions in PostgreSQL (Medium)
- Implement and understand the difference between **implicit** and **explicit** transactions.  
- Use **COMMIT** and **ROLLBACK** to control transaction success or failure.  
- Understand **ACID properties** (Atomicity, Consistency, Isolation, Durability).  
- Handle transaction failures and recovery.

### ii) Savepoints in Transactions (Hard)
- Implement **SAVEPOINTS** for partial rollbacks within transactions.  
- Handle exceptions gracefully using **exception blocks**.  
- Display messages for both successful and failed insertions.  
- Preserve previous valid inserts even if a later insert fails.  

---

## 🧰 Tools Used

- **Database:** PostgreSQL  
- **Language:** SQL & PL/pgSQL  
- **Platform:** pgAdmin / SQL Shell (psql)

---

## 🧩 Experiment Details

### 🔹 Step 1 – Creating the Students Table

```sql
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    course VARCHAR(50)
);
```

---

### 🔹 Step 2 – Implicit Transactions (Auto-Commit Mode)

```sql
-- Each statement is automatically committed unless an error occurs.
INSERT INTO students (name, age, course)
VALUES ('Arpit Anand', 21, 'CS101');

UPDATE students SET course = 'CS202' WHERE id = 1;

DELETE FROM students WHERE id = 2;
```

👉 *In implicit transactions, each SQL statement is treated as a separate transaction automatically committed after execution.*

---

### 🔹 Step 3 – Explicit Transactions (BEGIN, COMMIT, ROLLBACK)

```sql
BEGIN;

INSERT INTO students (name, age, course)
VALUES ('Misal Saini', 20, 'CSE202');

UPDATE students SET course = 'CSE303' WHERE id = 1;

-- Rollback example
DELETE FROM students WHERE name = 'Nonexistent';

ROLLBACK;

-- Commit example
COMMIT;
```

👉 *Explicit transactions provide more control by allowing manual commits or rollbacks.*

---

### 🔹 Step 4 – Savepoints and Exception Handling (Advanced)

```sql
DO $$
BEGIN
    BEGIN
        INSERT INTO students (name, age, course)
        VALUES ('John', 21, 'CS101');
        
        SAVEPOINT sp1;

        INSERT INTO students (name, age, course)
        VALUES (NULL, 22, 'CS102');  -- Invalid data (name is NULL)
        
        -- Rollback only failed insert
        ROLLBACK TO sp1;

        INSERT INTO students (name, age, course)
        VALUES ('Emily', 23, 'CS103');

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Transaction failed and rolled back completely!';
    END;
END $$;
```

👉 *If an insert fails (like inserting NULL in a non-nullable field), only that statement rolls back, while others are preserved.*

---

## 🧾 Sample Output

```
NOTICE:  Insert successful for John
ERROR:   null value in column "name" violates not-null constraint
NOTICE:  Rolled back to savepoint sp1
NOTICE:  Insert successful for Emily
NOTICE:  Transaction committed successfully!
```

---

## 🧠 Learning Outcomes

1. Understood the **concept of transactions** and their importance in data integrity.  
2. Learned the difference between **implicit** and **explicit** transactions in PostgreSQL.  
3. Gained hands-on knowledge of **ACID properties**.  
4. Mastered **COMMIT** and **ROLLBACK** for transaction control.  
5. Implemented **savepoints** for partial rollbacks and **exception handling** for robust database systems.

---

**👨‍💻 Author:** Misal Saini  
**Course:** Advanced Database Management Systems (ADBMS)  
**Semester:** 5th  
**Subject Code:** 23CSP-333  
**Institute:** EduSmart Institute  
**Date of Performance:** 09/10/2025  
