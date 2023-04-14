/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/03/21
	Task: Enhance Initial data Setting For PP - Pragmatic [RM:#181686] 
	DB: DBCUST/CUSTDB

	Revisions:
		- Change the bet limit setting for Nova88, 789y, IBCBet & licensees [RM:#181686]
*/
DECLARE @Old_BetType SMALLINT
	,   @New_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 4101
	,  @New_BetType = 7000
	,  @SportType = 248

IF OBJECT_ID('tempdb..#tmp_DEP_StakeLevel') IS NOT NULL
    DROP TABLE #tmp_DEP_StakeLevel ;  

CREATE TABLE #tmp_DEP_StakeLevel (StakeLevelID VARCHAR(200))
DECLARE @tmp_GameGroupID TABLE (GameGroupID INT)  

INSERT INTO @tmp_GameGroupID
SELECT GameGroupID
FROM GameGroup g  WITH (NOLOCK)
WHERE RefBetType = @Old_BetType AND IsDeposit = 1


INSERT INTO #tmp_DEP_StakeLevel
SELECT StakeLevelID FROM Dep_StakeLevel WITH (NOLOCK)
where GameGroupID IN (SELECT GameGroupID FROM @tmp_GameGroupID) AND GameTypeID = @Old_BetType

--SELECT * FROM @tmp_GameGroupID
--SELECT * FROM #tmp_DEP_StakeLevel

------------------------DEPOSIT--------------------------
--SELECT ProductSettingID,* 
UPDATE p SET BetType = @New_BetType
FROM Dep_ProductSettingDetail p WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @SportType
AND BetType = @Old_BetType
AND ProductSettingID = 23

---------------------------Dep_StakeLevelGroupDetail----------------------------

--SELECT *
UPDATE stakeDetail SET GameTypeID = @New_BetType
FROM Dep_StakeLevelGroupDetail stakeDetail WITH (ROWLOCK, UPDLOCK)
INNER JOIN #tmp_DEP_StakeLevel stake ON stakeDetail.StakeLevelID = stake.StakeLevelID
WHERE stakeDetail.GameTypeID = @Old_BetType


--SELECT *
DELETE stakeDetail
FROM Dep_StakeLevelGroupDetail stakeDetail WITH (ROWLOCK, UPDLOCK)
INNER JOIN #tmp_DEP_StakeLevel stake ON stakeDetail.StakeLevelID = stake.StakeLevelID
WHERE stakeDetail.GameTypeID <> @New_BetType

-----------------------------------Dep_StakeLevel---------------------------------

--SELECT *
UPDATE stakeLevel SET GameTypeID = @New_BetType
FROM Dep_StakeLevel stakeLevel WITH (ROWLOCK, UPDLOCK)
INNER JOIN #tmp_DEP_StakeLevel stake ON stakeLevel.StakeLevelID = stake.StakeLevelID
WHERE stakeLevel.GameTypeID = @Old_BetType

---------------------------------GameGroup---------------------------------

--SELECT * 
UPDATE g SET RefBetType = @New_BetType
FROM GameGroup g  WITH (ROWLOCK , UPDLOCK)
WHERE RefBetType = @Old_BetType AND IsDeposit = 1

---------------------------------SportBettypeSettingMatrix---------------------------------
--SELECT * 
UPDATE s SET BetTypeRefBetSetting = @New_BetType
FROM SportBettypeSettingMatrix s WITH (ROWLOCK , UPDLOCK)
WHERE Sporttype = @SportType and isLicensee = 1