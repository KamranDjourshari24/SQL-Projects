/*Answer 1*/ 
USE ap; 
SELECT vendor_name AS Vendor, CONCAT(vendor_contact_last_name, ", ", vendor_contact_first_name) AS "Vendor Contact",
	CONCAT("Phone #: ", vendor_phone) AS "Contact's Number", 
	CONCAT("State: ", vendor_state, ", City: ", vendor_city) AS "Vendor Location"
FROM vendors
WHERE vendor_state != "CA"
ORDER BY vendor_state, vendor_city, vendor;



/*Answer 2*/ 
USE om;
	SELECT CONCAT(customer_last_name, ", ", customer_first_name) AS customer_name, order_date, 
		shipped_date, customer_state
	FROM customers INNER JOIN orders
		USING(customer_id)
	WHERE shipped_date IS NOT NULL
UNION
	SELECT CONCAT(customer_last_name, ", ", customer_first_name), order_date, 
		"Not Yet Shipped", customer_state
	FROM customers INNER JOIN orders
		USING(customer_id)
	WHERE shipped_date IS NULL
ORDER BY order_date DESC, shipped_date;



/*Answer 3*/
USE ap;
SELECT v.vendor_name AS "Vendor Name", CONCAT(vc.first_name, " ", vc.last_name) AS "Vendor Contact Name",
	i.invoice_total AS "Invoice Total", i.invoice_due_date AS "Due Date", i.payment_date AS "Payment Date"
FROM vendors v
	LEFT JOIN invoices i
		USING(vendor_id)
	LEFT JOIN vendor_contacts vc
		USING(vendor_id)
ORDER BY v.vendor_name, i.invoice_total DESC, i.invoice_due_date DESC;



/*Answer 4*/
USE ap;
SELECT CONCAT(vendor_city, ", ", vendor_state) AS "Vendor City/State", vendor_name AS "Vendor Name", 
	ili.invoice_id AS "Invoice ID", ili.line_item_description AS "Line Item Description", 
	ili.account_number AS "Account Number"
FROM vendors v  
	LEFT JOIN invoices i 
		ON v.vendor_id = i.vendor_id
	INNER JOIN invoice_line_items ili 
		ON v.default_account_number = ili.account_number
WHERE vendor_state >= "EZ" AND vendor_state <= "KZ"
ORDER BY vendor_state, vendor_city, vendor_name, ili.line_item_description;
	



