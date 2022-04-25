/*<info serverAlias="DBARCCUST-Bodb_Archive_Customer_Licensee"></info>*/
/*
	Created by: Eden@20220301
	Task: Create New tables For SB - Deposit DCS & Number Games DCS [Redmine:#167898]		
	DB: DBARCCUST-Bodb_Archive_Customer_Licensee
*/
USE Bodb_Archive_Customer_Licensee 
GO
DROP TABLE [Dep_CustBetSettingGame_Member]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Dep_CustBetSettingGame_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL
) ON Dep_CustBetSetting_Table

GO
ALTER TABLE [Dep_CustBetSettingGame_Member] ADD CONSTRAINT PK_Dep_CustBetSettingGame_Member PRIMARY KEY ([CustID],[SportType],[BetType])
GO