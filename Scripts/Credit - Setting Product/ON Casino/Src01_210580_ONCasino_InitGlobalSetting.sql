/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240906@Virgil
	Task:  ON Casino - Implement customer setting [RedmineID: #210025]
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
)
SELECT 373 AS ProductSettingID,
		7 AS SettingType,
		138 AS SportType,
		11850 AS BetType,
		0 AS IsLive,
		41 AS ProductID,
		NULL AS IsSync,
		NULL AS IsHidden,
		NULL AS IsDisabled,
		2 AS SettingLevel,
		6 AS DisplayOrder,
		1 AS SettingStatus,
		41 AS RealProductID,
		35 AS Child_DisplayOrder,
		3 AS GroupID,
		158 AS GroupType,
		5 AS GroupTypeOrder,
		1 AS CreationStatus,
		1 AS DisplayType,
		0 AS MarketType

