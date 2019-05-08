/*
	Created: Elodie@20190508
	DB: DBCUST/CustDB
	Task: add new column username2 into CustSearch [redmine: #113044]	
*/
USE CustDB
GO

ALTER TABLE dbo.custSearch ADD username2 VARCHAR(50) NULL