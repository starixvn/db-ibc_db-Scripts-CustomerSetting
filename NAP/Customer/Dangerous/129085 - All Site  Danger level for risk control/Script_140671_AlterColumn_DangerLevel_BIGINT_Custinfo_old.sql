/*	
	Created by: Elodie
	Date: 20200831
	Task: Alter column Custinfo_Old.DangerLevel[Redmine:#140671]	
	DB: DB05/bodb_customer
*/
USE bodb_customer
GO

ALTER TABLE dbo.Custinfo_Old DROP COLUMN DangerLevel
GO

ALTER TABLE dbo.Custinfo_Old ADD DangerLevel BIGINT NULL