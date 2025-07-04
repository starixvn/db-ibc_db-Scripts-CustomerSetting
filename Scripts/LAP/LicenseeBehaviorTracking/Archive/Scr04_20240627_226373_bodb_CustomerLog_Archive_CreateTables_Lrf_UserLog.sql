/*<info serverAlias="DBLOG-bodb_CustomerLog_Archive"></info>*/
/*
	Created by: Tacy@20240627
	Task: Archive tables Lrf_UserLog_Session and Lrf_UserLog_LicenseeBehavior
		https://nexdev.net/issues/226373
	DB: DBLOG-bodb_CustomerLog_Archive
*/
USE [bodb_CustomerLog_Archive]
GO

-- 1. Lrf_UserLog_Session
CREATE TABLE [dbo].[Lrf_UserLog_Session](
    [LogID]        BIGINT        NOT NULL,
    [SessionID]    VARCHAR(100)  NOT NULL,
    [UserID]       INT           NOT NULL,
    [LicenseeID]   INT           NOT NULL,
    [ServerID]     INT           NOT NULL,
    [IP]           VARCHAR(15)   NOT NULL,
    [DomainName]   VARCHAR(253)  NULL,
    [BrowserName]  VARCHAR(255)  NULL,
    [Platform]     VARCHAR(255)  NULL,
    [LogDate]      DATETIME      NOT NULL,
) ON [ps_Lrf_UserLog_monthly]([LogDate])
WITH
(
DATA_COMPRESSION = PAGE
)
GO

CREATE CLUSTERED INDEX [CIX_Lrf_UserLog_Session] ON [dbo].[Lrf_UserLog_Session]
(
    [UserID] ASC,
    [LogDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Lrf_UserLog]
GO

-- 2. Lrf_UserLog_LicenseeBehavior
CREATE TABLE [dbo].[Lrf_UserLog_LicenseeBehavior](
    [LogID]        BIGINT         NOT NULL,
    [SessionID]    VARCHAR(100)   NOT NULL,
    [UserID]       INT            NOT NULL,
    [LicenseeID]   INT            NOT NULL,
    [ActionTypeID] INT            NOT NULL,
    [SubTypeID]    INT            NOT NULL,
    [Target]       VARCHAR(100)   NULL,
    [FullTag]      VARCHAR(255)   NULL,
    [FunctionKey]  VARCHAR(50)    NULL,
    [ExtraContext] NVARCHAR(MAX)  NULL,
    [LogDate]      DATETIME       NOT NULL,
) ON [ps_Lrf_UserLog_monthly]([LogDate]) TEXTIMAGE_ON [ps_Lrf_UserLog_monthly]
WITH
(
DATA_COMPRESSION = PAGE
)
GO

CREATE CLUSTERED INDEX [CIX_Lrf_UserLog_LicenseeBehavior] ON [dbo].[Lrf_UserLog_LicenseeBehavior]
(
    [UserID] ASC,
    [LogDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Lrf_UserLog]
GO

CREATE NONCLUSTERED INDEX [IX_Lrf_UserLog_LicenseeBehavior_UserID] ON [dbo].[Lrf_UserLog_LicenseeBehavior]
(
    [UserID] ASC,
    [FunctionKey] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Lrf_UserLog]
GO

-- Grant permission:
GRANT SELECT ON [dbo].[Lrf_UserLog_Session]				TO wsv_lap;
GRANT SELECT ON [dbo].[Lrf_UserLog_LicenseeBehavior]	TO wsv_lap;