/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240215@Winfred
	DB: DBCUST/CustDB
	Task: 20240215@Winfred: [NAP CM] Customer Class - SP Integrate Spread setting [RedmineID: #200996
*/
-- New Index
--===================================================================================


--CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadClass] ON [dbo].[CustomerClassSpreadClass] 
--(
--	[CustomerClass] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
--GO

--CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadClass_UAT] ON [dbo].[CustomerClassSpreadClass_UAT] 
--(
--	[CustomerClass] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
--GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadDetail] ON [dbo].[CustomerClassSpreadDetail] 
(
	[SiteID] ,
	[Currency] ,
	[Platform] 
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadDetail_UAT] ON [dbo].[CustomerClassSpreadDetail_UAT] 
(
	[SiteID] ,
	[Currency] ,
	[Platform] 
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO