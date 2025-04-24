/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250428@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: IRS_DBTP-bodb02
*/

DROP INDEX [IX_roleid] ON [dbo].[Customer]
GO


/*
--run this step with others servers
ALTER TABLE Customer ALTER COLUMN Currency SMALLINT WITH(ONLINE = ON)
GO

CREATE NONCLUSTERED INDEX [IX_roleid] ON [dbo].[Customer]
(
	[roleid] ASC
)
INCLUDE([custid],[username],[currency]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Customer_index]
GO
*/