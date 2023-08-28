/*<info serverAlias="DB06x-bodb02,DBTP-bodb02"></info>*/
/*
	Created: Luke@20230919
	Task: Change datatype column WinLostDate(WinLimit_CustGameMonitoring_History) to DATETIME [Redmine: #193014]   
	DB: DB06x/bodb02,DBTP/bodb02
*/
USE bodb02
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

