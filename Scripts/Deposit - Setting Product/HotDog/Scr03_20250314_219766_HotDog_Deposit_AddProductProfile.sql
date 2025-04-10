/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Tacy@20250314
	Task: HOTDOG - Integrate New Product [redmine: #219766]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

----------------------------------------------------------------------------------
DECLARE  @ProductID	SMALLINT = 95
		,@SportType SMALLINT = 139
		,@Bettype	SMALLINT = 11900  

		,@BitmapOrder TINYINT = 58
		,@Max_psID	INT = 231

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--Insert setting:
INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder, RepUpdateTime)
SELECT @SportType,	@Bettype,	@BitmapOrder,	 dbo.f_Getdatetime2()

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel]
		   , RepUpdateTime)
	  SELECT @Max_psID+1, @ProductID, 4, 0, 1, 1,	 dbo.f_Getdatetime2()
UNION SELECT @Max_psID+2, @ProductID, 1, 0, 2, 1,	 dbo.f_Getdatetime2()

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
SELECT       @Max_psID+1, @SportType, @Bettype, 0, 0, 1, NULL, 0,	 dbo.f_Getdatetime2()
UNION SELECT @Max_psID+2, @SportType, @Bettype, 0, 0, 1, NULL, 0,	 dbo.f_Getdatetime2()
GO