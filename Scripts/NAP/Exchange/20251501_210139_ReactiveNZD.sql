/*<info serverAlias="DBCUST-CUSTDB"></info>*/

/*
	Created: 20250115@Elodie
	Task : Reactive NZD for Licensee [RedmineID: #210139]
	DB: DBCUST-CUSTDB
*/
USE CustDB
GO

UPDATE exchange WITH (ROWLOCK, UPDLOCK)
SET OfferSite=2, IsActive = 1, actualrate = 2.5249,
	RepUpdateTime=SYSDATETIME()
WHERE currency='NZD'
GO