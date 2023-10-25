/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created by: Tacy@20231011
	Task: Clean wrong data [Redmine:#194624] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--Dep_ProductStakeLevelGroup
USE bodb02
GO

DELETE FROM Dep_ProductStakeLevelGroup WITH (ROWLOCK)
WHERE SiteID=99
GO