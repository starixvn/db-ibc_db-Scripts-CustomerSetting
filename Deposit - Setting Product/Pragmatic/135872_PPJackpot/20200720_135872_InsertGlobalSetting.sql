/*
	Date: 20200720
	Created: Elodie
	Task: INSERT Global setting for PP Jackpot - Deposit [#135872]
	DB: DBCUST/CUSTDB
*/

-----------------------------------------------------------------
USE CustDB
GO

DECLARE @Sporttype INT = 248, @Bettype INT = 4297

UPDATE p
SET p.SettingLevel = 3
FROM Dep_ProductSettingDetail ps WITH (NOLOCK)
	INNER JOIN Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = ps.ProductSettingID
WHERE sporttype = 248 AND SettingType = 1

-->Dep_ProductSettingDetail
DECLARE @ProductSettingID INT

SELECT @ProductSettingID = p.ProductSettingID
FROM Dep_ProductSettingDetail ps WITH (NOLOCK)
	INNER JOIN Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = ps.ProductSettingID
WHERE sporttype = 248 AND SettingType = 1

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
WHERE sporttype = 248 AND SettingType = 1
GO