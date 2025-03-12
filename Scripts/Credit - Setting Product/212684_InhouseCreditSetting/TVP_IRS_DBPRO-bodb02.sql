/*<info serverAlias="IRS_DBPRO-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241112@Johnson	
	Task: In-House
	DB: IRS_DBPRO-bodb02
	
	Revisions:
		- 20241112@Johnson: Created [RedmineID: #212684]

	Example:			
*/
CREATE TYPE [dbo].[TVP_Replcustinfo] AS TABLE (
	[username] [NVARCHAR](50) NULL
	,[custid] [INT] NOT NULL	
	,[roleid] [TINYINT] NULL	
	,[Abnormal] [TINYINT] NOT NULL
	,[DoubleCommLosing] [BIT] NOT NULL
	,[autosuspend2] [BIT] NULL
	,[DisableEsports] [BIT] NULL
	,[DisableSuperLive] [BIT] NULL	
	,[LockUpd] [BIT] NULL
	,[BonusWalletFlag] [BIT] NULL
	,[CreditUpdatedDate] [SMALLDATETIME] NULL
	,[DangerLevel] [INT] NULL
	,[CustomerClass] [SMALLINT] NULL
	,[Danger4] [TINYINT] NULL
	,[Danger5] [TINYINT] NULL
	,[CCSoccer] [SMALLINT] NULL
	,[CCBasketball] [SMALLINT] NULL
	,[CCEsports] [SMALLINT] NULL
	,[CCOtherSports] [SMALLINT] NULL
	,[CCNonSports] [SMALLINT] NULL
	,[autosuspend3] [BIT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_Replcustinfo] TO [repl_ap] AS [dbo]
GO
/***************************************************************************/




