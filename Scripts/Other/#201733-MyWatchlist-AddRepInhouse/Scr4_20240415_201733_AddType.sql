/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
	Created: 20240415@Eden
	Task: add new TYPE for Rep-inhouse [#201733]
		WLMonitored_Global
		WLMonitored_Player
		WLMonitored_SMA
	DB: DBAGE-bodb02
*/
USE bodb02
GO
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutWLMonitored_Global')
BEGIN
	DROP PROCEDURE Repl_PutWLMonitored_Global;
END

IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutWLMonitored_Player')
BEGIN
	DROP PROCEDURE Repl_PutWLMonitored_Player;
END

IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutWLMonitored_SMA')
BEGIN
	DROP PROCEDURE Repl_PutWLMonitored_SMA;
END

IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplWLMonitored_Global' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplWLMonitored_Global;
END

CREATE TYPE [dbo].TVP_ReplWLMonitored_Global AS TABLE (
	[AgentID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[LosingThreshold] [money] NULL,
	[LosingUpdateTime] [datetime] NULL,
	[InitSettingTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplWLMonitored_Global TO [repl_ap] AS [dbo]
GO
-------------------------
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplWLMonitored_Player' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplWLMonitored_Player;
END

CREATE TYPE [dbo].TVP_ReplWLMonitored_Player AS TABLE (
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[AgentID] [int] NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[LosingThreshold] [money] NULL,
	[LosingUpdateTime] [datetime] NULL,
	[InitSettingTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[CreatedDate] [datetime] NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplWLMonitored_Player TO [repl_ap] AS [dbo]
GO
-------------------------
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplWLMonitored_SMA' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplWLMonitored_SMA;
END

CREATE TYPE [dbo].TVP_ReplWLMonitored_SMA AS TABLE (
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[WinningThreshold] [money] NULL,
	[WinningUpdateTime] [datetime] NULL,
	[LosingThreshold] [money] NULL,
	[LosingUpdateTime] [datetime] NULL,
	[InitSettingTime] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplWLMonitored_SMA TO [repl_ap] AS [dbo]
GO
