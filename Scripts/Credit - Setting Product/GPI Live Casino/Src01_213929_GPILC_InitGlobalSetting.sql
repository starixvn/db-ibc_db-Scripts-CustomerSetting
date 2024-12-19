/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241120@Virgil
	Task: GPI Live Casino - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #213485]
	DB: DBCUST-CustDB
*/

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
SELECT 374 AS ProductSettingID,
		7 AS SettingType,
		144 AS SportType,
		11500 AS BetType,
		0 AS IsLive,
		41 AS ProductID,
		0 AS IsSync,
		1 AS IsHidden,
		0 AS IsDisabled,
		2 AS SettingLevel,
		6 AS DisplayOrder,
		1 AS SettingStatus,
		41 AS RealProductID,
		28 AS Child_DisplayOrder,
		3 AS GroupID,
		158 AS GroupType,
		5 AS GroupTypeOrder,
		1 AS CreationStatus,
		1 AS DisplayType,
		0 AS MarketType,
		dbo.f_GetDateTime2()

