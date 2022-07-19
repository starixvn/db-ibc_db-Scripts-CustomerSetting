/*<info serverAlias="DBCUST-CustDB, DBTP-bodb02"></info>*/
/*
	Created: 20220712@Tacy
	Task: Add new column MaxPerBall for tables Dep_ProductBetSetting [redmine:#174509]
	DB: DBCust/CustDB, DBTP/bodb02
*/
ALTER TABLE Dep_ProductBetSetting ADD MaxPerBall [decimal](19, 8) NULL
GO