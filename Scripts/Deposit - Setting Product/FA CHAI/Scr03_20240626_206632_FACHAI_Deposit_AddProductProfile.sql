/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240626 
	Task: FA CHAI - Integrate New Product [redmine: #206632]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE  @ProductID	SMALLINT = 89
		,@SportType SMALLINT = 146
		,@Bettype	SMALLINT = 11300

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder)
SELECT @SportType,	@Bettype,	48

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
	  SELECT 198, @ProductID, 4, 0, 1, 1
UNION SELECT 199, @ProductID, 1, 0, 2, 1

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT       198, @SportType, @Bettype, 0, 0, 1, NULL, 0
UNION SELECT 199, @SportType, @Bettype, 0, 0, 1, NULL, 0
GO