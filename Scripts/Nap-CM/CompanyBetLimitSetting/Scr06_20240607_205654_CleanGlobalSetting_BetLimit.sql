/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20240607
	Task: VGaming & Virtual Games - clean global setting
		https://nexdev.net/issues/205654
	DB: DBCust/CustDB
*/ 
/*
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

CREATE TABLE #tmpDep_StakeLevel (StakeLevelID INT PRIMARY KEY)

CREATE TABLE #tmpDep_StakeLevel_Batch (StakeLevelID INT PRIMARY KEY)

DECLARE @batch INT = 3000;

---------------------------------------------------------------------------------------------
INSERT INTO #Dep_ProductSetting(ProductSettingID, SportType, BetType)
SELECT ps.ProductSettingID, SportType, BetType
FROM Dep_ProductSettingDetail psd WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting ps WITh(NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
WHERE ps.ProductID in (38,66) AND ps.SettingType IN (7,8)

--Dep_StakeLevelGroupDetail
DELETE slg
FROM Dep_StakeLevelGroupDetail slg WITH (ROWLOCK)
INNER JOIN Dep_StakeLevel sl WITH (NOLOCK) ON sl.StakeLevelID=slg.StakeLevelID
INNER JOIN #Dep_ProductSetting ps ON ps.BetType=sl.GameTypeID

--Dep_StakeLevel
INSERT INTO #tmpDep_StakeLevel (StakeLevelID)
SELECT sl.StakeLevelID
FROM Dep_StakeLevel sl WITH (NOLOCK)
INNER JOIN #Dep_ProductSetting ps ON ps.BetType=sl.GameTypeID

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpDep_StakeLevel_Batch

	DELETE TOP (3000) T
	OUTPUT deleted.StakeLevelID	INTO #tmpDep_StakeLevel_Batch (StakeLevelID)
	FROM #tmpDep_StakeLevel T

	IF @@ROWCOUNT=0
		BREAK;

	DELETE sl
	FROM Dep_StakeLevel sl WITH (ROWLOCK)
	INNER JOIN #tmpDep_StakeLevel_Batch t 
				ON t.StakeLevelID=sl.StakeLevelID

	WAITFOR DELAY '00:00:00:280'
END	

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
