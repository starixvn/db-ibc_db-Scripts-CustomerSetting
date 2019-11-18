/*
	Created: Eden
	Date: 2019/10/21
	Task: DELETE Global setting for Lucky 3,Poker Games,Bullfighting,IMBC Cricket,Cockfighting
	DB: DBCUST/CUSTDB
*/	
------------------------------CREDIT----------------------------------------------------------------
CREATE TABLE #SportTypeList (Sporttype SMALLINT,ProductID tinyint)

INSERT INTO #SportTypeList(Sporttype, ProductID)
SELECT 160, 26--Lucky 3
UNION ALL SELECT 163, 33 -- Poker Games
UNION ALL SELECT 207, 30 --Bullfighting
UNION ALL SELECT 50, 20 --IMBC Cricket
UNION ALL SELECT 206, 19 --Cockfighting

--> LossLimit_GlobalSetting
DELETE a
FROM LossLimit_GlobalSetting a WITH(UPDLOCK,ROWLOCK) 
INNER JOIN #SportTypeList t ON a.ProductId = t.ProductID

--> Winlimit_ProductGlobalSetting
DELETE a
FROM Winlimit_ProductGlobalSetting  a WITH(UPDLOCK,ROWLOCK) 
INNER JOIN #SportTypeList t ON a.ProductId = t.ProductID

-->ProductBetSetting
DELETE a
FROM ProductBetSetting  a WITH(UPDLOCK,ROWLOCK) 
INNER JOIN #SportTypeList t ON a.Sporttype = t.Sporttype

--> Winning Share Commission
DELETE a
FROM VendorGlobalSetting  a WITH(UPDLOCK,ROWLOCK) 
INNER JOIN #SportTypeList t ON a.Sporttype = t.Sporttype

--> ProductStatusSiteCurrency
DELETE a
FROM ProductStatusSiteCurrency a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #SportTypeList t ON a.Sporttype = t.Sporttype

--> ProductLaunchedSiteCurrency
DELETE a
FROM dbo.ProductLaunchedSiteCurrency a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #SportTypeList t ON a.Sporttype = t.Sporttype

--> ProductSettingDetail
DELETE a
FROM dbo.ProductSettingDetail a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #SportTypeList t ON a.Sporttype = t.Sporttype

-->ProductStatusProfile
DELETE a
FROM ProductStatusProfile  a WITH(UPDLOCK,ROWLOCK) 
INNER JOIN #SportTypeList t ON a.Sporttype = t.Sporttype

--> Stake level
DELETE sg
FROM  GameGroup g WITH (NOLOCK) 
INNER JOIN StakeLevel s WITH(NOLOCK) 
	ON g.GameGroupID = s.GameGroupID
INNER JOIN StakeLevelGroupDetail sg WITH(UPDLOCK,ROWLOCK)
	ON sg.StakeLevelID = s.StakeLevelID
INNER JOIN #SportTypeList t ON g.RefSportType = t.Sporttype
WHERE g.IsDeposit = 0

DELETE s
FROM  GameGroup g WITH (NOLOCK) 
INNER JOIN StakeLevel s WITH(UPDLOCK,ROWLOCK) 
	ON g.GameGroupID = s.GameGroupID
INNER JOIN #SportTypeList t ON g.RefSportType = t.Sporttype
WHERE  g.IsDeposit = 0

DELETE g
FROM  GameGroup g WITH(UPDLOCK,ROWLOCK)  
INNER JOIN #SportTypeList t ON g.RefSportType = t.Sporttype
WHERE g.IsDeposit = 0

---------------------------------DEPOSIT---------------------------------------------------------------
--> DEP_ProductSettingDetail
DELETE a
FROM dbo.DEP_ProductSettingDetail a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #SportTypeList t ON a.Sporttype = t.Sporttype

-->DEP_ProductStatusProfile
DELETE a
FROM DEP_ProductStatusProfile a WITH(UPDLOCK,ROWLOCK) 
INNER JOIN #SportTypeList t ON a.Sporttype = t.Sporttype

--> Dep_ProductSetting
DELETE a
FROM dbo.Dep_ProductSetting a WITH(ROWLOCK,UPDLOCK)
INNER JOIN #SportTypeList t ON a.ProductID = t.ProductID

--> DEP Stake level
DELETE sg
FROM  GameGroup g WITH (NOLOCK) 
INNER JOIN DEP_StakeLevel s WITH(NOLOCK) 
	ON g.GameGroupID = s.GameGroupID
INNER JOIN DEP_StakeLevelGroupDetail sg WITH(UPDLOCK,ROWLOCK)
	ON sg.StakeLevelID = s.StakeLevelID
INNER JOIN #SportTypeList t ON g.RefSportType = t.Sporttype
WHERE g.IsDeposit = 1

DELETE s
FROM  GameGroup g WITH (NOLOCK) 
INNER JOIN DEP_StakeLevel s WITH(UPDLOCK,ROWLOCK) 
	ON g.GameGroupID = s.GameGroupID
INNER JOIN #SportTypeList t ON g.RefSportType = t.Sporttype
WHERE g.IsDeposit = 1

DELETE g
FROM  GameGroup g WITH(UPDLOCK,ROWLOCK)  
INNER JOIN #SportTypeList t ON g.RefSportType = t.Sporttype
WHERE g.IsDeposit = 1


