/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250327@Tacy
	Task: Add profile for Comm Setting for ASKMESLOT, Funky Games, HOTDOG [redmine: #221461]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel]
		   ,RepUpdateTime 
           )
	  SELECT 236,	103,	9,	0,	4,	1,	SYSDATETIME()
UNION SELECT 237,	104,	9,	0,	4,	1,	SYSDATETIME()
UNION SELECT 238,	95,		9,	0,	4,	1,	SYSDATETIME()

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA]
		   ,RepUpdateTime
           )
	  SELECT 236,	130,	15000,	0,	0,	0,	NULL,	0,	SYSDATETIME() 
UNION SELECT 237,	131,	15200,	0,	0,	0,	NULL,	0,	SYSDATETIME()
UNION SELECT 238,	139,	11900,	0,	0,	0,	NULL,	0,	SYSDATETIME()
GO