/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20231109
	Task:  WE Live Casino - Implement customer setting [RedmineID: #195886]
	DB: DBCUST/CustDB
*/

--Product Setting Profile
INSERT INTO ProductSettingProfile(
	[ProductSettingID],
	[SettingType],
	[SportType],
	[BetType],
	[IsLive],
	[ProductID],
	[SettingLevel],
	[DisplayOrder],
	[SettingStatus],
	[RealProductId],
	[MaxChoice],
	[Child_DisplayOrder],
	[GroupID],
	[GroupType],
	[GroupTypeOrder],
	[CreationStatus],
	[DisplayType],
	[MarketType]
)
SELECT 340 AS ProductSettingID,
		17 AS SettingType,
		228 AS SportType,
		10300 AS BetType,
		0 AS IsLive,
		41 AS ProductID,
		2 AS SettingLevel,
		6 AS DisplayOrder,
		1 AS SettingStatus,
		41 AS RealProductID,
		3 AS MaxChoice,
		11 AS Child_DisplayOrder,
		3 AS GroupID,
		158 AS GroupType,
		0 AS GroupTypeOrder,
		1 AS CreationStatus,
		1 AS DisplayType,
		0 AS MarketType

--Product Setting Detail
INSERT INTO ProductSettingDetail(
	SettingType,
	SportType,
	BetType,
	IsLive,
	ProductID,
	SettingLevel,
	DisplayOrder,
	SettingStatus,
	RealProductId,
	MaxChoice,
	ProductSettingID
)
SELECT
	17 AS SettingType,
	228 AS SportType,
	10300 AS BetType,
	0 AS IsLive,
	41 AS ProductID,
	2 AS SettingLevel,
	6 AS DisplayOrder,
	1 AS SettingStatus,
	41 AS RealProductID,
	3 AS MaxChoice,
	340 AS ProductSettingID

