/*
	Created: Eden
	Date: 20200323
	Task: INSERT Global setting for Indo 4D DEPOSIT
	DB: DBCust/CustDB
*/
-----------------------------------------------------------------
--Cleanup Data
DELETE  
FROM Dep_ProductStatusProfile WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 223

DELETE  
FROM Dep_ProductSetting WITH(ROWLOCK, UPDLOCK)
WHERE ProductID = 43

DELETE  
FROM Dep_ProductSettingDetail WITH(ROWLOCK, UPDLOCK)
WHERE Sporttype = 223

--> Insert new data

--> Dep_ProductStatusProfile
INSERT INTO Dep_ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
SELECT 223,5001,15

-->Dep_ProductSetting
INSERT INTO Dep_ProductSetting (
	 ProductSettingID
	,ProductID
	,SettingType
	,TemplateID
	,DisplayOrder
	,SettingLevel
	)
	  SELECT 45, 43, 4, 0, 1, 1 --Product Status
UNION SELECT 46, 43, 1, 0, 2, 1 --PT
UNION SELECT 47, 43, 2, 0, 3, 4 --BetLimit

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
	  SELECT 45, 223, 5001, 0, 0, 1, NULL, 0
UNION SELECT 46, 223, 5001, 0, 0, 1, NULL, 0
UNION SELECT 47, 223, 5001, 0, 0, 1, NULL, 0
UNION SELECT 47, 223, 5002, 0, 0, 1, NULL, 0
UNION SELECT 47, 223, 5003, 0, 0, 1, NULL, 0
UNION SELECT 47, 223, 5004, 0, 0, 1, NULL, 0
UNION SELECT 47, 223, 5005, 0, 0, 1, NULL, 0
UNION SELECT 47, 223, 5006, 0, 0, 1, NULL, 0
UNION SELECT 47, 223, 5007, 0, 0, 1, NULL, 0

