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
WHERE srecommend in (SELECT custid from Dep_CustSuper where site = 'Salon365')
	AND roleid = 2

--7699 rows affects
UPDATE customer WITH(UPDLOCK,ROWLOCK)
SET ugroup = 'c'
WHERE srecommend in (SELECT custid FROM Dep_CustSuper WHERE site = 'Salon365')	
	AND roleid = 1	
	AND ugroup <> 'c'

