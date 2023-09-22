/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20230910
	Task:	 Bitcoin - Change Bet Limit for licensees newly created customer  RedmineID:#193730
	DB:		 DBCUST/CustDB
*/
-- BEGIN STEP 2.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	(@maxcustID INT)
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #supers (CustID INT PRIMARY KEY, Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #data(Currency INT,MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, IsMinBet BIT,  Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
	CREATE TABLE #History_BetLimitTbl (CustID INT, SportType SMALLINT, BetType SMALLINT, MaxBet	MONEY
		, MaxPerMatch MONEY, UpdateTime DATETIME)

	INSERT INTO #data(Currency, MinBet, MaxBet, MaxPerMatch, IsMinBet)
	SELECT 2  AS Currency ,5 AS MinBet,500 AS MaxBet,500 AS MaxPerMatch, 0 As IsUpdMinBet		UNION ALL   -- RM
	SELECT 4  AS Currency ,50 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch, 1 As IsUpdMinBet	UNION ALL   -- TB
	SELECT 5  AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- HK$
	SELECT 13 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- RMB
	SELECT 15 AS Currency ,10 AS MinBet,2500 AS MaxBet,2500 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- IN
	SELECT 51 AS Currency ,25 AS MinBet,5000 AS MaxBet,5000 AS MaxPerMatch, 0 As IsUpdMinBet	UNION ALL   -- INH
	SELECT 61 AS Currency ,50 AS MinBet,15000 AS MaxBet,15000 AS MaxPerMatch, 1 As IsUpdMinBet	UNION ALL   -- INR
	SELECT 66 AS Currency ,10 AS MinBet,1000 AS MaxBet,1000 AS MaxPerMatch, 0 As IsUpdMinBet	

	INSERT INTO #supers(custid,Currency)
	SELECT ci.custid,ci.currency
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND ci.currency in (2,4,5,13,15,51,61,66) -- RM, TB, HK$, RMB, IN, INH, INR, YUN				  
	ORDER BY ci.custid 
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')
	-------------------------------------Betlimit Setting-----------------------------------------------
	CREATE TABLE #MemberTemp (CustID INT ,Sporttype INT, Bettype INT,MinBet  MONEY, MaxBet MONEY,MaxPerMatch MONEY,IsMinBet	BIT,isfinished BIT DEFAULT(0), PRIMARY KEY(CustID ,Sporttype, Bettype ))	
	CREATE TABLE #SMATemp  (CustID INT, Sporttype INT, Bettype INT, MinBet  MONEY, MaxBet MONEY,MaxPerMatch MONEY,IsMinBet	BIT, PRIMARY KEY(CustID ,Sporttype, Bettype ))	
	--Agent Level
	INSERT INTO  #SMATemp (CustID, Sporttype, Bettype, MinBet, MaxBet, MaxPerMatch, IsMinBet)
	SELECT CI.custid, d.SportType, d.BetType, d.MinBet,  d.MaxBet, d.MaxPerMatch , d.IsMinBet
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN #supers C WITH (NOLOCK) ON C.custid = CI.srecommend
		INNER JOIN #data d WITH (NOLOCK) ON c.currency = d.currency
	WHERE ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @maxcustid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	UPDATE dca 
	SET dca.MinBet= CASE WHEN c.IsMinBet = 1 
							THEN c.MinBet 
							ELSE (CASE WHEN dca.MinBet > c.MaxBet THEN c.MaxBet ELSE dca.MinBet END) END,
		dca.MaxBet= CASE WHEN dca.MaxBet > c.MaxBet THEN c.MaxBet ELSE dca.MaxBet END, 
		dca.MaxPerMatch= CASE WHEN dca.MaxPerMatch > c.MaxPerMatch THEN c.MaxPerMatch ELSE dca.MaxPerMatch END
	FROM Dep_CustBetSetting_Agent dca WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #SMATemp c ON dca.CustID = c.CustID AND dca.SportType = c.SportType AND dca.BetType = c.BetType
	
	--Member Level
	INSERT INTO #MemberTemp  (CustID,Sporttype, Bettype, MinBet, MaxBet, MaxPerMatch, IsMinBet) 
	SELECT CI.custid, d.SportType, d.BetType, d.MinBet,  d.MaxBet, d.MaxPerMatch , d.IsMinBet
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN #supers C WITH (NOLOCK) ON C.custid = CI.srecommend
		INNER JOIN #data d WITH (NOLOCK) ON c.currency = d.currency
	WHERE  ci.roleid IN (1) AND Enabled = 1 AND ci.custid > @maxcustid AND CI.mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	DECLARE @Cust_Temp TABLE(CustID INT, Sporttype INT, Bettype INT, MinBet  MONEY, MaxBet MONEY,MaxPerMatch MONEY,IsMinBet	BIT)
	DECLARE @BatchSize SMALLINT = 5000
	
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.MinBet,DELETED.MaxBet,DELETED.MaxPerMatch,DELETED.IsMinBet INTO @Cust_Temp(CustID,Sporttype,Bettype,MinBet, MaxBet, MaxPerMatch, IsMinBet)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	
		
		UPDATE dca 
		SET dca.MinBet= CASE WHEN c.IsMinBet = 1 
							THEN c.MinBet 
							ELSE (CASE WHEN dca.MinBet > c.MaxBet THEN c.MaxBet ELSE dca.MinBet END) END,
				dca.MaxBet= CASE WHEN dca.MaxBet > c.MaxBet THEN c.MaxBet ELSE dca.MaxBet END, 
				dca.MaxPerMatch= CASE WHEN dca.MaxPerMatch > c.MaxPerMatch THEN c.MaxPerMatch ELSE dca.MaxPerMatch END
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType, deleted.MaxBet, deleted.MaxPerMatch, GETDATE()
		INTO #History_BetLimitTbl(CustID, SportType, BetType, MaxBet, MaxPerMatch, UpdateTime)
		FROM Dep_CustBetSetting_Member dca WITH (ROWLOCK, UPDLOCK)
			INNER JOIN @Cust_Temp c ON dca.CustID = c.CustID AND dca.SportType = c.SportType AND dca.BetType = c.BetType
		
		DELETE cs 
		FROM #History_BetLimitTbl cs 
			INNER JOIN @Cust_Temp c ON cs.CustID = c.CustID AND cs.SportType = c.SportType AND cs.BetType = c.BetType
		WHERE cs.MaxBet <= c.MaxBet AND cs.MaxPerMatch <= c.MaxPerMatch
		
		IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE') 
		BEGIN
			INSERT INTO Dep_CustMaxBetSetting_History (CustID, SportType, BetType, OldMaxBet, OldMaxPerMatch, OldStakeLevelList, UpdateTime)
			SELECT CustID, SportType, BetType, MaxBet, MaxPerMatch, NULL, UpdateTime
			FROM #History_BetLimitTbl
		END 

		DELETE FROM @Cust_Temp
		TRUNCATE TABLE #History_BetLimitTbl
	END

	DROP TABLE #supers
	DROP TABLE #Dummy
	DROP TABLE #MemberTemp
	DROP TABLE #SMATemp
	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
END
GO
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
