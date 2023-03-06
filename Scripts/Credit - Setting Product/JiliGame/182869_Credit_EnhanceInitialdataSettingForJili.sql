/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230303@Helios
	Task: Enhance Initial data Setting For Jili [redmine:#182869]
	DB: DBCust/CustDB
*/
DECLARE @tmp_StakeLevel TABLE (StakeLevelID INT)  

DECLARE @BetType SMALLINT , @GameGroupID SMALLINT
		
SELECT  @BetType = 5100 , @GameGroupID = 41



---- Update New BetType For JiliGames
--SELECT *
UPDATE p SET BetType = 5160
FROM [ProductSettingDetail] p WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 18 AND [SportType] = 158 AND BetType = @BetType and [SettingType] = 8

-- COLLECT Data Temp
INSERT INTO @tmp_StakeLevel
SELECT StakeLevelID FROM StakeLevel s WITH(ROWLOCK,UPDLOCK) WHERE GameGroupID = @GameGroupID AND GameTypeID = @BetType


---- DELETE StakeLevelGroupDetail --> SAS Initial Againt New Values
--SELECT *
DELETE sl
FROM StakeLevelGroupDetail sl WITH(ROWLOCK,UPDLOCK) WHERE StakeLevelID IN (SELECT * FROM @tmp_StakeLevel)


---- DELETE StakeLevel --> SAS Initial Againt New Values
--SELECT * 
DELETE s
FROM StakeLevel s WITH(ROWLOCK,UPDLOCK) WHERE GameGroupID = @GameGroupID AND GameTypeID = @BetType

---- Update New BetType For JiliGames
--select * 
UPDATE gg SET RefBetType = 5160
FROM GameGroup gg WITH (ROWLOCK , UPDLOCK) 
WHERE RefSportType = 158 and IsDeposit = 0 