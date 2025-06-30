/*<info serverAlias="IRS_DBACC-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250519@Winfred	
	DB: IRS_DBACC-bodb02
	Task: Remove Link server of VR Jobs
	
	Revisions:
		- 20250519@Winfred: VR Auto Job - Scale out DBCust - Remove Link server of VR Jobs [RedmineID: #211727]

	Example:			
*/
/***************************************************************************/
CREATE TYPE [dbo].[TVP_ReplVRMemberBigStake] AS TABLE (
	[CustID] [INT] NOT NULL
	,[Type] [TINYINT] NOT NULL
	,[FirstBetDate] [DATE] NULL
	,[Status] [TINYINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplVRMemberBigStake] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/