/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20230910
	Task: Bitcoin - Change Bet Limit setting for newly created customer [Redmine: 193730]
	DB: DBCUST/CustDB
	P/s : Step 2 Change Bet Limit for newly created customer
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_11]
	@MaxCustID INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN

	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;
	CREATE TABLE #supers (custid int)
	
	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.Site NOT IN ('CN88')
		AND ci.currency IN ( 2, 5, 13, 15, 22, 33, 34, 43, 47, 51, 67) --RM, TB, HK$, RMB, IN, IND, IDD, IDR, THB, DDD, INH, INR, YUN, HKK
	
	CREATE TABLE #MemberTemp ( CustID INT PRIMARY KEY CLUSTERED,Currency INT)
	CREATE TABLE #MemberTempIns ( CustID INT PRIMARY KEY CLUSTERED , Currency INT )
	CREATE TABLE #SMATemp ( CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT , Currency INT)

	INSERT INTO #MemberTemp (CustID , Currency )
	SELECT custid , currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid, Currency)
	SELECT custid, roleid, currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 
	
	CREATE TABLE #ProductBetSetting (Currency INT,MinBet	MONEY,MaxBet	MONEY,MaxPerMatch	MONEY,
									SuperMinBet	MONEY,SuperMaxBet	MONEY,SuperMaxPerMatch	MONEY, IsUpdMinBet BIT,  Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
					
	INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,SuperMinBet,SuperMaxBet,SuperMaxPerMatch,IsUpdMinBet)
	SELECT 2 AS Currency ,5 AS MinBet,500 AS MaxBet,500 AS MaxPerMatch,5 AS SuperMinBet,500 AS SuperMaxBet,500  AS SuperMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- RM
	SELECT 5 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch,10 AS SuperMinBet,1000 AS SuperMaxBet,1000  AS SuperMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- HK$
	SELECT 13 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch,10 AS SuperMinBet,1000 AS SuperMaxBet,1000  AS SuperMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- RMB
	SELECT 15 AS Currency ,10 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,10 AS SuperMinBet,2500 AS SuperMaxBet,2500  AS SuperMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- IN
	SELECT 22 AS Currency ,25 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,10 AS SuperMinBet,2500 AS SuperMaxBet,2500  AS SuperMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- IND
	SELECT 33 AS Currency ,25 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,10 AS SuperMinBet,2500 AS SuperMaxBet,2500  AS SuperMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- IDD
	SELECT 34 AS Currency ,25 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,10 AS SuperMinBet,2500 AS SuperMaxBet,2500  AS SuperMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- IDR
	SELECT 43 AS Currency ,50 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch,50 AS SuperMinBet,5000 AS SuperMaxBet,5000  AS SuperMaxPerMatch, 1 As IsUpdMinBet UNION ALL   -- THB
	SELECT 47 AS Currency ,25 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch,25 AS SuperMinBet,2500 AS SuperMaxBet,2500  AS SuperMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- DDD
	SELECT 51 AS Currency ,25 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch,25 AS SuperMinBet,5000 AS SuperMaxBet,5000  AS SuperMaxPerMatch, 0 As IsUpdMinBet UNION ALL   -- INH
	SELECT 67 AS Currency ,5 AS MinBet,500 AS MaxBet,500 AS MaxPerMatch,5 AS SuperMinBet,500 AS SuperMaxBet,500  AS SuperMaxPerMatch, 0 As IsUpdMinBet    -- HKK

	--------------------------------------Bet Setting-------------------------------------------------
	
	--SMA level
	UPDATE cs
	SET cs.MinBet = CASE WHEN ps.IsUpdMinBet = 1 
							THEN ps.MinBet 
							ELSE (CASE WHEN cs.MinBet > ps.MaxBet THEN ps.MaxBet ELSE cs.MinBet END) END ,
		cs.MaxBet = CASE WHEN cs.MaxBet > ps.MaxBet THEN ps.MaxBet ELSE cs.MaxBet END,
		cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch > ps.MaxPerMatch THEN ps.MaxPerMatch ELSE cs.MaxPerMatch END		
	FROM dbo.CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #SMATemp ci ON cs.CustID = ci.CustID
		INNER JOIN #ProductBetSetting ps ON cs.SportType = ps.Sporttype AND cs.BetType = ps.Bettype AND ps.Currency = ci.Currency

	DECLARE @tmpCustHistory TABLE(custid INT,Currency INT, sporttype SMALLINT, bettype SMALLINT, MaxBet MONEY, MaxPerMatch MONEY, UpdateTime DATETIME PRIMARY KEY(custid,sporttype,bettype))
	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns
		DELETE TOP (3000) t 
		OUTPUT DELETED.CustID, DELETED.Currency 
		INTO #MemberTempIns(CustID,Currency)
		FROM #MemberTemp t 
		
		IF @@ROWCOUNT=0
			BREAK
			
		--Member Level	
		UPDATE cs
		SET cs.MinBet = CASE WHEN ps.IsUpdMinBet = 1 
							THEN ps.MinBet 
							ELSE (CASE WHEN cs.MinBet > ps.MaxBet THEN ps.MaxBet ELSE cs.MinBet END) END ,
			cs.MaxBet = CASE WHEN cs.MaxBet >  ps.MaxBet  THEN ps.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch >  ps.MaxPerMatch  THEN ps.MaxPerMatch ELSE cs.MaxPerMatch END	
		OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype, DELETED.MaxBet, DELETED.MaxPerMatch, ci.Currency, GETDATE()
		INTO @tmpCustHistory(custid,sporttype,bettype,maxbet,MaxPerMatch,Currency,UpdateTime)
		FROM dbo.CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #MemberTempIns ci ON cs.CustID = ci.CustID
			INNER JOIN #ProductBetSetting ps ON cs.SportType = ps.Sporttype AND cs.BetType = ps.Bettype AND ps.Currency = ci.Currency
		
		DELETE cs 
		FROM @tmpCustHistory cs 
			INNER JOIN #ProductBetSetting c ON cs.SportType = c.SportType AND cs.BetType = c.BetType AND c.Currency = cs.Currency
		WHERE cs.MaxBet <= c.MaxBet AND cs.MaxPerMatch <= c.MaxPerMatch 

		IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE') 
		BEGIN
			INSERT INTO CustMaxBetSetting_History 
				(CustID, SportType, BetType, OldMaxBet, OldMaxPerMatch, OldStakeLevelList, UpdateTime)
			SELECT CustID, SportType, BetType, MaxBet, MaxPerMatch, NULL StakeLevelList, UpdateTime
			FROM @tmpCustHistory c	
		END
		DELETE FROM @tmpCustHistory
	END


	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #ProductBetSetting
	DROP TABLE #MemberTempIns
END
GO
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_DynamicCustSetting3rd_11 @MaxCustID=@MaxCustID