/*
	Created: Johnson
	Date: 2019-04-23
	Task: update firstlogin for cn88 uus
	DB: DBCUST/CustDB
*/

select c.custid, username,username2,currency, roleid
into #tmp
from customer c (NOLOCK)
inner join CustLoginInfo ci WITH(NOLOCK) on c.custid = ci.custid
where site = 'cn88'
	and currency = 20 
	and roleid IN (0,2,3,4)
	AND username2 is NULL
	and ci.isFirstLogin = 0

--16 rows affected
select * from #tmp

UPDATE CustLoginInfo WITH(UPDLOCK,ROWLOCK)
SET isFirstLogin = 1
WHERE custid IN (SELECT custid FROM #tmp)