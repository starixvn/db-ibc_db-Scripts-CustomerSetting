/*<info serverAlias="DBCUST-GlobCustDB,DBAGE-bodb02,DBACC-bodb02,DBSIG-CustDB,DBTXN-CustDB, DBTP-bodb02"></info>*/
/*
	Created: Elodie
	Date: 20240716
	Task: Add FQDN Column in CustDBSiteConfig [RedmineID:#206738]
	DB: DBCust/GlobCustDB
*/
USE GlobCustDB
GO

ALTER TABLE CustDBSiteConfig ADD FQDN VARCHAR(50) NULL