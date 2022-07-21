/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20220715
	Task: Create table SiteDBConfig [RedmineID:#158293]
	DB: DBCust/CustDB
*/
USE CustDB
GO
TRUNCATE TABLE SiteDBConfig

GO
INSERT INTO SiteDBConfig ([SiteID], [Site], [SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
SELECT SiteId, Site, 1, 'DBSite1', 'DBGRP01L', '10.18.200.58\testsitedb'
FROM Site WITH (NOLOCK)
WHERE site IN ('12Bet','Athena000')

INSERT INTO SiteDBConfig ([SiteID], [Site], [SiteDBGroupID], [LinkedServerName], [ClientAccessName], [AGIP])
SELECT 0 AS SiteId, 'OtherSites', 0, 'DBTXN', 'DBTRANS', '10.18.200.55'



