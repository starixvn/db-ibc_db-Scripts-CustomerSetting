/*
	Created: 20190606@Elodie
	DB: DBCUST/CustDB
	Task: Update comm 
*/

SELECT t.* INTO #SportBettypeFilter2
FROM dbo.f_CS_SportBetTypeSettingSelect(1, 2, 0) t	

CREATE TABLE #SuperList (CustId INT)
CREATE TABLE #MasterList (CustId INT, srecommend INT)
CREATE TABLE #AgentList (CustId INT, srecommend INT, mrecommend INT)
CREATE TABLE #MemberList (CustId INT, srecommend INT, mrecommend INT, recommend INT, ugroup VARCHAR(3))
CREATE TABLE #MemberGroupList (CustId INT, srecommend INT, mrecommend INT, recommend INT, ugroup VARCHAR(3))

INSERT INTO #SuperList (CustId)
SELECT c.custid
FROM dbo.vw_customer c WITH (NOLOCK)
WHERE c.roleid = 4 AND c.site = 'CN88' 

INSERT INTO #MasterList (CustId, srecommend)
SELECT c.custid, srecommend
FROM dbo.vw_customer c WITH (NOLOCK)
WHERE c.roleid = 3 AND c.site = 'CN88'

INSERT INTO #AgentList (CustId, srecommend, mrecommend)
SELECT c.custid, srecommend, mrecommend
FROM dbo.vw_customer c WITH (NOLOCK)
WHERE c.roleid = 2 AND c.site = 'CN88'

INSERT INTO #MemberList (CustId, srecommend, mrecommend, recommend, ugroup)
SELECT c.custid, srecommend, mrecommend, recommend, c.ugroup
FROM dbo.vw_customer c WITH (NOLOCK)
	INNER JOIN dbo.CS_CustSettingMode cm WITH (NOLOCK) ON c.custid = cm.CustId
WHERE c.roleid = 1 AND c.site = 'CN88' AND cm.IsGroupComm = 0

INSERT INTO #MemberGroupList (CustId, srecommend, mrecommend, recommend, ugroup)
SELECT c.custid, srecommend, mrecommend, recommend, c.ugroup
FROM dbo.vw_customer c WITH (NOLOCK)
	INNER JOIN dbo.CS_CustSettingMode cm WITH (NOLOCK) ON c.custid = cm.CustId
WHERE c.roleid = 1 AND c.site = 'CN88' AND cm.IsGroupComm = 1

SELECT ci.custid, mc.sporttype, mc.bettype, mc.Islive, mc.GroupId, mc.Discount
INTO #SuperComm
FROM #SuperList ci 
	CROSS APPLY dbo.f_CS_GetDiscount_Agent(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive

SELECT ci.custid, ci.srecommend, mc.sporttype, mc.bettype, mc.Islive, mc.GroupId, mc.Discount
INTO #MasterComm
FROM #MasterList ci 
	CROSS APPLY dbo.f_CS_GetDiscount_Agent(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive

SELECT ci.custid, ci.srecommend, ci.mrecommend, mc.sporttype, mc.bettype, mc.Islive, mc.GroupId, mc.Discount
INTO #AgentComm
FROM #AgentList ci 
	CROSS APPLY dbo.f_CS_GetDiscount_Agent(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive

SELECT ci.custid, ci.srecommend, ci.mrecommend, mc.sporttype, mc.bettype, mc.Islive, gc.GroupId, mc.SuperDiscount, mc.MasterDiscount, mc.AgentDiscount, mc.PlayerDiscount
INTO #GroupComm
FROM #AgentList ci 
	CROSS APPLY dbo.f_CS_GetGroupDiscount_Member(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive
	LEFT JOIN dbo.CS_GroupConfig gc ON gc.SportType = ft.SportType AND gc.BetType = ft.Bettype AND gc.IsLive = ft.IsLive AND mc.uGroup = gc.uGroup

SELECT ci.custid, ci.srecommend, ci.mrecommend, ci.recommend, ci.ugroup, mc.sporttype, mc.bettype, mc.Islive, mc.SuperDiscount, mc.MasterDiscount, mc.AgentDiscount, mc.PlayerDiscount
INTO #MemberComm
FROM #MemberList ci 
	CROSS APPLY dbo.f_CS_GetDiscount_Member(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive

SELECT *
FROM #SuperComm sc
	INNER JOIN #MasterComm mc ON mc.srecommend = sc.CustId AND sc.sporttype = mc.sporttype AND sc.Bettype = mc.bettype AND mc.IsLive = sc.IsLive AND sc.groupid = mc.groupid
	INNER JOIN #AgentComm ac ON ac.srecommend = sc.CustId AND ac.mrecommend = mc.CustId AND ac.sporttype = mc.sporttype AND ac.Bettype = mc.bettype AND mc.IsLive = ac.IsLive AND ac.groupid = mc.groupid
WHERE mc.Discount > sc.Discount
	OR ac.Discount > mc.Discount
	OR ac.Discount > sc.Discount
	
SELECT DISTINCT memc.custid INTO #WrongList
FROM #SuperComm sc
	INNER JOIN #MasterComm mc ON mc.srecommend = sc.CustId AND sc.sporttype = mc.sporttype AND sc.Bettype = mc.bettype AND mc.IsLive = sc.IsLive AND sc.groupid = mc.groupid
	INNER JOIN #AgentComm ac ON ac.srecommend = sc.CustId AND ac.mrecommend = mc.CustId AND ac.sporttype = mc.sporttype AND ac.Bettype = mc.bettype AND mc.IsLive = ac.IsLive AND ac.groupid = mc.groupid	
	INNER JOIN dbo.CS_GroupConfig gc ON gc.GroupId = ac.groupid
	INNER JOIN #MemberComm memc ON memc.srecommend = sc.CustId AND memc.mrecommend = mc.CustId AND memc.recommend = ac.CustId AND memc.ugroup = gc.uGroup
WHERE sc.Discount <> memc.SuperDiscount
	OR mc.Discount <> memc.MasterDiscount
	OR ac.Discount <> memc.AgentDiscount

INSERT INTO #WrongList (custid)
SELECT custid
FROM #MemberComm memc
WHERE memc.MasterDiscount > memc.SuperDiscount
	OR memc.AgentDiscount > memc.MasterDiscount
	OR memc.AgentDiscount > memc.SuperDiscount
	OR memc.PlayerDiscount > memc.AgentDiscount
	OR memc.PlayerDiscount > memc.MasterDiscount
	OR memc.PlayerDiscount > memc.SuperDiscount

INSERT INTO #WrongList (custid)
SELECT custid
FROM #GroupComm gc
WHERE gc.MasterDiscount > gc.SuperDiscount
	OR gc.AgentDiscount > gc.MasterDiscount
	OR gc.AgentDiscount > gc.SuperDiscount
	OR gc.PlayerDiscount > gc.AgentDiscount
	OR gc.PlayerDiscount > gc.MasterDiscount
	OR gc.PlayerDiscount > gc.SuperDiscount

SELECT ci.custid, ci.username, ci.currency,*
FROM #WrongList wl
	INNER JOIN custinfo ci WITH (NOLOCK) ON wl.custid = ci.custid

SELECT *
FROM #WrongList wl
	INNER JOIN #MemberComm memc ON memc.CustId = wl.CustId

--DROP TABLE #SportBettypeFilter2
--DROP TABLE #SuperList
--DROP TABLE #MasterList
--DROP TABLE #AgentList
--DROP TABLE #MemberList
--DROP TABLE #SuperComm
--DROP TABLE #MasterComm
--DROP TABLE #AgentComm
--DROP TABLE #GroupComm
--DROP TABLE #MemberComm