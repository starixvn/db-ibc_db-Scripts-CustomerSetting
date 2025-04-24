/*<info serverAlias="IRS_DBACC-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250429@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: IRS_DBACC-bodb02
*/


CREATE NONCLUSTERED INDEX [IX_roleid] ON [dbo].[Customer]
(
	[roleid] ASC
)
INCLUDE([custid],[username],[currency]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Customer_index]
GO