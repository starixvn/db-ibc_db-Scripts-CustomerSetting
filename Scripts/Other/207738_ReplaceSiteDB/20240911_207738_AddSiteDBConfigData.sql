/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie@20240905
	Task: Replace SiteDB server [RedmineID:#207738]
	DB: DBCust/CustDB
*/
USE CustDB
GO
--SIT
IF @@SERVERNAME = 'SITDBCUST'
	UPDATE s
	SET s.ClientAccessName = CASE WHEN s.SiteDBGroupID = 1 THEN 'SITDBSITEC1'
								WHEN s.SiteDBGroupID = 2 THEN 'SITDBSITEC2\INST2'
								WHEN s.SiteDBGroupID = 3 THEN 'SITDBSITEC3\INST3' ELSE s.ClientAccessName END,
		s.AGIP = CASE WHEN s.SiteDBGroupID = 1 THEN '172.16.40.66'
								WHEN s.SiteDBGroupID = 2 THEN '172.16.40.67'
								WHEN s.SiteDBGroupID = 3 THEN '172.16.40.68' ELSE s.AGIP END,
		RepUpdateTime = GETDATE()
	FROM SiteDBConfig s	

--PRO
IF @@SERVERNAME = 'DBCUST'
	UPDATE s
	SET s.ClientAccessName = CASE WHEN s.SiteDBGroupID = 1 THEN 'DBSITEC1'
								WHEN s.SiteDBGroupID = 2 THEN 'DBSITEC2\INST2'
								WHEN s.SiteDBGroupID = 3 THEN 'DBSITEC3\INST3' ELSE s.ClientAccessName END,
		s.AGIP = CASE WHEN s.SiteDBGroupID = 1 THEN '10.40.40.242'
								WHEN s.SiteDBGroupID = 2 THEN '10.40.40.243'
								WHEN s.SiteDBGroupID = 3 THEN '10.40.40.244' ELSE s.AGIP END,
		RepUpdateTime = GETDATE()
	FROM SiteDBConfig s	

SELECT * FROM SiteDBConfig





