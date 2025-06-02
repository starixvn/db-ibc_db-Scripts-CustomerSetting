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
CREATE TYPE [dbo].[TVP_ReplCustVirtualSetting] AS TABLE (
	[custid] [int] NOT NULL
	,[seqNo] [tinyint] NOT NULL
	,[bitmapVirtual] [binary](64) NOT NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustVirtualSetting] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplVRAgentAutoAdjustment] AS TABLE (
	[AgentID] [int] NOT NULL
	,[Type] [tinyint] NOT NULL
	,[Status] [tinyint] NULL
	,[VR0_Date] [date] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplVRAgentAutoAdjustment] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplVRCustAutoAdjustment] AS TABLE (
	[SportType] [smallint] NOT NULL
	,[CustID] [int] NOT NULL
	,[FirstBetDate] [date] NULL
	,[Status] [tinyint] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplVRCustAutoAdjustment] TO [repl_ap] AS [dbo]
GO
