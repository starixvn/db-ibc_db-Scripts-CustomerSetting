/*
	Created: 20200514@Elodie
	Task: Correct betlimit for Allbet, SA, Sexy Gaming, Gold Deluxe for SMA [Redmine: #131171]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

CREATE TABLE #CustStakeLevel_Agent_Copy (CustID INT, SportType SMALLINT, BetType INT, StakeLevelList VARCHAR(200), roleID TINYINT)
DECLARE @SportList TABLE (Sporttype SMALLINT, Bettype INT)

INSERT INTO @SportList(Sporttype, Bettype)
SELECT Sporttype, Bettype 
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE SettingType IN (17)

INSERT INTO #CustStakeLevel_Agent_Copy (CustID, SportType, BetType, StakeLevelList, roleID)
SELECT ci.CustID, s.SportType, s.BetType, ISNULL(sr.LowestStakeLevel, ''), ci.roleID
FROM CustInfo ci WITH (NOLOCK)
	INNER JOIN dbo.CustStakeLevel_Agent cs WITH (NOLOCK) ON cs.CustID = ci.recommend
	INNER JOIN @SportList s ON s.Sporttype = cs.SportType AND s.Bettype = cs.BetType
	OUTER APPLY (
					SELECT TOP(1) ISNULL(CONVERT(VARCHAR(20), sl.StakeLevelID), '') AS LowestStakeLevel
					FROM (
						SELECT	CAST(val AS INT) AS val
						FROM	dbo.strSplit(cs.StakeLevelList, ',')
					) AS ss
					INNER JOIN	dbo.StakeLevel AS sl WITH(NOLOCK)
							ON	ss.val = sl.StakeLevelID
					ORDER BY	sl.MaxStake, sl.MinStake, sl.GameGroupID
				) sr
WHERE ci.roleID = 1
	AND ci.custid IN (43083253, 43083329)

INSERT INTO dbo.CustStakeLevel_Member (CustID, SportType, BetType, StakeLevelList, LastUpdated)
SELECT CustID, SportType, BetType, StakeLevelList, GETDATE()
FROM #CustStakeLevel_Agent_Copy t
WHERE NOT EXISTS (SELECT 1 FROM dbo.CustStakeLevel_Member cs WHERE t.CustID = cs.CustID AND t.SportType = cs.SportType AND t.BetType = cs.BetType)
	AND t.roleID IN (1)