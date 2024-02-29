/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20231212
	Task:  WE Live Casino - Implement customer setting [RedmineID: #195886]
	DB: DBCUST/CustDB
*/

--Product Setting Detail_UAT
INSERT INTO ProductSettingDetail_UAT(
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

