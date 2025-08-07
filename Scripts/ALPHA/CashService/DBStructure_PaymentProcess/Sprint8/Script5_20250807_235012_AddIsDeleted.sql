/*<info serverAlias="IRS_DBSIC-CustDB"></info>*/
/*
  Created: 20250807@Eden
  Task: Step 1: Disable Job
		Step 2: Alter Table add IsDeleted
		Step 3: Re-init data
		Step 4: Enabled Job

  DB: IRS_DBSIC-CustDB
  
  Revisions:
    - 20250609@Eden: Initial [RedmineID: #235012]
*/
USE custdb
go
-- Step 1: Disable Job
UPDATE RepInfo
SET active = 0
WHERE [name] =  'custSub'

--Step 2: Alter Table add IsDeleted
ALTER TABLE custSub ADD [IsDeleted] [bit]

--Step 3: Re-init data
TRUNCATE TABLE custSub

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
	,IsDeleted
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
	,IsDeleted
FROM DBCUST.custdb.dbo.custSub WITH(NOLOCK)

SET IDENTITY_INSERT [dbo].[custSub] OFF;

--Step 4: Enabled Job
UPDATE RepInfo
SET active = 1
WHERE [name] =  'custSub'