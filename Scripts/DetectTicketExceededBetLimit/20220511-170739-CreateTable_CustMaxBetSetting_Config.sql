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

CREATE TABLE [dbo].[CustMaxBetSetting_Config](
	[ConfigName] [varchar](100) NOT NULL,
	[ConfigValue] [varchar](100) NOT NULL,
 CONSTRAINT [PK_CustMaxBetSetting_Config] PRIMARY KEY CLUSTERED 
(
	[ConfigName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO