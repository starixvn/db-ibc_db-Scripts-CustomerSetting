/*
	Created by: Winnie
	Date: 2017-11-02
	Task: Initial setting data for Exchange Product - [Redmine: #66797]
*/ 

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB			--
------------------------------------------------------------------

USE [CustDB]
GO

DECLARE @MaxProductSettingID INT

SELECT @MaxProductSettingID=19

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
     VALUES
           (@MaxProductSettingID+1
           ,31
           ,5
           ,0
           ,2
           ,1)

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
     VALUES
           (@MaxProductSettingID+2
           ,31
           ,4
           ,0
           ,1
           ,1)

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
		   ,[MinDefaultValue])
     VALUES
           (@MaxProductSettingID+1
           ,221
           ,8001
           ,0
           ,0.06
           ,0
		   ,0.02)

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]         
           ,[SettingStatus])
     VALUES
           (@MaxProductSettingID+2
           ,221
           ,8001
           ,0        
           ,0)

INSERT INTO [dbo].[Dep_ProductStatusProfile]
           ([Sporttype]
           ,[Bettype]
           ,[bitmapOrder])
SELECT 221,8001,MAX(bitmapOrder)+1
FROM [Dep_ProductStatusProfile] WITH(NOLOCK)
   
GO


