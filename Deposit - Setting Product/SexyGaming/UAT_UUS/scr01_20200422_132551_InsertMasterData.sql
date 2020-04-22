/*
	Created: 20200422@Tiara
	Date: 20200422
	Task: Insert product profile for SexyGaming Deposit [Redmine: 132551]
	DB: DBCUST/CustDB
*/
USE [CustDB]
Go
--Dep_ProductSetting
DELETE D
FROM Dep_ProductSetting D WITH (ROWLOCK)
WHERE D.ProductID = 45 AND D.ProductSettingID BETWEEN 56 AND 58

INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (56,45,4,0,1,1) -- ProductSatus
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (57,45,1,0,2,1) --PT
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES (58,45,7,0,3,3) -- StakeLevel

--Dep_ProductSettingDetail

DELETE D
FROM Dep_ProductSettingDetail D WITH (ROWLOCK)
WHERE D.SportType = 243 

INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (56,243,3101,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (57,243,3101,0,0,1)
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus)
VALUES (58,243,3101,0,0,1)

--Dep_ProductStatusProfile 

DELETE D
FROM Dep_ProductStatusProfile D WITH (ROWLOCK)
WHERE D.SportType = 243

INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype,Bettype,bitmapOrder)
VALUES (243,3101,18)

