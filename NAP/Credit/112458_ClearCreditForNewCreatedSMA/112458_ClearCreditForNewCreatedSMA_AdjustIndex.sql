/*	
	Created: Elodie
	Date: 2019-05-08
	Task: Adjust index on CustomerClearCredit
	DB: DBCUST/CustDB
*/

ALTER TABLE dbo.CustomerClearCredit  
DROP CONSTRAINT [PK__Customer__973AFEFE4CB5A3C5]  
WITH (ONLINE = ON)

GO
ALTER TABLE dbo.CustomerClearCredit ALTER COLUMN Batch TINYINT NOT NULL

GO
ALTER TABLE dbo.CustomerClearCredit 
ADD CONSTRAINT PK_CustomerClearCredit PRIMARY KEY CLUSTERED (Batch, custid)