/*
	Created: Elodie
	Date: 20200323
	Task: DELETE existed stake level for Virtual game DEPOSIT
	DB: DBCust/CustDB
*/
USE CustDB
GO

DELETE FROM dbo.Dep_StakeLevel WHERE GameTypeID = 4601 AND SiteID IS NULL