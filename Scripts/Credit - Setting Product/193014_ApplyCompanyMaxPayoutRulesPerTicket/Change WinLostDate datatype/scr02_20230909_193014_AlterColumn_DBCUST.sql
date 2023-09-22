/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke@20230919
	Task: Change datatype column WinLostDate(WinLimit_CustGameMonitoring_History) to DATETIME [Redmine: #193014]   
	DB: DBCUST/CustDB
*/
USE CustDB 
GO 

DROP INDEX [CIX_CustID_ProductID_BetTypeID_WinlostDate] ON [dbo].[WinLimit_CustGameMonitoring_History]  WITH ( ONLINE = ON )
GO

DROP INDEX [IX_WinlostDate_LogID] ON [dbo].[WinLimit_CustGameMonitoring_History]
GO

ALTER TABLE dbo.WinLimit_CustGameMonitoring_History ALTER COLUMN WinLostDate DATETIME NOT NULL
GO

CREATE CLUSTERED INDEX [CIX_CustID_ProductID_BetTypeID_WinlostDate] ON [dbo].[WinLimit_CustGameMonitoring_History]
(
	[CustID] ASC,
	[ProductID] ASC,
	[GroupID] ASC,
	[WinlostDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [WinlimitSetting_Tables]
GO

CREATE NONCLUSTERED INDEX [IX_WinlostDate_LogID] ON [dbo].[WinLimit_CustGameMonitoring_History]
(
	[WinlostDate] ASC,
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [WinlimitSetting_Tables]
GO

