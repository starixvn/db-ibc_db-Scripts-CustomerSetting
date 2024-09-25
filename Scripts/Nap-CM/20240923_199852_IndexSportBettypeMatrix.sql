/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240923@Winfred
	DB: DBCUST/CustDB
	Task: [NAP CM] CCMgt - Integrate for Non-Sports [RedmineID: #199852] 
*/
-- New Index
--===================================================================================
--DROP INDEX [dbo].[SportBettypeSettingMatrix].[IX_SportBettypeSettingMatrix_SportType]

CREATE NONCLUSTERED INDEX [IX_SportBettypeSettingMatrix_SportType] ON [dbo].[SportBettypeSettingMatrix]
(
	[SportType] ASC,
	[RealProductId] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

