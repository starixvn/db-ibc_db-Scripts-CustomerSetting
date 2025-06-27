/*<info serverAlias="DBLOG-bodb_CustomerLog,DBCUST-bodb_CustomerLog"></info>*/
/*
    Created: 20240627@Tacy
    Task: Create tables for user log session & behavior [#226373]
    DB: DBLOG-bodb_CustomerLog,DBCUST-bodb_CustomerLog

    Tables:
        Lrf_UserLog_Session
        Lrf_UserLog_LicenseeBehavior
        Lrf_ActionType
        Lrf_SubType
*/
USE bodb_CustomerLog
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
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Lrf_UserLog]
) ON [Lrf_UserLog] TEXTIMAGE_ON [Lrf_UserLog]
GO

ALTER TABLE [dbo].[Lrf_UserLog_Session] 
    ADD CONSTRAINT [DF_Lrf_UserLog_Session_LogDate] DEFAULT (GETDATE()) FOR [LogDate]
GO

-- 2. Lrf_UserLog_LicenseeBehavior
CREATE TABLE [dbo].[Lrf_UserLog_LicenseeBehavior](
    [LogID]        BIGINT         NOT NULL IDENTITY(1,1),
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
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Lrf_UserLog]
) ON [Lrf_UserLog] TEXTIMAGE_ON [Lrf_UserLog]
GO

ALTER TABLE [dbo].[Lrf_UserLog_LicenseeBehavior] 
    ADD CONSTRAINT [DF_Lrf_UserLog_LicenseeBehavior_LogDate] DEFAULT (GETDATE()) FOR [LogDate]
GO

IF @@SERVERNAME NOT IN ('DBCUST')
BEGIN
	-- 3. Lrf_ActionType
	CREATE TABLE [dbo].[Lrf_ActionType](
		[ActionTypeID] INT           NOT NULL,
		[ActionName]   VARCHAR(50)   NOT NULL,
		CONSTRAINT [PK_Lrf_ActionType] PRIMARY KEY CLUSTERED 
		(
			[ActionTypeID] ASC
		) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
	) ON [DATA]

	-- 4. Lrf_SubType
	CREATE TABLE [dbo].[Lrf_SubType](
		[SubTypeID] INT           NOT NULL,
		[SubType]   VARCHAR(50)   NOT NULL,
		CONSTRAINT [PK_Lrf_SubType] PRIMARY KEY CLUSTERED 
		(
			[SubTypeID] ASC
		) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
	) ON [DATA]
END
GO

-- Grant permission:
GRANT SELECT ON [dbo].[Lrf_UserLog_Session]				TO wsv_lap;
GRANT SELECT ON [dbo].[Lrf_UserLog_LicenseeBehavior]	TO wsv_lap;
GRANT SELECT ON [dbo].[Lrf_ActionType]					TO wsv_lap;
GRANT SELECT ON [dbo].[Lrf_SubType]						TO wsv_lap;
