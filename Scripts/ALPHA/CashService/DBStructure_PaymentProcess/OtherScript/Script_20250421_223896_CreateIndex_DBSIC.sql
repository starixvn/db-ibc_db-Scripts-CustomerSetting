/*<info serverAlias="DBSIC-bodb02"></info>*/
/*
	Created: 20250421@Eden
	Task: Create Index [#RedmineID:#223896]
	DB: DBSIC-bodb02
*/
USE bodb02
GO
--DROP INDEX IX_TypeID_Status ON [dbo].[CashTransaction];
--DROP INDEX IX_TypeID_Status ON [dbo].[IX_CreatedTime];
CREATE NONCLUSTERED INDEX IX_TypeID_Status ON [dbo].CashTransaction (CustId,TransactionTypeId,StatusId) ON [DATA];
CREATE NONCLUSTERED INDEX IX_CreatedTime ON [dbo].CashTransaction (CreatedTime) ON [DATA];
GO