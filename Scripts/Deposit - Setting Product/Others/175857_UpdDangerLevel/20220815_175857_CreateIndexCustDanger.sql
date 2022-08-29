/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220815@Tacy
	Task: Create index on CustDangerLevelInfo, CustDangerWinlossInfo tables [redmine:#175857]
	DB: DBCUST.CUSTDB
*/
CREATE NONCLUSTERED INDEX IX_BatchNo ON CustDangerLevelInfo(BatchNo)
GO

CREATE NONCLUSTERED INDEX IX_BatchNo ON CustDangerWinlossInfo(BatchNo)
GO
