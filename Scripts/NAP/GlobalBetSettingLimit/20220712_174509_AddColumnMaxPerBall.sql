/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220712@Tacy
	Task: Add new column MaxPerBall for tables ProductBetSetting, Dep_ProductBetSetting [redmine:#174509]
	DB: DBCust/CustDB
*/

USE CustDB
GO

ALTER TABLE ProductBetSetting ADD MaxPerBall [decimal](19, 8) NULL
GO

ALTER TABLE Dep_ProductBetSetting ADD MaxPerBall [decimal](19, 8) NULL
GO