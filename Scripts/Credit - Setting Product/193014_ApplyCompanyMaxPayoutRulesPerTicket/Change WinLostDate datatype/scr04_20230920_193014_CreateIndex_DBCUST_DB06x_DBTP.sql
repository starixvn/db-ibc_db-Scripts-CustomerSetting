/*<info serverAlias="DBCUST-CustDB,DB06x-bodb02,DBTP-bodb02"></info>*/
/*
	Created: Luke@20230919
	Task: Add index IX_ModifiedDate ON Winlimit_CustGameMonitoring_History [Redmine: #193014]   
	DB: DBCUST/CustDB, DB06x/bodb02, DBTP/bodb02
*/

CREATE NONCLUSTERED INDEX [IX_ModifiedDate] ON [dbo].[WinLimit_CustGameMonitoring_History]
(
	[ModifiedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [WinlimitSetting_Tables]
GO

