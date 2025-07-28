/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Tacy@20250722
	Task: Odin Gaming - Integrate New Product - Commission [redmine: #219223]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

----------------------------------------------------------------------------------
DECLARE  @ProductID	SMALLINT = 105
		,@SportType SMALLINT = 128
		,@Bettype	SMALLINT = 15400   
		,@psID	INT = 264

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