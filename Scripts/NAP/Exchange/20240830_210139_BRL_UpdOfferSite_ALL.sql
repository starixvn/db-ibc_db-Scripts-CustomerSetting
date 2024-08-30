/*<info serverAlias="DBCUST-CUSTDB"></info>*/

/*
	Created: 20240830@Tacy
	Task : "BRL" - Update OfferSite for ALL [RedmineID: #210139]
	DB: DBCUST-CUSTDB
*/
USE CustDB
GO

UPDATE exchange WITH (ROWLOCK, UPDLOCK)
SET OfferSite=0
	,RepUpdateTime=SYSDATETIME()
WHERE currency='BRL'
GO