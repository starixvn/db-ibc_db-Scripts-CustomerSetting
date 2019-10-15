-- get dummy super list
SELECT DISTINCT srecommend custid INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
WHERE ci.site not IN ('033333', '766666', '789y', 'Y987','CN88')
     AND ci.roleid IN (2, 3) AND ci.currency <> 20
UNION
SELECT DISTINCT ci.srecommend
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
     INNER JOIN vw_customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
WHERE ca.site not IN ('033333', '766666', '789y', 'Y987','CN88')
     AND ci.roleid IN (1) AND ci.currency <> 20



DECLARE @max_custid INT
SELECT @max_custid =39142836

SELECT ci.custid into #supers
FROM vw_customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND ci.currency<>20
	and ci.site not in ('033333', '766666', '789y', 'Y987','CN88')
	and cs.IsInternal=0
	and ci.username not like '3rdSuper%'
    and ci.username not IN ( 'STAFF')
    and ci.username not like 'SuperTest%'
    and ci.username not like 'STEST%'
    and ci.username not like 'SIBC%'
    and ci.username not like '%ACCSuper%'


	

CREATE TABLE #DirectMaster (CustID INT )
	CREATE TABLE #DirectAgent (CustID INT)
			
	--- get direct master
	INSERT INTO #DirectMaster (CustID)
	SELECT ci.custid
	FROM vw_customer ci with(nolock)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 AND ci.srecommend in (select custid from #supers)
		AND ci.custid <= @max_custid 
		AND c.Enabled=1
		and ci.site not in ('033333', '766666', '789y', 'Y987','CN88')

		
	--- get direct agent
	INSERT INTO #DirectAgent (CustID)
	SELECT ci.custid
	FROM vw_Customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	WHERE  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		and ci.roleid = 2 AND ci.srecommend in (select custid from #supers)
		AND ci.custid <= @max_custid
		AND c.Enabled=1
		and ci.site not in ('033333', '766666', '789y', 'Y987','CN88')

-- get super list
		select distinct co.custid into #SuperList from custOverride co with (nolock)
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		inner join #supers s on s.custid=co.custid
		where (co.minpositiontaking<>co.maxpositiontaking
		or (minlivepositiontaking <> maxlivepositiontaking and co.sporttype = 1 and co.bettype in (1,3,7,8))
		or ca.MinPT<>ca.MaxPT
		)
		and s.custid not in (select custid from #dummySuper)

-- get master list		
		select distinct co.custid into #MasterList from custOverride co with (nolock)
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		inner join #DirectMaster s on s.custid=co.custid
		where (co.minpositiontaking<>co.maxpositiontaking
		or (minlivepositiontaking <> maxlivepositiontaking and co.sporttype = 1 and co.bettype in (1,3,7,8))
		or ca.MinPT<>ca.MaxPT
		)
-- get agent list
		select distinct co.custid into #AgentList from custOverride co with (nolock)
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		inner join #DirectAgent s on s.custid=co.custid
		where (co.minpositiontaking<>co.maxpositiontaking
		or (minlivepositiontaking <> maxlivepositiontaking and co.sporttype = 1 and co.bettype in (1,3,7,8))
		or ca.MinPT<>ca.MaxPT
		)


-- export excel file
	select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Super' 'Level',s .site, e.currency, case when cus.reject = 1 then 'Suspended'
		   else 'Open' End 'Status'
		from #SuperList ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
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
		from #MasterList ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
where  cus.closed=0 
union all
select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Agent',s .site, e.currency,case when cus.reject = 1 then 'Suspended'
		   else 'Open' End 'Status'
		from #AgentList ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
where  cus.closed=0 
