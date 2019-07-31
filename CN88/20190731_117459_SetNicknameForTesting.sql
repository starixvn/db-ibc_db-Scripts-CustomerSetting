

USE CustDB
GO

UPDATE c 
SET username2 = 'CN88$super8813'
FROM customer c WITH (ROWLOCK) 
WHERE username = 'supertestshcn8813'

--SELECT username2, * FROM vw_customer WHERE username = 'supertestshcn8813'