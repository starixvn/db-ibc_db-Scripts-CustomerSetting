/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
    Created: 20250702@Tacy
    Task: Create tables for user log session & behavior [#226373]
    DB: DBLOG-bodb_CustomerLog

    Tables:
        Lrf_UserLog_Session
        Lrf_UserLog_LicenseeBehavior
        Lrf_ActionType
        Lrf_SubType
*/
USE bodb_CustomerLog
GO

-- FileGroup:
ALTER DATABASE bodb_CustomerLog ADD FILEGROUP Lrf_UserLog

IF @@SERVERNAME NOT LIKE 'SIT%'
BEGIN -- PROD
	ALTER DATABASE bodb_CustomerLog
	ADD FILE
	(
		NAME ='Lrf_UserLog'
		,FILENAME = 'H:\USER_DB\Lrf_UserLog.ndf'
		--> Server TEST: /mnt/DiskG/bodb_CustomerLog/Lrf_UserLog.ndf
		--> Server DEV: G:\SQLSERVER2019_DEVDB055\IBC_DB\bodb_CustomerLog\Lrf_UserLog.ndf
		,SIZE = 1024KB
		,FILEGROWTH = 32768KB
	)
	TO FILEGROUP Lrf_UserLog
END

----------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Lrf_UserLog_Session
CREATE TABLE [dbo].[Lrf_UserLog_Session](
    [LogID]        BIGINT        NOT NULL IDENTITY(1,1),
    [SessionID]    VARCHAR(50)   NOT NULL,
    [UserID]       INT           NOT NULL,
    [LicenseeID]   INT           NOT NULL,
    [IP]           VARCHAR(15)   NOT NULL,
    [DomainName]   VARCHAR(200)  NULL,
    [BrowserName]  VARCHAR(100)  NULL,
    [Platform]     VARCHAR(100)  NULL,
    [LogDate]      DATETIME      NOT NULL,
    CONSTRAINT [PK_Lrf_UserLog_Session] PRIMARY KEY NONCLUSTERED 
    (
        [LogID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Lrf_UserLog]
) ON [Lrf_UserLog]
GO

ALTER TABLE [dbo].[Lrf_UserLog_Session] ADD CONSTRAINT [DF_Lrf_UserLog_Session_LogDate] DEFAULT (GETDATE()) FOR [LogDate]
GO

CREATE CLUSTERED INDEX [CIX_Lrf_UserLog_Session] ON [dbo].[Lrf_UserLog_Session]
(
    [UserID] ASC,
    [LogDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Lrf_UserLog]
GO

-- 2. Lrf_UserLog_LicenseeBehavior
CREATE TABLE [dbo].[Lrf_UserLog_LicenseeBehavior](
    [LogID]        BIGINT         NOT NULL IDENTITY(1,1),
    [SessionID]    VARCHAR(50)    NOT NULL,
    [UserID]       INT            NOT NULL,
    [LicenseeID]   INT            NOT NULL,
    [ActionTypeID] INT            NOT NULL,
    [SubTypeID]    INT            NOT NULL,
    [Target]       VARCHAR(100)   NULL,
    [FunctionKey]  VARCHAR(50)    NULL,
    [ExtraContext] NVARCHAR(MAX) NULL, 
    [LogDate]      DATETIME       NOT NULL,
    CONSTRAINT [PK_Lrf_UserLog_LicenseeBehavior] PRIMARY KEY NONCLUSTERED 
    (
        [LogID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Lrf_UserLog]
) ON [Lrf_UserLog] TEXTIMAGE_ON [Lrf_UserLog]
GO

ALTER TABLE [dbo].[Lrf_UserLog_LicenseeBehavior] ADD CONSTRAINT [DF_Lrf_UserLog_LicenseeBehavior_LogDate] DEFAULT (GETDATE()) FOR [LogDate];
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

-- 3. Lrf_ActionType
CREATE TABLE [dbo].[Lrf_ActionType](
    [ActionTypeID] INT           NOT NULL,
    [ActionName]   VARCHAR(50)   NOT NULL,
    CONSTRAINT [PK_Lrf_ActionType] PRIMARY KEY CLUSTERED 
    (
        [ActionTypeID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-- 4. Lrf_SubType
CREATE TABLE [dbo].[Lrf_SubType](
    [SubTypeID] INT           NOT NULL,
    [SubType]   VARCHAR(50)   NOT NULL,
    CONSTRAINT [PK_Lrf_SubType] PRIMARY KEY CLUSTERED 
    (
        [SubTypeID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

-- Grant permission:
GRANT SELECT ON [dbo].[Lrf_UserLog_Session]				TO wsv_lap;
GRANT SELECT ON [dbo].[Lrf_UserLog_LicenseeBehavior]	TO wsv_lap;
GRANT SELECT ON [dbo].[Lrf_ActionType]					TO wsv_lap;
GRANT SELECT ON [dbo].[Lrf_SubType]						TO wsv_lap;
