COUNT OF FINISHED AND ACTIVE ORDERS:
	SELECT status,COUNT(status) as "Finished_count" FROM customer
RIGHT JOIN orders
	ON customer.id = orders.id
GROUP BY Status;


ORDERS AND THEIR COST:
	SELECT order_id,  SUM(amount*products.cost) as "order_cost" FROM orders_products
INNER JOIN orders on orders.id = orders_products.order_id
INNER JOIN products on products.id = orders_products.product_id
GROUP BY order_id
HAVING SUM(amount*products.cost)>10
ORDER BY order_cost ASC;


LEFT JOIN:
	SELECT status,COUNT(status) as "Finished_count" FROM customer
LEFT JOIN orders
	ON customer.id = orders.id
GROUP BY Status
HAVING status is not null;


INDEX:
	CREATE INDEX idx_users_last_name
ON users(last_name);
;
 
EXPLAIN SELECT last_name FROM users WHERE last_name = 'Cafe';
DROP INDEX idx_users_first_name;

SELECT rate FROM review WHERE rate > 2 AND rate < 4;




SELECT rate 
FROM review 
WHERE rate > (
    SELECT AVG(rate)
    FROM review
    )




SELECT first_name FROM employee
INNER JOIN users ON users.id = users_id
WHERE EXISTS(
	SELECT employee.id
	FROM employee
	WHERE age>22 AND employee.id =users.id
);



SELECT * FROM article
WHERE EXTRACT(MONTH FROM article.date) <10;