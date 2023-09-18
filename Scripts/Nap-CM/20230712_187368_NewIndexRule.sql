/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20230712@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM]  Customer Class - Enhance for CC [187368]
*/
-- New Index
--===================================================================================
CREATE NONCLUSTERED INDEX [IX_CustomerClassRule_SportType] ON [dbo].[CustomerClassRule]
(
	[SportType] ASC,
	[CustomerClass] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

