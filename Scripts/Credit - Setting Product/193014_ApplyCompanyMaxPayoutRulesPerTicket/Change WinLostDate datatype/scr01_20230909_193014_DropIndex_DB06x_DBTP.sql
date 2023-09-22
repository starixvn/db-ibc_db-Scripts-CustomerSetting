/*<info serverAlias="DB06x-bodb02,DBTP-bodb02"></info>*/
/*
	Created: Luke@20230919
	Task: Change datatype column WinLostDate(WinLimit_CustGameMonitoring_History) to DATETIME [Redmine: #193014]   
	DB: DB06x/bodb02,DBTP/bodb02
*/
USE bodb02
GO

DROP INDEX [CIX_CustID_ProductID_BetTypeID_WinlostDate] ON [dbo].[WinLimit_CustGameMonitoring_History]  WITH ( ONLINE = ON )
GO

DROP INDEX [IX_WinlostDate_LogID] ON [dbo].[WinLimit_CustGameMonitoring_History]
GO
