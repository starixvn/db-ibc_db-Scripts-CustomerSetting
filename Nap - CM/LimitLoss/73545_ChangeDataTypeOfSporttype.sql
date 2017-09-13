/*
	Created: Winnie
	Date: 2017-09-13
	Task: Change datatype of column [SportType] FROM TINYINT TO SMALLINT RedmineID:#73545
	DB: DBACC/[bodb_ACC]
*/ 

USE [bodb_ACC]
GO
ALTER TABLE [dbo].[BetMonitoring_CustTotalBet] DROP CONSTRAINT [PK_BetMonitoring_CustTotalBet]
GO

ALTER TABLE BetMonitoring_CustTotalBet
ALTER COLUMN SportType SMALLINT NOT NULL; 
GO

ALTER TABLE [dbo].[BetMonitoring_CustTotalBet] ADD  CONSTRAINT [PK_BetMonitoring_CustTotalBet] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [accData]
GO


