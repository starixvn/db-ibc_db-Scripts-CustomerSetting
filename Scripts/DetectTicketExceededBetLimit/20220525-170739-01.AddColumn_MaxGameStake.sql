/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220525@Tacy
	Task: Add column MaxGameStake on table StakeLevelGroupDetail, Dep_StakeLevelGroupDetail
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

ALTER TABLE StakeLevelGroupDetail ADD MaxGameStake [decimal](19, 8) NULL;

ALTER TABLE Dep_StakeLevelGroupDetail ADD MaxGameStake [decimal](19, 8) NULL;