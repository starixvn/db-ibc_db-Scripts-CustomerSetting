/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: Eden@20240628
	Task: Create Type [Redmine: #206823]  
	DB: IRS_DBTP-bodb02 , DBGLOB-GlobCustDB
*/

USE bodb02
GO

/***************************************************************************/
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutCustInfoMini_Dist')
BEGIN
	DROP PROCEDURE Repl_PutCustInfoMini_Dist;
END
GO
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplCustInfoMini' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplCustInfoMini;
END
GO
CREATE TYPE [dbo].[TVP_ReplCustInfoMini] AS TABLE (
	[CustID] [INT] NOT NULL
	,[username] [VARCHAR](30) NOT NULL
	,[username2] [VARCHAR](50) NULL
	,[recommend] [INT] NULL
	,[mrecommend] [INT] NULL
	,[srecommend] [INT] NULL
	,[roleid] [TINYINT] NULL
	,[SiteDBGroupID] [SMALLINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[Site] [VARCHAR](10) NULL
	,[Currency] [INT] NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustInfoMini] TO [repl_ap] AS [dbo]
GO


/***************************************************************************/
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutCustSubMini_Dist')
BEGIN
	DROP PROCEDURE Repl_PutCustSubMini_Dist;
END
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplCustSubMini' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplCustSubMini;
END
GO
CREATE TYPE [dbo].[TVP_ReplCustSubMini] AS TABLE (
	[subaccid] [INT] NOT NULL
	,[CustID] [INT] NOT NULL
	,[username] [VARCHAR](30) NOT NULL
	,[username2] [VARCHAR](50) NULL
	,[SiteDBGroupID] [SMALLINT] NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustSubMini] TO [repl_ap] AS [dbo]