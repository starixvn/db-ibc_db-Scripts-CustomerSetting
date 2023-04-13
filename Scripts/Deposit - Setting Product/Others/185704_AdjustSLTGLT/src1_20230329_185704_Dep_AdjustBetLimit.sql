/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230328
	Task: [Sports Lottery - Table Game - Lottery] Adjust betlimit for licensees RedmineID:#185704
	DB: DBCUST/CustDB
	
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX) 	= ''
	,@srecommend INT
 	,@RoleID INT = 0
 	,@BetLimit VARCHAR(MAX)
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
			    
	INSERT INTO #CustList(custid)	
	SELECT VALUE AS RuleID 
	FROM STRING_SPLIT(@CustIDs,',') WHERE VALUE <> ''
	
	DECLARE @batch SMALLINT = 5000, @iDoc INT, @SportType SMALLINT, @BetType SMALLINT,@MaxBet MONEY,           
			 @MaxPerMatch 	MONEY
	DECLARE @SportBetType TABLE
	(
		ProductID SMALLINT,
		SportType SMALLINT, 
		BetType   SMALLINT,
		MaxBet	  MONEY,
		MaxPerMatch	MONEY,
		isfinished BIT DEFAULT(0)
	)
	
	BEGIN TRY
		EXECUTE	sp_xml_preparedocument	@iDoc OUTPUT,	@BetLimit;

		INSERT INTO @SportBetType(ProductID, SportType, BetType, MaxBet, MaxPerMatch) 
		SELECT	Data.ProductID   				
			 ,	Data.SportType 					    
			 ,	Data.BetType 					    
			 ,	Data.MaxBet 					    
			 ,	Data.MaxPerMatch
		FROM OPENXML (@iDoc, '/Root/BL', 1) 
		WITH (
			 ProductID  SMALLINT,           
			 SportType 	SMALLINT,           
			 BetType 	SMALLINT,           
			 MaxBet 	MONEY,           
			 MaxPerMatch 	MONEY
		) AS Data;

		EXECUTE	sp_xml_removedocument	@iDoc;
	END TRY
	BEGIN CATCH		
		RETURN
	END CATCH

	WHILE(1 =1)
	BEGIN
		UPDATE TOP (1) c
		SET c.isfinished = 1,
			@SportType = c.SportType,
			@BetType = c.BetType,
			@MaxBet = c.MaxBet,
			@MaxPerMatch = c.MaxPerMatch
		FROM @SportBetType c 
		WHERE isfinished = 0
			
		IF @@ROWCOUNT = 0 BREAK
		-- SMA LEVEL
		IF @RoleID <>1
		BEGIN
			WHILE(1 =1)
			BEGIN
			
				UPDATE TOP (@batch) c WITH (ROWLOCK)
				SET c.isfinished = 1
				OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
				FROM #CustList c 
				WHERE isfinished = 0
			
				IF @@ROWCOUNT = 0 BREAK
				-------------------------------------Betlimit Setting----------------------------------------------	
				UPDATE dca 
				SET dca.MinBet= CASE WHEN dca.MinBet > @MaxBet THEN @MaxBet ELSE dca.MinBet END,
					dca.MaxBet=@MaxBet, dca.MaxPerMatch=@MaxPerMatch
				FROM Dep_CustBetSetting_Agent dca WITH (ROWLOCK, UPDLOCK)
					INNER JOIN #CustListTemp c ON dca.CustID = c.CustID AND dca.SportType = @SportType 
								AND dca.BetType = @BetType
			
				TRUNCATE TABLE #CustListTemp
			END
		END	
	
		IF @RoleID  = 1
		BEGIN
			WHILE(1 = 1)
			BEGIN
			
				UPDATE TOP (@batch) c WITH (ROWLOCK)
				SET c.isfinished = 1
				OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
				FROM #CustList c 
				WHERE isfinished = 0
			
				IF @@ROWCOUNT = 0 BREAK
				-------------------------------------Betlimit Setting----------------------------------------------
				UPDATE dca 
				SET dca.MinBet= CASE WHEN dca.MinBet > @MaxBet THEN @MaxBet ELSE dca.MinBet END,
					dca.MaxBet=@MaxBet, dca.MaxPerMatch=@MaxPerMatch
				FROM Dep_CustBetSetting_Member dca WITH (ROWLOCK, UPDLOCK)
					INNER JOIN #CustListTemp c ON dca.CustID = c.CustID AND dca.SportType = @SportType 
								AND dca.BetType = @BetType

				TRUNCATE TABLE #CustListTemp
			END 	
		END
	END

	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers			(CustID INT PRIMARY KEY, Currency INT, site VARCHAR(20),isfinished BIT DEFAULT(0))
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpBetLimit		(Site VARCHAR(50),Currency INT,BetLimit VARCHAR(MAX))
CREATE CLUSTERED INDEX CIX_tmpBetLimit ON #tmpBetLimit(Site, currency)

DECLARE @batch SMALLINT = 20000
DECLARE @CustIDs VARCHAR(MAX) 
DECLARE @max_custid INT, @srecommend INT , @currency INT , @Role SMALLINT = 0 , @site VARCHAR(20) , @BetLimit VARCHAR(MAX)
SELECT @max_custid = xxx

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
BEGIN
	SET @target = 'DBCUST'
END
ELSE 
BEGIN	
	SET @target = 'REPLICATED'
END
PRINT 'Server Name : ' + @target

INSERT INTO #tmpBetLimit(Site,Currency,BetLimit)
		  SELECT '12Bet' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT '12Bet' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '12Bet' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT '12Bet' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '12Bet' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT '12Bet' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT '12Bet' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT '12Bet' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT '12Bet' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT '12Bet' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT '12Bet' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT '12Bet' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT '12Bet' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT '12Bet' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT '12Bet' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT '12Bet' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT '12Bet' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT '12Bet' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT '12Bet' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '12Bet' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT '12Bet' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT '12Bet' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '12Bet' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '12Bet' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '12Bet' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT '12Bet' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT '12Bet' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT '365online' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT '365online' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '365online' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT '365online' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '365online' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT '365online' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT '365online' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT '365online' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT '365online' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT '365online' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT '365online' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT '365online' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT '365online' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT '365online' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT '365online' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT '365online' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT '365online' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT '365online' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT '365online' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '365online' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT '365online' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT '365online' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '365online' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '365online' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '365online' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT '365online' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT '365online' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT '368Cash' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT '368Cash' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '368Cash' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT '368Cash' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '368Cash' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT '368Cash' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT '368Cash' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT '368Cash' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT '368Cash' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT '368Cash' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT '368Cash' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT '368Cash' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT '368Cash' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT '368Cash' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT '368Cash' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT '368Cash' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT '368Cash' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT '368Cash' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT '368Cash' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '368Cash' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT '368Cash' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT '368Cash' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '368Cash' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '368Cash' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '368Cash' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT '368Cash' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT '368Cash' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT '3star88' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT '3star88' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '3star88' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT '3star88' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '3star88' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT '3star88' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT '3star88' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT '3star88' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT '3star88' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT '3star88' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT '3star88' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT '3star88' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT '3star88' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT '3star88' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT '3star88' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT '3star88' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT '3star88' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT '3star88' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT '3star88' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '3star88' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT '3star88' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT '3star88' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '3star88' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '3star88' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '3star88' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT '3star88' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT '3star88' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT '9bet' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT '9bet' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '9bet' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT '9bet' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '9bet' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT '9bet' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT '9bet' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT '9bet' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT '9bet' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT '9bet' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT '9bet' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT '9bet' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT '9bet' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT '9bet' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT '9bet' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT '9bet' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT '9bet' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT '9bet' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT '9bet' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '9bet' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT '9bet' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT '9bet' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT '9bet' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT '9bet' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT '9bet' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT '9bet' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT '9bet' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'A1game' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'A1game' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'A1game' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'A1game' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'A1game' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'A1game' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'A1game' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'A1game' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'A1game' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'A1game' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'A1game' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'A1game' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'A1game' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'A1game' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'A1game' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'A1game' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'A1game' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'A1game' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'A1game' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'A1game' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'A1game' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'A1game' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'A1game' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'A1game' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'A1game' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'A1game' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'A1game' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Ae88' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Ae88' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Ae88' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Ae88' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Ae88' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Ae88' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Ae88' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Ae88' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Ae88' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Ae88' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Ae88' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Ae88' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Ae88' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Ae88' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Ae88' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Ae88' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Ae88' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Ae88' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Ae88' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Ae88' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Ae88' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Ae88' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Ae88' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Ae88' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Ae88' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Ae88' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Ae88' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'AEUG' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'AEUG' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'AEUG' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'AEUG' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'AEUG' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'AEUG' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'AEUG' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'AEUG' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'AEUG' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'AEUG' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'AEUG' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'AEUG' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'AEUG' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'AEUG' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'AEUG' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'AEUG' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'AEUG' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'AEUG' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'AEUG' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'AEUG' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'AEUG' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'AEUG' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'AEUG' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'AEUG' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'AEUG' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'AEUG' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'AEUG' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ALPHA88' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ALPHA88' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ALPHA88' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ALPHA88' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ALPHA88' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ALPHA88' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ALPHA88' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ALPHA88' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ALPHA88' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ALPHA88' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ALPHA88' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ALPHA88' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ALPHA88' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ALPHA88' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ALPHA88' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ALPHA88' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ALPHA88' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ALPHA88' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ALPHA88' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ALPHA88' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ALPHA88' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ALPHA88' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ALPHA88' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ALPHA88' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ALPHA88' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ALPHA88' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ALPHA88' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Aoncash' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Aoncash' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Aoncash' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Aoncash' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Aoncash' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Aoncash' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Aoncash' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Aoncash' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Aoncash' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Aoncash' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Aoncash' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Aoncash' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Aoncash' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Aoncash' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Aoncash' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Aoncash' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Aoncash' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Aoncash' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Aoncash' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Aoncash' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Aoncash' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Aoncash' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Aoncash' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Aoncash' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Aoncash' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Aoncash' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Aoncash' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'B24VN' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'B24VN' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'B24VN' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'B24VN' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'B24VN' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'B24VN' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'B24VN' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'B24VN' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'B24VN' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'B24VN' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'B24VN' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'B24VN' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'B24VN' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'B24VN' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'B24VN' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'B24VN' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'B24VN' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'B24VN' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'B24VN' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'B24VN' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'B24VN' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'B24VN' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'B24VN' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'B24VN' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'B24VN' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'B24VN' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'B24VN' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'B8KRW' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'B8KRW' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'B8KRW' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'B8KRW' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'B8KRW' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'B8KRW' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'B8KRW' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'B8KRW' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'B8KRW' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'B8KRW' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'B8KRW' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'B8KRW' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'B8KRW' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'B8KRW' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'B8KRW' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'B8KRW' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'B8KRW' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'B8KRW' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'B8KRW' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'B8KRW' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'B8KRW' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'B8KRW' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'B8KRW' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'B8KRW' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'B8KRW' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'B8KRW' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'B8KRW' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'bdtt' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'bdtt' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'bdtt' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'bdtt' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'bdtt' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'bdtt' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'bdtt' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'bdtt' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'bdtt' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'bdtt' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'bdtt' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'bdtt' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'bdtt' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'bdtt' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'bdtt' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'bdtt' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'bdtt' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'bdtt' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'bdtt' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'bdtt' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'bdtt' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'bdtt' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'bdtt' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'bdtt' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'bdtt' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'bdtt' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'bdtt' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'beplay' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'beplay' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'beplay' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'beplay' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'beplay' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'beplay' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'beplay' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'beplay' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'beplay' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'beplay' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'beplay' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'beplay' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'beplay' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'beplay' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'beplay' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'beplay' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'beplay' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'beplay' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'beplay' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'beplay' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'beplay' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'beplay' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'beplay' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'beplay' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'beplay' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'beplay' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'beplay' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'BigGaming' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'BigGaming' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'BigGaming' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'BigGaming' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'BigGaming' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'BigGaming' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'BigGaming' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'BigGaming' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'BigGaming' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'BigGaming' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'BigGaming' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'BigGaming' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'BigGaming' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'BigGaming' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'BigGaming' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'BigGaming' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'BigGaming' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'BigGaming' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'BigGaming' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'BigGaming' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'BigGaming' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'BigGaming' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'BigGaming' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'BigGaming' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'BigGaming' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'BigGaming' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'BigGaming' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Bolanation' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Bolanation' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Bolanation' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Bolanation' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Bolanation' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Bolanation' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Bolanation' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Bolanation' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Bolanation' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Bolanation' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Bolanation' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Bolanation' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Bolanation' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Bolanation' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Bolanation' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Bolanation' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Bolanation' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Bolanation' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Bolanation' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Bolanation' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Bolanation' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Bolanation' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Bolanation' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Bolanation' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Bolanation' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Bolanation' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Bolanation' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Bonanza88' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Bonanza88' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Bonanza88' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Bonanza88' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Bonanza88' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Bonanza88' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Bonanza88' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Bonanza88' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Bonanza88' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Bonanza88' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Bonanza88' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Bonanza88' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Bonanza88' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Bonanza88' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Bonanza88' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Bonanza88' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Bonanza88' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Bonanza88' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Bonanza88' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Bonanza88' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Bonanza88' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Bonanza88' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Bonanza88' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Bonanza88' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Bonanza88' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Bonanza88' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Bonanza88' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'BPLE' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'BPLE' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'BPLE' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'BPLE' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'BPLE' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'BPLE' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'BPLE' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'BPLE' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'BPLE' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'BPLE' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'BPLE' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'BPLE' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'BPLE' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'BPLE' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'BPLE' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'BPLE' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'BPLE' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'BPLE' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'BPLE' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'BPLE' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'BPLE' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'BPLE' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'BPLE' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'BPLE' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'BPLE' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'BPLE' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'BPLE' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'CGame4' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'CGame4' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'CGame4' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'CGame4' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'CGame4' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'CGame4' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'CGame4' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'CGame4' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'CGame4' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'CGame4' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'CGame4' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'CGame4' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'CGame4' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'CGame4' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'CGame4' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'CGame4' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'CGame4' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'CGame4' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'CGame4' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'CGame4' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'CGame4' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'CGame4' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'CGame4' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'CGame4' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'CGame4' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'CGame4' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'CGame4' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'DEWA' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'DEWA' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'DEWA' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'DEWA' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'DEWA' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'DEWA' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'DEWA' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'DEWA' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'DEWA' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'DEWA' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'DEWA' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'DEWA' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'DEWA' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'DEWA' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'DEWA' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'DEWA' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'DEWA' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'DEWA' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'DEWA' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'DEWA' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'DEWA' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'DEWA' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'DEWA' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'DEWA' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'DEWA' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'DEWA' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'DEWA' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'DMsports' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'DMsports' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'DMsports' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'DMsports' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'DMsports' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'DMsports' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'DMsports' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'DMsports' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'DMsports' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'DMsports' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'DMsports' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'DMsports' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'DMsports' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'DMsports' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'DMsports' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'DMsports' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'DMsports' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'DMsports' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'DMsports' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'DMsports' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'DMsports' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'DMsports' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'DMsports' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'DMsports' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'DMsports' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'DMsports' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'DMsports' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'DongYing' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'DongYing' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'DongYing' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'DongYing' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'DongYing' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'DongYing' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'DongYing' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'DongYing' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'DongYing' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'DongYing' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'DongYing' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'DongYing' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'DongYing' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'DongYing' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'DongYing' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'DongYing' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'DongYing' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'DongYing' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'DongYing' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'DongYing' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'DongYing' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'DongYing' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'DongYing' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'DongYing' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'DongYing' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'DongYing' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'DongYing' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'e8casino' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'e8casino' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'e8casino' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'e8casino' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'e8casino' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'e8casino' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'e8casino' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'e8casino' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'e8casino' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'e8casino' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'e8casino' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'e8casino' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'e8casino' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'e8casino' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'e8casino' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'e8casino' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'e8casino' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'e8casino' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'e8casino' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'e8casino' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'e8casino' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'e8casino' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'e8casino' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'e8casino' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'e8casino' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'e8casino' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'e8casino' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ECLBET' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ECLBET' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ECLBET' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ECLBET' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ECLBET' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ECLBET' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ECLBET' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ECLBET' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ECLBET' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ECLBET' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ECLBET' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ECLBET' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ECLBET' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ECLBET' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ECLBET' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ECLBET' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ECLBET' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ECLBET' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ECLBET' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ECLBET' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ECLBET' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ECLBET' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ECLBET' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ECLBET' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ECLBET' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ECLBET' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ECLBET' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'erhaozhan' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'erhaozhan' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'erhaozhan' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'erhaozhan' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'erhaozhan' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'erhaozhan' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'erhaozhan' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'erhaozhan' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'erhaozhan' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'erhaozhan' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'erhaozhan' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'erhaozhan' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'erhaozhan' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'erhaozhan' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'erhaozhan' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'erhaozhan' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'erhaozhan' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'erhaozhan' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'erhaozhan' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'erhaozhan' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'erhaozhan' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'erhaozhan' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'erhaozhan' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'erhaozhan' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'erhaozhan' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'erhaozhan' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'erhaozhan' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'FB88' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'FB88' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'FB88' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'FB88' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'FB88' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'FB88' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'FB88' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'FB88' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'FB88' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'FB88' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'FB88' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'FB88' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'FB88' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'FB88' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'FB88' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'FB88' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'FB88' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'FB88' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'FB88' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'FB88' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'FB88' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'FB88' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'FB88' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'FB88' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'FB88' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'FB88' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'FB88' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'FHLMSABA' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'FHLMSABA' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'FHLMSABA' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'FHLMSABA' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'FHLMSABA' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'FHLMSABA' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'FHLMSABA' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'FHLMSABA' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'FHLMSABA' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'FHLMSABA' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'FHLMSABA' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'FHLMSABA' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'FHLMSABA' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'FHLMSABA' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'FHLMSABA' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'FHLMSABA' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'FHLMSABA' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'FHLMSABA' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'FHLMSABA' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'FHLMSABA' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'FHLMSABA' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'FHLMSABA' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'FHLMSABA' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'FHLMSABA' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'FHLMSABA' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'FHLMSABA' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'FHLMSABA' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'GAMEBee' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'GAMEBee' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'GAMEBee' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'GAMEBee' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'GAMEBee' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'GAMEBee' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'GAMEBee' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'GAMEBee' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'GAMEBee' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'GAMEBee' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'GAMEBee' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'GAMEBee' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'GAMEBee' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'GAMEBee' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'GAMEBee' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'GAMEBee' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'GAMEBee' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'GAMEBee' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'GAMEBee' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'GAMEBee' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'GAMEBee' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'GAMEBee' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'GAMEBee' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'GAMEBee' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'GAMEBee' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'GAMEBee' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'GAMEBee' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Gampag' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Gampag' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Gampag' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Gampag' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Gampag' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Gampag' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Gampag' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Gampag' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Gampag' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Gampag' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Gampag' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Gampag' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Gampag' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Gampag' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Gampag' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Gampag' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Gampag' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Gampag' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Gampag' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Gampag' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Gampag' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Gampag' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Gampag' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Gampag' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Gampag' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Gampag' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Gampag' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Gaobet' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Gaobet' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Gaobet' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Gaobet' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Gaobet' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Gaobet' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Gaobet' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Gaobet' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Gaobet' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Gaobet' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Gaobet' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Gaobet' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Gaobet' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Gaobet' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Gaobet' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Gaobet' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Gaobet' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Gaobet' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Gaobet' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Gaobet' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Gaobet' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Gaobet' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Gaobet' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Gaobet' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Gaobet' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Gaobet' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Gaobet' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'GBET' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'GBET' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'GBET' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'GBET' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'GBET' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'GBET' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'GBET' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'GBET' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'GBET' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'GBET' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'GBET' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'GBET' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'GBET' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'GBET' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'GBET' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'GBET' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'GBET' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'GBET' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'GBET' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'GBET' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'GBET' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'GBET' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'GBET' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'GBET' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'GBET' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'GBET' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'GBET' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'GMASTER' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'GMASTER' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'GMASTER' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'GMASTER' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'GMASTER' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'GMASTER' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'GMASTER' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'GMASTER' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'GMASTER' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'GMASTER' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'GMASTER' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'GMASTER' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'GMASTER' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'GMASTER' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'GMASTER' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'GMASTER' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'GMASTER' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'GMASTER' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'GMASTER' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'GMASTER' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'GMASTER' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'GMASTER' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'GMASTER' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'GMASTER' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'GMASTER' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'GMASTER' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'GMASTER' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'GoldenF2' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'GoldenF2' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'GoldenF2' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'GoldenF2' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'GoldenF2' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'GoldenF2' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'GoldenF2' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'GoldenF2' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'GoldenF2' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'GoldenF2' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'GoldenF2' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'GoldenF2' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'GoldenF2' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'GoldenF2' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'GoldenF2' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'GoldenF2' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'GoldenF2' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'GoldenF2' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'GoldenF2' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'GoldenF2' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'GoldenF2' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'GoldenF2' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'GoldenF2' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'GoldenF2' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'GoldenF2' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'GoldenF2' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'GoldenF2' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Hecbet' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Hecbet' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Hecbet' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Hecbet' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Hecbet' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Hecbet' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Hecbet' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Hecbet' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Hecbet' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Hecbet' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Hecbet' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Hecbet' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Hecbet' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Hecbet' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Hecbet' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Hecbet' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Hecbet' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Hecbet' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Hecbet' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Hecbet' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Hecbet' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Hecbet' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Hecbet' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Hecbet' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Hecbet' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Hecbet' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Hecbet' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'HFTH' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'HFTH' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'HFTH' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'HFTH' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'HFTH' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'HFTH' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'HFTH' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'HFTH' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'HFTH' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'HFTH' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'HFTH' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'HFTH' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'HFTH' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'HFTH' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'HFTH' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'HFTH' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'HFTH' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'HFTH' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'HFTH' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'HFTH' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'HFTH' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'HFTH' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'HFTH' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'HFTH' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'HFTH' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'HFTH' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'HFTH' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'iBET' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'iBET' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'iBET' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'iBET' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'iBET' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'iBET' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'iBET' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'iBET' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'iBET' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'iBET' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'iBET' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'iBET' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'iBET' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'iBET' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'iBET' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'iBET' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'iBET' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'iBET' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'iBET' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'iBET' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'iBET' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'iBET' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'iBET' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'iBET' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'iBET' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'iBET' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'iBET' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'IBO' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'IBO' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'IBO' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'IBO' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'IBO' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'IBO' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'IBO' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'IBO' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'IBO' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'IBO' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'IBO' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'IBO' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'IBO' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'IBO' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'IBO' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'IBO' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'IBO' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'IBO' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'IBO' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'IBO' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'IBO' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'IBO' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'IBO' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'IBO' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'IBO' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'IBO' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'IBO' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ID88' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ID88' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ID88' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ID88' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ID88' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ID88' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ID88' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ID88' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ID88' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ID88' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ID88' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ID88' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ID88' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ID88' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ID88' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ID88' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ID88' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ID88' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ID88' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ID88' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ID88' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ID88' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ID88' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ID88' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ID88' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ID88' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ID88' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'INSERTGAME' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'INSERTGAME' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'INSERTGAME' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'INSERTGAME' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'INSERTGAME' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'INSERTGAME' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'INSERTGAME' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'INSERTGAME' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'INSERTGAME' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'INSERTGAME' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'INSERTGAME' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'INSERTGAME' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'INSERTGAME' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'INSERTGAME' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'INSERTGAME' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'INSERTGAME' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'INSERTGAME' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'INSERTGAME' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'INSERTGAME' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'INSERTGAME' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'INSERTGAME' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'INSERTGAME' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'INSERTGAME' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'INSERTGAME' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'INSERTGAME' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'INSERTGAME' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'INSERTGAME' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ITCbet' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ITCbet' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ITCbet' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ITCbet' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ITCbet' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ITCbet' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ITCbet' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ITCbet' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ITCbet' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ITCbet' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ITCbet' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ITCbet' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ITCbet' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ITCbet' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ITCbet' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ITCbet' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ITCbet' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ITCbet' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ITCbet' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ITCbet' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ITCbet' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ITCbet' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ITCbet' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ITCbet' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ITCbet' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ITCbet' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ITCbet' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Jiuyou' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Jiuyou' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Jiuyou' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Jiuyou' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Jiuyou' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Jiuyou' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Jiuyou' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Jiuyou' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Jiuyou' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Jiuyou' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Jiuyou' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Jiuyou' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Jiuyou' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Jiuyou' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Jiuyou' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Jiuyou' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Jiuyou' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Jiuyou' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Jiuyou' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Jiuyou' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Jiuyou' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Jiuyou' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Jiuyou' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Jiuyou' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Jiuyou' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Jiuyou' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Jiuyou' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'KzingP88' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'KzingP88' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'KzingP88' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'KzingP88' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'KzingP88' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'KzingP88' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'KzingP88' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'KzingP88' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'KzingP88' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'KzingP88' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'KzingP88' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'KzingP88' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'KzingP88' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'KzingP88' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'KzingP88' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'KzingP88' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'KzingP88' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'KzingP88' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'KzingP88' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'KzingP88' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'KzingP88' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'KzingP88' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'KzingP88' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'KzingP88' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'KzingP88' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'KzingP88' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'KzingP88' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'LEIHUO' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'LEIHUO' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'LEIHUO' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'LEIHUO' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'LEIHUO' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'LEIHUO' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'LEIHUO' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'LEIHUO' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'LEIHUO' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'LEIHUO' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'LEIHUO' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'LEIHUO' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'LEIHUO' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'LEIHUO' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'LEIHUO' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'LEIHUO' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'LEIHUO' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'LEIHUO' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'LEIHUO' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'LEIHUO' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'LEIHUO' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'LEIHUO' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'LEIHUO' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'LEIHUO' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'LEIHUO' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'LEIHUO' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'LEIHUO' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Leng4D' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Leng4D' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Leng4D' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Leng4D' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Leng4D' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Leng4D' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Leng4D' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Leng4D' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Leng4D' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Leng4D' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Leng4D' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Leng4D' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Leng4D' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Leng4D' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Leng4D' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Leng4D' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Leng4D' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Leng4D' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Leng4D' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Leng4D' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Leng4D' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Leng4D' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Leng4D' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Leng4D' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Leng4D' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Leng4D' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Leng4D' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'LIGAWLHKB' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'LIGAWLHKB' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'LIGAWLHKB' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'LIGAWLHKB' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'LIGAWLHKB' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'LIGAWLHKB' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'LIGAWLHKB' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'LIGAWLHKB' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'LIGAWLHKB' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'LIGAWLHKB' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'LIGAWLHKB' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'LIGAWLHKB' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'LIGAWLHKB' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'LIGAWLHKB' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'LIGAWLHKB' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'LIGAWLHKB' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'LIGAWLHKB' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'LIGAWLHKB' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'LIGAWLHKB' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'LIGAWLHKB' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'LIGAWLHKB' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'LIGAWLHKB' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'LIGAWLHKB' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'LIGAWLHKB' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'LIGAWLHKB' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'LIGAWLHKB' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'LIGAWLHKB' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Lode88' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Lode88' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Lode88' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Lode88' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Lode88' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Lode88' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Lode88' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Lode88' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Lode88' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Lode88' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Lode88' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Lode88' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Lode88' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Lode88' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Lode88' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Lode88' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Lode88' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Lode88' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Lode88' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Lode88' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Lode88' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Lode88' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Lode88' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Lode88' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Lode88' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Lode88' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Lode88' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'M8bola' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'M8bola' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'M8bola' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'M8bola' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'M8bola' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'M8bola' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'M8bola' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'M8bola' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'M8bola' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'M8bola' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'M8bola' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'M8bola' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'M8bola' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'M8bola' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'M8bola' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'M8bola' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'M8bola' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'M8bola' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'M8bola' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'M8bola' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'M8bola' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'M8bola' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'M8bola' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'M8bola' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'M8bola' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'M8bola' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'M8bola' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Macaubet' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Macaubet' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Macaubet' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Macaubet' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Macaubet' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Macaubet' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Macaubet' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Macaubet' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Macaubet' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Macaubet' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Macaubet' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Macaubet' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Macaubet' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Macaubet' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Macaubet' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Macaubet' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Macaubet' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Macaubet' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Macaubet' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Macaubet' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Macaubet' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Macaubet' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Macaubet' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Macaubet' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Macaubet' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Macaubet' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Macaubet' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'MANBETX' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'MANBETX' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'MANBETX' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'MANBETX' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'MANBETX' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'MANBETX' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'MANBETX' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'MANBETX' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'MANBETX' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'MANBETX' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'MANBETX' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'MANBETX' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'MANBETX' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'MANBETX' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'MANBETX' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'MANBETX' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'MANBETX' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'MANBETX' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'MANBETX' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'MANBETX' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'MANBETX' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'MANBETX' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'MANBETX' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'MANBETX' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'MANBETX' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'MANBETX' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'MANBETX' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Mancity2' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Mancity2' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Mancity2' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Mancity2' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Mancity2' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Mancity2' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Mancity2' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Mancity2' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Mancity2' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Mancity2' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Mancity2' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Mancity2' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Mancity2' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Mancity2' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Mancity2' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Mancity2' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Mancity2' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Mancity2' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Mancity2' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Mancity2' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Mancity2' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Mancity2' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Mancity2' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Mancity2' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Mancity2' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Mancity2' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Mancity2' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Mayayule' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Mayayule' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Mayayule' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Mayayule' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Mayayule' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Mayayule' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Mayayule' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Mayayule' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Mayayule' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Mayayule' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Mayayule' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Mayayule' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Mayayule' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Mayayule' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Mayayule' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Mayayule' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Mayayule' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Mayayule' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Mayayule' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Mayayule' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Mayayule' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Mayayule' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Mayayule' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Mayayule' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Mayayule' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Mayayule' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Mayayule' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Mopgaming' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Mopgaming' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Mopgaming' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Mopgaming' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Mopgaming' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Mopgaming' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Mopgaming' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Mopgaming' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Mopgaming' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Mopgaming' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Mopgaming' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Mopgaming' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Mopgaming' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Mopgaming' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Mopgaming' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Mopgaming' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Mopgaming' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Mopgaming' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Mopgaming' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Mopgaming' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Mopgaming' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Mopgaming' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Mopgaming' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Mopgaming' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Mopgaming' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Mopgaming' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Mopgaming' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'MTech' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'MTech' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'MTech' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'MTech' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'MTech' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'MTech' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'MTech' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'MTech' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'MTech' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'MTech' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'MTech' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'MTech' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'MTech' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'MTech' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'MTech' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'MTech' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'MTech' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'MTech' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'MTech' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'MTech' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'MTech' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'MTech' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'MTech' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'MTech' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'MTech' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'MTech' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'MTech' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'N8BK' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'N8BK' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'N8BK' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'N8BK' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'N8BK' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'N8BK' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'N8BK' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'N8BK' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'N8BK' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'N8BK' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'N8BK' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'N8BK' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'N8BK' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'N8BK' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'N8BK' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'N8BK' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'N8BK' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'N8BK' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'N8BK' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'N8BK' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'N8BK' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'N8BK' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'N8BK' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'N8BK' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'N8BK' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'N8BK' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'N8BK' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'NewFuture' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'NewFuture' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'NewFuture' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'NewFuture' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'NewFuture' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'NewFuture' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'NewFuture' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'NewFuture' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'NewFuture' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'NewFuture' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'NewFuture' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'NewFuture' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'NewFuture' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'NewFuture' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'NewFuture' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'NewFuture' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'NewFuture' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'NewFuture' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'NewFuture' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'NewFuture' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'NewFuture' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'NewFuture' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'NewFuture' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'NewFuture' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'NewFuture' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'NewFuture' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'NewFuture' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'OCMS' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'OCMS' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'OCMS' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'OCMS' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'OCMS' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'OCMS' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'OCMS' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'OCMS' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'OCMS' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'OCMS' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'OCMS' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'OCMS' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'OCMS' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'OCMS' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'OCMS' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'OCMS' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'OCMS' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'OCMS' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'OCMS' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'OCMS' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'OCMS' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'OCMS' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'OCMS' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'OCMS' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'OCMS' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'OCMS' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'OCMS' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Ot88' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Ot88' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Ot88' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Ot88' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Ot88' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Ot88' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Ot88' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Ot88' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Ot88' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Ot88' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Ot88' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Ot88' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Ot88' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Ot88' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Ot88' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Ot88' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Ot88' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Ot88' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Ot88' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Ot88' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Ot88' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Ot88' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Ot88' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Ot88' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Ot88' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Ot88' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Ot88' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Raisetech' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Raisetech' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Raisetech' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Raisetech' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Raisetech' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Raisetech' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Raisetech' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Raisetech' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Raisetech' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Raisetech' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Raisetech' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Raisetech' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Raisetech' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Raisetech' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Raisetech' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Raisetech' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Raisetech' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Raisetech' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Raisetech' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Raisetech' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Raisetech' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Raisetech' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Raisetech' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Raisetech' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Raisetech' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Raisetech' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Raisetech' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Rakyat4DSW' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Rakyat4DSW' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Rakyat4DSW' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Rakyat4DSW' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Rakyat4DSW' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Rakyat4DSW' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Rakyat4DSW' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Rakyat4DSW' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Rakyat4DSW' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Rakyat4DSW' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Rakyat4DSW' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Rakyat4DSW' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Rakyat4DSW' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Rakyat4DSW' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Rakyat4DSW' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Rakyat4DSW' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Rakyat4DSW' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Rakyat4DSW' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Rakyat4DSW' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Rakyat4DSW' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Rakyat4DSW' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Rakyat4DSW' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Rakyat4DSW' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Rakyat4DSW' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Rakyat4DSW' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Rakyat4DSW' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Rakyat4DSW' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'SKY1688' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'SKY1688' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'SKY1688' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'SKY1688' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'SKY1688' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'SKY1688' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'SKY1688' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'SKY1688' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'SKY1688' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'SKY1688' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'SKY1688' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'SKY1688' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'SKY1688' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'SKY1688' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'SKY1688' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'SKY1688' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'SKY1688' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'SKY1688' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'SKY1688' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'SKY1688' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'SKY1688' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'SKY1688' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'SKY1688' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'SKY1688' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'SKY1688' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'SKY1688' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'SKY1688' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'SM88' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'SM88' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'SM88' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'SM88' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'SM88' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'SM88' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'SM88' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'SM88' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'SM88' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'SM88' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'SM88' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'SM88' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'SM88' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'SM88' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'SM88' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'SM88' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'SM88' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'SM88' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'SM88' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'SM88' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'SM88' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'SM88' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'SM88' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'SM88' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'SM88' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'SM88' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'SM88' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Sunriseb2b' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Sunriseb2b' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Sunriseb2b' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Sunriseb2b' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Sunriseb2b' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Sunriseb2b' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Sunriseb2b' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Sunriseb2b' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Sunriseb2b' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Sunriseb2b' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Sunriseb2b' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Sunriseb2b' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Sunriseb2b' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Sunriseb2b' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Sunriseb2b' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Sunriseb2b' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Sunriseb2b' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Sunriseb2b' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Sunriseb2b' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Sunriseb2b' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Sunriseb2b' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Sunriseb2b' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Sunriseb2b' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Sunriseb2b' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Sunriseb2b' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Sunriseb2b' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Sunriseb2b' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Sunwin' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Sunwin' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Sunwin' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Sunwin' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Sunwin' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Sunwin' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Sunwin' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Sunwin' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Sunwin' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Sunwin' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Sunwin' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Sunwin' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Sunwin' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Sunwin' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Sunwin' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Sunwin' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Sunwin' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Sunwin' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Sunwin' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Sunwin' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Sunwin' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Sunwin' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Sunwin' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Sunwin' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Sunwin' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Sunwin' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Sunwin' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'TCbet' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'TCbet' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'TCbet' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'TCbet' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'TCbet' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'TCbet' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'TCbet' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'TCbet' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'TCbet' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'TCbet' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'TCbet' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'TCbet' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'TCbet' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'TCbet' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'TCbet' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'TCbet' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'TCbet' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'TCbet' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'TCbet' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'TCbet' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'TCbet' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'TCbet' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'TCbet' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'TCbet' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'TCbet' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'TCbet' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'TCbet' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'txwl002' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'txwl002' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'txwl002' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'txwl002' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'txwl002' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'txwl002' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'txwl002' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'txwl002' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'txwl002' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'txwl002' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'txwl002' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'txwl002' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'txwl002' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'txwl002' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'txwl002' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'txwl002' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'txwl002' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'txwl002' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'txwl002' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'txwl002' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'txwl002' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'txwl002' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'txwl002' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'txwl002' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'txwl002' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'txwl002' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'txwl002' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'V03' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'V03' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'V03' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'V03' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'V03' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'V03' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'V03' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'V03' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'V03' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'V03' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'V03' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'V03' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'V03' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'V03' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'V03' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'V03' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'V03' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'V03' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'V03' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'V03' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'V03' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'V03' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'V03' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'V03' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'V03' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'V03' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'V03' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'VFUN88' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'VFUN88' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'VFUN88' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'VFUN88' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'VFUN88' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'VFUN88' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'VFUN88' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'VFUN88' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'VFUN88' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'VFUN88' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'VFUN88' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'VFUN88' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'VFUN88' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'VFUN88' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'VFUN88' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'VFUN88' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'VFUN88' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'VFUN88' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'VFUN88' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'VFUN88' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'VFUN88' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'VFUN88' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'VFUN88' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'VFUN88' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'VFUN88' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'VFUN88' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'VFUN88' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'VN88' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'VN88' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'VN88' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'VN88' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'VN88' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'VN88' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'VN88' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'VN88' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'VN88' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'VN88' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'VN88' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'VN88' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'VN88' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'VN88' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'VN88' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'VN88' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'VN88' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'VN88' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'VN88' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'VN88' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'VN88' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'VN88' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'VN88' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'VN88' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'VN88' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'VN88' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'VN88' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'vssports' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'vssports' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'vssports' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'vssports' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'vssports' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'vssports' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'vssports' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'vssports' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'vssports' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'vssports' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'vssports' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'vssports' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'vssports' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'vssports' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'vssports' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'vssports' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'vssports' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'vssports' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'vssports' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'vssports' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'vssports' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'vssports' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'vssports' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'vssports' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'vssports' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'vssports' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'vssports' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'W88' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'W88' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'W88' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'W88' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'W88' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'W88' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'W88' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'W88' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'W88' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'W88' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'W88' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'W88' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'W88' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'W88' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'W88' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'W88' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'W88' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'W88' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'W88' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'W88' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'W88' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'W88' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'W88' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'W88' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'W88' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'W88' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'W88' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'WKPHIL' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'WKPHIL' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'WKPHIL' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'WKPHIL' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'WKPHIL' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'WKPHIL' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'WKPHIL' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'WKPHIL' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'WKPHIL' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'WKPHIL' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'WKPHIL' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'WKPHIL' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'WKPHIL' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'WKPHIL' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'WKPHIL' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'WKPHIL' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'WKPHIL' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'WKPHIL' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'WKPHIL' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'WKPHIL' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'WKPHIL' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'WKPHIL' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'WKPHIL' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'WKPHIL' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'WKPHIL' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'WKPHIL' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'WKPHIL' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'wmcasino' AS Site, 2 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'wmcasino' AS Site, 3 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'wmcasino' AS Site, 4 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'wmcasino' AS Site, 5 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'wmcasino' AS Site, 6 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'wmcasino' AS Site, 7 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'wmcasino' AS Site, 12 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'wmcasino' AS Site, 13 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'wmcasino' AS Site, 15 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'wmcasino' AS Site, 32 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'wmcasino' AS Site, 41 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'wmcasino' AS Site, 42 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'wmcasino' AS Site, 45 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'wmcasino' AS Site, 46 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'wmcasino' AS Site, 51 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'wmcasino' AS Site, 55 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'wmcasino' AS Site, 56 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'wmcasino' AS Site, 61 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'wmcasino' AS Site, 70 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'wmcasino' AS Site, 71 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'wmcasino' AS Site, 82 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'wmcasino' AS Site, 92 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'wmcasino' AS Site, 94 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'wmcasino' AS Site, 96 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'wmcasino' AS Site, 97 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'wmcasino' AS Site, 121 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'wmcasino' AS Site, 123 AS Currency, '<Root><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'WRServices' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'WRServices' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'WRServices' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'WRServices' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'WRServices' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'WRServices' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'WRServices' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'WRServices' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'WRServices' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'WRServices' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'WRServices' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'WRServices' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'WRServices' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'WRServices' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'WRServices' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'WRServices' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'WRServices' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'WRServices' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'WRServices' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'WRServices' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'WRServices' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'WRServices' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'WRServices' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'WRServices' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'WRServices' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'WRServices' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'WRServices' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Xinbo' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Xinbo' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Xinbo' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Xinbo' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Xinbo' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Xinbo' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Xinbo' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Xinbo' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Xinbo' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Xinbo' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Xinbo' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Xinbo' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Xinbo' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Xinbo' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Xinbo' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Xinbo' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Xinbo' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Xinbo' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Xinbo' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Xinbo' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Xinbo' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Xinbo' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Xinbo' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Xinbo' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Xinbo' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Xinbo' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Xinbo' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Yibo' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Yibo' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Yibo' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Yibo' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Yibo' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Yibo' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Yibo' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Yibo' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Yibo' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Yibo' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Yibo' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Yibo' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="7500.0000" MaxPerMatch="37000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Yibo' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Yibo' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Yibo' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Yibo' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Yibo' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Yibo' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="50000.0000" MaxPerMatch="250000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Yibo' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Yibo' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Yibo' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Yibo' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="5000.0000" MaxPerMatch="25000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Yibo' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="750.0000" MaxPerMatch="3700.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Yibo' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Yibo' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Yibo' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Yibo' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/><BL ProductID="40" SportType="222" BetType="4901" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'YSYBO688' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'YSYBO688' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'YSYBO688' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'YSYBO688' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'YSYBO688' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'YSYBO688' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'YSYBO688' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'YSYBO688' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'YSYBO688' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'YSYBO688' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'YSYBO688' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'YSYBO688' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'YSYBO688' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'YSYBO688' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'YSYBO688' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'YSYBO688' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'YSYBO688' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'YSYBO688' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'YSYBO688' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'YSYBO688' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'YSYBO688' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'YSYBO688' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'YSYBO688' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'YSYBO688' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'YSYBO688' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'YSYBO688' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'YSYBO688' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZF026' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZF026' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF026' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZF026' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF026' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZF026' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZF026' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZF026' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZF026' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZF026' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZF026' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZF026' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZF026' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZF026' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZF026' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZF026' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZF026' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZF026' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZF026' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF026' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZF026' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZF026' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF026' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF026' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF026' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZF026' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZF026' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZF138THB' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZF138THB' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF138THB' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZF138THB' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF138THB' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZF138THB' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZF138THB' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZF138THB' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZF138THB' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZF138THB' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZF138THB' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZF138THB' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZF138THB' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZF138THB' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZF138THB' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZF138THB' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZF138THB' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZF138THB' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZF138THB' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF138THB' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZF138THB' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZF138THB' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF138THB' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF138THB' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF138THB' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZF138THB' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZF138THB' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZF138USD' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZF138USD' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF138USD' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZF138USD' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF138USD' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZF138USD' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZF138USD' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZF138USD' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZF138USD' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZF138USD' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZF138USD' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZF138USD' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZF138USD' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZF138USD' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZF138USD' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZF138USD' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZF138USD' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZF138USD' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZF138USD' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF138USD' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZF138USD' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZF138USD' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF138USD' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF138USD' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF138USD' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZF138USD' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZF138USD' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZF138VND' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZF138VND' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF138VND' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZF138VND' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF138VND' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZF138VND' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZF138VND' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZF138VND' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZF138VND' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZF138VND' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZF138VND' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZF138VND' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZF138VND' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZF138VND' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZF138VND' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZF138VND' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZF138VND' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZF138VND' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZF138VND' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF138VND' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZF138VND' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZF138VND' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF138VND' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF138VND' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF138VND' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZF138VND' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZF138VND' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZF215aTR' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZF215aTR' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF215aTR' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZF215aTR' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF215aTR' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZF215aTR' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZF215aTR' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZF215aTR' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZF215aTR' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZF215aTR' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZF215aTR' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZF215aTR' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZF215aTR' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZF215aTR' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZF215aTR' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZF215aTR' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZF215aTR' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZF215aTR' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZF215aTR' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF215aTR' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZF215aTR' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZF215aTR' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZF215aTR' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZF215aTR' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZF215aTR' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZF215aTR' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZF215aTR' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT126' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT126' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT126' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT126' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT126' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT126' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT126' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT126' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT126' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT126' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT126' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT126' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT126' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT126' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT126' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT126' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT126' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT126' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT126' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT126' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT126' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT126' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT126' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT126' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT126' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT126' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT126' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT132' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT132' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT132' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT132' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT132' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT132' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT132' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT132' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT132' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT132' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT132' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT132' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT132' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT132' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT132' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT132' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT132' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT132' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT132' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT132' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT132' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT132' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT132' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT132' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT132' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT132' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT132' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT144' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT144' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT144' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT144' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT144' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT144' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT144' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT144' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT144' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT144' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT144' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT144' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT144' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT144' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT144' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT144' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT144' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT144' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT144' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT144' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT144' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT144' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT144' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT144' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT144' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT144' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT144' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT151' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT151' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT151' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT151' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT151' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT151' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT151' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT151' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT151' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT151' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT151' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT151' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT151' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT151' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT151' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT151' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT151' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT151' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT151' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT151' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT151' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT151' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT151' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT151' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT151' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT151' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT151' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT166' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT166' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT166' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT166' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT166' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT166' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT166' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT166' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT166' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT166' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT166' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT166' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT166' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT166' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT166' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT166' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT166' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT166' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT166' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT166' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT166' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT166' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT166' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT166' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT166' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT166' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT166' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT179' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT179' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT179' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT179' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT179' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT179' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT179' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT179' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT179' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT179' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT179' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT179' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT179' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT179' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT179' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT179' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT179' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT179' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT179' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT179' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT179' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT179' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT179' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT179' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT179' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT179' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT179' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT186' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT186' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT186' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT186' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT186' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT186' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT186' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT186' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT186' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT186' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT186' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT186' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT186' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT186' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT186' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT186' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT186' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT186' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT186' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT186' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT186' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT186' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT186' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT186' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT186' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT186' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT186' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT195' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT195' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT195' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT195' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT195' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT195' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT195' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT195' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT195' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT195' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT195' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT195' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT195' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT195' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT195' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT195' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT195' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT195' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT195' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT195' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT195' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT195' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT195' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT195' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT195' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT195' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT195' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT213' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT213' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT213' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT213' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT213' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT213' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT213' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT213' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT213' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT213' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT213' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT213' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT213' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT213' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT213' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT213' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT213' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT213' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT213' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT213' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT213' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT213' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT213' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT213' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT213' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT213' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT213' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT218' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT218' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT218' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT218' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT218' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT218' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT218' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT218' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT218' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT218' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT218' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT218' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT218' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT218' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT218' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT218' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT218' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT218' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT218' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT218' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT218' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT218' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT218' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT218' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT218' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT218' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT218' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT276' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT276' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT276' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT276' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT276' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT276' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT276' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT276' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT276' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT276' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT276' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT276' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT276' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT276' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT276' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT276' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT276' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT276' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT276' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT276' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT276' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT276' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT276' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT276' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT276' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT276' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT276' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZFRT282' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZFRT282' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT282' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZFRT282' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT282' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZFRT282' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZFRT282' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZFRT282' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZFRT282' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZFRT282' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZFRT282' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZFRT282' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZFRT282' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZFRT282' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZFRT282' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZFRT282' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZFRT282' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZFRT282' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZFRT282' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT282' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZFRT282' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZFRT282' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZFRT282' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZFRT282' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZFRT282' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZFRT282' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZFRT282' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng009' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng009' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng009' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng009' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng009' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng009' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng009' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng009' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng009' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng009' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng009' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng009' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng009' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng009' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng009' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng009' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng009' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng009' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng009' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng009' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng009' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng009' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng009' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng009' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng009' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng009' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng009' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng012' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng012' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng012' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng012' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng012' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng012' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng012' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng012' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng012' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng012' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng012' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng012' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng012' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng012' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng012' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng012' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng012' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng012' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng012' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng012' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng012' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng012' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng012' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng012' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng012' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng012' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng012' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng021' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng021' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng021' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng021' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng021' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng021' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng021' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng021' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng021' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng021' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng021' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng021' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng021' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng021' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng021' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng021' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng021' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng021' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng021' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng021' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng021' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng021' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng021' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng021' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng021' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng021' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng021' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng032' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng032' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng032' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng032' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng032' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng032' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng032' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng032' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng032' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng032' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng032' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng032' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng032' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng032' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng032' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng032' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng032' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng032' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng032' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng032' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng032' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng032' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng032' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng032' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng032' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng032' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng032' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng035' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng035' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng035' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng035' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng035' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng035' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng035' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng035' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng035' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng035' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng035' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng035' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng035' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng035' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng035' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng035' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng035' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng035' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng035' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng035' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng035' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng035' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng035' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng035' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng035' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng035' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng035' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng036' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng036' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng036' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng036' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng036' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng036' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng036' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng036' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng036' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng036' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng036' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng036' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng036' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng036' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng036' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng036' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng036' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng036' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng036' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng036' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng036' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng036' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng036' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng036' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng036' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng036' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng036' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng040' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng040' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng040' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng040' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng040' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng040' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng040' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng040' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng040' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng040' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng040' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng040' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng040' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng040' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng040' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng040' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng040' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng040' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng040' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng040' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng040' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng040' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng040' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng040' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng040' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng040' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng040' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng041' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng041' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng041' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng041' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng041' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng041' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng041' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng041' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng041' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng041' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng041' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng041' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng041' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng041' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng041' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng041' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng041' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng041' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng041' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng041' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng041' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng041' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng041' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng041' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng041' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng041' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng041' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng147' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng147' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng147' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng147' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng147' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng147' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng147' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng147' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng147' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng147' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng147' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng147' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng147' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng147' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng147' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng147' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng147' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng147' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng147' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng147' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng147' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng147' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng147' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng147' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng147' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng147' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng147' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng176' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng176' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng176' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng176' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng176' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng176' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng176' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng176' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng176' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng176' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng176' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng176' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng176' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng176' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng176' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng176' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng176' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng176' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng176' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng176' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng176' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng176' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng176' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng176' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng176' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng176' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng176' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng222' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng222' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng222' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng222' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng222' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng222' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng222' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng222' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng222' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng222' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng222' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng222' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng222' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng222' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng222' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng222' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng222' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng222' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng222' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng222' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng222' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng222' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng222' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng222' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng222' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng222' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng222' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng228' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng228' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng228' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng228' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng228' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng228' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng228' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng228' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng228' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng228' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng228' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng228' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng228' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng228' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng228' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng228' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng228' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng228' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng228' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng228' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng228' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng228' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng228' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng228' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng228' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng228' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng228' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng229' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng229' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng229' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng229' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng229' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng229' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng229' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng229' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng229' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng229' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng229' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng229' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng229' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng229' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng229' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng229' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng229' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng229' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng229' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng229' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng229' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng229' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng229' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng229' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng229' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng229' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng229' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'ZhiFeng258' AS Site, 2 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'ZhiFeng258' AS Site, 3 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng258' AS Site, 4 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'ZhiFeng258' AS Site, 5 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng258' AS Site, 6 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'ZhiFeng258' AS Site, 7 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'ZhiFeng258' AS Site, 12 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'ZhiFeng258' AS Site, 13 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'ZhiFeng258' AS Site, 15 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'ZhiFeng258' AS Site, 32 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'ZhiFeng258' AS Site, 41 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'ZhiFeng258' AS Site, 42 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'ZhiFeng258' AS Site, 45 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'ZhiFeng258' AS Site, 46 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'ZhiFeng258' AS Site, 51 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'ZhiFeng258' AS Site, 55 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'ZhiFeng258' AS Site, 56 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'ZhiFeng258' AS Site, 61 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'ZhiFeng258' AS Site, 70 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng258' AS Site, 71 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'ZhiFeng258' AS Site, 82 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'ZhiFeng258' AS Site, 92 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'ZhiFeng258' AS Site, 94 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'ZhiFeng258' AS Site, 96 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'ZhiFeng258' AS Site, 97 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'ZhiFeng258' AS Site, 121 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'ZhiFeng258' AS Site, 123 AS Currency, '<Root><BL ProductID="63" SportType="169" BetType="3611" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'Zowin' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'Zowin' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Zowin' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'Zowin' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Zowin' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'Zowin' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000000.0000" MaxPerMatch="30000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'Zowin' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'Zowin' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'Zowin' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'Zowin' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'Zowin' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'Zowin' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="3700.0000" MaxPerMatch="18000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'Zowin' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="250000.0000" MaxPerMatch="1200000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'Zowin' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'Zowin' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'Zowin' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="6000.0000" MaxPerMatch="30000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'Zowin' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'Zowin' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'Zowin' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Zowin' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'Zowin' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'Zowin' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'Zowin' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="370.0000" MaxPerMatch="1800.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'Zowin' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="600.0000" MaxPerMatch="3000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'Zowin' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="10000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'Zowin' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'Zowin' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --NPR
UNION ALL SELECT 'zt828' AS Site, 2 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="2500.0000" MaxPerMatch="12000.0000"/></Root>' AS BetLimit      --RM
UNION ALL SELECT 'zt828' AS Site, 3 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'zt828' AS Site, 4 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --TB
UNION ALL SELECT 'zt828' AS Site, 5 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'zt828' AS Site, 6 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --EURO
UNION ALL SELECT 'zt828' AS Site, 7 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000000.0000" MaxPerMatch="60000000.0000"/></Root>' AS BetLimit      --DON
UNION ALL SELECT 'zt828' AS Site, 12 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --GBP
UNION ALL SELECT 'zt828' AS Site, 13 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --RMB
UNION ALL SELECT 'zt828' AS Site, 15 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --IN
UNION ALL SELECT 'zt828' AS Site, 32 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --JPY
UNION ALL SELECT 'zt828' AS Site, 41 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --CHF
UNION ALL SELECT 'zt828' AS Site, 42 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="7500.0000" MaxPerMatch="37000.0000"/></Root>' AS BetLimit      --PE
UNION ALL SELECT 'zt828' AS Site, 45 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="500000.0000" MaxPerMatch="2500000.0000"/></Root>' AS BetLimit      --Won
UNION ALL SELECT 'zt828' AS Site, 46 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --BND
UNION ALL SELECT 'zt828' AS Site, 51 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --INH
UNION ALL SELECT 'zt828' AS Site, 55 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="12000.0000" MaxPerMatch="60000.0000"/></Root>' AS BetLimit      --RUB
UNION ALL SELECT 'zt828' AS Site, 56 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --PLN
UNION ALL SELECT 'zt828' AS Site, 61 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="50000.0000" MaxPerMatch="250000.0000"/></Root>' AS BetLimit      --INR
UNION ALL SELECT 'zt828' AS Site, 70 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'zt828' AS Site, 71 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --KHR
UNION ALL SELECT 'zt828' AS Site, 82 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --BRL
UNION ALL SELECT 'zt828' AS Site, 92 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="5000.0000" MaxPerMatch="25000.0000"/></Root>' AS BetLimit      --HID,HK$
UNION ALL SELECT 'zt828' AS Site, 94 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="750.0000" MaxPerMatch="3700.0000"/></Root>' AS BetLimit      --MK,MKK
UNION ALL SELECT 'zt828' AS Site, 96 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="1200.0000" MaxPerMatch="6000.0000"/></Root>' AS BetLimit      --USDT,US$
UNION ALL SELECT 'zt828' AS Site, 97 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --BDT
UNION ALL SELECT 'zt828' AS Site, 121 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --PKR
UNION ALL SELECT 'zt828' AS Site, 123 AS Currency, '<Root><BL ProductID="28" SportType="220" BetType="1021" MaxBet="25000.0000" MaxPerMatch="120000.0000"/></Root>' AS BetLimit      --NPR

INSERT INTO #supers(custid,Currency,site)
SELECT ci.custid,ci.currency, cs.site
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN( '12Bet' , '365online' , '368Cash' , '3star88' , '9bet' , 'A1game' , 'Ae88' , 'AEUG' , 'ALPHA88' , 'Aoncash' , 'B24VN' , 'B8KRW' , 'bdtt' , 'beplay' , 'BigGaming' , 'Bolanation' , 'Bonanza88' , 'BPLE' , 'CGame4' , 'DEWA' , 'DMsports' , 'DongYing' , 'e8casino' , 'ECLBET' , 'erhaozhan' , 'FB88' , 'FHLMSABA' , 'GAMEBee' , 'Gampag' , 'Gaobet' , 'GBET' , 'GMASTER' , 'GoldenF2' , 'Hecbet' , 'HFTH' , 'iBET' , 'IBO' , 'ID88' , 'INSERTGAME' , 'ITCbet' , 'Jiuyou' , 'KzingP88' , 'LEIHUO' , 'Leng4D' , 'LIGAWLHKB' , 'Lode88' , 'M8bola' , 'Macaubet' , 'MANBETX' , 'Mancity2' , 'Mayayule' , 'Mopgaming' , 'MTech' , 'N8BK' , 'NewFuture' , 'OCMS' , 'Ot88' , 'Raisetech' , 'Rakyat4DSW' , 'SKY1688' , 'SM88' , 'Sunriseb2b' , 'Sunwin' , 'TCbet' , 'txwl002' , 'V03' , 'VFUN88' , 'VN88' , 'vssports' , 'W88' , 'WKPHIL' , 'wmcasino' , 'WRServices' , 'Xinbo' , 'Yibo' , 'YSYBO688' , 'ZF026' , 'ZF138THB' , 'ZF138USD' , 'ZF138VND' , 'ZF215aTR' , 'ZFRT126' , 'ZFRT132' , 'ZFRT144' , 'ZFRT151' , 'ZFRT166' , 'ZFRT179' , 'ZFRT186' , 'ZFRT195' , 'ZFRT213' , 'ZFRT218' , 'ZFRT276' , 'ZFRT282' , 'ZhiFeng009' , 'ZhiFeng012' , 'ZhiFeng021' , 'ZhiFeng032' , 'ZhiFeng035' , 'ZhiFeng036' , 'ZhiFeng040' , 'ZhiFeng041' , 'ZhiFeng147' , 'ZhiFeng176' , 'ZhiFeng222' , 'ZhiFeng228' , 'ZhiFeng229' , 'ZhiFeng258' , 'Zowin' , 'zt828')
	AND ci.currency IN (2,3,4,5,6,7,12,13,15,32,41,42,45,46,51,55,56,61,70,71,82,92,94,96,97,121,123) 				  
ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #supers) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID,srecommend)
SELECT CustID, srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #tmpSMA(CustID,RoleID,srecommend)
SELECT CustID,RoleID,srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4) AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 
DECLARE @startRun DATETIME, @endRun DATETIME, @duration	INT, @msgtmp nvarchar(200), @indexDetail INT = 0
SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d. '
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	SELECT @startRun = GETDATE()
	IF EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION ALL
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			)
	BEGIN
		 UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
		FROM #tmpSMA a	
		WHERE isfinished = 0 AND RoleID <>  2 AND srecommend = @srecommend
		
		IF @@ROWCOUNT = 0 SET @DoneSM = 1
		IF @DoneSM = 0
		BEGIN
		  SET @CustIDs = @CustIDs + (SELECT string_agg(convert(varchar(max),custid),',')  FROM #tmpSMATemp)
		END
		ELSE
		BEGIN
			UPDATE TOP (@batch) a
			SET a.isfinished = 1
			OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
			FROM #tmpSMA a	
			WHERE isfinished = 0 AND RoleID = 2 AND srecommend = @srecommend
			
			IF @@ROWCOUNT = 0 SET @DoneAgent = 1
			IF @DoneAgent = 0
			BEGIN
				SET @CustIDs = @CustIDs + (SELECT string_agg(convert(varchar(max),custid),',')  FROM #tmpSMATemp)
				SELECT @Role = 2
			END
			ELSE
			BEGIN
				UPDATE TOP (@batch) a
				SET a.isfinished = 1
				OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
				FROM #tmpCust a	
				WHERE isfinished = 0 AND srecommend = @srecommend
				IF @@ROWCOUNT = 0 BREAK
				SET @CustIDs = @CustIDs + (SELECT string_agg(convert(varchar(max),custid),',')  FROM #tmpCustTemp)
				SELECT @Role = 1
			END
		END
		SET @indexDetail = @indexDetail + 1
		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role, @BetLimit = @BetLimit, @srecommend = @srecommend,@target = @target

		SELECT @endRun = GETDATE()
			, @duration = DATEDIFF(MILLISECOND, @startRun, @endRun)
		SELECT @msgtmp = 'Detail ' +  @msg  + ' Duration '+ CAST(@duration AS VARCHAR(20))
		RAISERROR (@msgtmp, 0, 1,@indexDetail, @srecommend) WITH NOWAIT

		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.050'	
	END
	ELSE
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid
			,@currency = currency
			,@site = site
			,@DoneSM = 0
			,@DoneAgent = 0	
			,@Role  = 0	
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		SET @index = @index + 1
		SET @indexDetail = 0
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
		SELECT @BetLimit = BetLimit FROM #tmpBetLimit WHERE Site = @site AND Currency = @currency
	   END
END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
DROP TABLE #tmpBetLimit	
GO
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

