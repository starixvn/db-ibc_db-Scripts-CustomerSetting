/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20221129
	Task: Deposit - Delete global settings for GDG, Fishing World
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 
CREATE TABLE #SportTypeList (Sporttype SMALLINT, Bettype SMALLINT,ProductID tinyint)

INSERT INTO #SportTypeList(Sporttype, Bettype, ProductID)
SELECT 219, 1011, 24 --Fishing World
UNION ALL 
SELECT 236, 5701, 59 -- GDG

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
DELETE s
FROM  DEP_StakeLevel s WITH(UPDLOCK,ROWLOCK) 
INNER JOIN #SportTypeList t ON s.GameTypeID = t.Bettype