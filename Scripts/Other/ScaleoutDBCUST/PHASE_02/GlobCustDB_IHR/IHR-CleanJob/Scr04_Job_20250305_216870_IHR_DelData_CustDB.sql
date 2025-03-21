/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20250305
	Task: in-house - Clean job [Redmine:#216870] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

DELETE FROM RepInfo_CleanData WITH (ROWLOCK)
WHERE TableName IN ('Dep_ProductStakeLevelGroup'
					,'DomainManagement'
					,'ProductStakeLevelGroup'
					,'SportBettypeSettingMatrix'
				)
GO