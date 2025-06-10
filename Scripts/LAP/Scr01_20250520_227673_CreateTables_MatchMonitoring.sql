/*<info serverAlias="DBCUST-bodb_licensee,DBLIC-bodb_Licensee,DBBOF-bodb_Licensee,DBACC-bodb_Licensee,DBTP-bodb_Licensee"></info>*/
/*
	Created: 20250520@Tacy
	Task: Create new tables for LAP - Match Monitoring Center [#RedmineID:#227673]
	DB: DBCUST-bodb_licensee,DBLIC-bodb_Licensee,DBBOF-bodb_Licensee,DBACC-bodb_Licensee,DBTP-bodb_Licensee

	Tables:
		LicenseeMatchMonitoring
		LicenseeMatchMonitoringRule
		LicenseeMatchMonitoringSetting
		LicenseeMatchMonitoringSetting_Detail
*/
USE bodb_Licensee
GO

CREATE TABLE [dbo].[LicenseeMatchMonitoring](
    [MonitoringID] [int] NOT NULL IDENTITY(1,1) NOT FOR REPLICATION,
    [LicenseeId] [int] NOT NULL,
    [MatchID] [int] NOT NULL,
    [BetType] [smallint] NOT NULL,
    [LiveIndicator] [bit] NOT NULL,
    [LiveHomeScore] [smallint] NULL,
    [LiveAwayScore] [smallint] NULL,    
	[IsActive] [bit] NOT NULL,
    [IsAlerted] [bit] NOT NULL,
    [CreatedDate] [datetime] NOT NULL,
    CONSTRAINT [PK_LicenseeMatchMonitoring] PRIMARY KEY CLUSTERED 
    (
        [MonitoringID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [licensee_table]
) ON [licensee_table]
GO

ALTER TABLE [dbo].[LicenseeMatchMonitoring] ADD CONSTRAINT [DF_LicenseeMatchMonitoring_IsActive] DEFAULT (1) FOR [IsActive]
GO

ALTER TABLE [dbo].[LicenseeMatchMonitoring] ADD CONSTRAINT [DF_LicenseeMatchMonitoring_IsAlerted] DEFAULT (0) FOR [IsAlerted]
GO

ALTER TABLE [dbo].[LicenseeMatchMonitoring] ADD CONSTRAINT [DF_LicenseeMatchMonitoring_CreatedDate] DEFAULT (GETDATE()) FOR [CreatedDate]
GO

CREATE NONCLUSTERED INDEX [IX_LicenseeMatchMonitoring_LicenseeID] ON [dbo].[LicenseeMatchMonitoring]
(
    [LicenseeID] ASC,
    [MatchID] ASC,
    [BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [licensee_table]
GO

CREATE TABLE [dbo].[LicenseeMatchMonitoringRule](
    [RuleID] [smallint] NOT NULL,
    [RuleName] [varchar](50) NOT NULL,
    CONSTRAINT [PK_LicenseeMatchMonitoringRule] PRIMARY KEY CLUSTERED 
    (
        [RuleID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [licensee_table]
) ON [licensee_table]
GO

CREATE TABLE [dbo].[LicenseeMatchMonitoringSetting](
    [SettingID] [int] NOT NULL IDENTITY(1,1) NOT FOR REPLICATION,
    [SettingName] [nvarchar](100) NOT NULL,
    [MonitoringID] [int] NOT NULL,    
	[ConditionType] [tinyint] NOT NULL, -- 0 = OR, 1 = AND
    [BaseCurrency] [varchar](10) NOT NULL,
    [NotificationInterval] [smallint] NOT NULL,
    [LastSendNotification] [datetime] NULL,
    [CreatedDate] [datetime] NOT NULL,
    [ModifiedDate] [datetime] NOT NULL,
    CONSTRAINT [PK_LicenseeMatchMonitoringSetting] PRIMARY KEY CLUSTERED 
    (
        [SettingID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [licensee_table]
) ON [licensee_table]
GO

ALTER TABLE [dbo].[LicenseeMatchMonitoringSetting] ADD CONSTRAINT [DF_LicenseeMatchMonitoringSetting_CreatedDate] DEFAULT (GETDATE()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[LicenseeMatchMonitoringSetting] ADD CONSTRAINT [DF_LicenseeMatchMonitoringSetting_ModifiedDate] DEFAULT (GETDATE()) FOR [ModifiedDate]
GO

CREATE TABLE [dbo].[LicenseeMatchMonitoringSetting_Detail](
    [SettingID] [int] NOT NULL,
    [RuleID] [smallint] NOT NULL,
    [Threshold] [money] NOT NULL,
    CONSTRAINT [PK_LicenseeMatchMonitoringSetting_Detail] PRIMARY KEY CLUSTERED 
    (
        [SettingID] ASC,
        [RuleID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [licensee_table]
) ON [licensee_table]
GO

-- Grant permission:
GRANT SELECT ON dbo.LicenseeMatchMonitoring TO [wsv_lap];
GRANT SELECT ON dbo.LicenseeMatchMonitoringRule TO [wsv_lap];
GRANT SELECT ON dbo.LicenseeMatchMonitoringSetting TO [wsv_lap];
GRANT SELECT ON dbo.LicenseeMatchMonitoringSetting_Detail TO [wsv_lap];

IF @@SERVERNAME IN ('DB053','DB052' --PROD
					,'SITDB052','SITDB053')	--SIT
BEGIN
	GRANT SELECT ON dbo.LicenseeMatchMonitoring TO [wsv_nap];
	GRANT SELECT ON dbo.LicenseeMatchMonitoringRule TO [wsv_nap];
	GRANT SELECT ON dbo.LicenseeMatchMonitoringSetting TO [wsv_nap];
	GRANT SELECT ON dbo.LicenseeMatchMonitoringSetting_Detail TO [wsv_nap];
END