/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game DEPOSIT
	DB: DBCust/CustDB
*/
-----------------------------------------------------------------
/*
DELETE  
FROM Dep_ProductStatusProfile WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 245

DELETE  
FROM Dep_ProductSetting WITH(ROWLOCK, UPDLOCK)
WHERE ProductID = 38

DELETE  
FROM Dep_ProductSettingDetail WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 245

*/
--> Dep_ProductStatusProfile
INSERT INTO Dep_ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
SELECT 245,4601,11

DECLARE @MaxProductSettingID INT
SELECT @MaxProductSettingID = MAX(ProductSettingID) FROM Dep_ProductSetting WITH(NOLOCK)

-->Dep_ProductSetting
INSERT INTO Dep_ProductSetting (
	 ProductSettingID
	,ProductID
	,SettingType
	,TemplateID
	,DisplayOrder
	,SettingLevel
	)
	  SELECT 32, 38, 4, 0, 1, 1 --Product Status
UNION SELECT 33, 38, 1, 0, 2, 1 --PT
UNION SELECT 34, 38, 7, 0, 3, 4 --BetLimit

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
	  SELECT 32, 245, 4601, 0, 0, 1, NULL, 0
UNION SELECT 33, 245, 4601, 0, 0, 1, NULL, 0
UNION SELECT 34, 245, 4601, 0, 0, 1, NULL, 0

