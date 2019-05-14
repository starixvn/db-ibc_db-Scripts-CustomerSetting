
/*
	Created: 20190509@Winnie
	Task: CN88 crmsetting Insert data test RedmineID:#112637
	DB: DBCRM/bodb_CRM
*/
USE [bodb_CRM]
GO
INSERT INTO [dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
		   ,[SiteOffer])
     VALUES
           ('SiteCategory'
           ,33002
           ,'CN88'
           ,3
           ,1
		   ,1)
GO

INSERT INTO [dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
		   ,[SiteOffer])
     VALUES
           ('Role'
           ,7006
           ,'Headline'
           ,6
           ,1
		   ,1)
GO


INSERT INTO [dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
           ,[SiteOffer])
     VALUES
           ('MainCategory'
           ,3043
           ,'TestMaincategoryCN881'
           ,104
           ,1
           ,1)
GO
INSERT INTO [dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
           ,[SiteOffer])
     VALUES
           ('MainCategory'
           ,3044
           ,'TestMaincategoryCN882'
           ,105
           ,1
           ,1)
GO
INSERT INTO [dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
           ,[SiteOffer])
     VALUES
           ('SubCategory'
           ,4230
           ,'TestSubcategoryCN881'
           ,244
           ,1
           ,1)
GO
INSERT INTO [dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
           ,[SiteOffer])
     VALUES
           ('SubCategory'
           ,4231
           ,'TestMaincategoryCN882'
           ,245
           ,1
           ,1)
GO
INSERT INTO [dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
           ,[SiteOffer])
     VALUES
           ('SubCategory'
           ,4232
           ,'TestMaincategoryCN883'
           ,246
           ,1
           ,1)
GO
INSERT INTO [dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive]
           ,[SiteOffer])
     VALUES
           ('SubCategory'
           ,4233
           ,'TestMaincategoryCN884'
           ,247
           ,1
           ,1)
GO

INSERT INTO crmSettingRelation(SettingID,ParentID,DisplayOrder)
 VALUES
           (4230
           ,3044      
           ,1)
GO
INSERT INTO crmSettingRelation(SettingID,ParentID,DisplayOrder)
 VALUES
           (4231
           ,3044      
           ,2)
GO
INSERT INTO crmSettingRelation(SettingID,ParentID,DisplayOrder)
 VALUES
           (4232
           ,3043   
           ,3)
GO
INSERT INTO crmSettingRelation(SettingID,ParentID,DisplayOrder)
 VALUES
           (4233
           ,3043   
           ,4)
GO

