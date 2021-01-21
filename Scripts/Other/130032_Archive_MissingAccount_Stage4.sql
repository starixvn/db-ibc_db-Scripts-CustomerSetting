/*
	Created: Helen@20210121
	Task: Archive - delete missing account
	DB: db05.bodb_customer
	
	
*/ 

--db05.bodb_customer
INSERT INTO ArchivedMasterAgent_Stage3 (CustID, username, Level)
SELECT b.custid, b.username
--, b.username2, b.creatdate, b.site, ArchiveDate, c.roleid
, Level = CASE WHEN c.roleid = 2 then 'Agent' ELSE 'Master' END
FROM custInfo_old c with (nolock)
	INNER JOIN customer_old b with(nolock) on b.custid = c.custid
	LEFT JOIN ArchivedMasterAgent_Stage3_20201224_test a on a.custid = c.custid
where ArchiveDate >= '2020-12-08'
	and c.roleid IN(2,3)
	and c.custid not in(select custid from bodb02.dbo.customer with (nolock))-- cust deleted
	and a.Level is null -- check not exist in list s3