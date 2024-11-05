/*<info serverAlias="DBCUST-CustDB"></info>*/
GO
/*
	Created: 20240909@Virgil
	Task:  Insert Product Settings for ON Casino [RedmineID: #210025]
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @ProductID INT, @BetType INT, @SportType INT, @BitmapOrder INT

SET @ProductID = 96
SET @SportType = 138
SET @BetType = 11850
SET @BitmapOrder = 51

-- Dep_ProductSetting
DELETE D
FROM Dep_ProductSetting D WITH (ROWLOCK)
WHERE D.ProductID = @ProductID AND D.ProductSettingID BETWEEN 204 AND 206

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
SELECT 204 ProductSettingID, @ProductID ProductID, 4 SettingType, 0 TemplateID, 1 DisplayOrder, 1 SettingLevel -- ProductSatus
UNION ALL
SELECT 205 ProductSettingID, @ProductID ProductID, 7 SettingType, 0 TemplateID, 2 DisplayOrder, 3 SettingLevel -- Stake Level
UNION ALL
SELECT 206 ProductSettingID, @ProductID ProductID, 1 SettingType, 0 TemplateID, 3 DisplayOrder, 1 SettingLevel --Position Taking

-- Dep_ProductSettingDetail
DELETE D
FROM Dep_ProductSettingDetail D WITH (ROWLOCK)
WHERE D.SportType = @SportType 

INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
SELECT 204 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus -- ProductSatus
UNION ALL
SELECT 205 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus -- Stake Level
UNION ALL
SELECT 206 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus -- Position Taking

-- Dep_ProductStatusProfile 
DELETE D
FROM Dep_ProductStatusProfile D WITH (ROWLOCK)
WHERE D.SportType = @SportType 

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (@SportType,@BetType,@BitmapOrder)


