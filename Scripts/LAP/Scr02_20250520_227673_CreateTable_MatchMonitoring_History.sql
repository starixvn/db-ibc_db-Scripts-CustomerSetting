/*<info serverAlias="DBLIC-bodb_LicenseeReport"></info>*/
/*
	Created: 20250520@Kelvin
	Task: LAP - Match Monitoring Center (Redmine: #227673)
	DB: DBLIC.bodb_LicenseeReport
	Remark:
		- Run on pair DB052-DB053
		- Create the sub folder LicenseeMatchMonitoring_History under the database folder K:\USER_DB\bodb_LicenseeReport\
*/
USE bodb_LicenseeReport
GO

ALTER DATABASE bodb_LicenseeReport ADD FILEGROUP LicenseeMatchMonitoring_HistoryData

ALTER DATABASE bodb_LicenseeReport
ADD FILE
(
	NAME ='LicenseeMatchMonitoring_HistoryData'
	,FILENAME = 'K:\USER_DB\bodb_LicenseeReport\LicenseeMatchMonitoring_HistoryData.ndf'
	--'G:\SQLSERVER2019_DEVDB053\IBC_DB\bodb_LicenseeReport\LicenseeMatchMonitoring_HistoryData.ndf'	--Local
	,SIZE = 8MB
	,MAXSIZE = UNLIMITED
	,FILEGROWTH = 32MB
)
TO FILEGROUP LicenseeMatchMonitoring_HistoryData

CREATE TABLE [dbo].[LicenseeMatchMonitoring_History](
	[LogID] [bigint] NOT NULL IDENTITY(1,1),
	[MonitoringID] [int] NOT NULL,
	[ExtraInfo] [nvarchar](4000) NULL,
	[SettingInfo] [nvarchar](4000) NULL,
	[LogDate] [datetime] NOT NULL,
	CONSTRAINT [PK_LicenseeMatchMonitoring_History] PRIMARY KEY CLUSTERED
	(
		[LogID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [LicenseeMatchMonitoring_HistoryData]
) ON [LicenseeMatchMonitoring_HistoryData]

ALTER TABLE [dbo].[LicenseeMatchMonitoring_History] ADD CONSTRAINT [DF_LicenseeMatchMonitoring_History_LogDate] DEFAULT (GETDATE()) FOR [LogDate]

CREATE NONCLUSTERED INDEX [IX_LicenseeMatchMonitoring_History_LogDate] ON [dbo].[LicenseeMatchMonitoring_History]
(
	[LogDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [LicenseeMatchMonitoring_HistoryData]

CREATE NONCLUSTERED INDEX [IX_LicenseeMatchMonitoring_History_MonitoringID] ON [dbo].[LicenseeMatchMonitoring_History]
(
	[MonitoringID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [LicenseeMatchMonitoring_HistoryData]
GO


--grant select permission
GRANT SELECT ON dbo.LicenseeMatchMonitoring_History TO [wsv_nap];
GO