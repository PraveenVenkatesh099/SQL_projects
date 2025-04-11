--26. Find the highest-paid employee in each department using a correlated subquery.
SELECT name, department_id, salary
FROM employees e1
WHERE salary = (
    SELECT MAX(salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
)

--27. Write a query to list customers who have placed orders with all available sales agents.
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT sales_agent_id) = (SELECT COUNT(*) FROM sales_agents);

--28. Find all products that have been ordered more than the average quantity.
SELECT product_id
FROM order_details
GROUP BY product_id
HAVING SUM(quantity) > (
    SELECT AVG(quantity) FROM order_details
);

--29.Use a subquery to get the product with the highest revenue.
SELECT product_id
FROM order_details
GROUP BY product_id
ORDER BY SUM(quantity * price) DESC LIMIT 1;

--30. List departments where the average salary is higher than the company-wide average.
SELECT deaprtment_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

--31. Find employees who earn more than their department’s average salary.
SELECT name, salary
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e1.department_id = e2.deaprtment_id
);

--32. Get all customers who have placed more orders than customer X.
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > (
    SELECT COUNT(*) FROM orders WHERE customer_id ='X'
);

--33.Use a subquery to find the second-highest order value.
SELECT MAX(total_amount) AS second_highest_order
FROM orders
WHERE total_amount < (
    SELECT MAX(total_amount) FROM orders
);

--34. Return the names of employees who have the same salary as someone in another department.
SELECT DISTINCT e1.name
FROM employees e1
WHERE salary IN (
    SELECT salary
    FROM employees e2
    WHERE e2.department_id <> e1.department_id
);

--35. Get products whose price is greater than the average price in their category.
SELECT product_id, name
FROM product p1
WHERE price > (
    SELECT AVG(price)
    FROM product p2
    WHERE p1.category_id = p2.category_id
);

--36. List employees whose salary is in the top 10% of their department.
SELECT * 
FROM employees e1
WHERE salary >= (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

--37. Write a query to find orders placed on the same day as the customer’s birthday.
SELECT *
FROM orders o
WHERE DATE(o.order_date) IN (
    SELECT DATE(birth_date)
    FROM customers
    WHERE customer_id = o.customer_id
);

--38. Find users who have reviewed every product they’ve purchased.
SELECT customer_id
FROM purchases
GROUP BY customer_id
HAVING COUNT(DISTINCT product_id) = (
    SELECT COUNT(DISTINCT product_id)
    FROM reviews r
    WHERE r.customer_id = purchases.customer_id
);

--39.Use NOT EXISTS to list customers who have never ordered.
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
);

--40. Get a list of suppliers who supply products that were never ordered.
SELECT DISTINCT s.supplier_id
FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id
WHERE NOT EXISTS (
    SELECT 1 FROM order_details od WHERE od.product_id = p.product_id
);

--41. Find products that are cheaper than all other products in the same category.
SELECT *
FROM products p1
WHERE price < ALL (
    SELECT price FROM products p2
    WHERE p1.category_id = p2.category_id AND p1.product_id <> p2.product_id
);

--42. Write a subquery to find the most recent order per customer.
SELECT *
FROM orders o1
WHERE order_date = (
    SELECT MAX(order_date) FROM orders o2 WHERE o1.customer_id = o2.customer_id
);

--43.Use a scalar subquery to show the average salary next to each employee.
SELECT name, salary, (
    SELECT AVG(salary) FROM employees
) AS avg_salary
FROM employees;

--44. Find customers who spent more than the average customer but made fewer purchases.
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > (SELECT AVG(total_amount) FROM orders)
   AND COUNT(*) < (SELECT AVG(cnt) FROM (SELECT COUNT(*) AS cnt FROM orders GROUP BY customer_id) AS sub);

--45.Use a subquery to check if a product was ever sold at a discount.
SELECT product_id
FROM order_details
WHERE discount > 0
GROUP BY product_id;

--46. Find employees whose salary is below the department’s median salary.
SELECT *
FROM employees e1
WHERE salary < (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

--47.Use a correlated subquery to show the running total of sales per day.
SELECT order_date, total_amount,
       (
        SELECT SUM(o2.total_amount)
        FROM orders o2
        WHERE o2.order_date <= o1.order_date
       ) AS running_total
FROM orders o1;

--48. Get all customers who have only purchased items from a single category.
SELECT customer_id
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT category_id) = 1;

--49. Find orders whose total value is more than double the average order value.
SELECT order_id
FROM orders
GROUP BY order_id
HAVING SUM(total_amount) > 2 * (SELECT AVG(total_amount) FROM orders);

--50.Use a subquery in the FROM clause to aggregate sales data, then filter.
SELECT *
FROM (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
) AS sales_summary
WHERE total_spent > 1000;