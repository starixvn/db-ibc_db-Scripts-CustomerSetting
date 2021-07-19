/*
	Created by: Elodie
	Date: 20200831
	Task: Alter column CustInfo_history.DangerLevel[Redmine:#140671]		
	DB: DBTP/bodb_CustHistory
*/
--Step 1 : Alter column CustInfo_history.DangerLevel
USE bodb_CustHistory
GO
ALTER TABLE dbo.CustInfo_history DROP COLUMN DangerLevel
GO

ALTER TABLE dbo.CustInfo_history ADD DangerLevel INT NULL