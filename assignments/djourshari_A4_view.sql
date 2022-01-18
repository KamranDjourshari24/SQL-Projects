USE ap;
CREATE OR REPLACE VIEW overdue_accounts AS
	SELECT vendor_name AS "Vendor's Name", invoice_due_date AS "Invoice Due Date",
		terms_due_days AS "Terms Due Days", 
        DATEDIFF('2014-09-10', invoice_date) AS "Number of Days From Invoicing", 
        DATEDIFF('2014-09-10', invoice_due_date) AS "Number of Days Overdue",
        CONCAT("$", FORMAT(invoice_total - payment_total - credit_total, 2)) AS "Total Balance Due"
	FROM invoices 	
		JOIN vendors
			USING(vendor_id)
		JOIN terms
			USING(terms_id)
	WHERE payment_date IS NULL AND invoice_due_date < '2014-09-10'
    ORDER BY DATEDIFF('2014-09-10', invoice_due_date) DESC, vendor_name;



-- --> TEST YOUR CODE:
SELECT * FROM overdue_accounts;
    

