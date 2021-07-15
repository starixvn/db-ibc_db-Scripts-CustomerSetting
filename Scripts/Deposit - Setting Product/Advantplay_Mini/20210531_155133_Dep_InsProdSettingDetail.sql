/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210531
	Task:  Insert new Product [AdvantPlay Mini] - deposit RedmineID:#155133
	DB: DBCust/CustDB
*/
DECLARE @productID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @productID = 68 
SET @sportType = 174
SET @betType = 7801  

--Dep_ProductSetting
DELETE D
FROM Dep_ProductSetting D WITH (ROWLOCK)
WHERE D.ProductID = @productID AND D.ProductSettingID BETWEEN 104 AND 106

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (104,@productID,4,0,1,1) -- ProductSatus
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (105,@productID,1,0,2,1) --PT
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (106,@productID,8,0,3,2) -- StakeLevelGroup		

--Dep_ProductSettingDetail

DELETE D
FROM Dep_ProductSettingDetail D WITH (ROWLOCK)
WHERE D.SportType = @sportType 

INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (104,@sportType,@betType,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (105,@sportType,@betType,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (106,@sportType,@betType,0,0,1)

--Dep_ProductStatusProfile 

DELETE D
FROM Dep_ProductStatusProfile D WITH (ROWLOCK)
WHERE D.SportType = @sportType 

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (@sportType,@betType,29)