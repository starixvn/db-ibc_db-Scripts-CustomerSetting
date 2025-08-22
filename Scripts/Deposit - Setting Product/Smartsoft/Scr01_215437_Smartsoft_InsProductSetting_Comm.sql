/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250811
	Task: Smartsoft - Implement Customer Setting and Initial data - Commission [RedmineID: #210946]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

----------------------------------------------------------------------------------
DECLARE  @ProductID	SMALLINT = 99
		,@SportType SMALLINT = 135
		,@Bettype	SMALLINT = 12150
		,@psID	INT = 265

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--Insert setting:
INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel]
		   , RepUpdateTime)
SELECT @psID, @ProductID, 9, 0, 3, 1,	 dbo.f_Getdatetime2()

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA]
		   ,RepUpdateTime)
SELECT @psID, @SportType, @Bettype, 0, 0, 1, NULL, 0,	 dbo.f_Getdatetime2()
GO
