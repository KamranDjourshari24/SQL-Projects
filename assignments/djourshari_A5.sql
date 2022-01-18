/* Question 1 */
USE ap;
SET SESSION sql_safe_updates = FALSE;
SET GLOBAL max_connections = 51;
SET SESSION autocommit = ON;
SET SESSION autocommit = OFF;
SET GLOBAL long_query_time = 7;
SET SESSION cte_max_recursion_depth = 500; 
SELECT @@SESSION.sql_safe_updates;
SELECT @@GLOBAL.max_connections;
SELECT @@SESSION.autocommit;
SELECT @@GLOBAL.long_query_time;
SELECT @@SESSION.cte_max_recursion_depth;
SHOW VARIABLES;



/* Question 2 */
USE ap;
CREATE USER thechild@localhost IDENTIFIED BY 'yoda' PASSWORD EXPIRE INTERVAL 60 DAY;
CREATE USER moff@localhost IDENTIFIED BY 'gideon' PASSWORD EXPIRE INTERVAL 60 DAY;
CREATE USER din_superuser@localhost IDENTIFIED BY 'beskar' PASSWORD EXPIRE INTERVAL 60 DAY;
CREATE USER omera_dev@localhost IDENTIFIED BY 'sorgan' PASSWORD EXPIRE INTERVAL 60 DAY;
RENAME USER thechild@localhost TO grogu@localhost;
ALTER USER grogu@localhost IDENTIFIED BY 'jedi';
DROP USER IF EXISTS moff@localhost;



/* Question 3 */
USE ap;
GRANT SELECT, UPDATE, INSERT, DELETE 
	ON my_guitar_shop.*
	TO din_superuser@localhost;
GRANT SELECT, UPDATE, INSERT
	ON my_guitar_shop.*
	TO omera_dev@localhost;
GRANT SELECT 
	ON my_guitar_shop.*
	TO grogu@localhost;
GRANT UPDATE
	ON my_guitar_shop.customers
	TO grogu@localhost;
REVOKE ALL, GRANT OPTION
	FROM grogu@localhost;
REVOKE INSERT
	ON my_guitar_shop.* FROM omera_dev@localhost;



/* Question 4 */
USE ap;
SELECT User, Host FROM mysql.user
ORDER BY Host, User; 
SHOW GRANTS FOR current_user;
SHOW GRANTS FOR grogu@localhost;
SHOW GRANTS FOR din_superuser@localhost;
SHOW GRANTS FOR omera_dev@localhost;
DROP USER IF EXISTS moff@localhost;
DROP USER IF EXISTS thechild@localhost;
DROP USER IF EXISTS din_superuser@localhost;
DROP USER IF EXISTS omera_dev@localhost;
DROP USER IF EXISTS grogu@localhost;
