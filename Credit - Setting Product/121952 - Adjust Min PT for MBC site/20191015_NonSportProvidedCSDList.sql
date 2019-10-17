
-- get dummy super list
SELECT DISTINCT srecommend custid INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
WHERE ci.roleid IN (2, 3) AND ci.currency <> 20 
UNION
SELECT DISTINCT ci.srecommend
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
     INNER JOIN vw_customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
WHERE ci.roleid IN (1) AND ci.currency <> 20 


DECLARE @max_custid INT

SELECT ci.custid into #supers
FROM vw_customer ci WITH (NOLOCK) 
inner join custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	inner join exchange e with (nolock) on e.exchangeid=ci.currency
WHERE ci.roleid = 4  	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.currency<>20
	and cs.IsInternal=0
	and ci.custid>=100
	and ci.custid not in (select custid from #dummySuper)
	and ci.username not like '3rdSuper%'
    and ci.username not IN ( 'STAFF')
    and ci.username not like 'SuperTest%'
    and ci.username not like 'STEST%'
    and ci.username not like 'SIBC%'
    and ci.username not like '%ACCSuper%'
	and ci.site in ('Indo','755555','KORIBC')
	and cu.closed = 0


CREATE TABLE #DirectMaster (CustID INT )
CREATE TABLE #DirectAgent (CustID INT)


			
	--- get direct master
	INSERT INTO #DirectMaster (CustID)
	SELECT ci.custid
	FROM vw_customer ci with(nolock)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	inner join exchange e with (nolock) on e.exchangeid=ci.currency
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 AND ci.srecommend in (select custid from #dummySuper)
		AND c.Enabled=1
		and c.closed = 0
		and  ci.site in ('Indo','755555','KORIBC')
		
	--- get direct agent
	INSERT INTO #DirectAgent (CustID)
	SELECT ci.custid
	FROM vw_Customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	inner join exchange e with (nolock) on e.exchangeid=ci.currency
	WHERE  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		and ci.roleid = 2 AND ci.srecommend in (select custid from #dummySuper)
		AND c.Enabled=1
		and c.closed = 0
		and ci.site in ('Indo','755555','KORIBC')

-- export excel file
	select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Super' 'Level',s .site, e.currency, case when cus.reject = 1 then 'Suspended'
		   else 'Open' End 'Status'
		from #supers ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
where s.custid>=100
and cus.closed=0 
union all
		select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Master',s .site, e.currency,case when cus.reject = 1 then 'Suspended'
		   else 'Open' End 'Status'
		from #DirectMaster ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
where  cus.closed=0 
union all
select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Agent',s .site, e.currency,case when cus.reject = 1 then 'Suspended'
		   else 'Open' End 'Status'
		from #DirectAgent ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
where  cus.closed=0 

drop table #dummySuper
drop table #DirectMaster
drop table #DirectAgent
drop table #supers

