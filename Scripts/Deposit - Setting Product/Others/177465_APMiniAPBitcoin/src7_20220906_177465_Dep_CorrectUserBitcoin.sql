/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20220907
	Task:	 Delete redundant and add new setting newly created customer for Bitcoin RedmineID:#159039
	DB:		 DBCUST/CustDB
	P/s : Step 6 Delete redundant and add new setting newly created customer Bitcoin
*/
USE [CustDB]
GO
-----------------------------------------------------
	PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

	DECLARE @SportType SMALLINT = 175,@betType SMALLINT = 7901
	DECLARE @BitOrder INT 

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype	
	
	CREATE TABLE #supers (custid int)

	CREATE TABLE #Member
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,InsBetSetting BIT DEFAULT 0
	   ,mrecommend INT
	)
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	   ,Currency INT
	   ,mrecommend INT
	)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN('Baji')

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

	INSERT INTO #Member(CustID,mrecommend,Currency)
	SELECT custid, mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid IN (49144188,51058808)
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	--DELETE existing data

	CREATE TABLE #ProductBetSetting (Currency INT,MinBet	MONEY,MaxBet	MONEY,MaxPerMatch	MONEY,
									SMAMinBet	MONEY,SMAMaxBet	MONEY,SMAMaxPerMatch	MONEY, Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
					
	INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,SMAMinBet,SMAMaxBet,SMAMaxPerMatch)
	SELECT 97 AS Currency ,200 AS MinBet,20000 AS MaxBet,60000 AS MaxPerMatch,200 AS DefaultMinBet,20000 AS DefaultMaxBet,60000 AS DefaultMaxPerMatch   --BDT
		
	-------------------------------------------------BetSetting----------------------------------------------------------------

	SELECT a.CustID,a.SportType,a.BetType
	INTO #Dep_CustBetSetting_Member 
	FROM Dep_CustBetSetting_Member a WITH(NOLOCK) 
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE SportType = @SportType AND BetType = @betType	
	
	DELETE cg
	FROM Dep_CustBetSetting_Member cg WITH(ROWLOCK,UPDLOCK)
		INNER  JOIN #Dep_CustBetSetting_Member t
			ON cg.CustID=t.CustID AND cg.SportType=t.SportType AND cg.BetType=t.Bettype 

-------------------------------------------------Add new Betlimit Setting----------------------------------------------------------------
	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTemp
		UPDATE TOP (3000)  t SET t.InsBetSetting = 1 OUTPUT DELETED.CustID,deleted.Currency INTO #MemberTemp(CustID,Currency) FROM #Member t WHERE t.InsBetSetting = 0

		IF @@ROWCOUNT=0
			BREAK

		INSERT INTO Dep_CustBetSetting_Member(
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		)
		SELECT t.CustID,b.SportType,b.BetType,b.MinBet,b.MaxBet,b.MaxPerMatch
		FROM #MemberTemp t WITH(NOLOCK)
			CROSS APPLY #ProductBetSetting b
		WHERE b.Currency = t.Currency	
	END


	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT M.CustID FROM #Member M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #Member temp ON temp.CustID = c.custid

	DECLARE @batch int = 3000
	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID,deleted.bitmapIsHidden,deleted.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	DROP TABLE #supers
	DROP TABLE #Dummy
	DROP TABLE #MemberTemp
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers