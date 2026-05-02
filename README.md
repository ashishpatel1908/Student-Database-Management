# Student-Database-Management
# 📘 Student Database Management System (SQL)

## 📌 Overview
This project is a simple SQL-based Student Database Management System created to understand basic database concepts.

It includes:
- Table creation (DDL)
- Data insertion (DML)
- Queries (SELECT, WHERE, JOIN)
- Aggregate functions (AVG, COUNT, etc.)
- Views for reporting

---

## 🛠️ Tech Stack
- SQL (SQLite)
- DB Browser for SQLite

---

## 🗂️ Database Schema

### 1. Departments
- dept_id (Primary Key)
- dept_name
- hod_name

### 2. Students
- student_id (Primary Key)
- full_name
- email
- gender
- dept_id (Foreign Key)
- semester

### 3. Subjects
- subject_id (Primary Key)
- subject_name
- dept_id (Foreign Key)
- credits

### 4. Marks
- mark_id (Primary Key)
- student_id (Foreign Key)
- subject_id (Foreign Key)
- marks
- grade

---

## ⚙️ Features
- Created relational database using primary & foreign keys
- Inserted sample data
- Performed filtering using WHERE clause
- Used JOIN to combine tables
- Applied aggregate functions (AVG, MAX, MIN, COUNT)
- Created views for analysis

---

## 📊 Sample Queries

### Get all students
```sql
SELECT * FROM Students;
