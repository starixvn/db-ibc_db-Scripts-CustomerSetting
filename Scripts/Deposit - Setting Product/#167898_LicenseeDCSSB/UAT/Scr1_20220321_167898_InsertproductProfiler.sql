/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20220321
	Task: INSERT Global setting for SB,NG,Keno DCS [Redmine:#167898]	
	DB: DBCust/CustDB
*/
-----------------------------------------------------------------
/*
	DELETE  a
	FROM Dep_ProductSettingDetail a WITH(ROWLOCK, UPDLOCK)
	INNER JOIN Dep_ProductSetting b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
	WHERE b.ProductID IN(3,8,1)

	DELETE  
	FROM Dep_ProductSetting WITH(ROWLOCK, UPDLOCK)
	WHERE ProductID IN(3,8,1)

	DELETE  
	FROM Dep_ProductStatusProfile WITH(ROWLOCK, UPDLOCK)
	WHERE Sporttype IN(161,202)

	select a.*--,b.*
	FROM Dep_ProductSettingDetail a WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
	WHERE b.ProductID IN(3,8,1)

	select *
	FROM Dep_ProductSetting WITH(NOLOCK)
	WHERE ProductID IN(3,8,1)

	select *
	FROM Dep_ProductStatusProfile WITH(NOLOCK)
	WHERE Sporttype IN(161,202)
*/
USE CustDB
GO
-->Dep_ProductSetting
INSERT INTO Dep_ProductSetting (
		ProductSettingID
	,ProductID
	,SettingType
	,TemplateID
	,DisplayOrder
	,SettingLevel
	)
SELECT 35, 3, 4, 0, 1, 1 --Product Status - Product level
UNION ALL SELECT 36, 3, 1, 0, 2, 1 --PT - Product level
UNION ALL SELECT 37, 3, 12, 0, 3, 2 --BetSetting - SportType level
UNION ALL SELECT 38, 3, 9, 0, 4, 1 --Discount - Product level

UNION ALL SELECT 39, 8, 4, 0, 1, 1 --Product Status - Product level
UNION ALL SELECT 40, 8, 1, 0, 2, 1 --PT - Product level
UNION ALL SELECT 41, 8, 2, 0, 3, 2 --BetSetting - SportType level
UNION ALL SELECT 126, 8, 9, 0, 4, 1 --Discount - Product level

UNION ALL SELECT 127, 1, 1, 0, 1, 4 --PT - Sport Bettype level
UNION ALL SELECT 128, 1, 1, 0, 1, 4 --PT - Sport Bettype level
UNION ALL SELECT 129, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 130, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 131, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 132, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 133, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 134, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 135, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 136, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 137, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 138, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 139, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 140, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 141, 1, 10, 0, 2, 4 --BetSetting - Sport Bettype level
UNION ALL SELECT 142, 1, 9, 0, 3, 4 --Discount - Sport Bettype level
UNION ALL SELECT 143, 1, 9, 0, 3, 4 --Discount - Sport Bettype level
UNION ALL SELECT 144, 1, 9, 0, 3, 4 --Discount - Sport Bettype level
UNION ALL SELECT 145, 1, 9, 0, 3, 4 --Discount - Sport Bettype level
UNION ALL SELECT 146, 1, 9, 0, 3, 4 --Discount - Sport Bettype level


-->Dep_ProductSettingDetail
INSERT INTO Dep_ProductSettingDetail(
	ProductSettingID
	,SportType
	,BetType
	,IsLive
	,MaxDefaultValue
	,SettingStatus
	,MinDefaultValue
	,IsApplyBA
	)
SELECT 35, 161, 81, 0, 0, 1, NULL, 0
UNION ALL SELECT 36, 161, 81, 0, 0, 1, NULL, 0
UNION ALL SELECT 37, 161, 81, 0, 0, 1, NULL, 0
UNION ALL SELECT 38, 161, 81, 0, 0, 1, NULL, 0

UNION ALL SELECT 39, 202, 1501, 0, 0, 1, NULL, 0
UNION ALL SELECT 40, 202, 1501, 0, 0, 1, NULL, 0
UNION ALL SELECT 41, 202, 1501, 0, 0, 1, NULL, 0
UNION ALL SELECT 126, 202, 1501, 0, 0, 1, NULL, 0

UNION ALL SELECT 127, 1, 1, 0, 0, 1, NULL, 1
UNION ALL SELECT 128, 2, 2, 0, 0, 1, NULL, 0
UNION ALL SELECT 129, 1, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 130, 1, 9, 0, 0, 1, NULL, 0
UNION ALL SELECT 131, 2, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 132, 3, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 133, 5, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 134, 8, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 135, 10, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 136, 11, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 137, 43, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 138, 99, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 139, 99, 9, 0, 0, 1, NULL, 0
UNION ALL SELECT 140, 9901, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 141, 9902, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 142, 1, 1, 0, 0, 1, NULL, 0
UNION ALL SELECT 143, 1, 4, 0, 0, 1, NULL, 0
UNION ALL SELECT 144, 1, 5, 0, 0, 1, NULL, 0
UNION ALL SELECT 145, 1, 9, 0, 0, 1, NULL, 0
UNION ALL SELECT 146, 2, 2, 0, 0, 1, NULL, 0

INSERT INTO Dep_ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
SELECT 161,81,12
UNION ALL SELECT 202,1501,13
GO
