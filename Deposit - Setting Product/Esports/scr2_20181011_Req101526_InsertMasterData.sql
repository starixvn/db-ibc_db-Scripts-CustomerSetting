/*
	Created: 20181011@Winnie
	Task: Insert product profile for Esports Deposit
	DB: DBCUST/CustDB
*/

USE [CustDB]
Go
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel)
VALUES 	
	-- PT
	 (24,16,1,0,1,2)
	,(25,16,2,0,2,2)
GO
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus,IsApplyBA)
VALUES 
	 (24,43,1,0,0,0,1)
	,(25,43,1,0,0,0,0)	
GO



