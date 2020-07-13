/*
	Created: 20200713@Johnson
	Task: Update bet setting/loss limit for newly customer for HKK
	DB: DBCUST/CUSTDB
*/

DECLARE @maxcustid INT = xxx

CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE currency = 67
	AND roleid = 4
	AND site IN ('733333','222223','722222')

--update LossLimit & bet setting
CREATE TABLE #Downlines (custid INT PRIMARY KEY, roleid TINYINT, isfinished BIT DEFAULT 0)

INSERT INTO #Downlines (custid,roleid)
SELECT custid, roleid
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND Enabled = 1
	AND custid > @maxcustid
	
DECLARE @BatchMember TABLE(custid INT PRIMARY KEY, roleid TINYINT)

DECLARE @BetSetting TABLE(sporttype INT, MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY)

INSERT INTO @BetSetting(sporttype,MinBet,MaxBet,MaxPerMatch)
SELECT 	180	, 5, 2200, 50000--	Virtual Soccer
UNION ALL SELECT 	181	, 5, 2200, 50000--	Virtual Horse Racing
UNION ALL SELECT 	182	, 5, 2200, 50000--	Virtual Greyhounds
UNION ALL SELECT 	183	, 5, 2200, 50000--	Virtual Speedway
UNION ALL SELECT 	184	, 5, 2200, 50000--	Virtual Motorsports
UNION ALL SELECT 	185	, 5, 2200, 50000--	Virtual Cycling
UNION ALL SELECT 	186	, 5, 2200, 50000--	Virtual Tennis
UNION ALL SELECT 	190	, 5, 2200, 50000--	Virtual Soccer League
UNION ALL SELECT 	191	, 5, 2200, 50000--	Virtual Soccer Nation
UNION ALL SELECT 	192	, 5, 2200, 50000--	Virtual Soccer World Cup
UNION ALL SELECT 	193	, 5, 2200, 50000--	Virtual Basketball
UNION ALL SELECT 	199	, 5, 2200, 50000--	Virtual Sports Parlay
UNION ALL SELECT 	161	, 10, 6000, 180000--	Number game
UNION ALL SELECT 	164	, 10, 12000, 120000--	Happy 5
UNION ALL SELECT 	202	, 5, 4200, 65000--	RnG Keno
UNION ALL SELECT 	220	, 5, 4200, 65000--	Lottery
UNION ALL SELECT 	224	, 5, 4200, 65000--	RnG War	
UNION ALL SELECT 	222	, 5, 4200, 65000--	Table Game

DECLARE @MaxPerMatch161 MONEY= 180000,
		@MaxPerBall161 MONEY = 60000,
		@MaxPerMatch164 MONEY = 120000
		
WHILE(1=1)
BEGIN
	DELETE @BatchMember
	
	UPDATE TOP (500) t
	SET isfinished = 1
	OUTPUT DELETED.custid, DELETED.roleid INTO @BatchMember(custid,roleid)
	FROM #Downlines t
	WHERE isfinished = 0		
			
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	UPDATE ci
	SET maxpermatch161 = CASE WHEN maxpermatch161 > @maxpermatch161 THEN @maxpermatch161 ELSE maxpermatch161 END,
		MaxPerBall161 = CASE WHEN maxPerBall161 > @maxPerBall161 THEN @maxPerBall161 ELSE maxPerBall161 END,
		maxpermatch164 = CASE WHEN maxpermatch164 > @maxpermatch164	THEN @maxpermatch164 ELSE maxpermatch164 END
	FROM custinfo ci WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @BatchMember)
		AND (maxpermatch161 > @maxpermatch161
			OR MaxPerBall161 > @maxPerBall161
			OR maxpermatch164 > @maxpermatch164				
			)	
				
	UPDATE cs
	SET MaxLossLimit = 500000
	FROM CustWinLimit cs WITH (UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM @BatchMember)
		AND sporttype IN (208) --casino
		AND MaxLossLimit > 500000
	
	IF EXISTS(SELECT 1 FROM @BatchMember WHERE roleid > 1)
	BEGIN
		UPDATE cs 
		SET MaxLossLimit = 500000
		FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE cs.custid IN (SELECT custid FROM @BatchMember WHERE roleid > 1)
			AND sporttype IN (180	,--	Virtual Soccer							
								211	,--	Allbet
								212	,--	Macau Games
								220	,--	Lottery
								222	,--	Table Game
								224	,--	RNG War
								225	,--	ION								
								243	,--	Sexy Gaming
								244	,--	SA Gaming
								245	,--	Virtual Games
								219	,--	Fishing World
								241	--	BBIN
							)	
			AND MaxLossLimit > 500000
		
		UPDATE cs
		SET cs.MinBet = CASE WHEN cs.MinBet > b.MinBet THEN b.MinBet ELSE cs.MinBet END, 
			cs.MaxBet = CASE WHEN cs.MaxBet > b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > b.MaxPerMatch THEN b.MaxPerMatch ELSE cs.MaxPerMatch END		
		FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @BetSetting b ON cs.sporttype = b.sporttype
		WHERE custid IN (SELECT custid FROM @BatchMember WHERE roleid > 1)
			AND b.sporttype IN (180,--Virtual soccer
								181	,--	Virtual Horse Racing
								182	,--	Virtual Greyhounds
								183	,--	Virtual Speedway
								184	,--	Virtual Motorsports
								185	,--	Virtual Cycling
								186	,--	Virtual Tennis
								190	,--	Virtual Soccer League
								191	,--	Virtual Soccer Nation
								192	,--	Virtual Soccer World Cup
								193	,--	Virtual Basketball
								199	,--	Virtual Sports Parlay									
								220	,--	Lottery
								222	,--	Table Game
								224	--	RNG War	
							)
			AND (cs.MinBet > b.MinBet 
				OR cs.MaxBet > b.MaxBet				
				OR cs.MaxPerMatch > b.MaxPerMatch
				)
	END

	IF EXISTS(SELECT 1 FROM @BatchMember WHERE roleid = 1)	
	BEGIN
		--Loss Limit
		UPDATE cs 
		SET MaxLossLimit = 500000
		FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
		WHERE cs.custid IN (SELECT custid FROM @BatchMember WHERE roleid = 1)
			AND sporttype IN (180	,--	Virtual Soccer							
								211	,--	Allbet
								212	,--	Macau Games
								220	,--	Lottery
								222	,--	Table Game
								224	,--	RNG War
								225	,--	ION								
								243	,--	Sexy Gaming
								244	,--	SA Gaming
								245	,--	Virtual Games
								219	,--	Fishing World
								241	--	BBIN
							)	
			AND MaxLossLimit > 500000
		
		--Bet setting
		UPDATE cs
		SET cs.MinBet = CASE WHEN cs.MinBet > b.MinBet THEN b.MinBet ELSE cs.MinBet END, 
			cs.MaxBet = CASE WHEN cs.MaxBet > b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > b.MaxPerMatch THEN b.MaxPerMatch ELSE cs.MaxPerMatch END		
		FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @BetSetting b ON cs.sporttype = b.sporttype
		WHERE custid IN (SELECT custid FROM @BatchMember WHERE roleid = 1)
			AND b.sporttype IN (180,--Virtual soccer
								181	,--	Virtual Horse Racing
								182	,--	Virtual Greyhounds
								183	,--	Virtual Speedway
								184	,--	Virtual Motorsports
								185	,--	Virtual Cycling
								186	,--	Virtual Tennis
								190	,--	Virtual Soccer League
								191	,--	Virtual Soccer Nation
								192	,--	Virtual Soccer World Cup
								193	,--	Virtual Basketball
								199	,--	Virtual Sports Parlay									
								220	,--	Lottery
								222	,--	Table Game
								224	--	RNG War	
							)
			AND (cs.MinBet > b.MinBet 
				OR cs.MaxBet > b.MaxBet				
				OR cs.MaxPerMatch > b.MaxPerMatch
				)
	END
	
	--RnG Keno
	UPDATE cs
	SET cs.MinBet = CASE WHEN cs.MinBet > b.MinBet THEN b.MinBet ELSE cs.MinBet END, 
		cs.MaxBet = CASE WHEN cs.MaxBet > b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END,
		cs.MaxPerGameType = CASE WHEN cs.MaxPerGameType > b.MaxPerMatch THEN b.MaxPerMatch ELSE cs.MaxPerGameType END
	FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)
		CROSS APPLY (SELECT * FROM @BetSetting WHERE sporttype = 202 )b 
	WHERE custid IN (SELECT custid FROM @BatchMember)
		AND cs.GameTypeID BETWEEN 1 AND 26			
		AND (cs.MinBet > b.MinBet 
			OR cs.MaxBet > b.MaxBet
			OR cs.MaxPerGameType > b.MaxPerMatch
			)
	
	--NG, Happy 5
	UPDATE cs
	SET cs.MinBet = CASE WHEN cs.MinBet > b.MinBet THEN b.MinBet ELSE cs.MinBet END, 
		cs.MaxBet = CASE WHEN cs.MaxBet > b.MaxBet THEN b.MaxBet ELSE cs.MaxBet END			
	FROM CustSetting3rd cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @BetSetting b ON cs.sporttype = b.sporttype
	WHERE custid IN (SELECT custid FROM @BatchMember)
		AND b.sporttype IN (161,164)
		AND (cs.MinBet > b.MinBet 
			OR cs.MaxBet > b.MaxBet				
			)
END	


