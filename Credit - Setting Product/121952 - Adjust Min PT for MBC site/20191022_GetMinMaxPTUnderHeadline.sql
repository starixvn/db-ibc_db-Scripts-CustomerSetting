/*
	Created: Gary
	Date: 2019/10/22
	Task: Headline 302RM would like to know before Company force Min PT on 17 Oct 2019, what is his Super account PT setting (Min & Max).
	Headline : 302RM 
	All Super/Direct account under 302RM
	Product: Sportbook and Sportbook 2
	Redmine: https://nexdev.net/issues/121952
	DB: DBTP.bodb02
	Revision: 
	- KEEP 'M63IRMB','M63IHK', 'M79CR' max pt 85%
	- Remove ci.username NOT IN ('MEA','MEB','S90AR','S90C','S90H','S90R','S90RM','SF8') --exclude headline mea, s90r, sf8
	- Remove c.username NOT IN ('M90RM') --exclude headline mea, s90r, sf8
	- Remove wrong cust direct account list
	- Exclude phone betting list
 */

 declare @headline varchar(30)
 select @headline='302RM'

 
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

SELECT ci.custid, ci.username INTO #WrongDirectMaster
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = ca.CustID
WHERE ci.srecommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 3

SELECT ci.custid, ci.username INTO #WrongDirectAgent
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = ca.CustID
WHERE ci.mrecommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 2

	SELECT ci.custid, ci.username INTO #WrongDirectMember
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = ca.CustID
WHERE ci.recommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 1



-- get dummy super list
SELECT DISTINCT srecommend custid INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
WHERE  ci.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')
and ci.roleid IN (2, 3) AND ci.currency <> 20
and ci.custid not in (select custid from #WrongDirectMaster
	union  select custid from #WrongDirectAgent )
UNION
SELECT DISTINCT ci.srecommend
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
     INNER JOIN vw_customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
WHERE ca.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')
     AND ci.roleid IN (1) AND ci.currency <> 20
    and ci.custid not in (select custid from #WrongDirectMember)



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
		AND c.Enabled=1
		and c.closed=0 
		and c.custid not in (select custid from #WrongDirectMaster)
		and ci.username not in ('M9999RM','ISN','ah501','STELIM','MHK1') -- exclude phone betting line

		
	--- get direct agent
	INSERT INTO #DirectAgent (CustID, MaxPT)
	SELECT ci.custid, m.MaxPT
	FROM vw_Customer ci WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
	inner join exchange e with (nolock) on e.exchangeid=ci.currency
	inner join #UpdateMinPT m on m.site=ci.site and m.currency=e.currency
	WHERE  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		and ci.roleid = 2 AND ci.srecommend in (select custid from #dummySuper)
		AND c.Enabled=1
		and c.closed=0 
		and c.custid not in (select custid from #WrongDirectAgent)
		and c.username not in ('MC-C1X2','MC-OS','MC-MTD','MC-PH','Mollybet','6666PEU','MBET','6666AHK','ccti','xyz100RM','8RM','BARM','ChesterHK')-- exclude phone betting line


		
-- get list super update maxPT
select distinct co.custid, co.minpositiontaking 'MinPT After',cs.spositiontaking 'MaxPT After' into #superMaxPT  from custOverride co with (nolock)
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		 inner join custsetting cs with (nolock) on cs.custid=co.custid and cs.sporttype=co.sporttype and cs.bettype=co.bettype
		inner join #supers s on s.custid=co.custid
		inner join custinfo c with (nolock) on c.custid=s.custid
		inner join vw_customer cu with (nolock) on cu.custid=c.custid
		inner join exchange e with (nolock) on e.exchangeid=c.currency
		inner join #UpdateMaxPT m on m.site=cu.site and m.currency=e.currency
		where  cs.sporttype <>154

-- get list  Master update maxPT 
select distinct co.custid, co.minpositiontaking 'MinPT After',cs.mpositiontaking 'MaxPT After' into #masterMaxPT  from custOverride co with (nolock)
		   inner join custsetting cs with (nolock) on cs.custid=co.custid and cs.sporttype=co.sporttype and cs.bettype=co.bettype
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		inner join #DirectMaster s on s.custid=co.custid
		inner join custinfo c with (nolock) on c.custid=s.custid
		inner join vw_customer cu with (nolock) on cu.custid=c.custid
		inner join exchange e with (nolock) on e.exchangeid=c.currency
		inner join #UpdateMaxPT m on m.site=cu.site and m.currency=e.currency
		where 
		cs.sporttype <>154 --HR
		and c.username not in ('M63IRMB','M63IHK', 'M79CR')  --KEEP 'M63IRMB','M63IHK', 'M79CR' max pt 85%

-- get list Agent update MaxPT
select distinct co.custid, co.minpositiontaking 'MinPT After',cs.apositiontaking 'MaxPT After' into #agentMaxPT  from custOverride co with (nolock)
		   inner join custsetting cs with (nolock) on cs.custid=co.custid and cs.sporttype=co.sporttype and cs.bettype=co.bettype
		inner join CustPTSetting3rd_Agent ca with (nolock) on ca.custid=co.custid and ca.sporttype in (43,44) --SB2,E-sports
		inner join #DirectAgent s on s.custid=co.custid
		inner join custinfo c with (nolock) on c.custid=s.custid
		inner join vw_customer cu with (nolock) on cu.custid=c.custid
		inner join exchange e with (nolock) on e.exchangeid=c.currency
		inner join #UpdateMaxPT m on m.site=cu.site and m.currency=e.currency
		where cs.sporttype <>154 --HR





-- get all account under headline
	select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Super' 'Level',s .site, e.currency,
	 case when cus.closed=0 and cus.reject = 1 then 'Suspended'
		  when cus.closed=0 and cus.reject = 0 then 'Open' 
		  when cus.closed=1 then 'Closed'  else '' End 'Status', ts.[MinPT After], ts.[MaxPT After] into #Report
		from #superMaxPT ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
where cu.username=@headline
union all
		select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Master',s .site, e.currency,
		case when cus.closed=0 and cus.reject = 1 then 'Suspended'
		  when cus.closed=0 and cus.reject = 0 then 'Open' 
		  when cus.closed=1 then 'Closed'  else '' End 'Status',ts.[MinPT After], ts.[MaxPT After]
		from #masterMaxPT ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
where cu.username=@headline
union all
select  isnull (cu. username,'Not assign group' ) 'Headline',s.username,s.custid,'Agent',s .site, e.currency,
case when cus.closed=0 and cus.reject = 1 then 'Suspended'
		  when cus.closed=0 and cus.reject = 0 then 'Open' 
		  when cus.closed=1 then 'Closed'  else '' End 'Status',ts.[MinPT After], ts.[MaxPT After]
		from #agentMaxPT ts inner join vw_Customer s with ( nolock) on s. custid=ts.custid
		inner join custinfo cus with (nolock) on cus.custid=s.custid
inner join exchange e with ( nolock) on e. exchangeid=s .currency
left join vw_CustAccount ca with ( nolock) on ca. custid=s.custid and groupid>0
left join CustGroupHeadline hl with ( nolock) on hl. GroupID=ca .groupID
left join custinfo cu with ( nolock) on hl. custid=cu .custid
where cu.username=@headline

-- get Old PT before Update
select distinct s.custid, isnull(minpositiontaking,s.[MinPT After]) 'MinPT Before', isnull(cs.spositiontaking,s.[MaxPT After]) 'MaxPT Before' into #OldPT from #Report s
left join bodb_CustHistory.dbo.CustOverride_History co with (nolock) on s.custid=co.custid and co.UpdateTime between '20191017' and '20191020' and co.sporttype <>154 --HR
left join bodb_CustHistory.dbo.CustSetting_History cs with (nolock) on s.custid=cs.custid and cs.UpdateTime between '20191017' and '20191020' and cs.sporttype <>154 --HR
where s.Level='Super' 
union all
select distinct s.custid, isnull(minpositiontaking,s.[MinPT After]), isnull(cs.mpositiontaking,s.[MaxPT After])  from #Report s
left join bodb_CustHistory.dbo.CustOverride_History co with (nolock) on s.custid=co.custid and co.UpdateTime between '20191017' and '20191020' and co.sporttype <>154 --HR
left join bodb_CustHistory.dbo.CustSetting_History cs with (nolock) on s.custid=cs.custid and cs.UpdateTime between '20191017' and '20191020' and cs.sporttype <>154 --HR
where s.Level='Master' 
union all
select distinct s.custid, isnull(minpositiontaking,s.[MinPT After]), isnull(cs.apositiontaking,s.[MaxPT After]) from #Report s
left join bodb_CustHistory.dbo.CustOverride_History co with (nolock) on s.custid=co.custid and co.UpdateTime between '20191017' and '20191020' and co.sporttype <>154 --HR
left join bodb_CustHistory.dbo.CustSetting_History cs with (nolock) on s.custid=cs.custid and cs.UpdateTime between '20191017' and '20191020' and cs.sporttype <>154 --HR
where s.Level='Agent' 

-- Export Excel
select r.Headline, r.username,r.custid,r.Level,r.site,r.currency,r.Status,o.[MinPT Before],r.[MinPT After],o.[MaxPT Before],r.[MaxPT After] from #Report r
inner join #OldPT o on r.custid=o.custid




drop table #supers
drop table #DirectMaster
drop table #DirectAgent
drop table #dummySuper
drop table #UpdateMaxPT
drop table #UpdateMinPT
drop table #superMaxPT
drop table #masterMaxPT
drop table #agentMaxPT

