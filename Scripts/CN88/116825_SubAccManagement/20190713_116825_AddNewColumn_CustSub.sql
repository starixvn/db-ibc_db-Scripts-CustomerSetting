/*
	Created: 20190715@Elodie
	Task: Add IsAllDownline, IsDeleted column into CustSub
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/

USE CustDB
GO

ALTER TABLE dbo.custSub ADD IsAllDownline BIT NULL
GO

ALTER TABLE dbo.custSub ADD IsDeleted BIT NULL
GO

