/*
	Date: 20200420
	Created: Eden
	Task: INSERT Global setting for Saba.Club - Deposit [#132698]
	DB: DBCUST/CUSTDB
*/

-----------------------------------------------------------------
DELETE  
FROM Dep_ProductStatusProfile WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 200

DELETE  
FROM Dep_ProductSetting WITH(ROWLOCK, UPDLOCK)
WHERE ProductID = 42

DELETE  
FROM Dep_ProductSettingDetail WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 200

DELETE  
FROM GameGroup WITH(ROWLOCK, UPDLOCK)
WHERE RefSportType = 200 AND IsDeposit = 1

DECLARE @ProductID INT = 42, @Sporttype INT = 200, @Bettype INT = 1611

--> Dep_ProductStatusProfile
INSERT INTO Dep_ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
SELECT @Sporttype,@Bettype,17

DECLARE @MaxProductSettingID INT = 52 

-->Dep_ProductSetting
INSERT INTO Dep_ProductSetting (
	 ProductSettingID
	,ProductID
	,SettingType
	,TemplateID
	,DisplayOrder
	,SettingLevel
	)
	  SELECT @MaxProductSettingID + 1 , @ProductID, 4, 0, 1, 1 --Product Status
UNION SELECT @MaxProductSettingID + 2 , @ProductID, 1, 0, 2, 1 --PT
UNION SELECT @MaxProductSettingID + 3 , @ProductID, 8, 0, 3, 2 --BetLimit -StakeLevelGroup

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
	  SELECT @MaxProductSettingID + 1 , @Sporttype, @Bettype, 0, 0, 1, NULL, 0
UNION SELECT @MaxProductSettingID + 2 , @Sporttype, @Bettype, 0, 0, 1, NULL, 0
UNION SELECT @MaxProductSettingID + 3 , @Sporttype, @Bettype, 0, 0, 1, NULL, 0

--> GameGroup
INSERT INTO GameGroup(GameGroupID,RefSportType,RefBetType,GroupName,IsDeposit)
SELECT 14, @Sporttype, @Bettype, 'Level 1', 1

GO
SELECT * 
FROM Dep_ProductSetting d (NOLOCK)
INNER JOIN Dep_ProductSettingDetail dp (NOLOCK) ON d.ProductSettingID = dp.ProductSettingID
WHERE d.ProductID = 42
GO