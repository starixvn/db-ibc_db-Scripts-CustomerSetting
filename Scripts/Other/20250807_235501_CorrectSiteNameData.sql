/*<info serverAlias="DBCUST-CustDB"></info>*/
 /*
	Created: 20250807@Tacy
	Task: Correct data [Redmine:#235501]	
	DB: DBCUST-CustDB

	*** CustAgent
		Dep_CustSuper
		custInfo
		Customer
		CustInfoMini
*/
USE CustDB
GO

CREATE TABLE #tmpCustomerList (
			[custid] [int] PRIMARY KEY,
			[site] [nvarchar](50),
			[new_username] [varchar](30),
			[new_username2] [varchar](50) NULL
	)

-- 31 rows
INSERT INTO #tmpCustomerList (custid, site, new_username, new_username2)
SELECT c.custid, s.site  
	,REPLACE(c.username, c.site, s.site) new_username
	,REPLACE(c.username2, c.site, s.site) new_username2
FROM vw_Customer c WITH (NOLOCK)
	INNER JOIN Site s WITH (NOLOCK) ON s.site=c.site
WHERE c.srecommend IN (253321682,254380561)

--------------------------------------------------------------------------
-- CustAgent
UPDATE c
SET c.site=t.site
	,c.RepUpdateTime=dbo.f_GetDateTime2()
FROM CustAgent c WITH(ROWLOCK, UPDLOCK)
INNER JOIN #tmpCustomerList t ON t.custid=c.custid

-- Dep_CustSuper
UPDATE c
SET c.username=t.new_username
	,c.site=t.site
	,c.RepUpdateTime=dbo.f_GetDateTime2()
FROM Dep_CustSuper c WITH(ROWLOCK, UPDLOCK)
INNER JOIN #tmpCustomerList t ON t.custid=c.custid

-- custInfo
UPDATE c
SET c.username=t.new_username
	,c.RepUpdateTime=dbo.f_GetDateTime2()
FROM custInfo c WITH(ROWLOCK, UPDLOCK)
INNER JOIN #tmpCustomerList t ON t.custid=c.custid

-- Customer
UPDATE c
SET c.username=t.new_username
	,c.username2=t.new_username2
	,c.site=t.site
	,c.RepUpdateTime=dbo.f_GetDateTime2()
FROM Customer c WITH(ROWLOCK, UPDLOCK)
INNER JOIN #tmpCustomerList t ON t.custid=c.custid

--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Switch to GlobCustDB:
USE GlobCustDB

-- CustInfoMini
UPDATE c
SET c.username=t.new_username
	,c.username2=t.new_username2
	,c.site=t.site
	,c.RepUpdateTime=dbo.f_GetDateTime2()
FROM CustInfoMini c WITH(ROWLOCK, UPDLOCK)
INNER JOIN #tmpCustomerList t ON t.custid=c.custid
GO