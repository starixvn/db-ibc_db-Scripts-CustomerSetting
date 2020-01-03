/*
	Created: 20200103@Johnson
	Task: Change odds group for Salon365 [redmine:#126349]
	DB: DBCUST/CUSTDB
*/
--2 rows affect
INSERT INTO [dbo].[Dep_DefaultOddGroup]
           ([AgentID]
           ,[Ugroup]
           ,[UpdatedDate]
           ,[UserId]
           ,[IsActive])
SELECT custid, 'c',getdate(), 10278938--StarixIT
,1
FROM Customer (nolock)
WHERE custid IN (13105570--Salon365RMB01
				,13106578--Salon365UUS01
				)

--7699 rows affects
UPDATE customer WITH(UPDLOCK,ROWLOCK)
SET ugroup = 'c'
WHERE srecommend IN (SELECT custid FROM Dep_CustSuper (NOLOCK) WHERE site = 'Salon365')
	AND roleid = 1
	AND ugroup <> 'c'

