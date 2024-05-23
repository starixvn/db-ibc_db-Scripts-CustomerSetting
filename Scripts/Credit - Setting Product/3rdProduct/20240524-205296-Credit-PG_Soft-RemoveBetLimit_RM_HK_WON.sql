/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20240524@Tacy
	Task: PG Soft - Credit - Remove RM/HK/Won Company Bet Limit setting [Redmine: #205296]
	Database:	DBCUST.CustDB
*/
/*
CreditGroupCurrency	-	CreditGroupID
MYR(RM);HKD (HKK)	-		1
KRW (Won)			-		8
*/

USE CustDB
GO

UPDATE ProductStakeLevelGroup WITH (ROWLOCK, UPDLOCK)
SET isDeleted=1, RepUpdateTime=SYSDATETIME()
WHERE Sporttype=232 AND CreditGroupID IN (1,8)
GO