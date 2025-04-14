/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Tacy
	Task: Microgaming Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #222203]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

-- Product Setting Profile
INSERT INTO ProductSettingProfile(
	[ProductSettingID]
	,[SettingType]
	,[SportType]
	,[BetType]
	,[IsLive]
	,[ProductID]
	,[IsSync]
	,[IsHidden]
	,[IsDisabled]
	,[SettingLevel]
	,[DisplayOrder]
	,[SettingStatus]
	,[RealProductId]
	,[Child_DisplayOrder]
	,[GroupID]
	,[GroupType]
	,[GroupTypeOrder]
	,[CreationStatus]
	,[DisplayType]
	,[MarketType]
	,[RepUpdateTime]
)
SELECT 375 AS ProductSettingID,
		7 AS SettingType,
		124 AS SportType,
		13900 AS BetType,
		0 AS IsLive,
		41 AS ProductID,
		0 AS IsSync,
		1 AS IsHidden,
		0 AS IsDisabled,
		2 AS SettingLevel,
		6 AS DisplayOrder,
		1 AS SettingStatus,
		41 AS RealProductID,
		29 AS Child_DisplayOrder,
		3 AS GroupID,
		158 AS GroupType,
		5 AS GroupTypeOrder,
		1 AS CreationStatus,
		1 AS DisplayType,
		0 AS MarketType,
		dbo.f_GetDateTime2()

-- Product Setting Profile
INSERT INTO ProductSettingDetail(
	[ProductSettingID]
	,[SettingType]
	,[SportType]
	,[BetType]
	,[IsLive]
	,[ProductID]
	,[IsSync]
	,[IsHidden]
	,[IsDisabled]
	,[SettingLevel]
	,[DisplayOrder]
	,[SettingStatus]
	,[RealProductId]
	,[Child_DisplayOrder]
	,[RepUpdateTime]
)
SELECT 375 AS ProductSettingID,
		7 AS SettingType,
		124 AS SportType,
		13900 AS BetType,
		0 AS IsLive,
		41 AS ProductID,
		0 AS IsSync,
		1 AS IsHidden,
		0 AS IsDisabled,
		2 AS SettingLevel,
		6 AS DisplayOrder,
		1 AS SettingStatus,
		41 AS RealProductID,
		29 AS Child_DisplayOrder,
		dbo.f_GetDateTime2()
GO