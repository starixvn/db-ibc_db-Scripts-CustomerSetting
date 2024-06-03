/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20240528@Tacy
	Task: CWL - Update setting [Redmine: #205073]
	Database:	DBCUST.CustDB
*/
USE CustDB
GO

UPDATE Winlimit_ProductGlobalSetting WITH (ROWLOCK, UPDLOCK)
SET blockedTransferLvl3=0
WHERE ProductID=40 AND IsDeposit=0 AND Currency<>0
GO