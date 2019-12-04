/*
	Created: Johnson
	Date: 2019-12-04
	Task: check data after group pt	
	DB: DBCUST/CUSTDB
*/

select count(distinct agentid) from CustPTGroupSetting3rd_Member (nolock) where AgentID in (select custid from #agentlist)


select top 100 ci.recommend,ci.username, cs.*
from CustPTSetting3rd_Member cs (nolock)
	inner join custinfo ci (nolock) on ci.custid = cs.custid
	inner join CustSettingMode3rd cm (nolock) on ci.custid = cm.custid
	inner join CustPTGroupSetting3rd_Member ca (nolock) on ca.AgentID = ci.recommend
													 and cs.SportType = ca.SportType 
													 and cs.BetType = ca.BetType 
													 and cs.IsLive = ca.IsLive
where ci.recommend in (select custid from #agentlist)
	and cm.IsGrouped = 1
	and ci.roleid = 1
	and (
		cs.AgentPT <> ca.AgentPT or cs.MasterPT <> ca.MasterPT or cs.SuperPT <> ca.SuperPT or cs.AutoMasterPT <> ca.AutoMasterPT 
		or cs.AutoSuperPT <> ca.AutoSuperPT or cs.IsAutoMasterPT <> ca.IsAutoMasterPT or cs.IsAutoSuperPT <> ca.IsAutoSuperPT
	)



select count(1)
from CustPTSetting3rd_Member cs (nolock)
	inner join custinfo ci (nolock) on ci.custid = cs.custid
	inner join CustSettingMode3rd cm (nolock) on ci.custid = cm.custid
where ci.recommend in (select custid from #agentlist)
	and cm.IsGrouped = 1
	and ci.roleid = 1


select recommend, SUM(case when IsGrouped = 1 then 1 else 0 end) grouped,
 SUM(case when IsGrouped = 0 then 1 else 0 end) nongrouped, count(1) cnt
from custinfo ci (nolock)
	inner join CustSettingMode3rd cm (nolock) on ci.custid = cm.custid
where ci.recommend in (select custid from #agentlist)
	and roleid = 1
	--and recommend = 11756839
group by recommend


