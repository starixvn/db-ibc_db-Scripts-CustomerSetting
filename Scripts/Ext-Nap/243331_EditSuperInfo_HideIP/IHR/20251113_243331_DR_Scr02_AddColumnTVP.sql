/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20251113@Dave
	Task: EXT - Allow Headline to hide IP info of their downlines [Redmine:#243331]
	DB: DBCUST.CustDB
*/

IF EXISTS (SELECT 1 FROM RepInfo WITH (NOLOCK) WHERE [name] = 'CustSuper' AND active = 0)
BEGIN
	DROP PROC IF EXISTS DR_Repl_PutCustSuper_Dist;
	DROP TYPE IF EXISTS dbo.TVP_ReplCustSuper;
END

CREATE TYPE [dbo].[TVP_ReplCustSuper] AS TABLE (
	[custid] [INT] NOT NULL
	,[AutoIBCPositionTaking_Tote] [SMALLMONEY] NOT NULL
	,[AutoIBCPositionTaking_Fixed] [SMALLMONEY] NOT NULL
	,[IsInternal] [BIT] NOT NULL
	,[TransferOption] [TINYINT] NULL
	,[LimitPerIP] [TINYINT] NOT NULL
	,[SelectedBetting] [BIT] NOT NULL
	,[AutoIBCPT151_AU] [SMALLMONEY] NOT NULL
	,[AutoIBCPT152_UK] [SMALLMONEY] NOT NULL
	,[AutoIBCPT152_AU] [SMALLMONEY] NOT NULL
	,[AutoIBCPT153_AU] [SMALLMONEY] NOT NULL
	,[NicknameLoginOnly] [BIT] NULL
	,[creationRemark] [NVARCHAR](300) NULL	
	,[IsMyanmarOdds] [BIT] NULL
	,[IsAllDayBalTransfer] [BIT] NULL
	,[MaxMember] [INT] NULL
	,[MaxMemberRemark] [NVARCHAR](300) NULL
	,[UplineId] [INT] NULL
	,[CurrencyModifier] [SMALLMONEY] NOT NULL
	,[IsAutoEnableADBMaster] [BIT] NOT NULL
	,[SiteDBGroupID] [SMALLINT] NOT NULL
	,[IsSynced] [BINARY](2) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
	,isHideIP BIT
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustSuper] TO [repl_ap] AS [dbo]
GO
