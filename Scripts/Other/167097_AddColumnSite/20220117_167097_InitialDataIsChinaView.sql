/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220107
	Task:  initial data column IsChinaView into Site table RedmineID:#167097
	DB: DBCust/CustDB 
*/

USE CustDB
GO

CREATE TABLE #Site (site NVARCHAR(50))

INSERT INTO #Site(site)
SELECT DISTINCT ds.site	
FROM dbo.custInfo c WITH(NOLOCK) 	
INNER JOIN Dep_CustSuper ds with (nolock) on ds.custid = c.CustID	
WHERE	c.username NOT LIKE '3rdSuper%'			
		AND c.Enabled=1
		AND c.currency in (124,125,20) --RMB2,INH2,UUS
		AND ds.site like '%CV'
ORDER BY ds.site

-- insert data Test
INSERT INTO #Site(site) VALUES ('golden88')

UPDATE s
SET s.IsChinaView = 0
FROM dbo.Site s WITH(UPDLOCK,ROWLOCK)
WHERE isLicensee = 1

UPDATE s
SET s.IsChinaView = 1
FROM dbo.Site s WITH(UPDLOCK,ROWLOCK)
INNER JOIN #Site st ON s.site = st.site

DROP TABLE #Site


