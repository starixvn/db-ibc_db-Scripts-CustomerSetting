/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20241120
	Task: Correct data customer: custid = 185566279 [Redmine: #206823]  
	DB: DBCUST-CustDB
*/
USE [CustDB]
GO
-- Correct data m
UPDATE t
SET	srecommend	= 0,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM Customer t WITH(ROWLOCK)
WHERE t.CustID IN(185566279)

UPDATE t
SET	srecommend	= 0,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM custinfo t WITH(ROWLOCK)
WHERE t.CustID IN(185566279)
