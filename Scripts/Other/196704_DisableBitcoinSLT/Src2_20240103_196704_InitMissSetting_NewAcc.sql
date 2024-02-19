/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240103@Winfred
	Task: Sitebuilder - Bitcoin/SLT - Enhance the settings when creating a new licensee [#196704]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub

	Step 1 : Initial setting miss Betlimit adjust new customer
*/
------------------------------------------------------
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
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
	
	DECLARE @BatchSize SMALLINT = 5000, @Sporttype INT = 175, @Bettype INT = 7901 
	CREATE TABLE #supers (CustID INT PRIMARY KEY, Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #data(Currency INT,MinBet MONEY, MaxBet MONEY, MaxPerMatch MONEY, IsMinBet BIT,  Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))

	INSERT INTO #supers(custid,Currency)
	SELECT ci.custid,ci.currency
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND ci.custid in ( 88806986,88807001,91143469,94403570,90780173,92131963,91749085,97369913,91607721,92643270,92643349,92643311,92643389,92643200,92643234,92643161,98280850,93082198,100288828,93773878,87336302,87336317,81770426,81770453,81770440,81770480,81770413,86572218,81770400,86572203,81770466,91749679,91218158,91218122,90083405,90083420,103544696,90303510,90303468,90303495,90303481,90303454,84914296,84914309,92267919,97048484,89323941,87065410,91144515,91144528,90075568,94935760,92081162,92081149,95541843,91141721,92133948,92002197,92002164,92002126,92002274,92063609,92002231,92270911,92270877,84858564,91048094,98457072,90835476,98203829,98203867,89595430,88720248,87336492,87336505,105235573,93605710,95930150,97852534,89311296,94167509,89656967,91071766,97698777,91071724,91805745,91805814,91805780,91805634,91805882,91805709,91805917,91805673,92579714,91805848,92579699,92076091,92076125,98208177,92641939,92641868,92641904,88130172,88130136,88129698,88129732,88129913,88129879,88129179,88129144,83464105,83464171,83464138,83463906,83464205,83464005,83464240,83463939,83463972,83464038,83463872,83464072,88131866,88131831,87654243,87654277,88129527,88129560,88129341,88129374,87654092,87654056,89119235,89119222,90320847,90320888,85780955,85780972,90006333,91805033,91805071,90778746,90778708,91807158,92705963,83979426,83979466,89592342,89592414,89592379,89592450,89592308,81721484,81721467,88115690,88801460,82980831,82980818,92576534,105235381,86501833,92759268,96007232,93076149,85790814,86343967,79692808,80876260,85863366,83199185,83199219,84711318,84711332,89806752,89806789,97369423)			  
	ORDER BY ci.custid 
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')
	-------------------------------------Betlimit Setting-----------------------------------------------
	CREATE TABLE #MemberTemp (CustID INT ,Sporttype INT, Bettype INT,MinBet  MONEY, MaxBet MONEY,MaxPerMatch MONEY,isfinished BIT DEFAULT(0), PRIMARY KEY(CustID ,Sporttype, Bettype ))	
	CREATE TABLE #SMATemp  (CustID INT, Sporttype INT, Bettype INT, MinBet  MONEY, MaxBet MONEY,MaxPerMatch MONEY, PRIMARY KEY(CustID ,Sporttype, Bettype ))	
	--Agent Level
	INSERT INTO  #SMATemp (CustID, Sporttype, Bettype, MinBet, MaxBet, MaxPerMatch)
	SELECT CI.custid, d.SportType, d.BetType, d.MinBet,  d.MaxBet, d.MaxPerMatch
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN #supers C WITH (NOLOCK) ON C.custid = CI.srecommend
		INNER JOIN Dep_ProductBetSetting d WITH (NOLOCK) ON c.currency = d.currency AND d.Sporttype = @Sporttype AND d.Bettype = @Bettype
	WHERE ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @maxcustid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO Dep_CustBetSetting_Agent(
		CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch
	FROM #SMATemp t
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM Dep_CustBetSetting_Agent WITH (NOLOCK) 
					  WHERE CustId=t.CustID AND SportType = t.Sporttype AND BetType = t.Bettype)
	
	--Member Level
	INSERT INTO #MemberTemp  (CustID,Sporttype, Bettype, MinBet, MaxBet, MaxPerMatch) 
	SELECT CI.custid, d.SportType, d.BetType, d.MinBet,  d.MaxBet, d.MaxPerMatch 
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN #supers C WITH (NOLOCK) ON C.custid = CI.srecommend
		INNER JOIN Dep_ProductBetSetting d WITH (NOLOCK) ON c.currency = d.currency AND d.Sporttype = @Sporttype AND d.Bettype = @Bettype
	WHERE  ci.roleid IN (1) AND Enabled = 1 AND ci.custid > @maxcustid AND CI.mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	DECLARE @Cust_Temp TABLE(CustID INT, Sporttype INT, Bettype INT, MinBet  MONEY, MaxBet MONEY,MaxPerMatch MONEY,IsMinBet	BIT)
		
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.MinBet,DELETED.MaxBet,DELETED.MaxPerMatch INTO @Cust_Temp(CustID,Sporttype,Bettype,MinBet, MaxBet, MaxPerMatch)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	
		
		INSERT INTO Dep_CustBetSetting_Member(
					 CustID
					,SportType
					,BetType
					,MinBet
					,MaxBet
					,MaxPerMatch
				)
		SELECT t.CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch
		FROM @Cust_Temp t
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM Dep_CustBetSetting_Member WITH (NOLOCK) 
					  WHERE CustId=t.CustID AND SportType = t.Sporttype AND BetType = t.Bettype)

		DELETE FROM @Cust_Temp
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
