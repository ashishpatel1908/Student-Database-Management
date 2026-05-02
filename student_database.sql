SELECT * FROM Students;


PRAGMA foreign_keys = ON;

-- Drop tables if re-running (order matters due to foreign keys)
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Subjects;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;

-- Departments table
CREATE TABLE Departments (
    dept_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    dept_name   VARCHAR(100) NOT NULL UNIQUE,
    hod_name    VARCHAR(100)
);

-- Students table
CREATE TABLE Students (
    student_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100) UNIQUE NOT NULL,
    phone       VARCHAR(15),
    gender      TEXT CHECK (gender IN ('Male', 'Female', 'Other')),
    dob         DATE,
    dept_id     INT,
    semester    INT CHECK (semester BETWEEN 1 AND 8),
    enrolled_on DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- Subjects table
CREATE TABLE Subjects (
    subject_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    subject_name VARCHAR(100) NOT NULL,
    dept_id      INT,
    credits      INT DEFAULT 3,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- Marks table
CREATE TABLE Marks (
    mark_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id  INT NOT NULL,
    subject_id  INT NOT NULL,
    marks       DECIMAL(5,2) CHECK (marks BETWEEN 0 AND 100),
    grade       CHAR(2),
    exam_date   DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

INSERT INTO Departments (dept_name, hod_name) VALUES
    ('Civil Engineering',     'Dr. R.K. Sharma'),
    ('Computer Science',      'Dr. Meena Gupta'),
    ('Mechanical Engineering','Dr. Arjun Nair'),
    ('Electronics',           'Dr. Sunita Rao');

INSERT INTO Students (full_name, email, phone, gender, dob, dept_id, semester, enrolled_on) VALUES
    ('Ashish Kumar',   'ashish@student.com',  '9876543210', 'Male',   '2003-05-14', 1, 6, '2024-01-10'),
    ('Ananya Sharma',  'ananya@student.com',  '9876543211', 'Female', '2003-08-22', 2, 6, '2024-02-14'),
    ('Aryan Mehta',    'aryan@student.com',   '9876543212', 'Male',   '2002-11-30', 1, 6, '2024-03-05'),
    ('Priya Singh',    'priya@student.com',   '9876543213', 'Female', '2004-01-10', 3, 4, '2024-01-20'),
    ('Rahul Verma',    'rahul@student.com',   '9876543214', 'Male',   '2003-07-05', 2, 5, '2023-12-01'),
    ('Sneha Patel',    'sneha@student.com',   '9876543215', 'Female', '2004-03-19', 4, 3, '2024-04-15'),
    ('Vikram Das',     'vikram@student.com',  '9876543216', 'Male',   '2002-09-25', 1, 8, '2023-07-01'),
    ('Neha Joshi',     'neha@student.com',    '9876543217', 'Female', '2003-12-01', 4, 5, '2024-01-08');

INSERT INTO Subjects (subject_name, dept_id, credits) VALUES
    ('Structural Analysis',         1, 4),
    ('Environmental Engineering',   1, 3),
    ('Fluid Mechanics',             1, 4),
    ('Data Structures',             2, 4),
    ('Database Management',         2, 3),
    ('Operating Systems',           2, 3),
    ('Thermodynamics',              3, 4),
    ('Machine Design',              3, 3),
    ('Digital Electronics',         4, 4),
    ('Signal Processing',           4, 3);

INSERT INTO Marks (student_id, subject_id, marks, grade, exam_date) VALUES
    (1, 1, 82.0, 'A',  '2025-04-10'),
    (1, 2, 76.5, 'B',  '2025-04-12'),
    (1, 3, 90.0, 'A+', '2025-04-14'),
    (2, 4, 88.0, 'A',  '2025-04-10'),
    (2, 5, 72.0, 'B',  '2025-04-12'),
    (2, 6, 65.0, 'C',  '2025-04-14'),
    (3, 1, 55.0, 'D',  '2025-04-10'),
    (3, 2, 61.0, 'C',  '2025-04-12'),
    (3, 3, 70.0, 'B',  '2025-04-14'),
    (4, 7, 91.0, 'A+', '2025-04-10'),
    (4, 8, 85.0, 'A',  '2025-04-12'),
    (5, 4, 78.0, 'B',  '2025-04-10'),
    (5, 5, 83.0, 'A',  '2025-04-12'),
    (6, 9, 69.0, 'C',  '2025-04-10'),
    (6,10, 74.0, 'B',  '2025-04-12'),
    (7, 1, 95.0, 'A+', '2025-04-10'),
    (7, 2, 88.0, 'A',  '2025-04-12'),
    (7, 3, 79.0, 'B',  '2025-04-14'),
    (8, 9, 60.0, 'C',  '2025-04-10'),
    (8,10, 55.0, 'D',  '2025-04-12');

-- All students
SELECT * FROM Students;

-- All students in Civil Engineering (dept_id = 1)
SELECT full_name, semester FROM Students WHERE dept_id = 1;

-- Students in semester 6
SELECT full_name, email FROM Students WHERE semester = 6;

-- Female students only
SELECT full_name, dept_id FROM Students WHERE gender = 'Female';

-- Students enrolled after 2024
SELECT full_name, enrolled_on FROM Students WHERE enrolled_on >= '2024-01-01';


-- Student names with their department
SELECT
    s.full_name,
    s.semester,
    d.dept_name
FROM Students s
JOIN Departments d ON s.dept_id = d.dept_id
ORDER BY d.dept_name;

-- Marks with student name and subject name
SELECT
    st.full_name        AS student,
    su.subject_name     AS subject,
    m.marks,
    m.grade
FROM Marks m
JOIN Students st ON m.student_id = st.student_id
JOIN Subjects su ON m.subject_id = su.subject_id
ORDER BY st.full_name;

-- All Civil Engineering students with their marks
SELECT
    st.full_name,
    su.subject_name,
    m.marks,
    m.grade
FROM Marks m
JOIN Students   st ON m.student_id  = st.student_id
JOIN Subjects   su ON m.subject_id  = su.subject_id
JOIN Departments d ON st.dept_id    = d.dept_id
WHERE d.dept_name = 'Civil Engineering';

-- Average marks per student
SELECT
    st.full_name,
    ROUND(AVG(m.marks), 2) AS avg_marks
FROM Marks m
JOIN Students st ON m.student_id = st.student_id
GROUP BY st.student_id, st.full_name
ORDER BY avg_marks DESC;

-- Highest marks in each subject
SELECT
    su.subject_name,
    MAX(m.marks) AS highest_marks,
    MIN(m.marks) AS lowest_marks
FROM Marks m
JOIN Subjects su ON m.subject_id = su.subject_id
GROUP BY su.subject_id, su.subject_name;

-- Number of students per department
SELECT
    d.dept_name,
    COUNT(s.student_id) AS total_students
FROM Departments d
LEFT JOIN Students s ON d.dept_id = s.dept_id
GROUP BY d.dept_id, d.dept_name;

-- Top 3 students by average marks
SELECT
    st.full_name,
    ROUND(AVG(m.marks), 2) AS avg_marks
FROM Marks m
JOIN Students st ON m.student_id = st.student_id
GROUP BY st.student_id, st.full_name
ORDER BY avg_marks DESC
LIMIT 3;

-- Students who scored above 80 in any subject
SELECT DISTINCT
    st.full_name,
    d.dept_name
FROM Marks m
JOIN Students    st ON m.student_id = st.student_id
JOIN Departments d  ON st.dept_id   = d.dept_id
WHERE m.marks > 80;


-- Update Aryan's semester
UPDATE Students SET semester = 7 WHERE student_id = 3;

-- Correct a mark entry
UPDATE Marks SET marks = 78.0, grade = 'B' WHERE mark_id = 7;

-- Delete a test/dummy record (safe example)
-- DELETE FROM Marks WHERE mark_id = 99;



-- View: Student scorecard
DROP VIEW IF EXISTS vw_scorecard;
CREATE VIEW vw_scorecard AS
SELECT
    st.full_name,
    d.dept_name,
    st.semester,
    su.subject_name,
    m.marks,
    m.grade
FROM Marks m
JOIN Students    st ON m.student_id  = st.student_id
JOIN Departments d  ON st.dept_id    = d.dept_id
JOIN Subjects    su ON m.subject_id  = su.subject_id;

-- View: Student GPA summary
DROP VIEW IF EXISTS vw_student_summary;
CREATE VIEW vw_student_summary AS
SELECT
    st.full_name,
    d.dept_name,
    st.semester,
    COUNT(m.mark_id)           AS subjects_taken,
    ROUND(AVG(m.marks), 2)     AS average_marks,
    MAX(m.marks)               AS highest,
    MIN(m.marks)               AS lowest
FROM Students st
LEFT JOIN Marks       m ON st.student_id = m.student_id
LEFT JOIN Departments d ON st.dept_id    = d.dept_id
GROUP BY st.student_id, st.full_name, d.dept_name, st.semester;
