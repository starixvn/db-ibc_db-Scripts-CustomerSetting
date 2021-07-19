/*
	Created by: Eden
	Date: 20200224
	Task: add new column CustInfo_history.DangerLevel[Redmine:#129085]		
	DB: DBTP/bodb_CustHistory
*/
--Step 1 : add new column CustInfo_history.DangerLevel
USE bodb_CustHistory
GO
ALTER TABLE dbo.CustInfo_history ADD DangerLevel TINYINT
GO