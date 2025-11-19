/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250924@Virgil
	Task: Add IX_Reftable_UAT for SportBettypeMatrix [Redmine: #235369]
	DB: DBPRO-bodb02
*/
USE [bodb02]
GO

CREATE NONCLUSTERED INDEX [IX_Reftable_Extra] ON [dbo].[SportBettypeMatrix]
(
	[RefTable] ASC
)
INCLUDE([BetType],[ProductID],[IsTest],[EventType],[ExtraInfo]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]

GO
