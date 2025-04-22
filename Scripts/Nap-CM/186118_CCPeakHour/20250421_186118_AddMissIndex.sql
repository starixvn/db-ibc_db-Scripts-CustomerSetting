/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20250421@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Customer Class - Add index miss for table _UAT [186118]
*/
--===================================================================================

CREATE NONCLUSTERED INDEX [IX_CustomerClassSpread_UAT_Spread] ON [dbo].[CustomerClassSpread_UAT] 
(
	[Spread] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO
