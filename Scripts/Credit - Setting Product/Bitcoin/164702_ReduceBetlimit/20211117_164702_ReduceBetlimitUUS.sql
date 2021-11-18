/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20211117
	Task: Bitcoin - Reduce bet limit setting by 50% UUS [Redmine: 164702]
	DB: DBCUST/CustDB
	P/s : Step 1 Reduce bet limit UUS
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
		recommend INT, 
		mrecommend INT, 
		srecommend INT,
		InsBetSetting BIT DEFAULT 0
	)

	CREATE TABLE #MemberTempIns
	(
		CustID INT PRIMARY KEY CLUSTERED,
		recommend INT, 
		mrecommend INT, 
		srecommend INT
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

	INSERT INTO #MemberTemp (CustID ,recommend ,mrecommend ,srecommend )
	SELECT custid ,recommend ,mrecommend ,srecommend
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 
	
	CREATE TABLE #ProductBetSetting (Currency INT,MinBet	MONEY,MaxBet	MONEY,MaxPerMatch	MONEY,
									SuperMinBet	MONEY,SuperMaxBet	MONEY,SuperMaxPerMatch	MONEY, Sporttype INT DEFAULT(175), Bettype INT DEFAULT(7901))
					
	INSERT INTO #ProductBetSetting(Currency,MinBet,MaxBet,MaxPerMatch,SuperMinBet,SuperMaxBet,SuperMaxPerMatch)
	SELECT 20 AS Currency ,3 AS MinBet,1500 AS MaxBet,9000 AS MaxPerMatch,3 AS SuperMinBet,1000 AS SuperMaxBet,4500  AS SuperMaxPerMatch Union ALL --UUS
	SELECT 72 AS Currency ,50 AS MinBet,25000 AS MaxBet,150000 AS MaxPerMatch,50 AS SuperMinBet,12500 AS SuperMaxBet,75000  AS SuperMaxPerMatch  --YNG
	--------------------------------------Bet Setting-------------------------------------------------
	--SMA level
	UPDATE cs
	SET cs.MaxBet = CASE WHEN ci.roleid  = 4 THEN (CASE WHEN cs.MaxBet >  ps.SuperMaxBet  THEN ps.SuperMaxBet ELSE cs.MaxBet END)
											 ELSE (CASE WHEN cs.MaxBet >  ps.MaxBet  THEN ps.MaxBet ELSE cs.MaxBet END) END,
		cs.MaxPerMatch = CASE WHEN ci.roleid  = 4 THEN (CASE WHEN cs.MaxPerMatch >  ps.SuperMaxPerMatch  THEN ps.SuperMaxPerMatch ELSE cs.MaxPerMatch END)
											 ELSE (CASE WHEN cs.MaxPerMatch >  ps.MaxPerMatch  THEN ps.MaxPerMatch ELSE cs.MaxPerMatch END) END		
	FROM dbo.CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #SMATemp ci ON cs.CustID = ci.CustID
	INNER JOIN #ProductBetSetting ps ON cs.SportType = ps.Sporttype AND cs.BetType = ps.Bettype AND ps.Currency = @Currency
	WHERE ((ci.roleid  = 4 AND (cs.MaxBet >  ps.SuperMaxBet OR cs.MaxPerMatch > PS.SuperMaxPerMatch)) OR 
		  (ci.roleid  IN (2,3) AND (cs.MaxBet >  ps.MaxBet OR cs.MaxPerMatch > PS.MaxPerMatch)))
	
	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns
		UPDATE TOP (3000)  t SET t.InsBetSetting = 1 OUTPUT DELETED.CustID INTO #MemberTempIns(CustID) FROM #MemberTemp t WHERE t.InsBetSetting = 0
		
		IF @@ROWCOUNT=0
			BREAK
			
		--Member Level	
		UPDATE cs
		SET cs.MaxBet = CASE WHEN cs.MaxBet >  ps.MaxBet  THEN ps.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch >  ps.MaxPerMatch  THEN ps.MaxPerMatch ELSE cs.MaxPerMatch END	
		FROM dbo.CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #MemberTempIns ci ON cs.CustID = ci.CustID
		INNER JOIN #ProductBetSetting ps ON cs.SportType = ps.Sporttype AND cs.BetType = ps.Bettype AND ps.Currency = @Currency
		WHERE cs.MaxBet >  ps.MaxBet OR cs.MaxPerMatch > PS.MaxPerMatch
		
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
	AND ci.currency IN (20,72) -- UUS

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
	AND ci.currency IN (20,72) -- UUS

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
