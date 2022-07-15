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
	SiteID INT,
	Site NVARCHAR(50),
	SiteDBGroupID SMALLINT,
	LinkedServerName  VARCHAR(512),
	ClientAccessName VARCHAR(512),
	AGIP VARCHAR (50),
	PRIMARY KEY (SiteID)
	)

CREATE NONCLUSTERED INDEX IX_SiteDBConfig_Site ON SiteDBConfig(Site)