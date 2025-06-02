/*<info serverAlias="IRS_DBWH-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250515@Virgil	
	Task: VR Auto Job - Scale out DBCust - Remove Link server of VR Jobs [RedmineID: #211727]
	DB: DBWH-bodb02
	
	Revisions:
		- 20250515@Virgil: Created [RedmineID: #211727]

	Table Related:
		CustVirtualSetting
		VRAgentAutoAdjustment
		VRCustAutoAdjustment
*/

CREATE TABLE [dbo].[CustVirtualSetting](
	[custid] [int] NOT NULL,
	[seqNo] [tinyint] NOT NULL,
	[bitmapVirtual] [binary](64) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
CONSTRAINT [PK_CustVirtualSetting] PRIMARY KEY CLUSTERED 
(
	[custid] ASC,
	[seqNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [virtualrate_table]
) ON [virtualrate_table]
GO

ALTER TABLE [dbo].[CustVirtualSetting] ADD  CONSTRAINT [DF_CustVirtualSetting_bitmapVirtual]  DEFAULT (0x00) FOR [bitmapVirtual]
GO

ALTER TABLE [dbo].[CustVirtualSetting] ADD  CONSTRAINT [DF_CustVirtualSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

/***************************************************************************/
CREATE TABLE [dbo].[VRAgentAutoAdjustment](
	[AgentID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Status] [tinyint] NULL,
	[VR0_Date] [date] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_VRAgentAutoAdjustment] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [virtualrate_table]
) ON [virtualrate_table]
GO

ALTER TABLE [dbo].[VRAgentAutoAdjustment] ADD  CONSTRAINT [DF_VRAgentAutoAdjustment_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
/***************************************************************************/
CREATE TABLE [dbo].[VRCustAutoAdjustment](
	[SportType] [smallint] NOT NULL,
	[CustID] [int] NOT NULL,
	[FirstBetDate] [date] NULL,
	[Status] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_VRCustAutoAdjustment] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [virtualrate_table]
) ON [virtualrate_table]
GO

ALTER TABLE [dbo].[VRCustAutoAdjustment] ADD  CONSTRAINT [DF_VRCustAutoAdjustment_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
