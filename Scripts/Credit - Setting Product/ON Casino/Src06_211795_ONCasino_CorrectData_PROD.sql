/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241003@Virgil
	Task:  ON Casino - Implement customer setting [RedmineID: #210025]
	DB: DBCUST-CustDB
*/

select custid, roleid, srecommend, mrecommend, recommend 
INTO #tmp
from vw_Customer c with (nolock) 
where c.custid between 172782795 and 172785814
	and c.srecommend not in (select custid from Dep_CustSuper with (nolock))
	and c.currency IN (13,6,5,67,47,33,34,15,22,45,69,2,14,43,35,3,95,64,16,51 ) --offer currency
 
INSERT INTO CustStakeLevel_Agent ([CustID], [SportType], [BetType], [StakeLevelList])
SELECT t.[CustID], [SportType], [BetType], [StakeLevelList]
FROM #tmp t
	INNER JOIN CustStakeLevel_Agent cs (NOLOCK) ON  cs.CustID = t.srecommend
WHERE SportType = 138 AND t.roleid  = 3
 
INSERT INTO CustStakeLevel_Agent ([CustID], [SportType], [BetType], [StakeLevelList])
SELECT t.[CustID], [SportType], [BetType], [StakeLevelList]
FROM #tmp t
	INNER JOIN CustStakeLevel_Agent cs (NOLOCK) ON  cs.CustID = t.mrecommend
WHERE SportType = 138 AND t.roleid  = 2
 
INSERT INTO CustStakeLevel_Member ([CustID], [SportType], [BetType], [StakeLevelList], [LastUpdated])
SELECT t.[CustID], [SportType], [BetType], ISNULL(sr.LowestStakeLevel, ''), GETDATE()
FROM #tmp t
	INNER JOIN CustStakeLevel_Agent csla (NOLOCK) ON  t.recommend = csla.custid
	OUTER APPLY (
					SELECT TOP(1) ISNULL(CONVERT(VARCHAR(20), sl.StakeLevelID), '') AS LowestStakeLevel
					FROM (
						SELECT	CAST(value AS INT) AS val
						FROM	STRING_SPLIT(csla.StakeLevelList, ',')
					) AS ss
					INNER JOIN	dbo.StakeLevel AS sl WITH(NOLOCK)
							ON	ss.val = sl.StakeLevelID
					ORDER BY	sl.MaxStake, sl.MinStake, sl.GameGroupID
					) sr
WHERE SportType = 138 AND t.roleid  = 1
	AND t.custid NOT IN (172785665 ,172785656)
 
 
DROP TABLE #tmp