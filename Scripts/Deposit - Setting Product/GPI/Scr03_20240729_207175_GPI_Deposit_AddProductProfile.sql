/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240729
	Task: GPI - Integrate New Product [redmine: #207175]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE  @ProductID	SMALLINT = 48
		,@SportType SMALLINT = 145
		,@Bettype	SMALLINT = 11400

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder,RepUpdateTime)
SELECT @SportType,	@Bettype,	50,	SYSDATETIME()

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel]
		   ,RepUpdateTime)
	  SELECT 202, @ProductID, 4, 0, 1, 1,	SYSDATETIME()
UNION SELECT 203, @ProductID, 1, 0, 2, 1,	SYSDATETIME()

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
SELECT       202, @SportType, @Bettype, 0, 0, 1, NULL, 0,	SYSDATETIME()
UNION SELECT 203, @SportType, @Bettype, 0, 0, 1, NULL, 0,	SYSDATETIME()
GO