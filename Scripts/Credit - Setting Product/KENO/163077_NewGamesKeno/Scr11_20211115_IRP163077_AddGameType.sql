/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20211111@Johnson
	Task: add global settings for new games keno for real currencies
	DB: DBTXN/bodb02
*/

USE [bodb02]
GO

INSERT INTO [dbo].[GameType]
           ([GameTypeID]
           ,[GameTypeName]
           ,[IsDisabled]
           ,[IBCBetTypeID]
           )
SELECT 30, N'Max Keno 3',0,1530
UNION SELECT 31, N'Max Keno 4',0,1531