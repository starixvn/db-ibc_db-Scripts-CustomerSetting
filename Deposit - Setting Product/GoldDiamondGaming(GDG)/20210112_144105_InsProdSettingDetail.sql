/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210112
	Task:  Insert new Product profile for GDG RedmineID:#144105
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @productID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @productID = 59 
SET @sportType = 236
SET @betType = 5701 

--Dep_ProductSetting
DELETE D
FROM Dep_ProductSetting D WITH (ROWLOCK)
WHERE D.ProductID = @productID AND D.ProductSettingID BETWEEN 89 AND 91

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (89,@productID,4,0,1,1) -- ProductSatus
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (90,@productID,1,0,2,1) --PT
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (91,@productID,7,0,3,3) -- StakeLevel	

--Dep_ProductSettingDetail

DELETE D
FROM Dep_ProductSettingDetail D WITH (ROWLOCK)
WHERE D.SportType = @sportType 

INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (89,@sportType,@betType,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (90,@sportType,@betType,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (91,@sportType,@betType,0,0,1)

--Dep_ProductStatusProfile 

DELETE D
FROM Dep_ProductStatusProfile D WITH (ROWLOCK)
WHERE D.SportType = @sportType 

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (@sportType,@betType,26)

