/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20220715
	Task: Create table SiteDBConfig [RedmineID:#158293]
	DB: DBCust/CustDB
*/
USE CustDB
GO
CREATE TABLE SiteDBConfig (
	SiteDBGroupID SMALLINT,
	LinkedServerName  VARCHAR(512),
	ClientAccessName VARCHAR(512),
	AGIP VARCHAR (50),
	PRIMARY KEY (SiteDBGroupID)
	)

ALTER TABLE Site ADD SiteDBGroupID SMALLINT NOT NULL CONSTRAINT DF_Site_SiteDBGroupID DEFAULT (0)

ALTER TABLE Dep_CustSuper ADD SiteDBGroupID SMALLINT NOT NULL CONSTRAINT DF_Dep_CustSuper_SiteDBGroupID DEFAULT (0)

ALTER TABLE CustSuper ADD SiteDBGroupID SMALLINT NOT NULL CONSTRAINT DF_CustSuper_SiteDBGroupID DEFAULT (0)