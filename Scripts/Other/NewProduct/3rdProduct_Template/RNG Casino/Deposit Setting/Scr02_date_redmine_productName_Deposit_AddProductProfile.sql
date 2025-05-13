/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: {Nickname}@{date}
	Task: initial data into Company Bet Limit for {productName} [Redmine: #xxx] 
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

----------------------------------------------------------------------------------
DECLARE  @ProductID	SMALLINT = {ProductID}
		,@SportType SMALLINT = {SportType}
		,@Bettype	SMALLINT = {Bettype}  

		,@BitmapOrder TINYINT = {BitmapOrder}
		,@Max_psID	INT = {Deposit_psID}

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
UNION SELECT @Max_psID+3, @ProductID, 9, 0, 3, 1,	 dbo.f_Getdatetime2()


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
UNION SELECT @Max_psID+3, @SportType, @Bettype, 0, 0, 1, NULL, 0,	 dbo.f_Getdatetime2()
GO
