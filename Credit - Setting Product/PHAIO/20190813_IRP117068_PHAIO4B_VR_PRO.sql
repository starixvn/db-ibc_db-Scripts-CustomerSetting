/*
	Created: Winnie
	Date: 2019-08-13
	Task: Update [Sport_Bettype_Reference_VirtualRate] for PHAIO 4B
	DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

UPDATE [dbo].[Sport_Bettype_Reference_VirtualRate] WITH(ROWLOCK,UPDLOCK)
	SET [isActive]=1
WHERE [SportType]=1 AND [BetType] IN(470,471,472,482,483,484,485)
         