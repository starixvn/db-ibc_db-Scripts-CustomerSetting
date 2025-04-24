/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250424@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: IRS_DBTP-bodb02
*/

------------------------------------------------------------------------------------
--MaxPayoutGlobalSetting
DROP PROCEDURE IF EXISTS Repl_PutMaxPayoutGlobalSetting_Dist
GO

DROP TYPE [dbo].[TVP_ReplMaxPayoutGlobalSetting]
GO

CREATE TYPE [dbo].[TVP_ReplMaxPayoutGlobalSetting] AS TABLE(
	[SportType] [int] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Currency] [smallint] NOT NULL,
	[SingleMatchParlay] [money] NOT NULL,
	[Combo2] [money] NOT NULL,
	[Combo35] [money] NOT NULL,
	[ComboOver6] [money] NOT NULL,
	[SettingStatus] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplMaxPayoutGlobalSetting] TO [repl_ap] AS [dbo]
GO

------------------------------------------------------------------------------------
--ProductBetSetting
DROP PROCEDURE IF EXISTS Repl_PutProductBetSetting_Dist
GO

DROP TYPE [dbo].[TVP_ReplProductBetSetting]
GO

CREATE TYPE [dbo].[TVP_ReplProductBetSetting] AS TABLE(
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[IsDep] [bit] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[DefaultMinBet] [money] NULL,
	[DefaultMaxBet] [money] NULL,
	[DefaultMaxPerMatch] [money] NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductBetSetting] TO [repl_ap] AS [dbo]
GO

------------------------------------------------------------------------------------
--LimitPTDailySetting
DROP PROCEDURE IF EXISTS Repl_PutLimitPTDailySetting_Dist
GO

DROP TYPE [dbo].[TVP_ReplLimitPTDailySetting]
GO

CREATE TYPE [dbo].[TVP_ReplLimitPTDailySetting] AS TABLE(
	[ProductID] [tinyint] NOT NULL,
	[CustID] [int] NOT NULL,
	[Currency] [smallint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[MaxCount] [tinyint] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[SettingStatus] [tinyint] NOT NULL,
	[LimitNewAccUpdPT] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplLimitPTDailySetting] TO [repl_ap] AS [dbo]
GO
