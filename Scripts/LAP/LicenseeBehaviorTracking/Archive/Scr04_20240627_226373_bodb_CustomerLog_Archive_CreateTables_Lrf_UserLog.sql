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
    [SessionID]    VARCHAR(100)  NOT NULL,
    [UserID]       INT           NOT NULL,
    [LicenseeID]   INT           NOT NULL,
    [ServerID]     INT           NOT NULL,
    [IP]           VARCHAR(15)   NOT NULL,
    [DomainName]   VARCHAR(253)  NULL,
    [BrowserName]  VARCHAR(255)  NULL,
    [Platform]     VARCHAR(255)  NULL,
    [LogDate]      DATETIME      NOT NULL,
    CONSTRAINT [PK_Lrf_UserLog_Session] PRIMARY KEY CLUSTERED 
    (
        [SessionID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_Lrf_UserLog_monthly]([LogDate])
) ON [ps_Lrf_UserLog_monthly]([LogDate])
WITH
(
DATA_COMPRESSION = PAGE
)
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
    CONSTRAINT [PK_Lrf_UserLog_LicenseeBehavior] PRIMARY KEY CLUSTERED 
    (
        [LogID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ps_Lrf_UserLog_monthly]([LogDate])
) ON [ps_Lrf_UserLog_monthly]([LogDate]) TEXTIMAGE_ON [ps_Lrf_UserLog_monthly]--([LogDate])
WITH
(
DATA_COMPRESSION = PAGE
)
GO

-- Create indexes for Lrf_UserLog_Session
CREATE NONCLUSTERED INDEX [IX_Lrf_UserLog_Session_LogDate] ON [dbo].[Lrf_UserLog_Session]
(
	[LogDate] ASC,
	[UserID] ASC,
	[LicenseeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ps_Lrf_UserLog_monthly]([LogDate])
GO

CREATE NONCLUSTERED INDEX [IX_Lrf_UserLog_Session_UserID] ON [dbo].[Lrf_UserLog_Session]
(
	[UserID] ASC,
	[LogDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ps_Lrf_UserLog_monthly]([LogDate])
GO

-- Create indexes for Lrf_UserLog_LicenseeBehavior
CREATE NONCLUSTERED INDEX [IX_Lrf_UserLog_LicenseeBehavior_LogDate] ON [dbo].[Lrf_UserLog_LicenseeBehavior]
(
	[LogDate] ASC,
	[UserID] ASC,
	[LicenseeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ps_Lrf_UserLog_monthly]([LogDate])
GO

CREATE NONCLUSTERED INDEX [IX_Lrf_UserLog_LicenseeBehavior_UserID] ON [dbo].[Lrf_UserLog_LicenseeBehavior]
(
	[UserID] ASC,
	[LogDate] ASC,
	[ActionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ps_Lrf_UserLog_monthly]([LogDate])
GO

CREATE NONCLUSTERED INDEX [IX_Lrf_UserLog_LicenseeBehavior_SessionID] ON [dbo].[Lrf_UserLog_LicenseeBehavior]
(
	[SessionID] ASC,
	[LogDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [ps_Lrf_UserLog_monthly]([LogDate])
GO 

-- Grant permission:
GRANT SELECT ON [dbo].[Lrf_UserLog_Session]				TO wsv_lap;
GRANT SELECT ON [dbo].[Lrf_UserLog_LicenseeBehavior]	TO wsv_lap;