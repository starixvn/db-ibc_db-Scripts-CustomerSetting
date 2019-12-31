/*
	Created: Tiara	
	Task: Set default Bet setting for customers under 789y Headline- Non-DCS Products- RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20191224
*/ 

DECLARE @max_custid INT
SELECT @max_custid = xx

--Super accounts under 789y Headline
CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND ci.site IN ('789y')
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND ci.currency <> 20	
--Number Game, Happy5
--Prepare list of customer
SELECT DISTINCT CI.custid,CI.roleid, CS.sporttype
INTO #tmpSetting_NG
FROM CustSetting3rd CS WITH (NOLOCK)
	INNER JOIN custInfo ci WITH (NOLOCK) ON CI.custid = CS.custid
	INNER JOIN #supers S WITH (NOLOCK) ON S.custid = CI.srecommend
WHERE CI.Enabled = 1
	AND CS.sporttype IN (161,164)
	AND ((minbet=0 and maxbet=0 and maxpermatch161=0 and cs.sporttype=161)
		OR (minbet=0 and maxbet=0 and maxpermatch164=0 and cs.sporttype=164)
		OR ((maxbet=0.1 or maxpermatch161=0.1) and cs.sporttype=161)
		OR (( maxbet=0.1 or maxpermatch164=0.1) and cs.sporttype=164)
		)
	AND CI.custid <= @max_custid	
----Update super
UPDATE CS
SET CS.minbet =X, CS.maxbet = X
FROM CustSetting3rd CS WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_NG  T ON T.custid = CS.custid
WHERE T.roleid = 4

UPDATE CI
SET CI.maxpermatch161 = CASE WHEN T.sporttype = 161 THEN X ELSE CI.maxpermatch161 END,
	CI.MaxPerBall161 = CASE WHEN T.sporttype = 161 THEN X ELSE CI.MaxPerBall161 END,
	CI.maxpermatch164 = CASE WHEN T.sporttype = 164 THEN X ELSE CI.maxpermatch164 END
FROM custInfo CI WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_NG  T ON T.custid = CI.custid
WHERE T.roleid = 4
----Update master, agent
UPDATE CS
SET CS.minbet =X, CS.maxbet = X
FROM CustSetting3rd CS WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_NG  T ON T.custid = CS.custid
WHERE T.roleid IN (2,3)

UPDATE CI
SET CI.maxpermatch161 = CASE WHEN T.sporttype = 161 THEN X ELSE CI.maxpermatch161 END,
	CI.MaxPerBall161 = CASE WHEN T.sporttype = 161 THEN X ELSE CI.MaxPerBall161 END,
	CI.maxpermatch164 = CASE WHEN T.sporttype = 164 THEN X ELSE CI.maxpermatch164 END
FROM custInfo CI WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_NG  T ON T.custid = CI.custid
WHERE T.roleid IN (2,3)
----Update member
UPDATE CI
SET CI.maxpermatch161 = CASE WHEN T.sporttype = 161 THEN X ELSE CI.maxpermatch161 END,
	CI.MaxPerBall161 = CASE WHEN T.sporttype = 161 THEN X ELSE CI.MaxPerBall161 END,
	CI.maxpermatch164 = CASE WHEN T.sporttype = 164 THEN X ELSE CI.maxpermatch164 END
FROM custInfo CI WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_NG  T ON T.custid = CI.custid
WHERE T.roleid = 1

UPDATE CI
SET CI.maxpermatch161 = CASE WHEN T.sporttype = 161 THEN X ELSE CI.maxpermatch161 END,
	CI.MaxPerBall161 = CASE WHEN T.sporttype = 161 THEN X ELSE CI.MaxPerBall161 END,
	CI.maxpermatch164 = CASE WHEN T.sporttype = 164 THEN X ELSE CI.maxpermatch164 END
FROM custInfo CI WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_NG  T ON T.custid = CI.custid
WHERE T.roleid = 1
--RNG Keno
--Prepare list of customer
SELECT DISTINCT CI.custid,CI.roleid, CS.GameTypeID, CS.MinBet,CS.MaxBet,CS.MaxPerGameType
INTO #tmpSetting_RK
FROM CustGameType CS with (nolock)
	INNER JOIN custInfo ci WITH (NOLOCK) ON CI.custid = CS.custid
	INNER JOIN #supers S WITH (NOLOCK) ON S.custid = CI.srecommend
WHERE CI.Enabled = 1
	AND GAMETYPEID NOT IN (2,7,9,1701,1702)
	AND ((CS.MinBet=0 and CS.MaxBet=0 and CS.MaxPerGameType=0 )
		OR(CS.MaxBet=0.1 or CS.MaxPerGameType=0.1))		
--Update Super
UPDATE CS
SET CS.MinBet = X, CS.MaxBet = X, CS.MaxPerGameType = X
FROM CustGameType CS WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_RK T ON T.custid = CS.CustID
WHERE T.roleid = 4
--Update Master, Agent
UPDATE CS
SET CS.MinBet = X, CS.MaxBet = X, CS.MaxPerGameType = X
FROM CustGameType CS WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_RK T ON T.custid = CS.CustID
WHERE T.roleid in (2,3)
--Update Member
UPDATE CS
SET CS.MinBet = X, CS.MaxBet = X, CS.MaxPerGameType = X
FROM CustGameType CS WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting_RK T ON T.custid = CS.CustID
WHERE T.roleid = 1

--RNG Casino
--Prepare list of customer
SELECT DISTINCT CI.custid, CI.roleid
INTO #SMAStakeLevel
FROM custInfo CI WITH (NOLOCK)
	INNER JOIN #supers S on S.custid=CI.srecommend
	INNER JOIN DBCASINO.CasinoAdmin.dbo.Customer c WITH (NOLOCK) ON CI.custid = c.ibccustid
    INNER JOIN DBCASINO.CasinoAdmin.dbo.CustGameType CG WITH (NOLOCK) ON CG.custid = CI.custid
WHERE CI.enabled=1
	AND (CG.StakeLevelList= '' OR CG.StakeLevelList= NULL)

--Update Super
UPDATE CG
SET CG.StakeLevelList= X
FROM DBCASINO.CasinoAdmin.dbo.CustGameType CG WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #SMAStakeLevel S ON S.custid = CG.custid
WHERE S.roleid = 4

--Update Master, Agent:
UPDATE CG
SET CG.StakeLevelList= X
FROM DBCASINO.CasinoAdmin.dbo.CustGameType CG WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #SMAStakeLevel S ON S.custid = CG.custid
WHERE S.roleid IN (2,3)

--Update Member:
UPDATE CG
SET CG.StakeLevelList= X
FROM DBCASINO.CasinoAdmin.dbo.CustGameType CG WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #SMAStakeLevel S ON S.custid = CG.custid
WHERE S.roleid = 1

--Gold Deluxe
--Prepare list of customer
SELECT DISTINCT CI.custid, CI.roleid
INTO #SMAStakeLevel_GD
FROM CustGameType cs WITH (NOLOCK)
INNER JOIN custInfo CI WITH (NOLOCK) ON CI.custid=cs.custid
INNER JOIN #supers S WITH (NOLOCK) ON S.custid=CI.srecommend
WHERE CI.enabled=1
	AND CS.GameTypeID in (1701,1702)
	AND (CS.StakeLevelList= '' OR CS.StakeLevelList= NULL)
	
--Update Super
UPDATE CG
SET CG.StakeLevelList= X
FROM CustGameType CG WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #SMAStakeLevel S ON S.custid = CG.custid
WHERE S.roleid = 4

--Update Master, Agent:
UPDATE CG
SET CG.StakeLevelList= X
FROM CustGameType CG WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #SMAStakeLevel S ON S.custid = CG.custid
WHERE S.roleid IN (2,3)

--Update Member:
UPDATE CG
SET CG.StakeLevelList= X
FROM CustGameType CG WITH (UPDLOCK,ROWLOCK)
	INNER JOIN #SMAStakeLevel S ON S.custid = CG.custid
WHERE S.roleid = 1

--Drop all temp tables
DROP TABLE #supers
DROP TABLE #SMAStakeLevel
DROP TABLE #SMAStakeLevel_GD
DROP TABLE #tmpSetting_NG
DROP TABLE #tmpSetting_RK