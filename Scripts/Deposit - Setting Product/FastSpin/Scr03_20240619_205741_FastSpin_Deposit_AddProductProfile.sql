/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240619 
	Task: FastSpin - Integrate New Product [redmine: #205741]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

DECLARE  @ProductID	SMALLINT = 87
		,@SportType SMALLINT = 230
		,@Bettype	SMALLINT = 11100

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder)
SELECT @SportType,	@Bettype,	47

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
	  SELECT 196, @ProductID, 4, 0, 1, 1
UNION SELECT 197, @ProductID, 1, 0, 2, 1

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT       196, @SportType, @Bettype, 0, 0, 1, NULL, 0
UNION SELECT 197, @SportType, @Bettype, 0, 0, 1, NULL, 0
GO