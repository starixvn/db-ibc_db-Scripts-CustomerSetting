/*<info serverAlias="DBTXN-bodb02"></info>*/
ALTER TRIGGER [dbo].[BalancePendingCreditGame_delete] 
	ON [dbo].[BalancePendingCreditGame]
	AFTER DELETE
AS
/*
	Creator: 20241210@Tacy
	Task: Alter trigger - Migrate data from table BalancePendingCreditGame to table history
	Database: DBTXN-bodb02

	Revisions:  
		- 20241210@Tacy: Create trigger [redmine:#214868]  
*/
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.BalancePendingCreditGame_History (
		  rn
		, custid
		, winlostdate
		, Balance
		, bettype
		, GameTypeID
		, RefID
		, UpdateTime
        )
    SELECT rn
		, custid
		, winlostdate
		, Balance
		, bettype
		, GameTypeID
		, RefID
		, UpdateTime
    FROM [DELETED]
END
GO

IF @@SERVERNAME IN ('DBTrans','SITDBTRANS','TESTDBTRANS','DB-60\DevDBTrans')
BEGIN
	ALTER TABLE [dbo].[BalancePendingCreditGame] DISABLE TRIGGER [BalancePendingCreditGame_delete]
END
GO