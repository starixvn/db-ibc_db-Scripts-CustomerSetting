/*<info serverAlias="DBAGE-bodb02,DBBOF-bodb02,DBTXN-CustDB"></info>*/
/*
	Created by: Tacy@20230803
	Task: Create new Database Structure and add in house replication [Redmine:#189389] 
	DB:	DBAGE-bodb02,DBBOF-bodb02,DBTXN-CustDB
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SportBettypeSettingMatrix](
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
	[ProductId] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_SportBettypeSettingMatrix] PRIMARY KEY CLUSTERED 
(
	[BetType] ASC,
	[SportType] ASC,
	[isLicensee] ASC,
	[isLive] ASC,
	[Site] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isActive]  DEFAULT ((0)) FOR [isActive]
GO

ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isLivePT]  DEFAULT ((0)) FOR [isLivePT]
GO

ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_IsLiveComm]  DEFAULT ((0)) FOR [IsLiveComm]
GO

ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_IsLiveBetSetting]  DEFAULT ((0)) FOR [IsLiveBetSetting]
GO

ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[SportBettypeSettingMatrix] ADD  CONSTRAINT [DF_SportBettypeSettingMatrix_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_RepUpdateTime] ON [dbo].[SportBettypeSettingMatrix]
(
	[RepUpdateTime] ASC
)