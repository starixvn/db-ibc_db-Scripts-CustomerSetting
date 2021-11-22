/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20211117
	Task: Bitcoin - Reduce bet limit setting by 50% [Redmine: 164702]
	DB: DBCUST/CustDB
	P/s : Step 1 Reduce bet limit
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN

	DECLARE @Currency INT
	SELECT @Currency = currency FROM Custinfo WITH (NOLOCK) WHERE custid = @srecommend
	
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		InsBetSetting BIT DEFAULT 0
	)

	CREATE TABLE #MemberTempIns
	(
		CustID INT PRIMARY KEY CLUSTERED
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

	INSERT INTO #MemberTemp (CustID  )
	SELECT custid 
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 
	
	CREATE TABLE #ProductBetSetting (Currency INT,MinBet	MONEY,MaxBet	MONEY,MaxPerMatch	MONEY,
									SuperMinBet	MONEY,SuperMaxBet	MONEY,SuperMaxPerMatch	MONEY, IsChangeMinBet BIT, Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
					
	INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,SuperMinBet,SuperMaxBet,SuperMaxPerMatch,IsChangeMinBet)
	SELECT 2 AS Currency ,5 AS MinBet,1500 AS MaxBet,7500 AS MaxPerMatch,5 AS SuperMinBet,2500 AS SuperMaxBet,15000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --RM
	SELECT 3 AS Currency ,3 AS MinBet,500 AS MaxBet,2250 AS MaxPerMatch,3 AS SuperMinBet,750 AS SuperMaxBet,4500  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --US$
	SELECT 5 AS Currency ,10 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,10 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --HK$
	SELECT 6 AS Currency ,2 AS MinBet,250 AS MaxBet,1500 AS MaxPerMatch,2 AS SuperMinBet,500 AS SuperMaxBet,3000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --EURO
	SELECT 7 AS Currency ,25000 AS MinBet,7500000 AS MaxBet,37500000 AS MaxPerMatch,25000 AS SuperMinBet,12500000 AS SuperMaxBet,75000000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --DON
	SELECT 9 AS Currency ,3 AS MinBet,500 AS MaxBet,2250 AS MaxPerMatch,3 AS SuperMinBet,750 AS SuperMaxBet,4500  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --AUD
	SELECT 12 AS Currency ,2 AS MinBet,250 AS MaxBet,1500 AS MaxPerMatch,2 AS SuperMinBet,500 AS SuperMaxBet,3000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --GBP
	SELECT 13 AS Currency ,10 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,10 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --RMB
	SELECT 15 AS Currency ,25 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,25 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --IN
	SELECT 16 AS Currency ,3 AS MinBet,500 AS MaxBet,2250 AS MaxPerMatch,3 AS SuperMinBet,750 AS SuperMaxBet,4500  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --Yen
	SELECT 22 AS Currency ,25 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,25 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --IND
	SELECT 33 AS Currency ,25 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,25 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --IDD
	SELECT 34 AS Currency ,25 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,25 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --IDR
	SELECT 35 AS Currency ,3 AS MinBet,500 AS MaxBet,2250 AS MaxPerMatch,3 AS SuperMinBet,750 AS SuperMaxBet,4500  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --$US
	SELECT 41 AS Currency ,2 AS MinBet,250 AS MaxBet,1500 AS MaxPerMatch,2 AS SuperMinBet,500 AS SuperMaxBet,3000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --CHF
	SELECT 42 AS Currency ,120 AS MinBet,17500 AS MaxBet,90000 AS MaxPerMatch,120 AS SuperMinBet,30000 AS SuperMaxBet,180000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --PE
	SELECT 43 AS Currency ,100 AS MinBet,12500 AS MaxBet,60000 AS MaxPerMatch,100 AS SuperMinBet,20000 AS SuperMaxBet,120000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --THB
	SELECT 45 AS Currency ,2500 AS MinBet,400000 AS MaxBet,2250000 AS MaxPerMatch,2500 AS SuperMinBet,750000 AS SuperMaxBet,4500000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --Won
	SELECT 47 AS Currency ,25 AS MinBet,5000 AS MaxBet,30000 AS MaxPerMatch,25 AS SuperMinBet,10000 AS SuperMaxBet,60000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --DDD
	SELECT 50 AS Currency ,3 AS MinBet,500 AS MaxBet,2250 AS MaxPerMatch,3 AS SuperMinBet,750 AS SuperMaxBet,4500  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --CAN
	SELECT 51 AS Currency ,25 AS MinBet,6250 AS MaxBet,37500 AS MaxPerMatch,25 AS SuperMinBet,12500 AS SuperMaxBet,75000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --INH
	SELECT 52 AS Currency ,15 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,15 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --DKK
	SELECT 53 AS Currency ,15 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,15 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --SEK
	SELECT 54 AS Currency ,15 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,15 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --NOK
	SELECT 57 AS Currency ,50 AS MinBet,6250 AS MaxBet,37500 AS MaxPerMatch,50 AS SuperMinBet,12500 AS SuperMaxBet,75000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --CZK
	SELECT 58 AS Currency ,10 AS MinBet,1500 AS MaxBet,7500 AS MaxPerMatch,10 AS SuperMinBet,2500 AS SuperMaxBet,15000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --RON
	SELECT 64 AS Currency ,3 AS MinBet,500 AS MaxBet,2250 AS MaxPerMatch,3 AS SuperMinBet,750 AS SuperMaxBet,4500  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --UT
	SELECT 67 AS Currency ,5 AS MinBet,1500 AS MaxBet,7500 AS MaxPerMatch,5 AS SuperMinBet,2500 AS SuperMaxBet,15000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --HKK
	SELECT 69 AS Currency ,4 AS MinBet,450 AS MaxBet,2700 AS MaxPerMatch,4 AS SuperMinBet,900 AS SuperMaxBet,5400  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --MMK
	SELECT 71 AS Currency ,10 AS MinBet,1500 AS MaxBet,7500 AS MaxPerMatch,10 AS SuperMinBet,2500 AS SuperMaxBet,15000  AS SuperMaxPerMatch,0  AS IsChangeMinBet Union ALL --KHR
	SELECT 81 AS Currency ,10 AS MinBet,2500 AS MaxBet,15000 AS MaxPerMatch,10 AS SuperMinBet,5000 AS SuperMaxBet,30000  AS SuperMaxPerMatch,1  AS IsChangeMinBet Union ALL --CY
	SELECT 95 AS Currency ,3 AS MinBet,500 AS MaxBet,2250 AS MaxPerMatch,3 AS SuperMinBet,750 AS SuperMaxBet,4500  AS SuperMaxPerMatch,0  AS IsChangeMinBet		 --USD

	--------------------------------------Bet Setting-------------------------------------------------
	--SMA level
	UPDATE cs
	SET cs.MinBet = CASE WHEN ci.roleid  = 4 THEN (CASE WHEN ps.IsChangeMinBet = 1 AND cs.MinBet <>  ps.SuperMinBet THEN ps.SuperMinBet ELSE cs.MinBet END)
											 ELSE (CASE WHEN ps.IsChangeMinBet = 1 AND cs.MinBet <>  ps.MinBet  THEN ps.MinBet ELSE cs.MinBet END) END,								 
		cs.MaxBet = CASE WHEN ci.roleid  = 4 THEN (CASE WHEN cs.MaxBet >  ps.SuperMaxBet  THEN ps.SuperMaxBet ELSE cs.MaxBet END)
											 ELSE (CASE WHEN cs.MaxBet >  ps.MaxBet  THEN ps.MaxBet ELSE cs.MaxBet END) END,
		cs.MaxPerMatch = CASE WHEN ci.roleid  = 4 THEN (CASE WHEN cs.MaxPerMatch >  ps.SuperMaxPerMatch  THEN ps.SuperMaxPerMatch ELSE cs.MaxPerMatch END)
											 ELSE (CASE WHEN cs.MaxPerMatch >  ps.MaxPerMatch  THEN ps.MaxPerMatch ELSE cs.MaxPerMatch END) END		
	FROM dbo.CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #SMATemp ci ON cs.CustID = ci.CustID
	INNER JOIN #ProductBetSetting ps ON cs.SportType = ps.Sporttype AND cs.BetType = ps.Bettype AND ps.Currency = @Currency
	WHERE ((ci.roleid  = 4 AND (cs.MaxBet >  ps.SuperMaxBet OR cs.MaxPerMatch > PS.SuperMaxPerMatch)) OR 
		  (ci.roleid  IN (2,3) AND (cs.MaxBet >  ps.MaxBet OR cs.MaxPerMatch > PS.MaxPerMatch))  OR 
		  (ps.IsChangeMinBet = 1 AND ((ci.roleid  = 4 AND cs.MinBet <>  ps.SuperMinBet) OR (ci.roleid  IN (2,3) AND  cs.MinBet <>  ps.MinBet)) )
		  )
	
	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns
		UPDATE TOP (3000)  t SET t.InsBetSetting = 1 OUTPUT DELETED.CustID INTO #MemberTempIns(CustID) FROM #MemberTemp t WHERE t.InsBetSetting = 0
		
		IF @@ROWCOUNT=0
			BREAK
			
		--Member Level	
		UPDATE cs
		SET cs.MinBet = CASE WHEN ps.IsChangeMinBet = 1 AND cs.MinBet <>  ps.MinBet  THEN ps.MinBet ELSE cs.MinBet END,
			cs.MaxBet = CASE WHEN cs.MaxBet >  ps.MaxBet  THEN ps.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch >  ps.MaxPerMatch  THEN ps.MaxPerMatch ELSE cs.MaxPerMatch END	
		FROM dbo.CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #MemberTempIns ci ON cs.CustID = ci.CustID
		INNER JOIN #ProductBetSetting ps ON cs.SportType = ps.Sporttype AND cs.BetType = ps.Bettype AND ps.Currency = @Currency
		WHERE cs.MaxBet >  ps.MaxBet OR cs.MaxPerMatch > PS.MaxPerMatch OR (ps.IsChangeMinBet = 1 AND cs.MinBet <>  ps.MinBet)
		
	END
	


	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #ProductBetSetting
	DROP TABLE #MemberTempIns
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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
	AND ci.custid <= @max_custid
	AND ci.Site NOT IN ('CN88')
	AND ci.currency IN ( 2,3,5,6,7,9,12,13,15,16,22,33,34,35,41,42,43,45,47,50,51,52,53,54,57,58,64,67,69,71,81,95)
	--RM,US$,HK$,EURO,DON,AUD,GBP,RMB,IN,Yen,IND,IDD,IDR,$US,CHF,PE,THB,Won,DDD,CAN,INH,DKK,SEK,NOK,CZK,RON,UT,HKK,MMK,KHR,CY,USD


-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.200'
END
GO

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

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
	AND ci.custid <= @max_custid
	AND ci.Site NOT IN ('CN88')
	AND ci.currency IN ( 2,3,5,6,7,9,12,13,15,16,22,33,34,35,41,42,43,45,47,50,51,52,53,54,57,58,64,67,69,71,81,95)
	--RM,US$,HK$,EURO,DON,AUD,GBP,RMB,IN,Yen,IND,IDD,IDR,$US,CHF,PE,THB,Won,DDD,CAN,INH,DKK,SEK,NOK,CZK,RON,UT,HKK,MMK,KHR,CY,USD

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.200'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
