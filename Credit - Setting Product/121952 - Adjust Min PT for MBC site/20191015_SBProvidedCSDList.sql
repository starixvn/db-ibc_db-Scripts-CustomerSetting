/*
	Created: Gary
	Date: 2019/10/15
	Task: Get Super, Direct Master, Direct Agent for MBC site for SportBook (SportBook, SportBook2, E-sports)
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */

 
create table #UpdateMinPT (site nvarchar(50), currency nvarchar(50), MaxPT int)
insert into #UpdateMinPT (site,currency,MaxPT)
SELECT 'BEST-ODDS','EURO', 85 UNION ALL
SELECT 'BEST-ODDS','RM', 85 UNION ALL
SELECT 'BEST-ODDS','YNG', 85 UNION ALL
SELECT 'BEST-ODDS','RMB', 85 UNION ALL
SELECT 'BEST-ODDS','HK$', 85 UNION ALL
SELECT 'BEST-ODDS','GBP', 85 UNION ALL
SELECT 'BEST-ODDS','US$', 85 UNION ALL
SELECT 'BEST-ODDS','HKK', 85 UNION ALL
SELECT 'BEST-ODDS','SD$', 85 UNION ALL
SELECT 'INDO','IDD', 80 UNION ALL
SELECT 'INDO','IND', 80 UNION ALL
SELECT 'INDO','IN', 80 UNION ALL
SELECT 'INDO','DDD', 80 UNION ALL
SELECT 'INDO','IDR', 80 UNION ALL
SELECT '611111','RMB', 85 UNION ALL
SELECT '611111','HK$', 85 UNION ALL
SELECT '733333','RM', 85 UNION ALL
SELECT '733333','HKK', 70 UNION ALL
SELECT '733333','HK$', 70 UNION ALL
SELECT '733333','RMB', 70 UNION ALL
SELECT '755555','THB', 80 UNION ALL
SELECT '755555','TB', 80 UNION ALL
SELECT '222223','HKK', 70 UNION ALL
SELECT '222223','RM', 85 UNION ALL
SELECT '7aa666','MMK', 80 UNION ALL
SELECT 'KORIBC','Won', 85 UNION ALL
SELECT '722222','RM', 85 UNION ALL
SELECT '722222','HKK', 70 UNION ALL
SELECT '722222','HK$', 70 UNION ALL
SELECT 'XYZBet','EURO', 85 UNION ALL
SELECT 'XYZBet','RM', 85 UNION ALL
SELECT 'XYZBet','HKK', 85 UNION ALL
SELECT 'XYZBet','HK$', 85 UNION ALL
SELECT 'XYZBet','GBP', 85 UNION ALL
SELECT 'XYZBet','RMB', 85


select * into #UpdateMaxPT from #UpdateMinPT
where MaxPT<>-1

-- get dummy super list
SELECT DISTINCT srecommend custid INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
WHERE  ci.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')
and ci.roleid IN (2, 3) AND ci.currency <> 20
UNION
SELECT DISTINCT ci.srecommend
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
     INNER JOIN vw_customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
WHERE ca.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')
     AND ci.roleid IN (1) AND ci.currency <> 20


DECLARE @max_custid INT
SELECT @max_custid =39193683

SELECT ci.custid,m.MaxPT into #supers
FROM vw_customer ci WITH (NOLOCK) 
inner join custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	inner join exchange e with (nolock) on e.exchangeid=ci.currency
	inner join #UpdateMinPT m on m.site=ci.site and m.currency=e.currency
WHERE ci.roleid = 4  	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
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
	and cu.closed=0 
	AND ci.username NOT IN ('MEA','MEB','S90AR','S90C','S90H','S90R','S90RM','SF8') --exclude headline mea, s90r, sf8




CREATE TABLE #DirectMaster (CustID INT, MaxPT int )
	CREATE TABLE #DirectAgent (CustID INT, MaxPT int)
			
	--- get direct master
	INSERT INTO #DirectMaster (CustID, MaxPT)
	SELECT ci.custid, m.MaxPT
	FROM vw_customer ci with(nolock)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	inner join exchange e with (nolock) on e.exchangeid=ci.currency
	inner join #UpdateMinPT m on m.site=ci.site and m.currency=e.currency
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 AND ci.srecommend in (select custid from #dummySuper)
		AND ci.custid <= @max_custid 
		AND c.Enabled=1
		and c.closed=0 
		AND c.username NOT IN ('M90RM') --exclude headline mea, s90r, sf8

		
	--- get direct agent
	INSERT INTO #DirectAgent (CustID, MaxPT)
	SELECT ci.custid, m.MaxPT
	FROM vw_Customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	inner join exchange e with (nolock) on e.exchangeid=ci.currency
	inner join #UpdateMinPT m on m.site=ci.site and m.currency=e.currency
	WHERE  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		and ci.roleid = 2 AND ci.srecommend in (select custid from #dummySuper)
		AND ci.custid <= @max_custid
		AND c.Enabled=1
		and c.closed=0 
		and c.custid not in (16129,922361)--7899HK ,BMW1 wrong data direct agent



-- get list super update maxPT
select distinct co.custid, co.minpositiontaking 'MinPT',cs.spositiontaking 'Current MaxPT',s.MaxPT/100.0 'Expected MaxPT' into #superMaxPT  from custOverride co with (nolock)
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		 inner join custsetting cs with (nolock) on cs.custid=co.custid and cs.sporttype=co.sporttype and cs.bettype=co.bettype
		inner join #supers s on s.custid=co.custid
		inner join custinfo c with (nolock) on c.custid=s.custid
		inner join vw_customer cu with (nolock) on cu.custid=c.custid
		inner join exchange e with (nolock) on e.exchangeid=c.currency
		inner join #UpdateMaxPT m on m.site=cu.site and m.currency=e.currency
		where (superPT<>s.MaxPT or cs.spositiontaking<>s.MaxPT/100.0)
		and cs.sporttype <>154

-- get list  Master update maxPT 
select distinct co.custid,co.minpositiontaking 'MinPT',cs.mpositiontaking 'Current MaxPT',s.MaxPT/100.0 'Expected MaxPT' into #masterMaxPT  from custOverride co with (nolock)
		   inner join custsetting cs with (nolock) on cs.custid=co.custid and cs.sporttype=co.sporttype and cs.bettype=co.bettype
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		inner join #DirectMaster s on s.custid=co.custid
		inner join custinfo c with (nolock) on c.custid=s.custid
		inner join vw_customer cu with (nolock) on cu.custid=c.custid
		inner join exchange e with (nolock) on e.exchangeid=c.currency
		inner join #UpdateMaxPT m on m.site=cu.site and m.currency=e.currency
		where 
		(masterPT<>s.MaxPT or cs.mpositiontaking<>s.MaxPT/100.0)
		and cs.sporttype <>154 --HR

-- get list Agent update MaxPT
select distinct co.custid,co.minpositiontaking 'MinPT',cs.apositiontaking 'Current MaxPT',s.MaxPT/100.0 'Expected MaxPT' into #agentMaxPT  from custOverride co with (nolock)
		   inner join custsetting cs with (nolock) on cs.custid=co.custid and cs.sporttype=co.sporttype and cs.bettype=co.bettype
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		inner join #DirectAgent s on s.custid=co.custid
		inner join custinfo c with (nolock) on c.custid=s.custid
		inner join vw_customer cu with (nolock) on cu.custid=c.custid
		inner join exchange e with (nolock) on e.exchangeid=c.currency
		inner join #UpdateMaxPT m on m.site=cu.site and m.currency=e.currency
		where (AgentPT<>s.MaxPT or cs.apositiontaking<>s.MaxPT/100.0)
		and cs.sporttype <>154 --HR


		
-- get super list update minPT
		select distinct co.custid into #SuperMinPT from custOverride co with (nolock)
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		 inner join custsetting cs with (nolock) on cs.custid=co.custid and cs.sporttype=co.sporttype and cs.bettype=co.bettype
		inner join #supers s on s.custid=co.custid
		where (
		co.minpositiontaking<>cs.spositiontaking
		or (minlivepositiontaking <> cs.slivepositiontaking and co.sporttype = 1 and co.bettype in (1,3,7,8))
		or 
		ca.MinPT<>ca.SuperPT
		)
		and cs.sporttype <>154 --HR
		union
		select custid from #superMaxPT where minpt=[Current MaxPT] 
	

-- get master list	update minPT	
		select distinct co.custid into #MasterMinPT from custOverride co with (nolock)
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		 inner join custsetting cs with (nolock) on cs.custid=co.custid and cs.sporttype=co.sporttype and cs.bettype=co.bettype
		inner join #DirectMaster s on s.custid=co.custid
		where (
		co.minpositiontaking<>cs.mpositiontaking
		or (minlivepositiontaking <> cs.mlivepositiontaking and co.sporttype = 1 and co.bettype in (1,3,7,8))
		or
		 ca.MinPT<>ca.MasterPT
		)
		and cs.sporttype <>154 --HR
		union
		select custid from #masterMaxPT where minpt=[Current MaxPT] 

		
-- get agent list update minPT
		select distinct co.custid into #AgentMinPT from custOverride co with (nolock)
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		inner join custsetting cs with (nolock) on cs.custid=co.custid and cs.sporttype=co.sporttype and cs.bettype=co.bettype
		inner join #DirectAgent s on s.custid=co.custid
		where (
		co.minpositiontaking<>cs.apositiontaking
		or (minlivepositiontaking <> cs.alivepositiontaking and co.sporttype = 1 and co.bettype in (1,3,7,8))
		or 
		ca.MinPT<>ca.AgentPT
		)
		and cs.sporttype <>154 --HR
		union
		select custid from #agentMaxPT where minpt=[Current MaxPT]



-- List 1. export excel file list update MaxPT
	select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Super' 'Level',s .site, e.currency,
	 case when cus.closed=0 and cus.reject = 1 then 'Suspended'
		  when cus.closed=0 and cus.reject = 0 then 'Open' 
		  when cus.closed=1 then 'Closed'  else '' End 'Status', ts.MinPT, ts.[Current MaxPT],ts.[Expected MaxPT]
		from #superMaxPT ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
union all
		select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Master',s .site, e.currency,
		case when cus.closed=0 and cus.reject = 1 then 'Suspended'
		  when cus.closed=0 and cus.reject = 0 then 'Open' 
		  when cus.closed=1 then 'Closed'  else '' End 'Status',ts.MinPT, ts.[Current MaxPT],ts.[Expected MaxPT]
		from #masterMaxPT ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
union all
select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Agent',s .site, e.currency,
case when cus.closed=0 and cus.reject = 1 then 'Suspended'
		  when cus.closed=0 and cus.reject = 0 then 'Open' 
		  when cus.closed=1 then 'Closed'  else '' End 'Status',ts.MinPT, ts.[Current MaxPT],ts.[Expected MaxPT]
		from #agentMaxPT ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid




-- List 2. export excel file list udpate MinPT
	select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Super' 'Level',s .site, e.currency, 
	case when cus.closed=0 and cus.reject = 1 then 'Suspended'
		  when cus.closed=0 and cus.reject = 0 then 'Open' 
		  when cus.closed=1 then 'Closed'  else '' End 'Status'
		from #SuperMinPT ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
union all
		select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Master',s .site, e.currency,
	case when cus.closed=0 and cus.reject = 1 then 'Suspended'
		  when cus.closed=0 and cus.reject = 0 then 'Open' 
		  when cus.closed=1 then 'Closed'  else '' End 'Status'
		from #MasterMinPT ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
union all
select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Agent',s .site, e.currency,
case when cus.closed=0 and cus.reject = 1 then 'Suspended'
		  when cus.closed=0 and cus.reject = 0 then 'Open' 
		  when cus.closed=1 then 'Closed'  else '' End 'Status'
		from #AgentMinPT ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid


