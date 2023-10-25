/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created by: Tacy@20231005
	Task: DELETE sample data for testing - SIT [Redmine:#194624] 
	DB:	DBCUST-CustDB,DBACC-bodb02,DBTP-bodb02
*/
DELETE FROM [ProductStakeLevelGroup] WITH (ROWLOCK)
GO

DELETE FROM [Dep_ProductStakeLevelGroup] WITH (ROWLOCK)
GO