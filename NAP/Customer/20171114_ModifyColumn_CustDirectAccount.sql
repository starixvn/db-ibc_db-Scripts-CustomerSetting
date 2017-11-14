/*
	Created: 20171114@Elodie
	Task: Modify column of CustDirectAccount
	DB: DBCUST/CustDB
*/
USE CustDB
GO

ALTER TABLE dbo.CustDirectAccount ALTER COLUMN ProcessedBy NVARCHAR(100)
ALTER TABLE dbo.CustDirectAccount ALTER COLUMN Boss NVARCHAR(100)
ALTER TABLE dbo.CustDirectAccount ALTER COLUMN RequestedBy NVARCHAR(100)
ALTER TABLE dbo.CustDirectAccount ALTER COLUMN ApprovedBy NVARCHAR(100)