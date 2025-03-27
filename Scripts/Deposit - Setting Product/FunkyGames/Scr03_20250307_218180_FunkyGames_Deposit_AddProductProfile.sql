/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20250307 
	Task: Funky Games - Integrate New Product [redmine: #218180]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

IF @@SERVERNAME = 'SITDBCUST'
	USE GlobCustDB

DECLARE  @ProductID	SMALLINT = 104
		,@SportType SMALLINT = 131
		,@Bettype	SMALLINT = 15200 

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder, RepUpdateTime)
SELECT @SportType,	@Bettype,	57,	 dbo.f_Getdatetime2()

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel]
		   , RepUpdateTime)
	  SELECT 230, @ProductID, 4, 0, 1, 1,	 dbo.f_Getdatetime2()
UNION SELECT 231, @ProductID, 1, 0, 2, 1,	 dbo.f_Getdatetime2()

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
SELECT       230, @SportType, @Bettype, 0, 0, 1, NULL, 0,	 dbo.f_Getdatetime2()
UNION SELECT 231, @SportType, @Bettype, 0, 0, 1, NULL, 0,	 dbo.f_Getdatetime2()
GO