/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
        Created by: Tacy@20250827
        Task: initial data for BGaming [Redmine: #236998] 
        DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

----------------------------------------------------------------------------------
DECLARE  @ProductID SMALLINT = 114
                ,@SportType  SMALLINT = 118
                ,@Bettype       SMALLINT = 16400  

                ,@BitmapOrder TINYINT = 68
                ,@psID        INT = 270

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
          SELECT @psID, @ProductID, 4, 0, 1, 1,         dbo.f_Getdatetime2()
UNION SELECT @psID+1, @ProductID, 1, 0, 2, 1,         dbo.f_Getdatetime2()
UNION SELECT @psID+2, @ProductID, 9, 0, 3, 1,         dbo.f_Getdatetime2()


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
GO