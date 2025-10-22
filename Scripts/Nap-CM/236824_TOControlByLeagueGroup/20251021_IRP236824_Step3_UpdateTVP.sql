/*<info serverAlias="DBCustRepl-ReplCustDB,IRS_DBTP-bodb02,IRS_DBAGE-bodb02"></info>*/
/*
	Created: 20251021@Johnson
	Task: Enhancement - TO Monitor Control By League [Redmine:#236824]	
	DB: DBCUST/CustDB
*/

--DBCustRepl-ReplCustDB,IRS_DBTP-bodb02
DROP PROCEDURE IF EXISTS [dbo].[Repl_PutTOControl_GlobalSetting_Dist]
GO

--IRS_DBAGE-bodb02
DROP PROCEDURE IF EXISTS [dbo].[Repl_PutTOControl_GlobalSetting]
GO

--DR
DROP PROCEDURE IF EXISTS [dbo].[DR_Repl_PutTOControl_GlobalSetting_Dist]
GO

DROP TYPE [dbo].[TVP_ReplTOControl_GlobalSetting]
GO

CREATE TYPE [dbo].[TVP_ReplTOControl_GlobalSetting] AS TABLE(
	[CustID] [int] NOT NULL,
    [LeagueGroupID] [int] NOT NULL,
	[MaxTurnOver] [money] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[IsGroupHeadLine] [bit] NOT NULL,
	[ProfileID] [smallint] NOT NULL,
	[IsGlobalLockTOLimit] [bit] NULL,
	[IsLeagueGroupLock] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NULL,
	[ID] [int] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplTOControl_GlobalSetting] TO [repl_ap] AS [dbo]
GO
