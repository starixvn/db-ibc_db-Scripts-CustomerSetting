/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20240702@Johnson
	Task: Add new type tables [redmine: #202025]
	DB: DBACC-bodb02,DBTP-bodb02
*/ 
-----------------------------------------------------------
--TVP_ReplDep_CustBAActive
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustBAActive' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustBAActive;
END

CREATE TYPE [dbo].TVP_ReplDep_CustBAActive AS TABLE (

	[CustId] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustBAActive TO [repl_ap] AS [dbo]
GO

-----------------------------------------------------------
--TVP_ReplDep_CustBetLimit_Special
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustBetLimit_Special' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustBetLimit_Special;
END

CREATE TYPE [dbo].TVP_ReplDep_CustBetLimit_Special AS TABLE (
	[Site] [varchar](10) NOT NULL,
	[CurrencyID] [int] NOT NULL,
	[SportType] [int] NOT NULL,
	[AgentID] [int] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerBall] [money] NULL,
	[Bettype] [int] NOT NULL,
	[Keyid] [int] NOT NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[MinBet] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustBetLimit_Special TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustBetSetting_Agent
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustBetSetting_Agent' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustBetSetting_Agent;
END

CREATE TYPE [dbo].TVP_ReplDep_CustBetSetting_Agent AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustBetSetting_Agent TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustBetSetting_Member
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustBetSetting_Member' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustBetSetting_Member;
END

CREATE TYPE [dbo].TVP_ReplDep_CustBetSetting_Member AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money],
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustBetSetting_Member TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustBetSettingGame_Agent
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustBetSettingGame_Agent' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustBetSettingGame_Agent;
END

CREATE TYPE [dbo].TVP_ReplDep_CustBetSettingGame_Agent AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustBetSettingGame_Agent TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustBetSettingGame_Member
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustBetSettingGame_Member' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustBetSettingGame_Member;
END

CREATE TYPE [dbo].TVP_ReplDep_CustBetSettingGame_Member AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustBetSettingGame_Member TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustDiscountSetting_Agent
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustDiscountSetting_Agent' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustDiscountSetting_Agent;
END

CREATE TYPE [dbo].TVP_ReplDep_CustDiscountSetting_Agent AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Discount] [decimal](9, 8) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustDiscountSetting_Agent TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustDiscountSetting_Member
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustDiscountSetting_Member' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustDiscountSetting_Member;
END

CREATE TYPE [dbo].TVP_ReplDep_CustDiscountSetting_Member AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[PlayerDiscount] [decimal](9, 8) NULL,
	[AgentDiscount] [decimal](9, 8) NULL,
	[MasterDiscount] [decimal](9, 8) NULL,
	[SuperDiscount] [decimal](9, 8) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustDiscountSetting_Member TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_Customer_Archived
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_Customer_Archived' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_Customer_Archived;
END

CREATE TYPE [dbo].TVP_ReplDep_Customer_Archived AS TABLE (
	[CustID] [int] NOT NULL,
	[ArchivedDate] [datetime] NULL,
	[Username] [varchar](50) NULL,
	[Username2] [varchar](50) NULL,
	[Recommend] [int] NULL,
	[ClosingBalance] [money] NULL,
	[CustIDBalanceDummy] [int] NULL,
	[Status] [varchar](50) NULL,
	[RepUpdateTime] [datetime2](7),
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_Customer_Archived TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustomerClass
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustomerClass' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustomerClass;
END

CREATE TYPE [dbo].TVP_ReplDep_CustomerClass AS TABLE (
	[CustID] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
	[CategoryID] [smallint] NULL,
	[ModifiedDate] [datetime] NULL,
	[OldCustomerClass] [smallint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustomerClass TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustProductSetting
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustProductSetting' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustProductSetting;
END

CREATE TYPE [dbo].TVP_ReplDep_CustProductSetting AS TABLE (
	[CustID] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[IsEnabled] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustProductSetting TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustProductStatus
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustProductStatus' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustProductStatus;
END

CREATE TYPE [dbo].TVP_ReplDep_CustProductStatus AS TABLE (
	[CustID] [int] NOT NULL,
	[bitmapIsHidden] [binary](32) NOT NULL,
	[bitmapIsDisabled] [binary](32) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustProductStatus TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustPTGroupSetting_Member
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustPTGroupSetting_Member' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustPTGroupSetting_Member;
END

CREATE TYPE [dbo].TVP_ReplDep_CustPTGroupSetting_Member AS TABLE (
	[AgentID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SuperPT] [smallmoney] NULL,
	[MasterPT] [smallmoney] NULL,
	[AgentPT] [smallmoney] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustPTGroupSetting_Member TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustPTSetting_Agent
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustPTSetting_Agent' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustPTSetting_Agent;
END

CREATE TYPE [dbo].TVP_ReplDep_CustPTSetting_Agent AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SuperPT] [smallmoney] NULL,
	[MasterPT] [smallmoney] NULL,
	[AgentPT] [smallmoney] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustPTSetting_Agent TO [repl_ap] AS [dbo]
GO

-----------------------------------------------------------
--TVP_ReplDep_CustPTSetting_Member
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustPTSetting_Member' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustPTSetting_Member;
END

CREATE TYPE [dbo].TVP_ReplDep_CustPTSetting_Member AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SuperPT] [smallmoney] NULL,
	[MasterPT] [smallmoney] NULL,
	[AgentPT] [smallmoney] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustPTSetting_Member TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustSetting_AGCasino
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustSetting_AGCasino' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustSetting_AGCasino;
END

CREATE TYPE [dbo].TVP_ReplDep_CustSetting_AGCasino AS TABLE (
	[CustID] [int] NOT NULL,
	[AGGroup] [varchar](20) NULL,
	[IsEnabled] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustSetting_AGCasino TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustSettingGame
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustSettingGame' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustSettingGame;
END

CREATE TYPE [dbo].TVP_ReplDep_CustSettingGame AS TABLE (
	[CustID] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[apositiontaking] [smallmoney] NOT NULL,
	[mpositiontaking] [smallmoney] NOT NULL,
	[spositiontaking] [smallmoney] NOT NULL,
	[playerdiscount] [decimal](9, 8) NOT NULL,
	[discount] [decimal](9, 8) NOT NULL,
	[adiscount] [decimal](9, 8) NOT NULL,
	[sdiscount] [decimal](9, 8) NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustSettingGame TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustSettingMode
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustSettingMode' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustSettingMode;
END

CREATE TYPE [dbo].TVP_ReplDep_CustSettingMode AS TABLE (
	[CustID] [int] NOT NULL,
	[IsGroupedPT] [bit] NOT NULL,
	[IsGroupedComm] [bit] NOT NULL,
	[IsGroupedBetLimit] [bit] NOT NULL,
	[IsGroupedStakeLevel] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustSettingMode TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustSpecialLevel
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustSpecialLevel' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustSpecialLevel;
END

CREATE TYPE [dbo].TVP_ReplDep_CustSpecialLevel AS TABLE (
	[custid] [int] NOT NULL,
	[SpecialLevel] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustSpecialLevel TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustStakeLevel_Agent
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustStakeLevel_Agent' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustStakeLevel_Agent;
END

CREATE TYPE [dbo].TVP_ReplDep_CustStakeLevel_Agent AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[StakeLevelList] [varchar](200) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustStakeLevel_Agent TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustStakeLevel_Member
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustStakeLevel_Member' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustStakeLevel_Member;
END

CREATE TYPE [dbo].TVP_ReplDep_CustStakeLevel_Member AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[StakeLevelList] [varchar](200) NULL,
	[LastUpdated] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustStakeLevel_Member TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_CustSuper
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustSuper' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_CustSuper;
END

CREATE TYPE [dbo].TVP_ReplDep_CustSuper AS TABLE (
	[custid] [int] NOT NULL,
	[currency] [int] NULL,
	[username] [nvarchar](50) NULL,
	[site] [varchar](20) NULL,
	[CurrencyModifier] [smallmoney] NOT NULL,
	[SiteDBGroupID] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_CustSuper TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_DefaultOddGroup
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_DefaultOddGroup' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_DefaultOddGroup;
END

CREATE TYPE [dbo].TVP_ReplDep_DefaultOddGroup AS TABLE (
	[AgentID] [int] NOT NULL,
	[Ugroup] [varchar](3) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_DefaultOddGroup TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_LicenseeProductSetting
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_LicenseeProductSetting' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_LicenseeProductSetting;
END

CREATE TYPE [dbo].TVP_ReplDep_LicenseeProductSetting AS TABLE (
	[CustID] [int] NOT NULL,
	[ProductSettingID] [int] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_LicenseeProductSetting TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_ProductBetSetting
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_ProductBetSetting' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_ProductBetSetting;
END

CREATE TYPE [dbo].TVP_ReplDep_ProductBetSetting AS TABLE (
	[Sporttype] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[DefaultMinBet] [money] NULL,
	[DefaultMaxBet] [money] NULL,
	[DefaultMaxPerMatch] [money] NULL,
	[MaxPerBall] [decimal](19, 8) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_ProductBetSetting TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_ProductStatusProfile
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_ProductStatusProfile' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_ProductStatusProfile;
END

CREATE TYPE [dbo].TVP_ReplDep_ProductStatusProfile AS TABLE (
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[bitmapOrder] [tinyint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_ProductStatusProfile TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_StakeLevel
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_StakeLevel' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_StakeLevel;
END

CREATE TYPE [dbo].TVP_ReplDep_StakeLevel AS TABLE (
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[GameGroupID] [smallint] NOT NULL,
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ExchangeID] [int] NULL,
	[ResourceId] [varchar](20) NULL,
	[SiteID] [int] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_StakeLevel TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_StakeLevelGroupDetail
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_StakeLevelGroupDetail' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_StakeLevelGroupDetail;
END

CREATE TYPE [dbo].TVP_ReplDep_StakeLevelGroupDetail AS TABLE (
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [smallint] NOT NULL,
	[MinLabel] [nvarchar](50) NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MinStake] [decimal](19, 8) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[ParentTypeID] [int] NULL,
	[MaxGameStake] [decimal](19, 8) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_StakeLevelGroupDetail TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_SuperSetting_AGCasino
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_SuperSetting_AGCasino' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_SuperSetting_AGCasino;
END

CREATE TYPE [dbo].TVP_ReplDep_SuperSetting_AGCasino AS TABLE (
	[CustID] [int] NOT NULL,
	[CheckedGroup] [varchar](500) NULL,
	[DefaultGroup] [varchar](20) NULL,
	[IsEnabled] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_SuperSetting_AGCasino TO [repl_ap] AS [dbo]
GO
 
-----------------------------------------------------------
--TVP_ReplDep_SupperProductSetting
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_SupperProductSetting' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplDep_SupperProductSetting;
END

CREATE TYPE [dbo].TVP_ReplDep_SupperProductSetting AS TABLE (
	[CustID] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[IsEnabled] [bit] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_SupperProductSetting TO [repl_ap] AS [dbo]
GO
