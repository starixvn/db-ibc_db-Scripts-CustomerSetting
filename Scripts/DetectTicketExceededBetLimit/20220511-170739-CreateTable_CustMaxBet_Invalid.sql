/*<info serverAlias="DBTP-bodb02"></info>*/

/*
	Created: 20220511@Tacy
	Task: https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBTP/bodb02
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustMaxBet_Invalid](
	[TransID] [bigint],
	[CustID] [int],
	[SportType] [smallint],
	[BetType] [int],
	[MaxBet] [money],
	[Currency] [tinyint],
	[Stake] [money],
	[Remark] [varchar](100),
	[IsSendLetstalkTest] [bit],
	[IsSendEmailTest] [bit],
	[IsSendLetstalk] [bit],
	[IsSendEmail] [bit]
 CONSTRAINT [PK_CustMaxBet_Invalid] PRIMARY KEY CLUSTERED 
(
	[TransID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [BetRestriction]
) ON [BetRestriction]
GO