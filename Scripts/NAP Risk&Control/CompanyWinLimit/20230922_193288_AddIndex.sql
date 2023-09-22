/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke@20230922
	Task: Add index IX_ModifiedDate_ActionID on (WinLimit_CustGameMonitoring_History) [Redmine: #193288]   
	DB: DBCUST/CustDB
*/

CREATE NONCLUSTERED INDEX [IX_ModifiedDate_ActionID] ON [dbo].[WinLimit_CustGameMonitoring_History]
(
	[ModifiedDate] ASC,
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [WinlimitSetting_Tables]
GO


