/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20241024
	Task: Correct data CustinfoMini: 'S3RMB','S3RMB11' [Redmine: #206823]  
	DB: DBCUST-CustDB
*/
USE GlobCustDB
GO
--Update Currency = 13
UPDATE c
SET  RepUpdateTime	= [dbo].[f_GetDateTime2]()
	,Currency			= 13
FROM GlobCustDB.dbo.CustInfoMini c WITH(ROWLOCK)
WHERE username IN('S3RMB','S3RMB11')
