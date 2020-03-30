/*
	Created: Elodie
	Date: 20200330
	Task: INSERT Global setting for Table Game DEPOSIT
	DB: DBCust/CustDB
*/
-----------------------------------------------------------------
DECLARE @ProductID TINYINT, @Sporttype SMALLINT, @Bettype SMALLINT, @BitmapOrder TINYINT
SELECT	@ProductID = 40
		,@Sporttype = 222
		,@Bettype = 4901
		,@BitmapOrder = 16

--Cleanup Data
DELETE  
FROM Dep_ProductStatusProfile WITH(ROWLOCK)
WHERE Sporttype = @Sporttype

DELETE  
FROM Dep_ProductSetting WITH(ROWLOCK)
WHERE ProductID = @ProductID

DELETE  
FROM Dep_ProductSettingDetail WITH(ROWLOCK)
WHERE Sporttype = @Sporttype

--> Insert new data

--> Dep_ProductStatusProfile
INSERT INTO Dep_ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
SELECT @Sporttype,@Bettype,@BitmapOrder

-->Dep_ProductSetting
INSERT INTO Dep_ProductSetting (
	 ProductSettingID
	,ProductID
	,SettingType
	,TemplateID
	,DisplayOrder
	,SettingLevel
	)
	  SELECT 48, @ProductID, 4, 0, 1, 1 --Product Status
UNION SELECT 49, @ProductID, 1, 0, 2, 1 --PT
UNION SELECT 50, @ProductID, 2, 0, 3, 2 --BetLimit

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
	  SELECT 48, @Sporttype, @Bettype, 0, 0, 1, NULL, 0
UNION SELECT 49, @Sporttype, @Bettype, 0, 0, 1, NULL, 0
UNION SELECT 50, @Sporttype, @Bettype, 0, 0, 1, NULL, 0


