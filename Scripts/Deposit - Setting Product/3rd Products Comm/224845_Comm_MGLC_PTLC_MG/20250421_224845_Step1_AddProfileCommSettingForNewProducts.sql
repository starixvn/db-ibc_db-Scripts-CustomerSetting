/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250421@Tacy
	Task: Add profile for Comm Setting for Microgaming Live, Playtech Live, Rich Gaming [redmine: #224845]
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
	  SELECT 247, 107, 9, 0, 4, 1, SYSDATETIME()
UNION SELECT 248, 101, 9, 0, 4, 1, SYSDATETIME()
UNION SELECT 249, 108, 9, 0, 4, 1, SYSDATETIME()

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
	  SELECT 247,	124,	13900,	0,	0,	1,	NULL,	0,	SYSDATETIME() 
UNION SELECT 248,	129,	15600,	0,	0,	1,	NULL,	0,	SYSDATETIME()
UNION SELECT 249,	123,	15800,	0,	0,	1,	NULL,	0,	SYSDATETIME()
GO
