/*
	Created: 20200514@Elodie
	Task: Correct betlimit for Allbet, SA, Sexy Gaming, Gold Deluxe for SMA [Redmine: #131171]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

CREATE TABLE #ListTmp (CustID INT, CopyCustID INT)
CREATE TABLE #ListDownline (CustID INT, srecommend INT, mrecommend INT, recommend INT, roleID TINYINT)

DECLARE @SportList TABLE (Sporttype SMALLINT, Bettype INT)
CREATE TABLE #CustStakeLevel_Agent_Copy (CustID INT, SportType SMALLINT, BetType INT, StakeLevelList VARCHAR(200), roleID TINYINT)

INSERT INTO #ListTmp (CustID, CopyCustID)
SELECT 43078362,43042414 
UNION ALL SELECT 43078487,14916425
UNION ALL SELECT 43079891,37893683
UNION ALL SELECT 43080621,42912706
UNION ALL SELECT 43081941,43081911
UNION ALL SELECT 43081967,43081911
UNION ALL SELECT 43082345,42272661
UNION ALL SELECT 43082376,42272661
UNION ALL SELECT 43082431,42917018
UNION ALL SELECT 43082981,40127567
UNION ALL SELECT 43083676,42978798
UNION ALL SELECT 43084313,41623905
UNION ALL SELECT 43084329,43082981
UNION ALL SELECT 43085544,33466262
UNION ALL SELECT 43079126,42599724
UNION ALL SELECT 43081049,42991453
UNION ALL SELECT 43081819,41721109
UNION ALL SELECT 43083040,28969617
UNION ALL SELECT 43083216,42881915
UNION ALL SELECT 43083273,42881915
UNION ALL SELECT 43083752,42936574
UNION ALL SELECT 43084839,43080522
UNION ALL SELECT 43086455,40100305
UNION ALL SELECT 43086654,1176086
UNION ALL SELECT 43086667,28927836
UNION ALL SELECT 43086756,1176083
UNION ALL SELECT 43086764,42838664
UNION ALL SELECT 43086779,42838664
UNION ALL SELECT 43086792,42838664
UNION ALL SELECT 43086794,28927783
UNION ALL SELECT 43086951,1176070
UNION ALL SELECT 43087061,28927783
UNION ALL SELECT 43087071,28927783
UNION ALL SELECT 43087145,28927783
UNION ALL SELECT 43087168,28927783
UNION ALL SELECT 43087178,28927976
UNION ALL SELECT 43087215,28927976
UNION ALL SELECT 43087221,41842869
UNION ALL SELECT 43087237,31545614
UNION ALL SELECT 43087244,43087237
UNION ALL SELECT 43087291,43087271
UNION ALL SELECT 43087355,28927783
UNION ALL SELECT 43087370,28099463
UNION ALL SELECT 43087392,28891851
UNION ALL SELECT 43087401,28891851

INSERT INTO @SportList(Sporttype, Bettype)
SELECT Sporttype, Bettype 
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE SettingType IN (17)

INSERT INTO #ListDownline (CustID, srecommend, mrecommend, recommend, roleID)
SELECT ci.custid, ci.srecommend, ci.mrecommend, ci.recommend, ci.roleID
FROM dbo.Custinfo ci WITH (NOLOCK)
	INNER JOIN #ListTmp t ON ci.srecommend = t.custid
	INNER JOIN dbo.custInfo u WITH (NOLOCK) ON t.CustID = u.custid
WHERE u.roleid = 4
UNION
SELECT ci.custid, ci.srecommend, ci.mrecommend, ci.recommend, ci.roleID
FROM dbo.Custinfo ci WITH (NOLOCK)
	INNER JOIN #ListTmp t ON ci.mrecommend = t.custid
	INNER JOIN dbo.custInfo u WITH (NOLOCK) ON t.CustID = u.custid
WHERE u.roleid = 3
UNION 
SELECT ci.custid, ci.srecommend, ci.mrecommend, ci.recommend, ci.roleID 
FROM dbo.Custinfo ci WITH (NOLOCK)
	INNER JOIN #ListTmp t ON ci.recommend = t.custid
	INNER JOIN dbo.custInfo u WITH (NOLOCK) ON t.CustID = u.custid
WHERE u.roleid = 2

INSERT INTO #CustStakeLevel_Agent_Copy (CustID, SportType, BetType, StakeLevelList, roleID)
SELECT t.CustID, s.SportType, s.BetType, cs.StakeLevelList, t.roleID
FROM #ListDownline t
	INNER JOIN dbo.CustStakeLevel_Agent cs WITH (NOLOCK) ON cs.CustID = t.srecommend
	INNER JOIN @SportList s ON s.Sporttype = cs.SportType AND s.Bettype = cs.BetType
WHERE t.roleID = 3

INSERT INTO #CustStakeLevel_Agent_Copy (CustID, SportType, BetType, StakeLevelList, roleID)
SELECT t.CustID, s.SportType, s.BetType, cs.StakeLevelList, t.roleID
FROM #ListDownline t
	INNER JOIN dbo.CustStakeLevel_Agent cs WITH (NOLOCK) ON cs.CustID = t.mrecommend
	INNER JOIN @SportList s ON s.Sporttype = cs.SportType AND s.Bettype = cs.BetType
WHERE t.roleID = 2

INSERT INTO #CustStakeLevel_Agent_Copy (CustID, SportType, BetType, StakeLevelList, roleID)
SELECT t.CustID, s.SportType, s.BetType, ISNULL(sr.LowestStakeLevel, ''), t.roleID
FROM #ListDownline t
	INNER JOIN dbo.CustStakeLevel_Agent cs WITH (NOLOCK) ON cs.CustID = t.recommend
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
WHERE t.roleID = 1

INSERT INTO dbo.CustStakeLevel_Agent (CustID, SportType, BetType, StakeLevelList)
SELECT CustID, SportType, BetType, StakeLevelList
FROM #CustStakeLevel_Agent_Copy t
WHERE NOT EXISTS (SELECT 1 FROM dbo.CustStakeLevel_Agent cs WHERE t.CustID = cs.CustID AND t.SportType = cs.SportType AND t.BetType = cs.BetType)
	AND t.roleID IN (3,2)

INSERT INTO dbo.CustStakeLevel_Member (CustID, SportType, BetType, StakeLevelList, LastUpdated)
SELECT CustID, SportType, BetType, StakeLevelList, GETDATE()
FROM #CustStakeLevel_Agent_Copy t
WHERE NOT EXISTS (SELECT 1 FROM dbo.CustStakeLevel_Member cs WHERE t.CustID = cs.CustID AND t.SportType = cs.SportType AND t.BetType = cs.BetType)
	AND t.roleID IN (1)