/*
	Created: 20190715@Elodie
	Task: Add PageAccessControl column into CustSuper
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/

USE CustDB
GO

ALTER TABLE dbo.CustSuper ADD PageAccessControl VARCHAR(50) NULL
GO

