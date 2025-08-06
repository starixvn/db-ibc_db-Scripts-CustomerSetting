/*<info serverAlias="DBGLOB-GlobCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250610@Dave	
	Task: In-House
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250610@Dave: Apply Inhouse replication for remain tables [RedmineID: #229159]
	
	Tables:
		 1. SportBettypeSettingMatrix
		 2. Dep_ProductStakeLevelGroup
		 3. DomainManagement
		 4. ProductStakeLevelGroup	
*/

/*SportBettypeSettingMatrix*/
IF TYPE_ID(N'dbo.TVP_ReplSportBettypeSettingMatrix') IS NULL
BEGIN
    CREATE TYPE [dbo].[TVP_ReplSportBettypeSettingMatrix] AS TABLE(
        [SportType] [smallint] NOT NULL,
        [BetType] [int] NOT NULL,
        [isLicensee] [bit] NOT NULL,
        [isLive] [bit] NOT NULL,
        [Site] [varchar](50) NOT NULL,
        [isActive] [bit] NOT NULL,
        [SportTypeRefPT] [smallint] NULL,
        [BetTypeRefPT] [int] NULL,
        [isLivePT] [bit] NOT NULL,
        [TablePT] [varchar](50) NULL,
        [SportTypeRefComm] [smallint] NULL,
        [BetTypeRefComm] [int] NULL,
        [TableComm] [varchar](50) NULL,
        [SportTypeRefBetSetting] [smallint] NULL,
        [BetTypeRefBetSetting] [int] NULL,
        [TableBetSetting] [varchar](50) NULL,
        [IsLiveComm] [bit] NOT NULL,
        [IsLiveBetSetting] [bit] NOT NULL,
        [TableBettrans] [varchar](100) NULL,
        [RealProductId] [tinyint] NULL,
        [SporttypeRefWinlossLimit] [smallint] NULL,
        [BettypeRefWinlossLimit] [smallint] NULL,
        [ProductID] [tinyint] NULL,
        [isDeleted] [bit] NULL,
        [RepUpdateTime] [datetime2](7) NULL,
        [_FetchedTime] [datetime2](7) NULL
    )
END
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplSportBettypeSettingMatrix] TO [repl_ap] AS [dbo]
GO

/*Dep_ProductStakeLevelGroup*/
IF TYPE_ID(N'dbo.TVP_ReplDep_ProductStakeLevelGroup') IS NULL
BEGIN
    CREATE TYPE [dbo].[TVP_ReplDep_ProductStakeLevelGroup] AS TABLE (
        [Sporttype] [smallint] NOT NULL,
        [GameGroupID] [tinyint] NOT NULL,
        [MinBet] [money] NOT NULL,
        [MaxBet] [money] NOT NULL,
        [LicenseeGroupID] [tinyint] NOT NULL,
        [SiteID] [int] NOT NULL,
        [Remark] [varchar](1000) NULL,
        [RepUpdateTime] [datetime2](7) NOT NULL,
        [isDeleted] [bit] NOT NULL,
        [_FetchedTime] [datetime2](7) NULL
    )
    GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplDep_ProductStakeLevelGroup] TO [repl_ap] AS [dbo]
END
GO

/*ProductStakeLevelGroup*/
IF TYPE_ID(N'dbo.TVP_ReplProductStakeLevelGroup') IS NULL
BEGIN
    CREATE TYPE [dbo].[TVP_ReplProductStakeLevelGroup] AS TABLE (
        [Sporttype] [smallint] NOT NULL,
        [GameGroupID] [tinyint] NOT NULL,
        [MinBet] [money] NOT NULL,
        [MaxBet] [money] NOT NULL,
        [CreditGroupID] [tinyint] NOT NULL,
        [Remark] [varchar](1000) NULL,
        [RepUpdateTime] [datetime2](7) NOT NULL,
        [isDeleted] [bit] NOT NULL,
        [_FetchedTime] [datetime2](7) NULL
    )
    GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductStakeLevelGroup] TO [repl_ap] AS [dbo]
END
GO

/*DomainManagement*/
IF TYPE_ID(N'dbo.TVP_ReplDomainManagement') IS NULL
BEGIN

	CREATE TYPE [dbo].[TVP_ReplDomainManagement] AS TABLE (
		[DomainID] [SMALLINT] NOT NULL
		,[Domain] [VARCHAR](50) NOT NULL
		,[System] [VARCHAR](20) NOT NULL
		,[Site] [VARCHAR](500) NOT NULL
		,[BrandName] [VARCHAR](10) NULL
		,[Status] [TINYINT] NOT NULL
		,[ExpiredDate] [DATETIME] NULL
		,[LastUpdateTime] [DATETIME] NOT NULL
		,[RestrictedCountries] [VARCHAR](4000) NULL
		,[Remark] [NVARCHAR](2000) NULL
		,[OfferType] [TINYINT] NULL
		,[isDeleted] [BIT]
		,[RepUpdateTime] [DATETIME2](7) NOT NULL
		,[_FetchedTime] [DATETIME2](7)
	)

END
GO

--Grant permission to set IDENTITY_INSERT on/off
GRANT ALTER ON [dbo].[DomainManagement] TO [repl_ap];
GO
