/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Helios@2023/04/13
	Task: Seal Entertainment - Project Team [RM:#186524]
	DB: DBCUST/CUSTDB

	Revisions:
		- Initial Script Update BetType Seal [RM:#186524] 
*/

use CustDB 

DECLARE @Old_BetType SMALLINT
	,   @New_BetType SMALLINT
	,	@SportType SMALLINT


SELECT @Old_BetType = 8900
	,  @New_BetType = 8999
	,  @SportType = 156

IF OBJECT_ID('tempdb..#tmp_StakeLevel') IS NOT NULL
    DROP TABLE #tmp_StakeLevel ;  

CREATE TABLE #tmp_StakeLevel (StakeLevelID VARCHAR(200))
DECLARE @tmp_GameGroupID TABLE (GameGroupID INT)  

INSERT INTO @tmp_GameGroupID
SELECT GameGroupID
FROM GameGroup g  WITH (NOLOCK)
WHERE RefBetType = @Old_BetType AND IsDeposit = 0


INSERT INTO #tmp_StakeLevel
SELECT StakeLevelID FROM StakeLevel WITH (NOLOCK)
where GameGroupID IN (SELECT GameGroupID FROM @tmp_GameGroupID) AND GameTypeID = @Old_BetType

--select * from @tmp_GameGroupID
--select * from #tmp_StakeLevel

--------------------------ProductSettingDetail--------------------------
--SELECT * 
UPDATE p SET BetType = @New_BetType
FROM ProductSettingDetail p WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @SportType
AND BetType = @Old_BetType
AND SettingType = 8

---------------------------StakeLevelGroupDetail----------------------------

--SELECT *
UPDATE stakeDetail SET GameTypeID = @New_BetType
FROM StakeLevelGroupDetail stakeDetail WITH (ROWLOCK, UPDLOCK)
INNER JOIN #tmp_StakeLevel stake ON stakeDetail.StakeLevelID = stake.StakeLevelID
WHERE stakeDetail.GameTypeID = @Old_BetType


--SELECT *
DELETE stakeDetail
FROM StakeLevelGroupDetail stakeDetail WITH (ROWLOCK, UPDLOCK)
INNER JOIN #tmp_StakeLevel stake ON stakeDetail.StakeLevelID = stake.StakeLevelID
WHERE stakeDetail.GameTypeID <> @New_BetType

-----------------------------------StakeLevel---------------------------------

--SELECT *
UPDATE stakeLevel SET GameTypeID = @New_BetType
FROM StakeLevel stakeLevel WITH (ROWLOCK, UPDLOCK)
INNER JOIN #tmp_StakeLevel stake ON stakeLevel.StakeLevelID = stake.StakeLevelID
WHERE stakeLevel.GameTypeID = @Old_BetType

---------------------------------GameGroup---------------------------------

--SELECT * 
UPDATE g SET RefBetType = @New_BetType
FROM GameGroup g  WITH (ROWLOCK , UPDLOCK)
WHERE RefBetType = @Old_BetType AND IsDeposit = 0

---------------------------------SportBettypeSettingMatrix---------------------------------
--SELECT * 
UPDATE s SET BetTypeRefBetSetting = @New_BetType
FROM SportBettypeSettingMatrix s WITH (ROWLOCK , UPDLOCK)
WHERE Sporttype = @SportType and isLicensee = 0

---------------------------------ProductSettingDetail_UAT---------------------------------
--SELECT *
UPDATE p SET BetType = @New_BetType
FROM ProductSettingDetail_UAT p WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @SportType
AND BetType = @Old_BetType
AND SettingType = 8

---------------------------------SportNonOfferedSiteCurrency---------------------------------
--SELECT * 
UPDATE c SET BetType = @New_BetType
FROM SportNonOfferedSiteCurrency c WITH (ROWLOCK ,UPDLOCK)
WHERE SportType = @SportType  AND BetType = @Old_BetType