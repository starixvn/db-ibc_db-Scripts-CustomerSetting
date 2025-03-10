/*<info serverAlias="DBCUST-CustDB" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250307@Virgil
	Task: BA Admin & LAP - Drop BA functions [Redmine #216882]
	DB: DBCUST-CustDB
	Note: Step 1 - Update AgentPT of BA (asiabet88)
*/
CREATE TABLE #tmpDiffPT (
	[CustID]	INT,
	[SportType]	SMALLINT,
	[BetType]	SMALLINT,
	[IsLive]	BIT,
	[SuperPT]	SMALLMONEY,
	[MasterPT]	SMALLMONEY,
	[AgentPT]	SMALLMONEY,
	[GroupPT]	SMALLMONEY
)

INSERT INTO #tmpDiffPT 
		([CustID], [SportType], [BetType], [IsLive], [SuperPT], [MasterPT], [AgentPT], [GroupPT])
SELECT m.CustID, m.SportType, m.BetType, m.IsLive, m.SuperPT, m.MasterPT, m.AgentPT, p.AgentPT
FROM Dep_CustPTSetting_Agent m WITH (NOLOCK)
INNER JOIN vw_Customer c WITH (NOLOCK) 
	ON  c.custid	= m.CustID
LEFT JOIN Dep_CustPTGroupSetting_Member p WITH (NOLOCK) 
	ON  m.CustID	= p.AgentID
	AND m.SportType = p.SportType
	AND m.BetType	= p.BetType
WHERE c.site = 'asiabet88' 
	AND c.currency IN (3,6)
	AND c.roleid = 2
	AND m.AgentPT <> ISNULL(p.AgentPT, -1)


--SELECT * FROM #tmpDiffPT

IF EXISTS (SELECT 1 FROM #tmpDiffPT WHERE GroupPT IS NULL)
BEGIN
	INSERT INTO Dep_CustPTGroupSetting_Member 
		([AgentID], [SportType], [BetType], [IsLive], [SuperPT], [MasterPT], [AgentPT], [RepUpdateTime])
	SELECT [CustID], [SportType], [BetType], [IsLive], [SuperPT], [MasterPT], [AgentPT], dbo.f_GetDateTime2()
	FROM #tmpDiffPT
	WHERE GroupPT IS NULL
END

UPDATE g
SET g.AgentPT = d.AgentPT
FROM Dep_CustPTGroupSetting_Member g WITH(ROWLOCK, UPDLOCK)
JOIN #tmpDiffPT d ON g.AgentID = d.CustID


DROP TABLE #tmpDiffPT