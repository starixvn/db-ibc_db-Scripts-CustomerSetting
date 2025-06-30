/*<info serverAlias="IRS_DBWH-bodb02 "></info>*/
/*
	Created: 20250519@Winfred
	DB: IRS_DBWH-bodb02
	Task: Remove Link server of VR Jobs
	Revisions:
		- 20250519@Winfred: VR Auto Job - Scale out DBCust - Remove Link server of VR Jobs [RedmineID: #211727]
*/
/***************************************************************************/
--DROP TABLE [dbo].[VRMemberBigStake]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRMemberBigStake]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[VRMemberBigStake]
	(
		[CustID] [INT] NOT NULL
		,[Type] [TINYINT] NOT NULL
		,[FirstBetDate] [DATE] NULL
		,[Status] [TINYINT] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,CONSTRAINT [PK_VRMemberBigStake] PRIMARY KEY CLUSTERED ([CustID],[Type]) ON [DATA]
	) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table VRMemberBigStake exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_VRMemberBigStake_RepUpdateTime]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[VRMemberBigStake] ADD  CONSTRAINT [DF_VRMemberBigStake_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRMemberBigStake]') AND name = N'IX_VRMemberBigStake_FirstBetDate')
CREATE NONCLUSTERED INDEX [IX_VRMemberBigStake_FirstBetDate] ON [dbo].[VRMemberBigStake]
(
	[FirstBetDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [virtualrate_table]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRMemberBigStake]') AND name = N'IX_VRMemberBigStake_RepUpdateTime')
CREATE NONCLUSTERED INDEX [IX_VRMemberBigStake_RepUpdateTime] ON [dbo].[VRMemberBigStake]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

