/*<info serverAlias="DBCUST-CustDB"></info>*/
GO
/*
	Created: 20201113@Tina
	Task:  Insert new Product profile for Big Gaming (BG) RedmineID:#142458
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @ProductID INT, @BetType INT, @SportType INT, @BitmapOrder INT 
SET @ProductID = 57
SET @SportType = 239
SET @BetType = 3501
SET @BitmapOrder = 22

--Dep_ProductSetting
DELETE D
FROM Dep_ProductSetting D WITH (ROWLOCK)
WHERE D.ProductID = @ProductID AND D.ProductSettingID BETWEEN 82 AND 84

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
SELECT 82 ProductSettingID, @ProductID ProductID, 4 SettingType, 0 TemplateID, 1 DisplayOrder, 1 SettingLevel -- ProductSatus
UNION ALL
SELECT 83 ProductSettingID, @ProductID ProductID, 7 SettingType, 0 TemplateID, 2 DisplayOrder, 3 SettingLevel --Stake Level
UNION ALL
SELECT 84 ProductSettingID, @ProductID ProductID, 1 SettingType, 0 TemplateID, 3 DisplayOrder, 1 SettingLevel --Position Taking

--Dep_ProductSettingDetail
DELETE D
FROM Dep_ProductSettingDetail D WITH (ROWLOCK)
WHERE D.SportType = @SportType 

INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
SELECT 82 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus -- ProductSatus
UNION ALL
SELECT 83 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus --Stake Level
UNION ALL
SELECT 84 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus --Position Taking

--Dep_ProductStatusProfile 
DELETE D
FROM Dep_ProductStatusProfile D WITH (ROWLOCK)
WHERE D.SportType = @SportType 

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (@SportType,@BetType,@BitmapOrder)

