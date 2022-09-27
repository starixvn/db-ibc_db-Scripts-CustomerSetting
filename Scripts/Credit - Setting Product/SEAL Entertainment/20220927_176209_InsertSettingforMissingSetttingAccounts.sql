/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220927@Tacy
	Task: Insert setting for missing setting Accounts [redmine:#176209]
	DB: DBCust/CustDB
*/

/*
	- member:
			68865560
			68865606
			68865619
			68865630
			68865503
			68865504
*/
CREATE TABLE #tmpCust (
	custid		INT PRIMARY KEY,
	agentid		INT,
	StakeLevelID INT
)

INSERT INTO #tmpCust (custid, agentid)
SELECT custid, recommend
FROM custInfo ci WITH (NOLOCK)
WHERE custid IN (68865560,
				 68865606,
				 68865619,
				 68865630,
				 68865503,
				 68865504)

UPDATE t
SET t.StakeLevelID=ss.StakeLevelID
FROM #tmpCust t
	INNER JOIN CustStakeLevel_Agent sla WITH (NOLOCK) ON sla.CustID=t.agentid
	CROSS APPLY (SELECT CAST(value AS INT) AS StakeLevelID FROM STRING_SPLIT(sla.StakeLevelList,',')) s
	CROSS APPLY (SELECT TOP (1) slg.StakeLevelID
				FROM StakeLevelGroupDetail slg WITH (NOLOCK) 
				WHERE slg.StakeLevelID=s.StakeLevelID
				ORDER BY slg.MaxStake, slg.MinStake) ss
WHERE SportType=156


--INSERT SETTING
INSERT INTO CustStakeLevel_Member
([CustID], [SportType], [BetType], [StakeLevelList], [LastUpdated])
SELECT custid, 156, 8900, StakeLevelID, GETDATE()
FROM #tmpCust