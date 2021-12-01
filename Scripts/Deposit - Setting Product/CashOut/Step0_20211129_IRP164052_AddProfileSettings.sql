/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211129@Johnson
	Task: add profile setting for Cash Out
	DB: DBCust/CustDB
*/

USE [CustDB]
GO


INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
SELECT 116, 25, 4, 0, 1, 1
GO

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT 116, 9903, 1, 0, 0, 1, 0, 0    	
GO

INSERT INTO [dbo].[Dep_ProductStatusProfile]
           ([Sporttype]
           ,[Bettype]
           ,[bitmapOrder])
SELECT 9903, 1, 31  