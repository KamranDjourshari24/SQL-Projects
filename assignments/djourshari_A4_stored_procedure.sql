USE ap;
DROP PROCEDURE IF EXISTS owed_to_state_vendors;

DELIMITER //
CREATE PROCEDURE owed_to_state_vendors
(
	state_abbreviation	VARCHAR(50)
)

BEGIN
	SELECT vendor_name AS "Name of Vendor", 
		CONCAT("$", FORMAT(invoice_total - payment_total - credit_total, 2)) AS "Total Amount Owed"
	FROM invoices JOIN vendors
		USING(vendor_id)
	WHERE vendor_state = state_abbreviation 
		AND invoice_total - payment_total - credit_total IN
			(SELECT SUM(invoice_total - payment_total - credit_total)
			FROM invoices JOIN vendors 
				USING(vendor_id)
			GROUP BY vendor_id
			HAVING SUM(invoice_total - payment_total - credit_total) > 0
			);
END //

DELIMITER ;



-- --> TEST YOUR CODE:
CALL owed_to_state_vendors('CA');
-- --- Do your see two rows with the following values?
-- --- 
-- --- 'Blue Cross', '224.00'
-- --- 'Ford Motor Credit Company', '503.20'
-- --- 
-- --- If "Yes", you have built the stored procedure as required; 
-- --- if "No", continue working on it.