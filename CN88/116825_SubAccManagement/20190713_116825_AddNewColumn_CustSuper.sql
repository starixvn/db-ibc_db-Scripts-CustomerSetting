/*
	Created: 20190422@Elodie
	Task: Add username2 column into CustSub
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/

USE CustDB
GO

ALTER TABLE dbo.CustSuper ADD PageAccessControl VARCHAR(50) NULL
GO

