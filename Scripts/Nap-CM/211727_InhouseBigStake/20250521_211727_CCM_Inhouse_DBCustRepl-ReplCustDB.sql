/*<info serverAlias="DBCustRepl-ReplCustDB "></info>*/
/*
	Created: 20250519@Winfred
	DB: DBCustRepl-ReplCustDB
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
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_VRMemberBigStake] PRIMARY KEY CLUSTERED ([CustID],[Type]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[VRMemberBigStake] ADD CONSTRAINT [DF_VRMemberBigStake_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[VRMemberBigStake] ADD CONSTRAINT [DF_VRMemberBigStake_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table VRMemberBigStake exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRMemberBigStake]') AND name = N'IX_VRMemberBigStake_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_VRMemberBigStake_RepUpdateTime] ON [dbo].[VRMemberBigStake] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
