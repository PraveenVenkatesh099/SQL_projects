# 👥 Employee Management System (SQL)

This project is a **relational database** for managing employee information, departments, projects, salaries, and leaves using **MySQL**. Designed for hands-on learning and query practice, this system is ideal for students, beginners, and anyone learning **database design and SQL**.

---

## 📦 Features

- Manage **employees**, **departments**, **salaries**, **projects**, and **leaves**
- Perform complex **SQL queries** to retrieve and analyze data
- Establish **foreign key relationships** between tables
- Learn how to structure normalized relational databases
- SQL_Employee_management.docx contains solution the problems

---

## 🗃️ Database Schema

The system includes the following tables:

- `departments`: Department info & manager
- `employees`: Employee details & department association
- `salaries`: Salary + bonus info linked to employees
- `projects`: Projects employees are working on
- `employee_projects`: Many-to-many relationship table
- `leaves`: Track employee leaves with status

---

## 🛠️ How to Use

### 1. Setup the Database
- Use **phpMyAdmin** or any MySQL environment
- Run the provided SQL scripts to:
  - Create tables
  - Set primary/foreign keys
  - Insert sample data

### 2. Populate the Tables
Use these scripts to insert sample data:
- `departments`: Add departments first
- `employees`: Add employees and assign departments
- `salaries`: Add salaries with basic + bonus
- `projects`: Define projects
- `employee_projects`: Assign employees to projects
- `leaves`: Add sample leave requests

> ⚠️ Ensure foreign key dependencies are satisfied during data insertion.

### 3. Run Queries
Test your SQL skills with examples like:

```sql
-- Count of employees per department
SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;
