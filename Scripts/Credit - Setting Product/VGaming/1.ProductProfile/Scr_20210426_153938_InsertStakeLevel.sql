/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Insert GameGroup, stake level for VGaming [#RM:153938]
	DB: DBCUST/CustDB
*/

USE CustDB
GO
DECLARE @Bettype int = 3801, @Sporttype smallint = 171, @GameGroupID TINYINT = 25

INSERT INTO	dbo.GameGroup (GameGroupID, RefSportType, RefBetType, GroupName, IsDeposit)      
SELECT @GameGroupID, @Sporttype, @Bettype, 'Level 1', 0

INSERT INTO dbo.StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID)
SELECT @Bettype, NULL, NULL, NULL, NULL, exchangeid, NULL, @GameGroupID
FROM dbo.exchange WITH (NOLOCK)
WHERE exchangeid = 20

INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT StakeLevelID, GameTypeID, '0.01', '50,000', 0.01, 50000, NULL
FROM dbo.StakeLevel t WITH (NOLOCK)
WHERE GameTypeID = @Bettype  AND ExchangeId = 20

SELECT * FROM dbo.GameGroup WITH (NOLOCK) WHERE RefBetType = @Bettype 
SELECT * FROM dbo.StakeLevel WITH (NOLOCK) WHERE GameTypeID = @Bettype
SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = @Bettype

/*
DELETE FROM dbo.GameGroup WITH (ROWLOCK) WHERE RefBetType = 3801
DELETE FROM dbo.StakeLevel WITH (ROWLOCK) WHERE GameTypeID = 3801
DELETE FROM dbo.StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 3801
*/
