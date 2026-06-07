-- ====================================================================
-- Topic 4, 5, 6, 7 & 8: Table Creation, Constraints, and Query Suites
-- Core System Schema: University Management Database
-- ====================================================================

-- --------------------------------------------------------------------
-- Topic 6: Table Creation with Constraints (DDL)
-- --------------------------------------------------------------------

-- Create Parent Table: Department (1:M Side)
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,                       -- Primary Key constraint
    dept_name VARCHAR(50) NOT NULL UNIQUE,         -- Column constraints
    budget DECIMAL(12, 2) CHECK (budget > 0.0)     -- Domain Check constraint
);

-- Create Child Table: Students (Many Side linked to Departments)
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gpa DECIMAL(3, 2) DEFAULT 0.00,
    enrollment_date DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL -- Foreign Key Referential Integrity
);

-- Create Bridge Table for M:N Relationship: Course Enrollment
CREATE TABLE Courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(100) NOT NULL,
    credits INT CHECK (credits BETWEEN 1 AND 5)
);

CREATE TABLE Enrollments (
    student_id INT,
    course_id VARCHAR(10),
    semester VARCHAR(10),
    PRIMARY KEY (student_id, course_id), -- Composite Primary Key
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- --------------------------------------------------------------------
-- Topic 4: Data Manipulation Operations (DML)
-- --------------------------------------------------------------------

-- Inserting sample data records
INSERT INTO Departments VALUES (1, 'Computer Science', 750000.00);
INSERT INTO Departments VALUES (2, 'Data Analytics', 500000.00);
INSERT INTO Departments VALUES (3, 'Electrical Eng', 600000.00);

INSERT INTO Students VALUES (101, 'Alice', 'Smith', 3.85, '2024-09-01', 1);
INSERT INTO Students VALUES (102, 'Bob', 'Jones', 2.90, '2024-09-01', 1);
INSERT INTO Students VALUES (103, 'Charlie', 'Brown', 3.65, '2025-01-15', 2);
INSERT INTO Students VALUES (104, 'David', 'Miller', 3.40, '2025-01-15', NULL);

INSERT INTO Courses VALUES ('CS101', 'Intro to Programming', 4);
INSERT INTO Courses VALUES ('DA201', 'Data Mining Foundations', 3);

INSERT INTO Enrollments VALUES (101, 'CS101', 'Fall 2024');
INSERT INTO Enrollments VALUES (101, 'DA201', 'Fall 2024');
INSERT INTO Enrollments VALUES (102, 'CS101', 'Fall 2024');

-- --------------------------------------------------------------------
-- Topic 5: Practice Complex Analytical Queries (Relational Operators)
-- --------------------------------------------------------------------

-- IN and UNION Operators
-- Find all students who are in Computer Science OR have a GPA above 3.5
SELECT first_name, last_name, gpa FROM Students WHERE dept_id IN (1)
UNION
SELECT first_name, last_name, gpa FROM Students WHERE gpa > 3.5;

-- EXISTS Operator
-- List all departments that have at least one student enrolled
SELECT dept_name FROM Departments d
WHERE EXISTS (
    SELECT 1 FROM Students s WHERE s.dept_id = d.dept_id
);

-- NOT EXISTS Operator
-- Find departments that have no students assigned
SELECT dept_name FROM Departments d
WHERE NOT EXISTS (
    SELECT 1 FROM Students s WHERE s.dept_id = d.dept_id
);

-- ALL Operator
-- Find students whose GPA is higher than ALL students in Department 2
SELECT first_name, last_name, gpa FROM Students
WHERE gpa > ALL (SELECT gpa FROM Students WHERE dept_id = 2);

-- INTERSECT Simulation (Using standard inner query join patterns)
-- Find department IDs that have active budgets AND active student counts
SELECT DISTINCT d.dept_id FROM Departments d 
JOIN Students s ON d.dept_id = s.dept_id;

-- --------------------------------------------------------------------
-- Topic 7: Aggregate Operations, Grouping, and Virtual Views
-- --------------------------------------------------------------------

-- Aggregate, GROUP BY, and HAVING clauses
-- Calculate departmental statistical summaries for departments with an average GPA > 3.0
SELECT 
    dept_id,
    COUNT(student_id) AS total_students,
    SUM(gpa) AS collective_gpa_weight,
    AVG(gpa) AS average_departmental_gpa,
    MAX(gpa) AS top_gpa,
    MIN(gpa) AS lowest_gpa
FROM Students
WHERE dept_id IS NOT NULL
GROUP BY dept_id
HAVING AVG(gpa) > 3.0;

-- Creation of a Virtual View structure
CREATE VIEW HighAchieversView AS
SELECT student_id, first_name, last_name, gpa
FROM Students
WHERE gpa >= 3.5;

-- Querying the virtual schema view matrix
SELECT * FROM HighAchieversView;

-- --------------------------------------------------------------------
-- Topic 8: Dropping and System Cleanup (DDL Destruction)
-- --------------------------------------------------------------------

-- Dropping a view
DROP VIEW HighAchieversView;

-- Dropping database tables cleanly (Child tables must be dropped before parent tables to avoid reference constraints violations)
DROP TABLE Enrollments;
DROP TABLE Courses;
DROP TABLE Students;
DROP TABLE Departments;
