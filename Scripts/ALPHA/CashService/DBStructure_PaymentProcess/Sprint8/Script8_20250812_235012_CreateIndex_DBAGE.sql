/*<info serverAlias="DBAGE-bodb02"></info>*/
/*
    Created: 20250812@Eden
    Task: Create Index [redmine: #235012]
    DB: DBAGE-bodb02
*/
USE bodb02
GO
CREATE NONCLUSTERED INDEX IX_CustID_Type ON [dbo].CashTransaction (CustId,TransactionTypeId,CreatedTime,StatusId) ON [DATA];
