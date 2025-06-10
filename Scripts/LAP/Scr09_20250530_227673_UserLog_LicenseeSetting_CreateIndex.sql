/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/

/*
    Created: 20250530@Tacy
    Task: Userlog_LicenseeSetting - Create index [RedmineID: #227673]
    DB: DBLOG-bodb_CustomerLog
*/
USE bodb_CustomerLog
GO


CREATE NONCLUSTERED INDEX [IX_Userlog_LicenseeSetting_LicenseeID] ON [dbo].[Userlog_LicenseeSetting]
(
	[LicenseeID]	ASC,
	[logdate]		ASC,
	[ActionId]		ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
GO


