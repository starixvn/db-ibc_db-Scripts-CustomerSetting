/*<info serverAlias="DBCUST-GlobCustDB"></info>*/
/*
	Created: Elodie
	Date: 20240716
	Task: Create table CustDBSiteConfig [RedmineID:#206738]
	DB: DBCust/GlobCustDB
*/
USE CustDB
GO

CREATE TABLE CustDBSiteConfig (
	CustDBGroupID SMALLINT,
	LinkedServerName  VARCHAR(512),
	ClientAccessName VARCHAR(512),
	AGIP VARCHAR (50),
	AWSProxyDomain VARCHAR(50),
	AWSProxyPort INT,
	RepUpdateTime datetime2(7)
	CONSTRAINT PK_CustDBSiteConfig_CustDBGroupID PRIMARY KEY (CustDBGroupID)
	)



