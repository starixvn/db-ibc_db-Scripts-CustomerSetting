/*
	Created: 20200312@Tiara
	Date: 20200327
	Task: Update LossLimit_GlobalSetting Revert [Redmine: #128058]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE L
SET L.ProductId = 21
FROM LossLimit_GlobalSetting L WITH (ROWLOCK,UPDLOCK)
WHERE L.ProductId = 41