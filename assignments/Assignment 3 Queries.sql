/* Question 1 */
USE my_guitar_shop;
SELECT product_name AS "Product Name", SUM(quantity) AS "Number Purchased", 
	CONCAT("$", FORMAT(SUM(item_price*quantity)- SUM(discount_amount*quantity), 2)) AS "Total of Orders",
	CONCAT("$", FORMAT(AVG(discount_amount), 2)) AS "Average Discount"	
FROM products INNER JOIN order_items
	USING(product_id)
GROUP BY product_name WITH ROLLUP;



/* Question 2 */
USE my_guitar_shop;
SELECT p.product_name AS "Product Name", CONCAT("$", FORMAT(list_price, 2)) AS "List Price",
	c.category_name AS "Category", p.description AS "Description"
FROM products p
	LEFT JOIN order_items oi
		USING(product_id)
	LEFT JOIN orders o
		ON o.order_id = oi.order_id
	INNER JOIN categories c
		USING(category_id)
WHERE p.list_price <
	(	SELECT AVG(list_price)
		FROM products 
			INNER JOIN order_items oi 
				USING(product_id)
			INNER JOIN orders o
				ON o.order_id = oi.order_id
		WHERE ship_date IS NOT NULL
	)
GROUP BY product_name
ORDER BY list_price;



/* Question 3 */
USE my_guitar_shop;
WITH not_east_coast AS
	(SELECT c.customer_id, CONCAT(last_name, ", ", first_name) AS customer_name, 
		CONCAT(line1, " ", line2) AS address, 
        city AS customer_city, state AS customer_state
	FROM customers c
		LEFT JOIN orders o
			ON c.customer_id = o.customer_id
		LEFT JOIN addresses a
			ON a.address_id = c.shipping_address_id
	WHERE state NOT IN
		("NJ","NY")
	GROUP BY customer_id
	)

SELECT customer_name, o.order_id, order_date, product_name, 
	address, customer_state, item_price
FROM not_east_coast nce
	LEFT JOIN orders o
		USING(customer_id)
	LEFT JOIN order_items oi	
		ON o.order_id = oi.order_id
	INNER JOIN products p
		ON p.product_id = oi.product_id
ORDER BY customer_name, order_date DESC;
