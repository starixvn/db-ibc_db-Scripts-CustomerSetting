/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230303@Helios
	Task: Enhance Initial data Setting For Jili [redmine:#182869]
	DB: DBCust/CustDB
*/
DECLARE @tmp_StakeLevel TABLE (StakeLevelID smallInt)  

DECLARE @BetType SMALLINT
		


SELECT  @BetType = 5100



---- Update New BetType For JiliGames
--SELECT *
UPDATE p SET BetType = 5160
FROM [ProductSettingDetail] p WITH(ROWLOCK,UPDLOCK)
WHERE ProductID = 18 AND [SportType] = 158 AND BetType = @BetType and [SettingType] = 8

INSERT INTO @tmp_StakeLevel
SELECT StakeLevelID FROM StakeLevel s WITH(ROWLOCK,UPDLOCK) WHERE GameGroupID = 41 AND GameTypeID = @BetType

---- Update StakeLevel
--SELECT * 
UPDATE s SET GameTypeID = 5160
FROM StakeLevel s WITH(ROWLOCK,UPDLOCK) WHERE GameGroupID = 41 AND GameTypeID = @BetType

---- DELETE StakeLevelGroupDetail --> SAS Initial New Values BetType 5160 And Min-Max Values
--SELECT *
DELETE
FROM StakeLevelGroupDetail WHERE StakeLevelID IN (SELECT * FROM @tmp_StakeLevel)
