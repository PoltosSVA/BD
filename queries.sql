Запросы с несколькими условиями:
----- Отзывы к магазинам за первый квартал 2022 -----
	SELECT * FROM review
	WHERE EXTRACT(YEAR FROM review.date)<2023 and EXTRACT(MONTH FROM review.date)<4
----- Работники у которых возраст между (18 и 25) и опыт больше 2-х лет -----
	SELECT * FROM employee
	WHERE age BETWEEN 18 and 25
	and experience >2
Запросы с вложенными конструкциями:
----- Поиск отзывов оценка котрых больше чем средняя оценка по всем отзывам -----
	SELECT * FROM review
	WHERE rate > (SELECT AVG(rate) FROM review)
----- Поиск продуктов от определенного поставщика ----- 
	SELECT title, amount, products.cost FROM products
	WHERE supplier_id = (SELECT suppliers.id FROM suppliers WHERE company_name = 'Yotz')
JOIN запросы:
	----- RIGHT JOIN (кол-во активных и завершенных заказов) -----
	SELECT status,COUNT(status) as "Finished_count" FROM customer
	RIGHT JOIN orders
	ON customer.id = orders.id
	GROUP BY Status;
	----- INNER JOIN (Получаем заказы и общую стоимость каждого, стоимость заказа должна быть > 10, заказы отсортированы по возрастанию цены заказа) -----
SELECT order_id,  SUM(amount*products.cost) as "order_cost" FROM orders_products
INNER JOIN orders on orders.id = orders_products.order_id
INNER JOIN products on products.id = orders_products.product_id
GROUP BY order_id
HAVING SUM(amount*products.cost)>10
ORDER BY order_cost ASC;
----- LEFT JOIN(Получаем автора статьи и её название) -----
SELECT Concat(first_name,' ',last_name) as "Author",title,article.id FROM article
LEFT JOIN users
ON author_id = users.id
----- Получение оценок в текстовом формате ------
SELECT rate, id,
    CASE
        WHEN rate = 5 THEN 'five'
        WHEN rate = 4 THEN 'four'
        WHEN rate = 3 THEN 'three'
        WHEN rate = 2 THEN 'two'
        WHEN rate = 1 THEN 'one'
        ELSE 'None' END AS word
FROM review;
----- Есть ли работники возрастом старше 22 лет -----
SELECT first_name FROM employee
INNER JOIN users ON users.id = users_id
WHERE EXISTS(
	SELECT employee.id
	FROM employee
	WHERE age>22 AND employee.id =users.id
);
----- INSERT INTO SELECT (Получаем id и usernames всех users)-----
CREATE TABLE attendence_list (
    userID int,
    userName VARCHAR(255)
    );
INSERT INTO attendence_list(userID, userName)
SELECT users.id, username FROM users
