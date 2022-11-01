/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20221101
    Task: Alter index [Customer].[IX_agent] include more columns [username],[site] [#175813]
    DB: DBCUST/CustDB
*/ 
USE custDB
GO
CREATE NONCLUSTERED INDEX [IX_agent] ON [dbo].[Customer]
(
  [recommend] ASC,
  [roleid] ASC
)
INCLUDE([username],[site]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON
, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [table_customer]