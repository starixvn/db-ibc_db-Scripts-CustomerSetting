/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231101
	Task: clean global setting
		https://nexdev.net/issues/194331
	DB: DBCust/CustDB
*/ 
/*
	ProductSettingDetail
	ProductSettingDetail_UAT
	StakeLevel
	StakeLevelGroupDetail

	ProductSettingProfile
	ProductSettingProfile_UAT

	Dep_ProductSettingDetail
	Dep_ProductSetting
	Dep_StakeLevel
	Dep_StakeLevelGroupDetail

	GameGroup
*/
USE CustDB
GO

-------------------------------------------------------------------
-------------------------------------------------------------------
--DEPOSIT
CREATE TABLE #Dep_ProductSetting (ProductSettingID INT, SportType SMALLINT, BetType SMALLINT)
CREATE TABLE #SportRNG (SportType SMALLINT)

CREATE TABLE #tmpStakeLevelGroupDetail (
				 StakeLevelID INT
				,GameTypeID SMALLINT
				,PRIMARY KEY(StakeLevelID,GameTypeID))

CREATE TABLE #tmpStakeLevelGroupDetail_Batch (
				 StakeLevelID INT
				,GameTypeID SMALLINT
				,PRIMARY KEY(StakeLevelID,GameTypeID))

DECLARE @batch INT = 3000;

--Get data
INSERT INTO #SportRNG (SportType)
	  SELECT 155 --MG-RNG
UNION SELECT 156 --SEAL Entertainment
UNION SELECT 158 --Jili
UNION SELECT 165 --Arcadia Gaming
UNION SELECT 167 --CG
UNION SELECT 172 --AdvantPlay
UNION SELECT 174 --AdvantPlay Mini
UNION SELECT 212 --Macau Games
UNION SELECT 232 --PG Soft
UNION SELECT 234 --Joker
UNION SELECT 237 --MaxGame
UNION SELECT 238 --Habanero
UNION SELECT 247 --SG
UNION SELECT 248 --PP

INSERT INTO #Dep_ProductSetting(ProductSettingID, SportType, BetType)
SELECT ps.ProductSettingID, psd.SportType, psd.BetType
FROM  Dep_ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK)
INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
INNER JOIN #SportRNG s ON s.sporttype=psd.SportType
WHERE SettingType=8 AND SettingStatus=2

--Dep_StakeLevelGroupDetail
INSERT INTO #tmpStakeLevelGroupDetail (StakeLevelID,GameTypeID)
SELECT slg.StakeLevelID, slg.GameTypeID
FROM Dep_StakeLevelGroupDetail slg WITH (NOLOCK)
INNER JOIN Dep_StakeLevel sl WITH (NOLOCK) ON sl.StakeLevelID=slg.StakeLevelID
INNER JOIN #Dep_ProductSetting ps ON ps.BetType=sl.GameTypeID

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpStakeLevelGroupDetail_Batch

	DELETE TOP (3000) T
	OUTPUT deleted.StakeLevelID, deleted.GameTypeID
		INTO #tmpStakeLevelGroupDetail_Batch (StakeLevelID, GameTypeID)
	FROM #tmpStakeLevelGroupDetail T

	IF @@ROWCOUNT=0
		BREAK;

	DELETE slg
	FROM Dep_StakeLevelGroupDetail slg WITH (ROWLOCK)
	INNER JOIN #tmpStakeLevelGroupDetail_Batch t 
				ON t.StakeLevelID=slg.StakeLevelID
				AND t.GameTypeID=slg.GameTypeID

	WAITFOR DELAY '00:00:00:280'
END	

--Dep_StakeLevel
DELETE sl
FROM Dep_StakeLevel sl WITH (ROWLOCK)
INNER JOIN #Dep_ProductSetting ps ON ps.BetType=sl.GameTypeID

--GameGroup
DELETE gg
FROM GameGroup gg WITH (ROWLOCK)
INNER JOIN #Dep_ProductSetting T ON T.SportType=gg.RefSportType
						AND T.BetType=gg.RefBetType
WHERE gg.IsDeposit=1

--Dep_ProductSettingDetail
DELETE psd
FROM  Dep_ProductSettingDetail psd WITH (ROWLOCK)
INNER JOIN #Dep_ProductSetting T ON psd.ProductSettingID=T.ProductSettingID

--Dep_ProductSetting
DELETE ps
FROM  Dep_ProductSetting ps WITH (ROWLOCK)
INNER JOIN #Dep_ProductSetting T ON ps.ProductSettingID=T.ProductSettingID

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--CREDIT
CREATE TABLE #ProductSetting (ProductSettingID INT, SportType SMALLINT, BetType INT)

INSERT INTO #ProductSetting (ProductSettingID, SportType, BetType)
SELECT PSD.ProductSettingID, psd.SportType, psd.BetType
FROM ProductSettingDetail psd WITH (NOLOCK)
WHERE SettingType=8 AND ProductID=18
AND SettingStatus = 2

--StakeLevelGroupDetail
DELETE FROM #tmpStakeLevelGroupDetail

INSERT INTO #tmpStakeLevelGroupDetail (StakeLevelID,GameTypeID)
SELECT slg.StakeLevelID, slg.GameTypeID
FROM StakeLevelGroupDetail slg WITH (NOLOCK)
INNER JOIN StakeLevel sl WITH (NOLOCK) ON sl.StakeLevelID=slg.StakeLevelID
INNER JOIN #ProductSetting ps ON ps.BetType=sl.GameTypeID

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpStakeLevelGroupDetail_Batch

	DELETE TOP (3000) T
	OUTPUT deleted.StakeLevelID, deleted.GameTypeID
		INTO #tmpStakeLevelGroupDetail_Batch (StakeLevelID, GameTypeID)
	FROM #tmpStakeLevelGroupDetail T

	IF @@ROWCOUNT=0
		BREAK;

	DELETE slg
	FROM StakeLevelGroupDetail slg WITH (ROWLOCK)
	INNER JOIN #tmpStakeLevelGroupDetail_Batch t 
				ON t.StakeLevelID=slg.StakeLevelID
				AND t.GameTypeID=slg.GameTypeID

	WAITFOR DELAY '00:00:00:280'
END	

--StakeLevel
DELETE sl
FROM StakeLevel sl WITH (ROWLOCK)
INNER JOIN #ProductSetting ps ON ps.BetType=sl.GameTypeID

--GameGroup
DELETE gg
FROM GameGroup gg WITH (ROWLOCK)
INNER JOIN #ProductSetting T ON T.SportType=gg.RefSportType
						AND T.BetType=gg.RefBetType
WHERE gg.IsDeposit=0

--ProductSettingDetail
DELETE FROM ProductSettingDetail WITH (ROWLOCK)
WHERE SettingType=8 AND ProductID=18

--ProductSettingDetail_UAT
DELETE FROM ProductSettingDetail_UAT WITH (ROWLOCK)
WHERE SettingType=8 AND ProductID=18

--ProductSettingProfile
DELETE FROM ProductSettingProfile WITH (ROWLOCK)
WHERE SettingType=8 AND ProductID=18

--ProductSettingProfile
DELETE FROM ProductSettingProfile_UAT WITH (ROWLOCK)
WHERE SettingType=8 AND ProductID=18

DROP TABLE #Dep_ProductSetting, #ProductSetting, #SportRNG
		 , #tmpStakeLevelGroupDetail, #tmpStakeLevelGroupDetail_Batch
GO