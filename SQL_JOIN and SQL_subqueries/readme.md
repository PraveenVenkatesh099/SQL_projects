
# SQL Join Practice Questions

This repository contains **25 SQL join practice questions** (questions 1–25) along with solutions. These examples are designed to help you strengthen your SQL skills using different types of joins such as `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`, `SELF JOIN`, and more.

This repository contains **25 advanced SQL subquery practice questions** (questions 26–50) with solutions. These examples focus on using scalar, correlated, nested, and EXISTS subqueries to answer complex analytical problems in SQL.


---

## 📘 What’s Inside?

| # | Question |
|--:|----------|
| 1 | Find all customers who placed more than one order in a single day |
| 2 | Get the details of employees who do not have a department assigned |
| 3 | Find the second-highest salary in each department using a self-join |
| 4 | Join employee and department tables to find departments with no employees |
| 5 | Find all customers who ordered only once using LEFT JOIN and aggregation |
| 6 | Use a FULL OUTER JOIN to find mismatched records between two tables |
| 7 | Find products that have never been ordered using an ANTI JOIN |
| 8 | Use CROSS JOIN to generate all possible pairs of employees and projects |
| 9 | Find employees who share the same manager using a self-join |
| 10 | Join customer and orders to find the top spender per city |
| 11 | Use a JOIN to calculate the average order value per customer |
| 12 | Join products and order details to find the most sold product in each category |
| 13 | Combine two sales tables from different years using UNION ALL and join with products |
| 14 | Show customers who have never logged in using LEFT JOIN |
| 15 | Show all employees with and without projects using a CASE expression |
| 16 | Join orders with payments to check for unpaid orders |
| 17 | Use a self-join to find employees who have the same job title as someone else |
| 18 | Report of customers who have ordered all products in a specific category |
| 19 | Use a RIGHT JOIN to identify regions with no assigned sales reps |
| 20 | Flag invoices that exceed the customer’s credit limit |
| 21 | Find orders where shipping and billing addresses are from different cities |
| 22 | Use a join to find duplicate email addresses in the customer table |
| 23 | Users who placed an order in the last 30 days but not before that |
| 24 | Get order details including customer, product, and delivery info using multiple joins |
| 25 | Use EXISTS to identify customers with multiple addresses |
| 26 | Find the highest-paid employee in each department using a correlated subquery |
| 27 | List customers who have placed orders with all available sales agents |
| 28 | Find all products that have been ordered more than the average quantity |
| 29 | Use a subquery to get the product with the highest revenue |
| 30 | List departments where the average salary is higher than the company-wide average |
| 31 | Find employees who earn more than their department’s average salary |
| 32 | Get all customers who have placed more orders than customer X |
| 33 | Use a subquery to find the second-highest order value |
| 34 | Return the names of employees who have the same salary as someone in another department |
| 35 | Get products whose price is greater than the average price in their category |
| 36 | List employees whose salary is in the top 10% of their department |
| 37 | Find orders placed on the same day as the customer’s birthday |
| 38 | Find users who have reviewed every product they’ve purchased |
| 39 | Use NOT EXISTS to list customers who have never ordered |
| 40 | Get a list of suppliers who supply products that were never ordered |
| 41 | Find products that are cheaper than all other products in the same category |
| 42 | Write a subquery to find the most recent order per customer |
| 43 | Use a scalar subquery to show the average salary next to each employee |
| 44 | Find customers who spent more than the average customer but made fewer purchases |
| 45 | Use a subquery to check if a product was ever sold at a discount |
| 46 | Find employees whose salary is below the department’s median salary |
| 47 | Use a correlated subquery to show the running total of sales per day |
| 48 | Get all customers who have only purchased items from a single category |
| 49 | Find orders whose total value is more than double the average order value |
| 50 | Use a subquery in the FROM clause to aggregate sales data, then filter |
---

## 💡 Purpose

This project is meant for:

- Practicing SQL joins in real-world scenarios
- Preparing for SQL-based interviews
- Understanding patterns of relational data analysis

---

## 📄 Files

- `sql_join.sql` — Contains all the queries
- `sql_substring.sql` — Contains all subquery queries
- `README.md` — This file, with descriptions and context

---

## 📚 Prerequisites

To run these queries, you’ll need:

- A SQL environment like MySQL, PostgreSQL, SQLite, or SQL Server
- Some mock or sample data for tables like `customers`, `orders`, `employees`, `departments`, `products`, etc.

You can generate dummy datasets using tools like [Mockaroo](https://mockaroo.com) or [DB Fiddle](https://dbfiddle.uk).

---

## 🤝 Contributions

Feel free to fork this repo and:

- Add new types of join examples
- Expand with sample data creation scripts
- Translate into other SQL dialects

---

## 🧠 Tips

- Use `EXPLAIN` to see how your joins are executed
- Practice writing variations using `WINDOW FUNCTIONS`, `CTEs`, and `SUBQUERIES`

---

## 📬 Let’s Connect

If this helped you, consider starring the repo 🌟 or reaching out to collaborate!

Happy querying! 🔍
