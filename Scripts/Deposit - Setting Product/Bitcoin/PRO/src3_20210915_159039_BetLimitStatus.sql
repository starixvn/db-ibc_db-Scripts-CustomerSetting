/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210915
	Task:  Insert Betlimit for Bitcoin - deposit RedmineID:#159039
	DB: DBCUST/CustDB
	
	P/s : Step 2 Insert Betlimit for Bitcoin
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN

	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY,InsBetSetting BIT DEFAULT 0)
	CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY,RoleID INT)

	DECLARE @SportType SMALLINT = 175,@Currency INT,@betType SMALLINT = 7901
	DECLARE @BitOrder INT

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype
	
	SELECT @Currency = currency FROM Custinfo WITH (NOLOCK) WHERE custid = @srecommend
	
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
		AND custid<=@max_custid 

	INSERT INTO #tmpCust(CustID)
	SELECT CustID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

	CREATE TABLE #ProductBetSetting (Currency INT,MinBet	MONEY,MaxBet	MONEY,MaxPerMatch	MONEY,
									SMAMinBet	MONEY,SMAMaxBet	MONEY,SMAMaxPerMatch	MONEY, Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
					
	INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,SMAMinBet,SMAMaxBet,SMAMaxPerMatch)
	SELECT 2 AS Currency ,5 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,5 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --RM
	SELECT 3 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --US$
	SELECT 4 AS Currency ,100 AS MinBet,8000 AS MaxBet,24000 AS MaxPerMatch,100 AS DefaultMinBet,8000 AS DefaultMaxBet,24000 AS DefaultMaxPerMatch  Union ALL --TB
	SELECT 5 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --HK$
	SELECT 6 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS DefaultMinBet,200 AS DefaultMaxBet,600 AS DefaultMaxPerMatch  Union ALL --EURO
	SELECT 7 AS Currency ,25000 AS MinBet,5000000 AS MaxBet,15000000 AS MaxPerMatch,25000 AS DefaultMinBet,5000000 AS DefaultMaxBet,15000000 AS DefaultMaxPerMatch  Union ALL --DON
	SELECT 9 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --AUD
	SELECT 12 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS DefaultMinBet,200 AS DefaultMaxBet,600 AS DefaultMaxPerMatch  Union ALL --GBP
	SELECT 13 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --RMB
	SELECT 15 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS DefaultMinBet,4000 AS DefaultMaxBet,12000 AS DefaultMaxPerMatch  Union ALL --IN
	SELECT 32 AS Currency ,250 AS MinBet,25000 AS MaxBet,75000 AS MaxPerMatch,250 AS DefaultMinBet,25000 AS DefaultMaxBet,75000 AS DefaultMaxPerMatch  Union ALL --JPY
	SELECT 41 AS Currency ,2 AS MinBet,200 AS MaxBet,600 AS MaxPerMatch,2 AS DefaultMinBet,200 AS DefaultMaxBet,600 AS DefaultMaxPerMatch  Union ALL --CHF
	SELECT 42 AS Currency ,120 AS MinBet,12000 AS MaxBet,36000 AS MaxPerMatch,120 AS DefaultMinBet,12000 AS DefaultMaxBet,36000 AS DefaultMaxPerMatch  Union ALL --PE
	SELECT 45 AS Currency ,2500 AS MinBet,300000 AS MaxBet,900000 AS MaxPerMatch,2500 AS DefaultMinBet,300000 AS DefaultMaxBet,900000 AS DefaultMaxPerMatch  Union ALL --Won
	SELECT 46 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --BND
	SELECT 47 AS Currency ,25 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,25 AS SuperMinBet,4000 AS SuperMaxBet,12000 AS SuperMaxPerMatch  Union ALL --DDD
	SELECT 49 AS Currency ,45 AS MinBet,4000 AS MaxBet,12000 AS MaxPerMatch,45 AS DefaultMinBet,4000 AS DefaultMaxBet,12000 AS DefaultMaxPerMatch  Union ALL --MXN
	SELECT 50 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --CAN
	SELECT 51 AS Currency ,25 AS MinBet,5000 AS MaxBet,15000 AS MaxPerMatch,25 AS DefaultMinBet,5000 AS DefaultMaxBet,15000 AS DefaultMaxPerMatch  Union ALL --INH
	SELECT 52 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --DKK
	SELECT 53 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --SEK
	SELECT 54 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --NOK
	SELECT 55 AS Currency ,175 AS MinBet,18000 AS MaxBet,54000 AS MaxPerMatch,175 AS DefaultMinBet,18000 AS DefaultMaxBet,54000 AS DefaultMaxPerMatch  Union ALL --RUB
	SELECT 56 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --PLN
	SELECT 57 AS Currency ,50 AS MinBet,5000 AS MaxBet,15000 AS MaxPerMatch,50 AS DefaultMinBet,5000 AS DefaultMaxBet,15000 AS DefaultMaxPerMatch  Union ALL --CZK
	SELECT 58 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --RON
	SELECT 61 AS Currency ,100 AS MinBet,18000 AS MaxBet,54000 AS MaxPerMatch,100 AS DefaultMinBet,18000 AS DefaultMaxBet,54000 AS DefaultMaxPerMatch  Union ALL --INR
	SELECT 66 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --YUN
	SELECT 70 AS Currency ,4 AS MinBet,360 AS MaxBet,1080 AS MaxPerMatch,4 AS DefaultMinBet,360 AS DefaultMaxBet,1080 AS DefaultMaxPerMatch  Union ALL --MKK
	SELECT 71 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --KHR
	SELECT 73 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --LIR
	SELECT 79 AS Currency ,250 AS MinBet,25000 AS MaxBet,75000 AS MaxPerMatch,250 AS DefaultMinBet,25000 AS DefaultMaxBet,75000 AS DefaultMaxPerMatch  Union ALL --KES
	SELECT 80 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --GHS
	SELECT 82 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --BRL
	SELECT 83 AS Currency ,1700 AS MinBet,170000 AS MaxBet,510000 AS MaxPerMatch,1700 AS DefaultMinBet,170000 AS DefaultMaxBet,510000 AS DefaultMaxPerMatch  Union ALL --CLP
	SELECT 85 AS Currency ,10 AS MinBet,1000 AS MaxBet,3000 AS MaxPerMatch,10 AS DefaultMinBet,1000 AS DefaultMaxBet,3000 AS DefaultMaxPerMatch  Union ALL --PEN
	SELECT 86 AS Currency ,200 AS MinBet,20000 AS MaxBet,60000 AS MaxPerMatch,200 AS DefaultMinBet,20000 AS DefaultMaxBet,60000 AS DefaultMaxPerMatch  Union ALL --ARS
	SELECT 92 AS Currency ,10 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,10 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --HID
	SELECT 93 AS Currency ,15 AS MinBet,2000 AS MaxBet,6000 AS MaxPerMatch,15 AS DefaultMinBet,2000 AS DefaultMaxBet,6000 AS DefaultMaxPerMatch  Union ALL --LAK
	SELECT 94 AS Currency ,4 AS MinBet,360 AS MaxBet,1080 AS MaxPerMatch,4 AS DefaultMinBet,360 AS DefaultMaxBet,1080 AS DefaultMaxPerMatch  Union ALL --MK
	SELECT 96 AS Currency ,3 AS MinBet,300 AS MaxBet,900 AS MaxPerMatch,3 AS DefaultMinBet,300 AS DefaultMaxBet,900 AS DefaultMaxPerMatch  Union ALL --USDT
	SELECT 97 AS Currency ,200 AS MinBet,20000 AS MaxBet,60000 AS MaxPerMatch,200 AS DefaultMinBet,20000 AS DefaultMaxBet,60000 AS DefaultMaxPerMatch  Union ALL --BDT
	SELECT 121 AS Currency ,350 AS MinBet,38000 AS MaxBet,114000 AS MaxPerMatch,350 AS DefaultMinBet,38000 AS DefaultMaxBet,114000 AS DefaultMaxPerMatch  Union ALL --PKR
	SELECT 122 AS Currency ,1000 AS MinBet,100000 AS MaxBet,300000 AS MaxPerMatch,1000 AS DefaultMinBet,100000 AS DefaultMaxBet,300000 AS DefaultMaxPerMatch  Union ALL --KZT
	SELECT 123 AS Currency ,250 AS MinBet,25000 AS MaxBet,75000 AS MaxPerMatch,250 AS DefaultMinBet,25000 AS DefaultMaxBet,75000 AS DefaultMaxPerMatch  Union ALL --NPR
	SELECT 20 AS Currency ,3 AS MinBet,600 AS MaxBet,1800 AS MaxPerMatch,3 AS DefaultMinBet,600 AS DefaultMaxBet,1800 AS DefaultMaxPerMatch  Union ALL --UUS
	SELECT 72 AS Currency ,50 AS MinBet,10000 AS MaxBet,30000 AS MaxPerMatch,50 AS DefaultMinBet,10000 AS DefaultMaxBet,30000 AS DefaultMaxPerMatch    --YNG
		
	-------------------------------------Betlimit Setting----------------------------------------------
	INSERT INTO Dep_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,b.SMAMinBet,b.SMAMaxBet,b.SMAMaxPerMatch
	FROM #tmpSMA t WITH(NOLOCK)
		CROSS APPLY #ProductBetSetting b
	WHERE b.Currency = @Currency
	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #tmpCustTemp
		UPDATE TOP (3000)  t SET t.InsBetSetting = 1 OUTPUT DELETED.CustID INTO #tmpCustTemp(CustID) FROM #tmpCust t WHERE t.InsBetSetting = 0

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
		FROM #tmpCustTemp t WITH(NOLOCK)
			CROSS APPLY #ProductBetSetting b
		WHERE b.Currency = @Currency		
	END

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=114)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,114
	END

	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #tmpSMA SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #tmpCust M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @betType AND PSP.Sporttype = @SportType
		INNER JOIN  #tmpSMA temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @betType AND PSP.Sporttype = @SportType
		INNER JOIN  #tmpCust temp ON temp.CustID = c.custid

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

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid=@srecommend AND ProductSettingID=113)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,113
	END

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers
	DROP TABLE #tmpCustTemp
	DROP TABLE #ProductBetSetting
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','Unobet','Bolanation')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20,72)))
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	
	
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @max_custid=@max_custid,@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO

-- END STEP 2: Run this SP at replicated DB: DB06, DBTP -----
-----------------------------------------------------------------------------------
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','Unobet','Bolanation')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20,72)))
ORDER BY ci.custid 


DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
		
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend,@max_custid=@max_custid,@target = 'DBCUST'
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO		


-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------
