select *
from customers;

-----cleaning names

SET SQL_SAFE_UPDATES = 0;


UPDATE customers
SET name = CONCAT(
UPPER(LEFT(name, 1)),
LOWER(SUBSTRING(name, 2))
)
WHERE name IS NOT NULL;

----- Cleaning cities
UPDATE customers
SET city = CONCAT(
UPPER(LEFT(city, 1)),
LOWER(SUBSTRING(city, 2))
)
WHERE city IS NOT NULL;

---- device_type

UPDATE customers
SET device_type = CONCAT(
UPPER(LEFT(device_type, 1)),
LOWER(SUBSTRING(device_type, 2))
)
WHERE device_type IS NOT NULL;

----maketing_source

UPDATE customers
SET marketing_source = CONCAT(
UPPER(LEFT(SUBSTRING_INDEX(TRIM(marketing_source), ' ', 1), 1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(marketing_source), ' ', 1), 2)),
' ',
UPPER(LEFT(SUBSTRING_INDEX(TRIM(marketing_source), ' ', -1), 1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(marketing_source), ' ', -1), 2))
)
WHERE marketing_source LIKE '% %' AND marketing_source NOT LIKE '% % %';

-----signup_date

UPDATE customers
SET signup_date = CASE
WHEN signup_date REGEXP '^[0-9]{0,2}/[0-9]{1,2}/[0-9]{4}$'
 THEN STR_TO_DATE(signup_date, '%d/%m/%Y')

WHEN signup_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
THEN STR_TO_DATE(signup_date, '%Y-%m-%d')

WHEN signup_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
THEN STR_TO_DATE(signup_date, '%b %d, %Y') 
ELSE STR_TO_DATE('29/09/2002', '%d/%m/%Y')
END
WHERE signup_date IS NOT NULL;

engagement


SELECT *
FROM engagement;

----last_active_date

UPDATE engagement
SET last_active_date = CASE
WHEN last_active_date REGEXP '^[0-9]{0,2}/[0-9]{1,2}/[0-9]{4}$'
 THEN STR_TO_DATE(last_active_date, '%d/%m/%Y')

WHEN last_active_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
THEN STR_TO_DATE(last_active_date, '%Y-%m-%d')

WHEN last_active_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
THEN STR_TO_DATE(last_active_date, '%b %d, %Y') 
ELSE STR_TO_DATE('29/09/2002', '%d/%m/%Y')
END
WHERE last_active_date IS NOT NULL;

---favourite_genre

UPDATE engagement
SET favourite_genre = CONCAT(
UPPER(LEFT(favourite_genre, 1)),
LOWER(SUBSTRING(favourite_genre, 2))
)
WHERE favourite_genre IS NOT NULL;

SELECT *
FROM subscriptions;

---CLEANING_renewal_date

UPDATE subscriptions
SET renewal_date = CASE
WHEN renewal_date REGEXP '^[0-9]{0,2}/[0-9]{1,2}/[0-9]{4}$'
 THEN STR_TO_DATE(renewal_date, '%d/%m/%Y')

WHEN renewal_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
THEN STR_TO_DATE(renewal_date, '%Y-%m-%d')

WHEN renewal_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
THEN STR_TO_DATE(renewal_date, '%b %d, %Y') 
ELSE STR_TO_DATE('29/09/2002', '%d/%m/%Y')
END
WHERE renewal_date IS NOT NULL;


---CLEANING cancel_date
UPDATE subscriptions
SET cancel_date = CASE
WHEN cancel_date REGEXP '^[0-9]{0,2}/[0-9]{1,2}/[0-9]{4}$'
 THEN STR_TO_DATE(cancel_date, '%d/%m/%Y')

WHEN cancel_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
THEN STR_TO_DATE(cancel_date, '%Y-%m-%d')

WHEN cancel_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
THEN STR_TO_DATE(cancel_date, '%b %d, %Y') 
ELSE STR_TO_DATE('29/09/2002', '%d/%m/%Y')
END
WHERE cancel_date IS NOT NULL;

-----CLEANING PLAN

UPDATE subscriptions
SET plan = CONCAT(
UPPER(LEFT(plan, 1)),
LOWER(SUBSTRING(plan, 2))
)
WHERE plan IS NOT NULL;

-----CLEANING STATUS

UPDATE subscriptions
SET status = CONCAT(
UPPER(LEFT(status, 1)),
LOWER(SUBSTRING(status, 2))
)
WHERE status IS NOT NULL;

SELECT *
FROM support_tickets;

--_CLEANING_ticket_category


UPDATE support_tickets
SET ticket_category = CONCAT(
UPPER(LEFT(ticket_category, 1)),
LOWER(SUBSTRING(ticket_category, 2))
)
WHERE ticket_category IS NOT NULL;

-----CLEANING-ticket_resolution_time

UPDATE support_tickets
SET ticket_resolution_time = CASE
WHEN ticket_resolution_time IS NULL THEN NULL
WHEN ticket_resolution_time REGEXP '^[0-9]+$' THEN 
CASE 
WHEN CAST(ticket_resolution_time AS UNSIGNED) = 1 
THEN '1 DAY'
ELSE CONCAT(ticket_resolution_time, ' DAYS')
END
ELSE ticket_resolution_time
END;
