/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230303@Helios
	Task: Enhance Initial data Setting For Jili [redmine:#182869]
	DB: DBCust/CustDB
*/
DECLARE @tmp_StakeLevel TABLE (StakeLevelID INT)  

DECLARE @BetType SMALLINT , @GameGroupID SMALLINT
		
SELECT  @BetType = 5100 , @GameGroupID = 43


-- UPDATE New BetType For JiliGames
SELECT * 
--UPDATE dp SET BetType = 5160
FROM Dep_ProductSettingDetail dp WITH(ROWLOCK , UPDLOCK) WHERE SportType = 158 AND ProductSettingID = 157 AND BetType = @BetType

-- COLLECT Data Temp
INSERT INTO @tmp_StakeLevel
SELECT StakeLevelID FROM Dep_StakeLevel s WITH(ROWLOCK,UPDLOCK) WHERE GameGroupID = @GameGroupID AND GameTypeID = @BetType

---- DELETE Dep_StakeLevelGroupDetail --> SAS Initial Againt New Values
SELECT DISTINCT StakeLevelID
--DELETE sl
FROM Dep_StakeLevelGroupDetail sl WITH(ROWLOCK,UPDLOCK) WHERE StakeLevelID IN (SELECT * FROM @tmp_StakeLevel)


---- DELETE Dep_StakeLevel --> SAS Initial Againt New Values
SELECT DISTINCT StakeLevelID 
--DELETE s
FROM Dep_StakeLevel s WITH(ROWLOCK,UPDLOCK) WHERE GameGroupID = @GameGroupID AND GameTypeID = @BetType



