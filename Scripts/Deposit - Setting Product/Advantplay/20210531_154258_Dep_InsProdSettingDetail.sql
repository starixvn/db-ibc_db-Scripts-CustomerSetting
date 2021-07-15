/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210531
	Task:  Insert new Product [AdvantPlay] - deposit RedmineID:#154258
	DB: DBCust/CustDB
*/
DECLARE @productID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @productID = 67 
SET @sportType = 172
SET @betType = 7701 

--Dep_ProductSetting
DELETE D
FROM Dep_ProductSetting D WITH (ROWLOCK)
WHERE D.ProductID = @productID AND D.ProductSettingID BETWEEN 98 AND 100

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (98,@productID,4,0,1,1) -- ProductSatus
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (99,@productID,1,0,2,1) --PT
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (100,@productID,8,0,3,2) -- StakeLevelGroup		

--Dep_ProductSettingDetail

DELETE D
FROM Dep_ProductSettingDetail D WITH (ROWLOCK)
WHERE D.SportType = @sportType 

INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (98,@sportType,@betType,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (99,@sportType,@betType,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (100,@sportType,@betType,0,0,1)

--Dep_ProductStatusProfile 

DELETE D
FROM Dep_ProductStatusProfile D WITH (ROWLOCK)
WHERE D.SportType = @sportType 

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (@sportType,@betType,27)