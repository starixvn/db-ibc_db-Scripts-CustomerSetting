/*
	Created: 20190606@Elodie
	DB: DBCUST/CustDB
	Task: Update comm 
*/
USE CustDB
GO

SELECT t.* INTO #SportBettypeFilter2
FROM dbo.f_CS_SportBetTypeSettingSelect(1, 2, 0) t	

CREATE TABLE #MemberGroupList (CustId INT, srecommend INT, mrecommend INT, recommend INT, ugroup VARCHAR(3))
CREATE TABLE #WrongList(custid INT, roleid TINYINT, RuleID TINYINT)

INSERT INTO #MemberGroupList (CustId, srecommend, mrecommend, recommend, ugroup)
SELECT c.custid, srecommend, mrecommend, recommend, c.ugroup
FROM dbo.vw_customer c WITH (NOLOCK)
	INNER JOIN dbo.CS_CustSettingMode cm WITH (NOLOCK) ON c.custid = cm.CustId
WHERE c.roleid = 1 AND c.site = 'CN88' AND cm.IsGroupComm = 1

SELECT ci.custid, mc.sporttype, mc.bettype, mc.Islive, mc.GroupId, mc.Discount, mc.ValueId
INTO #SuperComm
FROM dbo.vw_customer ci WITH (NOLOCK)
	CROSS APPLY dbo.f_CS_GetDiscount_Agent(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive
WHERE ci.roleid = 4 AND ci.site = 'CN88' 

SELECT ci.custid, ci.srecommend, mc.sporttype, mc.bettype, mc.Islive, mc.GroupId, mc.Discount, mc.ValueId
INTO #MasterComm
FROM dbo.vw_customer ci WITH (NOLOCK)
	CROSS APPLY dbo.f_CS_GetDiscount_Agent(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive
WHERE ci.roleid = 3 AND ci.site = 'CN88' 

SELECT ci.custid, ci.srecommend, ci.mrecommend, mc.sporttype, mc.bettype, mc.Islive, mc.GroupId, mc.Discount, mc.ValueId
INTO #AgentComm
FROM dbo.vw_customer ci WITH (NOLOCK)
	CROSS APPLY dbo.f_CS_GetDiscount_Agent(ci.custid) mc
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive
WHERE ci.roleid = 2 AND ci.site = 'CN88' 

SELECT ci.custid, ci.srecommend, ci.mrecommend, mc.sporttype, mc.bettype, mc.Islive, gc.GroupId, mc.SuperDiscount, mc.MasterDiscount, mc.AgentDiscount, mc.PlayerDiscount, ct.ValueId
INTO #GroupComm
FROM dbo.vw_customer ci WITH (NOLOCK)
	CROSS APPLY dbo.f_CS_GetGroupDiscount_Member(ci.custid) mc
	INNER JOIN dbo.CS_CommTemplate ct ON mc.PlayerDiscount = ct.Value 
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive
	LEFT JOIN dbo.CS_GroupConfig gc ON gc.SportType = ft.SportType AND gc.BetType = ft.Bettype AND gc.IsLive = ft.IsLive AND mc.uGroup = gc.uGroup
WHERE ci.roleid = 2 AND ci.site = 'CN88' 

SELECT ci.custid, ci.srecommend, ci.mrecommend, ci.recommend, ci.ugroup, mc.sporttype, mc.bettype, mc.Islive, mc.SuperDiscount, mc.MasterDiscount, mc.AgentDiscount, mc.PlayerDiscount, ct.ValueId
INTO #MemberComm
FROM dbo.vw_customer ci WITH (NOLOCK)
	INNER JOIN dbo.CS_CustSettingMode cm WITH (NOLOCK) ON ci.custid = cm.CustId
	CROSS APPLY dbo.f_CS_GetDiscount_Member(ci.custid) mc
	INNER JOIN dbo.CS_CommTemplate ct ON mc.PlayerDiscount = ct.Value 
	INNER JOIN #SportBettypeFilter2 ft ON mc.SportType = ft.SportType AND mc.BetType = ft.BetType AND mc.IsLive = ft.IsLive
WHERE ci.roleid = 1 AND ci.site = 'CN88' AND cm.IsGroupComm = 0

SELECT *
FROM #SuperComm sc
WHERE sc.ValueId NOT IN (1,6,11,16,21,26,31,36,41,46)

SELECT *
FROM #MasterComm sc
WHERE sc.ValueId NOT IN (1,6,11,16,21,26,31,36,41,46)

SELECT *
FROM #AgentComm sc
WHERE sc.ValueId NOT IN (1,6,11,16,21,26,31,36,41,46)

SELECT *
FROM #GroupComm sc
WHERE sc.ValueId NOT IN (1,6,11,16,21,26,31,36,41,46)

SELECT *
FROM #MemberComm sc
WHERE sc.ValueId NOT IN (1,6,11,16,21,26,31,36,41,46)


SELECT *
FROM #SuperComm sc
WHERE sc.ValueId <> 1
	AND ((sporttype IN (1,2,99) AND bettype = 1 AND GroupID IN (4,8,12,16, 20, 24)) OR (sporttype IN (1,2,99,9999) AND bettype IN (5,9999, 20)))

SELECT *
FROM #MasterComm sc
WHERE sc.ValueId <> 1
	AND ((sporttype IN (1,2,99) AND bettype = 1 AND GroupID IN (4,8,12,16, 20, 24)) OR (sporttype IN (1,2,99,9999) AND bettype IN (5,9999, 20)))

SELECT *
FROM #AgentComm sc
WHERE sc.ValueId <> 1
	AND ((sporttype IN (1,2,99) AND bettype = 1 AND GroupID IN (4,8,12,16, 20, 24)) OR (sporttype IN (1,2,99,9999) AND bettype IN (5,9999, 20)))

SELECT *
FROM #GroupComm sc
WHERE sc.ValueId <> 1
	AND ((sporttype IN (1,2,99) AND bettype = 1 AND GroupID IN (4,8,12,16, 20, 24)) OR (sporttype IN (1,2,99,9999) AND bettype IN (5,9999, 20)))

SELECT *
FROM #MemberComm sc
WHERE sc.ValueId <> 1
	AND ((sporttype IN (1,2,99) AND bettype = 1) OR (sporttype IN (1,2,99,9999) AND bettype IN (5,9999, 20)))
	AND sc.ugroup = 'd'

SELECT *
FROM #MemberComm sc
WHERE sc.ValueId <> 1
	AND sporttype IN (1,2,99,9999) AND bettype IN (5,9999, 20)
	AND sc.ugroup <> 'd'
--DROP TABLE #SportBettypeFilter2
--DROP TABLE #SuperList
--DROP TABLE #MasterList
--DROP TABLE #AgentList
--DROP TABLE #MemberList
--DROP TABLE #MemberGroupList
--DROP TABLE #SuperComm
--DROP TABLE #MasterComm
--DROP TABLE #AgentComm
--DROP TABLE #GroupComm
--DROP TABLE #MemberComm
--DROP TABLE #WrongList