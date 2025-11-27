/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
        Created by: Tacy@20250818
        Task: initial data for OFA Live [Redmine: #236233] 
        DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

----------------------------------------------------------------------------------
DECLARE  @ProductID SMALLINT = 113
                ,@SportType  SMALLINT = 119
                ,@Bettype       SMALLINT = 12250  

                ,@BitmapOrder TINYINT = 67
                ,@psID        INT = 266

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--Insert setting:
INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder, RepUpdateTime)
SELECT @SportType,        @Bettype,        @BitmapOrder,         dbo.f_Getdatetime2()

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel]
           , RepUpdateTime)
      SELECT @psID,   @ProductID, 4, 0, 1, 1,         dbo.f_Getdatetime2()
UNION SELECT @psID+1, @ProductID, 7, 0, 2, 3,         dbo.f_Getdatetime2()
UNION SELECT @psID+2, @ProductID, 1, 0, 3, 1,         dbo.f_Getdatetime2()
UNION SELECT @psID+3, @ProductID, 9, 0, 4, 1,         dbo.f_Getdatetime2()


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
SELECT       @psID, @SportType, @Bettype, 0, 0, 1, NULL, 0,         dbo.f_Getdatetime2()
UNION SELECT @psID+1, @SportType, @Bettype, 0, 0, 1, NULL, 0,         dbo.f_Getdatetime2()
UNION SELECT @psID+2, @SportType, @Bettype, 0, 0, 1, NULL, 0,         dbo.f_Getdatetime2()
UNION SELECT @psID+3, @SportType, @Bettype, 0, 0, 1, NULL, 0,         dbo.f_Getdatetime2()
GO
