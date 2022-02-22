/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220106
	Task:  Insert Global setting SG Jackpot RedmineID:#165587
	DB: DBCust/CustDB
	P/s :  Step 1 Global setting SG jackpot
*/

USE CustDB
GO

DECLARE @Sporttype INT = 247, @Bettype INT = 4599

-->Dep_ProductSettingDetail
DECLARE @ProductSettingID INT

SELECT @ProductSettingID = p.ProductSettingID
FROM Dep_ProductSettingDetail ps WITH (NOLOCK)
	INNER JOIN Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = ps.ProductSettingID
WHERE sporttype = @Sporttype AND SettingType = 1


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
	  SELECT @ProductSettingID, @Sporttype, @Bettype, 0, 0, 1, NULL, 0

GO

SELECT ps.*
FROM Dep_ProductSettingDetail ps WITH (NOLOCK)
	INNER JOIN Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = ps.ProductSettingID
WHERE sporttype = 247 AND SettingType = 1
GO
