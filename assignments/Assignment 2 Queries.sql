/* Question 1 */
USE my_guitar_shop;
DROP TABLE IF EXISTS customers_copy;
DROP TABLE IF EXISTS products_copy;
DROP TABLE IF EXISTS addresses_copy;

CREATE TABLE customers_copy LIKE customers;
INSERT INTO customers_copy
SELECT *
FROM customers;

CREATE TABLE products_copy LIKE products;
INSERT INTO products_copy
SELECT *
FROM products;

CREATE TABLE addresses_copy LIKE addresses;
INSERT INTO addresses_copy
SELECT *
FROM addresses;



/* Question 2 */
USE my_guitar_shop;
INSERT INTO customers_copy 
	(email_address, password, first_name, last_name, shipping_address_id, 
    billing_address_id)
VALUES
	("pduffy@murach.com", "7a718fbd768d2378z511f8249b54897f940e9023",
	"Pamela", "Duffy", 10, 1);



/* Question 3 */
USE my_guitar_shop;
INSERT INTO products_copy
VALUES
	(11, 4, "pk_100", "Yamaha PK-100","The Yamaha PK-100 88-key weighted action digital piano has a Graded
	Hammer Standard Action, 192-note Polyphony, 24 Sounds, Stereo Sound System, EQ,
	and Drum Patterns/Virtual Accompaniment - Black", 749.99, 25.00, NOW());


 
/* Question 4 */
USE my_guitar_shop;
UPDATE products_copy
SET list_price = 1300.00, discount_percent = 65.00
WHERE product_id = 11;



/* Question 5 */
SET SQL_SAFE_UPDATES = 0;
USE my_guitar_shop;
UPDATE addresses_copy
SET disabled = 1
WHERE state = "NJ" OR state = "NY";
SET SQL_SAFE_UPDATES = 1;



/* Answer 6 */
USE my_guitar_shop;
SET SQL_SAFE_UPDATES = 0;
SELECT item_price, 
	ROUND((list_price*(100-discount_percent)/100) + ship_amount + tax_amount, 2) AS total_return, order_id, 
    CONCAT(first_name, " ", last_name) AS customer_name,
	CONCAT(line1, " ", line2, " ", city) AS address, state
FROM order_items oi
	JOIN orders o
		USING(order_id)
	JOIN customers c
		ON c.customer_id = o.customer_id
	JOIN addresses a
		ON o.ship_address_id = a.address_id
	JOIN products p
		USING(product_id)
WHERE oi.product_id = 5;

DELETE FROM order_items
WHERE order_id IN
	(5,6);

DELETE FROM orders
WHERE order_id IN
	(5,6);
SET SQL_SAFE_UPDATES = 1;



