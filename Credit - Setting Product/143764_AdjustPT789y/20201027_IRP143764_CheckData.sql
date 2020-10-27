/*
	Created: 20201027@Johnson
	Task: check data after adjust min pt for 789y's supers	
*/

CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE roleid = 4
	AND site IN ('789y')
	
--custsetting
SELECT mb.username,cs.*
INTO #tmpCustSetting
FROM custsetting cs WITH(NOLOCK)
	INNER JOIN custinfo mb WITH(NOLOCK) ON cs.custid = mb.custid							  	
WHERE  mb.srecommend IN (SELECT custid FROM #supers)
	AND mb.roleid = 1
	AND mb.Enabled = 1
	AND (cs.apositiontaking + cs.mpositiontaking + cs.spositiontaking < 0.805
		OR 1= CASE WHEN cs.sporttype = 1 and cs.bettype IN (1,3,7,8) 
					AND cs.alivepositiontaking + cs.mlivepositiontaking + cs.slivepositiontaking < 0.805  THEN 1 ELSE 0 END)

SELECT mb.username,cs.*
INTO #tmpCustSetting3rd
FROM custsetting3rd cs WITH(NOLOCK)
	INNER JOIN custinfo mb WITH(NOLOCK) ON cs.custid = mb.custid							  	
WHERE  mb.srecommend IN (SELECT custid FROM #supers)
	AND mb.roleid = 1
	AND mb.Enabled = 1
	AND (1= CASE WHEN cs.sporttype = 161 AND cs.bettype IN (85, 86, 87, 89, 90)
						AND cs.alivepositiontaking + cs.mlivepositiontaking + cs.slivepositiontaking < 0.805 THEN 1
					WHEN ((cs.sporttype = 161 AND cs.bettype IN (81, 83, 86, 88)) OR cs.sporttype IN (202,255))
						AND cs.apositiontaking + cs.mpositiontaking + cs.spositiontaking < 0.805 THEN 1
				ELSE 0 END)

SELECT mb.username,cs.*
INTO #tmpcustsettingGame
FROM custsettingGame cs WITH(NOLOCK)
	INNER JOIN custinfo mb WITH(NOLOCK) ON cs.custid = mb.custid							  	
WHERE  mb.srecommend IN (SELECT custid FROM #supers)
	AND mb.roleid = 1
	AND mb.Enabled = 1
	AND cs.sporttype IN (202,255))
	AND cs.apositiontaking + cs.mpositiontaking + cs.spositiontaking < 0.805

				
--> FOR DCS products
DECLARE @tmpSport TABLE (sporttype INT)

INSERT INTO @tmpSport(sporttype)
SELECT 43 --E-Sports
UNION SELECT 44	--Muay Thai
UNION SELECT 180 --	Virtual Soccer
UNION SELECT 181 --	Virtual Horse Racing
UNION SELECT 182 --	Virtual Greyhounds
UNION SELECT 183 --	Virtual Speedway
UNION SELECT 184 --	Virtual Motorsports
UNION SELECT 185 --	Virtual Cycling
UNION SELECT 186 --	Virtual Tennis
UNION SELECT 190 --	Virtual Soccer League
UNION SELECT 191 --	Virtual Soccer Nation
UNION SELECT 192 --	Virtual Soccer World Cup
UNION SELECT 193 --	Virtual Basketball
UNION SELECT 200 -- Saba.club
UNION SELECT 211 --Allbet
UNION SELECT 212 --	Macau Games
UNION SELECT 213 --	N
UNION SELECT 214 --	Sa
UNION SELECT 215 --	Sb
UNION SELECT 217 --	Sp
UNION SELECT 218 --	S a+b
UNION SELECT 219 --	Fishing World
UNION SELECT 220 --	Lottery
UNION SELECT 222 --	Table Game
UNION SELECT 224 --	RNG War
UNION SELECT 225 --	ION
UNION SELECT 241 --	BBIN
UNION SELECT 243 --	AE Casino
UNION SELECT 244 --	SA Gaming
UNION SELECT 245 --	Virtual Games

SELECT mb.username,cs.*
INTO #tmpCustPTSetting3rd_Member
FROM dbo.CustPTSetting3rd_Member cs WITH(NOLOCK)
	INNER JOIN custinfo mb WITH(NOLOCK) ON cs.custid = mb.custid							  	
WHERE  mb.srecommend IN (SELECT custid FROM #supers)
	AND mb.roleid = 1
	AND mb.Enabled = 1
	AND cs.sporttype IN (SELECT sporttype FROM @tmpSport)
	AND SuperPT + MasterPT + AgentPT < 80.5
	