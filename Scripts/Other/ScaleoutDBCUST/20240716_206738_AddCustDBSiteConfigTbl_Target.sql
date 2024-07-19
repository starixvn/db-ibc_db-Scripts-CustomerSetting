/*<info serverAlias="DBAGE-bodb02,DBACC-bodb02,DBSIG-CustDB,DBTXN-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20240716
	Task: Create table CustDBSiteConfig [RedmineID:#158293]
	DB: DBAGE-bodb02,DBACC-bodb02,DBSIG-CustDB,DBTXN-CustDB
*/

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
GO
ALTER TABLE [dbo].[CustDBSiteConfig] ADD  CONSTRAINT [DF_CustDBSiteConfig_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO




