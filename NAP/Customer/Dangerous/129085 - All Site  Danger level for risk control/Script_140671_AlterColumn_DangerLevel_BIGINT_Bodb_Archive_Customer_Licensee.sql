/*	
	Created by: Elodie
	Date: 20200831
	Task: Alter column CustInfo.DangerLevel[Redmine:#140671]	
	DB: DB05/Bodb_Archive_Customer_Licensee
*/
USE Bodb_Archive_Customer_Licensee
GO
ALTER TABLE dbo.CustInfo DROP COLUMN DangerLevel
GO

ALTER TABLE dbo.CustInfo ADD DangerLevel BIGINT NULL
