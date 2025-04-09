--1. Write a query to find all customers who placed more than one order in a single day
SELECT customer_id, customer_name, order_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id, order_date
HAVING COUNT(*) > 1;

--2. Get the details of employees who do not have a department assigned (LEFT JOIN with NULL check).
SELECT e.*
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

--3. Find the second-highest salary in each department using a self-join.
SELECT e1.department_id, MAX(e1.salary) AS second_highest_salary
FROM employees e1
JOIN employees e2 ON e1.department_id = e2.deaprtment_id AND e1.salary < e2.salary
GROUP BY e1.deaprtment_id;

--4. Join employee and department tables to find departments with no employees.
SELECT d.*
FROM departments d
LEFT JOIN employees e ON d.department_id = e.deaprtment_id
WHERE e.employee_id IS NULL;

--5. Find all customers who ordered only once using LEFT JOIN and aggregation.
SELECT c.*
FROM customers c
LEFT JOIN orders o ON c.cusrtomer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) = 1;

--6. Use a FULL OUTER JOIN to find mismatched records between two tables.
SELECT *
FROM table t1
FULL OUTER JOIN table t2 ON t1.id = t2.id
WHERE t1.id IS NULL OR t2.id IS NULL;

--7. Find products that have never been ordered using an ANTI JOIN (LEFT JOIN + IS NULL).
SELECT p.*
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE o.product_id IS NULL;

--8. Use CROSS JOIN to generate all possible pairs of employees and projects.
SELECT e.employee_id, p.project_id
FROM employees e
CROSS JOIN projects p;

--9. Find employees who share the same manager using a self-join.
SELECT e1.employee_id, e2.employee_id AS co-worker_id, e1.manager_id
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.manager_id AND e1.employee_id <> e2.employee_id

--10.Join customer and orders to find the top spender per city.
SELECT city, customer_id, SUM(total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY city, customer_id
QUALIFY RANK() OVER (PARTITION BY city ORDER BY SUM(total_amount) DESC) = 1;
#QUALIFY is an snowflake feature will not work in MySql

--Using CTE(Common Table Expression)
WITH ranked_customers AS (
    SELECT 
        c.city,
        c.customer_id,
        SUM(o.total_amount) AS total_spent,
        RANK() OVER (PARTITION BY c.city ORDER BY SUM(o.total_amount) DESC) AS rnk
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.city, c.customer_id
)
SELECT city, customer_id, total_spent
FROM ranked_customers
WHERE rnk = 1;

--11.Use a JOIN to calculate the average order value per customer.
SELECT c.customer_id, c.name, AVG(o.total_amount) AS avg_order_value
FROM customers c
JOIN orders o ON c.cusrtomer_id = o.customer_id
GROUP BY c.customer_id, c.name

--12.Join products and order details to find the most sold product in each category.
SELECT category_id, product_id, SUM(quantity) AS total_sold
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY category_id, product_id
QUALIFY RANK() OVER (PARTITION BY category_id ORDER BY SUM(quantity) DESC) = 1;
#QUALIFY is an snowflake feature will not work in MySql

#Using CTE(Common Table Expression)
WITH ranked_products AS (
    SELECT 
        p.category_id, p.product_id, SUM(od.quantity) AS total_sold,
        RANK() OVER (PARTITION BY p.category_id ORDER BY SUM(od.quantity) DESC) AS rank
    FROM products p
    JOIN order_details od ON p.product_id = od.product_id
    GROUP BY p.category_id, p.product_id
)
SELECT category_id, product_id, total_sold
FROM ranked_products
WHERE rank = 1;

-- 13.Combine two sales tables (same structure) from different years using UNION ALL,then join with products.
SELECT s.*, p.product_name
FROM (
    SELECT * FROM sales_2023
    UNION ALL
    SELECT * FROM sales_2024
) s JOIN products p ON s.product_id = p.product_id;

--14. Write a query to show customers who have never logged in using LEFT JOIN and login table.
SELECT c.*
FROM customers c
LEFT JOIN logins l ON c.customer_id = l.customer_id
WHERE l.login_id IS NULL;

--15. Show all employees with and without projects using LEFT JOIN and a CASE expression.
SELECT e.employee_id,
       CASE WHEN ep.project_id IS NULL THEN 'No Project' ELSE 'Has Project' END AS project_status
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id;

--16.Join orders with payments to check for unpaid orders.
SELECT 0.*
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;

--17.Use a self-join to find employees who have the same job title as someone else.
SELECT e1.employee_id, e2.employee_id AS peer_id, e1.job_title
FROM employees e1
JOIN employees e2 ON e1.job_title = e2.job_title AND e1.employee_id <> e2.employee_id;

--18.Create a report of customers who have ordered all products in a specific category.
SELECT c.customer_id, c.name
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN product p ON od.product_id = p.product_id
WHERE p.category_id = 2 --getting customers from specific category say 2 here.
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.product_id) = (
    SELECT COUNT(*) FROM products WHERE category_id = 2
);

--19.Use a RIGHT JOIN to identify regions with no assigned sales reps.
SELECT r.*
FROM sales_reps s
RIGHT JOIN regions r ON s.region_id = r.region_id
WHERE s.rep_id IS NULL;

--20.Join invoices and customers, and flag invoices that exceed the customer’s credit limit.
SELECT i.*,
        CASE WHEN i.amount > c.credit_limit THEN 'Exceeded' ELSE 'IN LIMIT' END AS status
FROM invoices i
JOIN customers c ON i.customer_id = c.customer_id;

--21. Find orders where the shipping address and billing address are from different cities.
SELECT * FROM orders
WHERE shipping_city <> billing_city;

--22.Use a join to find duplicate email addresses in the customer table.
SELECT DISTINCT c1.email
FROM customers c1
JOIN customers c2 ON c1.email = c2.email AND c1.customer_id <> c2.customer_id;


--23.Join to find users who placed an order in the last 30 days but not before that.
SELECT DISTINCT o.customer_id
FROM orders o
WHERE o.order_date >= CURRENT_DATE - INTERVAL '30' DAY
AND o.customer_id NOT IN (
    SELECT customer_id FROM orders WHERE order_date < CURRENT_DATE - INTERVAL '30' DAY
);

--24.Use multiple joins to get order details including customer, product, and delivery info.
SELECT o.order_id, c.name, p.product_name, d.delivery_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN deliveries d ON o.order_id = d.order_id;

--25.Use EXISTS in place of joins to identify customers with multiple addresses.
SELECT c.*
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM addresses a1
    JOIN addresses a2 ON a1.customer_id = a2.customer_id AND a1.address_id <> a2.address_id
    WHERE a1.customer_id = c.customer_id
);
