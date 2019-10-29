/*
	Created: Eden
	Date: 20191029
	Task: INSERT Global setting for Virtual game DEPOSIT
	DB: DBCust/CustDB
*/
--> Dep_ProductStatusProfile
INSERT INTO Dep_ProductStatusProfile(Sporttype,Bettype,bitmapOrder)
SELECT 245,4601,11

GO
DECLARE @MaxProductSettingID INT
SELECT @MaxProductSettingID = MAX(ProductSettingID) FROM Dep_ProductSetting WITH(NOLOCK)
SELECT @MaxProductSettingID

-->Dep_ProductSetting
INSERT INTO Dep_ProductSetting (
	 ProductSettingID
	,ProductID
	,SettingType
	,TemplateID
	,DisplayOrder
	,SettingLevel
	)
	  SELECT @MaxProductSettingID + 1 , 38, 4, 0, 1, 1
UNION SELECT @MaxProductSettingID + 2 , 38, 2, 0, 2, 2
UNION SELECT @MaxProductSettingID + 3 , 38, 8, 0, 3, 1

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
	  SELECT @MaxProductSettingID + 1 , 245, 4601, 0, 0, 0, NULL, 0
UNION SELECT @MaxProductSettingID + 2 , 245, 4601, 0, 0, 0, NULL, 0
UNION SELECT @MaxProductSettingID + 3 , 245, 4601, 0, 0, 0, NULL, 0

--> Dep_LicenseeProductSetting
INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT dl.CustID
	,ProductSettingID = CASE WHEN dl.ProductSettingID = 1 THEN @MaxProductSettingID + 1
							 WHEN dl.ProductSettingID = 2 THEN @MaxProductSettingID + 2
							 WHEN dl.ProductSettingID = 3 THEN @MaxProductSettingID + 3
						END
FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
	 INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
	 INNER JOIN custinfo ci WITH(NOLOCK) ON dl.CustID = ci.custid 
WHERE dp.ProductID = 22
	AND ci.currency = 20

--> Stake level
INSERT INTO GameGroup(GameGroupID,RefSportType,RefBetType,GroupName,IsDeposit)
SELECT 14, 245, 4601, 'Level 1', 1

INSERT INTO DEP_StakeLevel(
	 StakeLevelID
	,GameTypeID
	,ExchangeId
	,ResourceId
	,GameGroupID
)
SELECT StakeLevelID = MAX(StakeLevelID) + 1
	,GameTypeID = 4601
	,ExchangeId = 20
	,ResourceId = NULL
	,GameGroupID = 14 --DEPOSIT
FROM DEP_StakeLevel WITH(NOLOCK)

GO