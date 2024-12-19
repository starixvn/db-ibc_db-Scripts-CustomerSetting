/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241205@Virgil
	Task: GPI Live Casino - Add Setting to ProductSettingDetail [RedmineID: #213485]
	DB: DBCUST-CustDB
*/

--// ProductSettingDetail //--

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
-- ON Casino
SELECT 373 AS ProductSettingID,
		7 AS SettingType,
		138 AS SportType,
		11850 AS BetType,
		0 AS IsLive,
		41 AS ProductID,
		0 AS IsSync,
		1 AS IsHidden,
		0 AS IsDisabled,
		2 AS SettingLevel,
		6 AS DisplayOrder,
		0 AS SettingStatus,
		41 AS RealProductID,
		27 AS Child_DisplayOrder,
		dbo.f_GetDateTime2() AS RepUpdateTime
UNION ALL
-- GPILC
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
		dbo.f_GetDateTime2() AS RepUpdateTime

