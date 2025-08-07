/*<info serverAlias="IRS_DBSIC-CustDB"></info>*/
/*
	Created: 20250807@Eden
	Task: Init data custSub [#RedmineID:#223896]
	DB: IRS_DBSIC-CustDB
*/
USE custdb
GO
SET IDENTITY_INSERT [dbo].[custSub] ON;
 INSERT INTO custSub (
	 subaccid
	,custid
	,username
	,userpwd
	,PageAccess
	,createdate
	,firstname
	,lastname
	,closed
	,LoginCount
	,UserName2
	,NicknameLoginOnly
	,IsAllDownline
	,RepUpdateTime
 )
 SELECT  subaccid
	,custid
	,username
	,userpwd
	,PageAccess
	,createdate
	,firstname
	,lastname
	,closed
	,LoginCount
	,UserName2
	,NicknameLoginOnly
	,IsAllDownline
	,RepUpdateTime
FROM DBCUST.custdb.dbo.custSub WITH(NOLOCK)

SET IDENTITY_INSERT [dbo].[custSub] OFF;