/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
        Created: Tacy@20250818
        Task: OFA Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #236233]
        DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE  @SportType                INT = 119
                ,@BetType                INT = 12250
                ,@psID                INT = 384
                ,@Child_DisplayOrder TINYINT = 31

-- Product Setting Profile
INSERT INTO ProductSettingProfile(
        [ProductSettingID]
        ,[SettingType]
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[ProductID]
        ,[IsSync]
        ,[IsHidden]
        ,[IsDisabled]
        ,[SettingLevel]
        ,[DisplayOrder]
        ,[SettingStatus]
        ,[RealProductId]
        ,[Child_DisplayOrder]
        ,[GroupID]
        ,[GroupType]
        ,[GroupTypeOrder]
        ,[CreationStatus]
        ,[DisplayType]
        ,[MarketType]
        ,[RepUpdateTime]
)
SELECT @psID AS ProductSettingID,
                7 AS SettingType,
                @SportType AS SportType,
                @BetType AS BetType,
                0 AS IsLive,
                41 AS ProductID,
                0 AS IsSync,
                1 AS IsHidden,
                0 AS IsDisabled,
                2 AS SettingLevel,
                6 AS DisplayOrder,
                1 AS SettingStatus,
                41 AS RealProductID,
                @Child_DisplayOrder AS Child_DisplayOrder,
                3 AS GroupID,
                158 AS GroupType,
                5 AS GroupTypeOrder,
                1 AS CreationStatus,
                1 AS DisplayType,
                0 AS MarketType,
                dbo.f_GetDateTime2()

-- Product Setting Profile
INSERT INTO ProductSettingDetail(
        [ProductSettingID]
        ,[SettingType]
        ,[SportType]
        ,[BetType]
        ,[IsLive]
        ,[ProductID]
        ,[IsSync]
        ,[IsHidden]
        ,[IsDisabled]
        ,[SettingLevel]
        ,[DisplayOrder]
        ,[SettingStatus]
        ,[RealProductId]
        ,[Child_DisplayOrder]
        ,[RepUpdateTime]
)
SELECT @psID AS ProductSettingID,
        7 AS SettingType,
        @SportType AS SportType,
        @BetType AS BetType,
        0 AS IsLive,
        41 AS ProductID,
        0 AS IsSync,
        1 AS IsHidden,
        0 AS IsDisabled,
        2 AS SettingLevel,
        6 AS DisplayOrder,
        1 AS SettingStatus,
        41 AS RealProductID,
        @Child_DisplayOrder AS Child_DisplayOrder,
        dbo.f_GetDateTime2()
GO
