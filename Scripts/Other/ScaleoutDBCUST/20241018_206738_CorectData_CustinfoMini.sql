/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20241018
	Task: Correct data CustinfoMini [Redmine: #206823]  
	DB: DBCUST-CustDB
*/
USE [CustDB]
GO
--Insert data exists in customer but losing in CustInfoMini
INSERT INTO CustInfoMini (
	 CustID
	,username
	,username2
	,recommend
	,mrecommend
	,srecommend
	,roleid
	,SiteDBGroupID
	,RepUpdateTime
	,Site
	,Currency
)
SELECT CustID
	,username
	,username2
	,recommend
	,mrecommend
	,srecommend
	,roleid
	,SiteDBGroupID = 0
	,RepUpdateTime = [dbo].[f_GetDateTime2]() 
	,Site
	,Currency
FROM Customer c WITH(NOLOCK) 
WHERE c.roleid <> 4 and srecommend = 0
	AND NOT EXISTS( SELECT custid FROM CustInfoMini WITH(NOLOCK) WHERE custid = c.custid)

-- Correct data m
UPDATE cm
SET  username		= c.username
	,username2		= c.username2
	,recommend		= c.recommend
	,mrecommend		= c.mrecommend
	,srecommend		= c.srecommend
	,roleid			= c.roleid
	,SiteDBGroupID	= 0
	,RepUpdateTime	= [dbo].[f_GetDateTime2]()
	,Site			= c.Site
	,Currency		= c.Currency
from CustInfoMini cm WITH(ROWLOCK)
INNER JOIN Customer c WITH(NOLOCK) 
	ON cm.CustID = c.custid
WHERE cm.CustID IN(159916742,159916743,159916967)

--AdminCreateTest2
INSERT INTO CustInfoMini (
	 CustID
	,username
	,username2
	,recommend
	,mrecommend
	,srecommend
	,roleid
	,SiteDBGroupID
	,RepUpdateTime
	,Site
	,Currency
)
SELECT CustID
	,username
	,username2
	,recommend
	,mrecommend
	,srecommend
	,roleid
	,SiteDBGroupID = 0
	,RepUpdateTime = [dbo].[f_GetDateTime2]() 
	,Site
	,Currency
FROM Customer c WITH(NOLOCK) 
WHERE c.custid = 159916703
	AND NOT EXISTS( SELECT custid FROM CustInfoMini WITH(NOLOCK) WHERE custid = c.custid)