/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20231011
	Task: INITIAL sample data for testing - SIT (SEAL888 site) 
	[Redmine:#194624] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--UPDATE SiteID
UPDATE Dep_ProductStakeLevelGroup WITH (ROWLOCK, UPDLOCK)
SET SiteID=0
, RepUpdateTime=SYSDATETIME()

--add SEAL888 data
INSERT INTO [Dep_ProductStakeLevelGroup]([Sporttype], [GameGroupID], [LicenseeGroupID], [MinBet], [MaxBet], [SiteID], [Remark])
	  SELECT 248, 1, 6, 0.01, 35000, 0, NULL
UNION SELECT 248, 2, 6, 0.01, 17500, 0, NULL
UNION SELECT 248, 1, 6, 0.01, 1300, 875, NULL
UNION SELECT 248, 2, 6, 0.01, 3000, 875, NULL