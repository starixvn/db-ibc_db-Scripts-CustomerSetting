/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Tacy@20250320
	Task: Odin Gaming - Integrate New Product [redmine: #219223]
	DB: DBGLOB-GlobCustDB
*/
----------------------------------------------------------------------------------
DECLARE  @ProductID	SMALLINT = 105
		,@SportType SMALLINT = 128
		,@Bettype	SMALLINT = 15400   
		,@Max_psID	INT = 233
		,@BitmapOrder TINYINT = 59

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