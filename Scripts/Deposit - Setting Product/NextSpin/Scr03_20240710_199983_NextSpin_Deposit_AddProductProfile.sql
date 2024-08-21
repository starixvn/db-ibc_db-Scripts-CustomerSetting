/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240710@Tacy
	Task: Nextspin - Integrate New Product [redmine: #201983]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE  @ProductID	SMALLINT = 85
		,@SportType SMALLINT = 229
		,@Bettype	SMALLINT = 10450

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder)
SELECT @SportType,	@Bettype,	49

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
	  SELECT 200, @ProductID, 4, 0, 1, 1
UNION SELECT 201, @ProductID, 1, 0, 2, 1

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT       200, @SportType, @Bettype, 0, 0, 1, NULL, 0
UNION SELECT 201, @SportType, @Bettype, 0, 0, 1, NULL, 0
GO