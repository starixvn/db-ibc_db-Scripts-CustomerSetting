/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Tacy@20240306
	Task: Deposit - Clean VS3 old - CWL setting - [redmine: #198008]
	DB: DBTXN-bodb02
*/
DELETE a
FROM WinLimit_ProductOffer a WITH(ROWLOCK) 
WHERE ProductId in (49)
GO