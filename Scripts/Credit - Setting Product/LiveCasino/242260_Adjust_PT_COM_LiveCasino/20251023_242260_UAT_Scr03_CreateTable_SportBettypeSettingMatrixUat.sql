/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*      
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBGLOB-GlobCustDB
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE [GlobCustDB]
GO	

--DROP TABLE SportBettypeSettingMatrix_UAT;


IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.SportBettypeSettingMatrix_UAT') AND type in (N'U'))
BEGIN
	SELECT 'Table dbo.SportBettypeSettingMatrix_UAT already exists. No action taken.'
END
ELSE
BEGIN

	CREATE TABLE [dbo].[SportBettypeSettingMatrix_UAT](
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
		[SporttypeRefWinlossLimit] [smallint] NULL,
		[BettypeRefWinlossLimit] [smallint] NULL,
		[RealProductId] [tinyint] NULL,
		[isDeleted] [bit] NULL,
		[RepUpdateTime] [datetime2](7) NULL,
		[ProductID] [tinyint] NULL,
	CONSTRAINT [PK_SportBettypeSettingMatrix_UAT] PRIMARY KEY CLUSTERED 
	(
		[BetType] ASC,
		[SportType] ASC,
		[isLicensee] ASC,
		[isLive] ASC,
		[Site] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
	
	ALTER TABLE [dbo].[SportBettypeSettingMatrix_UAT] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isActive_UAT]  DEFAULT ((0)) FOR [isActive]
	
	ALTER TABLE [dbo].[SportBettypeSettingMatrix_UAT] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isLivePT_UAT]  DEFAULT ((0)) FOR [isLivePT]
	
	ALTER TABLE [dbo].[SportBettypeSettingMatrix_UAT] ADD  CONSTRAINT [SportBettypeSettingMatrix_IsLiveComm_UAT]  DEFAULT ((0)) FOR [IsLiveComm]
	
	ALTER TABLE [dbo].[SportBettypeSettingMatrix_UAT] ADD  CONSTRAINT [SportBettypeSettingMatrix_IsLiveBetSetting_UAT]  DEFAULT ((0)) FOR [IsLiveBetSetting]
	
	ALTER TABLE [dbo].[SportBettypeSettingMatrix_UAT] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isDeleted_UAT]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[SportBettypeSettingMatrix_UAT] ADD  CONSTRAINT [SportBettypeSettingMatrix_RepUpdateTime_UAT]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_RepUpdateTime_UAT] ON [dbo].[SportBettypeSettingMatrix_UAT]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	
	CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_SportType_UAT] ON [dbo].[SportBettypeSettingMatrix_UAT]
	(
		[SportType] ASC,
		[RealProductId] ASC,
		[ProductID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	
	--SELECT 'Table dbo.SportBettypeSettingMatrix_UAT has been created.'
END