/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/03/28
	Task: Initial data test For QC
	DB: DBCUST/CUSTDB

	Revisions:
		- Change the bet limit setting for Nova88, 789y, IBCBet & licensees [RM:#181686]
*/

DECLARE @MaxStakeLevelID INT

SELECT @MaxStakeLevelID = MAX(StakeLevelID) 
FROM Dep_StakeLevel (NOLOCK)

INSERT INTO [dbo].[Dep_StakeLevel]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[GameGroupID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ExchangeID]
           ,[ResourceId]
           ,[SiteID])
SELECT @MaxStakeLevelID + 1  , 7000 , 38 , NULL , NULL , NULL , NULL , 51 , NULL , NULL

INSERT INTO [dbo].[Dep_StakeLevelGroupDetail]
           ([StakeLevelID]
           ,[GameTypeID]
           ,[MinLabel]
           ,[MaxLabel]
           ,[MinStake]
           ,[MaxStake]
           ,[ParentTypeID]
           ,[MaxGameStake])
SELECT @MaxStakeLevelID + 1 , 7000 , 1 , 20 , 1.00000000	, 20.00000000 , NULL , NULL
