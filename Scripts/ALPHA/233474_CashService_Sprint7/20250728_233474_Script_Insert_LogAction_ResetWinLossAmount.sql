/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250728@Dave
	Task: Create log action for Reset Amount Winloss [RedmineID:#233474]
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO 


DELETE
FROM LogAction WITH(ROWLOCK,UPDLOCK)
WHERE ActionID IN (265001,265002);


INSERT INTO LogAction (ActionID, ActionTypeID, SPName, IsInternal ,ActionNameEN)
VALUES (265001, NULL, N'Age_BalanceGameReset_CashMember', 0, N'Reset Member Win Amount'),
(265002, NULL, N'Acc_CustWinLimitBetReset_CashMember', 0, N'Reset Member Win Amount');


SELECT * 
FROM LogAction WITH(NOLOCK) 
WHERE ActionID IN (265001,265002);

