/*
	Creator: 20180524@Elodie
	Task: Correct data PT group of Allbet
	DB: DBCUST/CustDB
*/
USE CustDB
GO

--Get Agent list
SELECT ci.custid INTO #AgentList
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN dbo.Dep_CustSuper s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE ci.mrecommend NOT IN (SELECT custid FROM dbo.custInfo WITH (NOLOCK) WHERE roleid = 3 AND username LIKE '%Acc%')
	AND ci.roleid = 2

SELECT DISTINCT cs.custid INTO #AgentMissing
FROM dbo.Dep_CustPTSetting_Agent cs WITH (NOLOCK) 
	INNER JOIN #AgentList a ON a.custid = cs.CustID
	LEFT JOIN dbo.Dep_CustPTGroupSetting_Member csg ON csg.BetType = cs.BetType AND csg.SportType = cs.SportType AND csg.AgentID = cs.CustID
WHERE csg.AgentID IS NULL

INSERT INTO [dbo].[Dep_CustPTGroupSetting_Member]
	([AgentID]
	,[SportType]
	,[BetType]
	,[IsLive]
	,[SuperPT]
	,[MasterPT]
	,[AgentPT]
	)
SELECT a.CustID,acs.SportType,acs.BetType,acs.IsLive,
		0,0,acs.AgentPT
FROM dbo.Dep_CustPTSetting_Agent acs WITH (NOLOCK)
	INNER JOIN #AgentMissing a ON a.CustID = acs.CustID
WHERE NOT EXISTS (SELECT TOP 1 1 FROM dbo.Dep_CustPTGroupSetting_Member WITH (NOLOCK) WHERE AgentID = a.CustID AND SportType = acs.SportType AND BetType = acs.BetType)

DROP TABLE #AgentList
DROP TABLE #AgentMissing