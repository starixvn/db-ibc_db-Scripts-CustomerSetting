/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241003@Virgil
	Task:  ON Casino - Implement customer setting [RedmineID: #211795]
	DB: DBCUST-CustDB
*/

select custid, roleid, srecommend, mrecommend, recommend 
INTO #tmp
from vw_Customer c with (nolock) 
where c.custid = 172785890
	and c.srecommend not in (select custid from Dep_CustSuper with (nolock))
	and c.currency IN (13,6,5,67,47,33,34,15,22,45,69,2,14,43,35,3,95,64,16,51 ) --offer currency

 
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
					ORDER BY sl.MaxStake, sl.MinStake, sl.GameGroupID
					) sr
WHERE SportType = 138 AND t.roleid  = 1
 
 
DROP TABLE #tmp