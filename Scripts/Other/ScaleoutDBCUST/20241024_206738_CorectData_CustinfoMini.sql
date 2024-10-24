/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20241024
	Task: Correct data CustinfoMini [Redmine: #206823]  
	DB: DBCUST-CustDB
*/
USE [CustDB]
GO
-- Correct data m
UPDATE t
SET	srecommend		= 0
FROM Customer t WITH(ROWLOCK)
WHERE t.CustID IN(179348092,179348098)

--Update Site = 'yUT'
UPDATE c
SET  RepUpdateTime	= [dbo].[f_GetDateTime2]()
	,Site			= 'yUT'
FROM GlobCustDB.dbo.CustInfoMini c WITH(ROWLOCK)
WHERE c.CustID IN (179348112)

--SiteDBGroupID	= 0
UPDATE t
SET  RepUpdateTime	= [dbo].[f_GetDateTime2]()
	,SiteDBGroupID	= 0
FROM GlobCustDB.dbo.CustInfoMini t WITH(ROWLOCK)
WHERE t.CustID IN (179348113)