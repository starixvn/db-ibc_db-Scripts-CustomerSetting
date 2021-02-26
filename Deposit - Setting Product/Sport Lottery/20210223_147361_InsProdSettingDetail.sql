/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task:  Insert new Product profile for Sports Lottery [Redmine: 147361]
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @productID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @productID = 63 
SET @sportType = 169
SET @betType = 3611 

--Dep_ProductSetting
DELETE D
FROM Dep_ProductSetting D WITH (ROWLOCK)
WHERE D.ProductID = @productID AND D.ProductSettingID BETWEEN 85 AND 87

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (85,@productID,4,0,1,1) -- ProductSatus
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (86,@productID,1,0,2,2) --PT
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (87,@productID,2,0,3,2) -- Bet Setting

--Dep_ProductSettingDetail

DELETE D
FROM Dep_ProductSettingDetail D WITH (ROWLOCK)
WHERE D.SportType = @sportType 

INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (85,@sportType,@betType,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (86,@sportType,@betType,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (87,@sportType,@betType,0,0,1)

--Dep_ProductStatusProfile 

DELETE D
FROM Dep_ProductStatusProfile D WITH (ROWLOCK)
WHERE D.SportType = @sportType 

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (@sportType,@betType,25)

