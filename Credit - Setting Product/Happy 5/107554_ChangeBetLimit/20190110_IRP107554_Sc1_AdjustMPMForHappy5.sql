/*
	Created: Johnson
	Date: 2018-11-08
	Task: copy bet setting for Happy 5 from NG
	DB: DBCUST/CUSTDB
*/
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@srecommend INT	
	,@max_custid INT
	,@Maxpermatch MONEY
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN

	CREATE TABLE #tblCust (CustID INT PRIMARY KEY, ID INT IDENTITY(1,1))
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)
	
	INSERT INTO #tblCust(custid)
	SELECT custid
	FROM custinfo ci WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @max_custid		
		AND Enabled = 1	
		AND roleid < 4
		AND maxpermatch164 NOT IN (0, 0.1)--dont get downline have mpm = 0, 0.1
		AND maxpermatch164 > @maxpermatch
	ORDER BY roleid DESC	
	
	--update super level, apply global setting
	UPDATE ci
	SET maxpermatch164 = @maxpermatch
	FROM custinfo ci (NOLOCK)
	WHERE custid = @srecommend
	
	DECLARE @Threshold INT = 5000,@fromID INT , @toID INT, @maxID INT
	
	SELECT @maxID = max(ID) FROM #tblCust
	SELECT @fromID = 0, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
		
	WHILE(1=1)
	BEGIN		
		DELETE @tmpCust

		DELETE #tblCust
		OUTPUT DELETED.custID
		INTO @tmpCust
		WHERE ID BETWEEN @fromID AND @toID
		
		UPDATE ci
		SET maxpermatch164 = @maxpermatch
		FROM dbo.CustInfo ci WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)
		
		SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold + 1

		IF @fromID > @maxID
			BREAK;			
			
		WAITFOR DELAY '00:00:00.200'
	END	
	
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at DBTXN -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, currency INT, code VARCHAR(20), MinBet MONEY, MaxBet Money, MaxPerMatch MONEY, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid,currency, code)
SELECT ci.custid, ci.currency,e.code
FROM customer ci WITH (NOLOCK) 
	INNER JOIN DBCUST.CUSTDB.dbo.exchange e WITH(NOLOCK) ON ci.currency = e.exchangeid
	INNER JOIN DBCUST.CUSTDB.dbo.site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN DBCUST.CUSTDB.dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM DBCUST.CUSTDB.dbo.Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid 
							FROM custinfo (NOLOCK)
							WHERE custid IN (SELECT custid 
											FROM DBCUST.CUSTDB.dbo.custaccount WITH (NOLOCK)
											WHERE groupid IN (60,515))--ETUS,ZU01 headline								
						)
	AND s.islicensee = 0
	--dont get site KORIBC, INDO
	AND s.site NOT IN ('KORIBC','INDO')	
	AND ci.custid <= @max_custid
	
SELECT	'IDR'	 code,	18	MinBet,	36000	MaxBet,	360000 MaxPerMatch
INTO #tmpBetSetting
UNION SELECT	'USD'	,	2	,	2700	,	27000
UNION SELECT	'KRW'	,	2751	,	3000000	,	30000000
UNION SELECT	'HKD'	,	13	,	20000	,	200000
UNION SELECT	'THB'	,	60	,	90000	,	900000
UNION SELECT	'MYR'	,	10	,	12000	,	120000
UNION SELECT	'EUR'	,	1	,	2400	,	24000
UNION SELECT	'CNY'	,	11	,	20000	,	200000
UNION SELECT	'MMK'	,	2	,	3600	,	36000
UNION SELECT	'SGD'	,	3	,	4000	,	40000
UNION SELECT	'GBP'	,	2	,	2221	,	22206
UNION SELECT	'CAD'	,	1	,	1714	,	17143
UNION SELECT	'TWD'	,	75	,	89419	,	894188
UNION SELECT	'JPY'	,	265	,	317460	,	3174603
UNION SELECT	'PHP'	,	128	,	153257	,	1532567
UNION SELECT	'NZD'	,	4	,	4254	,	42537
 	

DELETE #Supers
WHERE code NOT IN (SELECT code FROM #tmpBetSetting)

UPDATE s
SET s.MinBet = t.MinBet,
	s.MaxBet = t.MaxBet,
	s.MaxPerMatch = t.MaxPerMatch
FROM #supers s
	INNER JOIN #tmpBetSetting t ON s.code = t.code
WHERE s.currency <> 50 --exclude CAN currency

	
UPDATE s
SET s.MinBet = 3,
	s.MaxBet = 3901,
	s.MaxPerMatch = 39014
FROM #supers s
WHERE currency = 50--CurrenyName = CAN	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0, @maxpermatch MONEY

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
		,@maxpermatch = maxpermatch
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,
			@maxpermatch = @maxpermatch,
			@target = 'REPLICATED' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 2: Run this SP at DBTXN -----
-------------------------------------------------

------------------------------------------------------	
-- BEGIN STEP 3: Run this SP at replicated DB exclude DBTXN -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, currency INT, code VARCHAR(20), MinBet MONEY, MaxBet Money, MaxPerMatch MONEY, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid,currency, code)
SELECT ci.custid, ci.currency,e.code
FROM customer ci WITH (NOLOCK) 
	INNER JOIN exchange e WITH(NOLOCK) ON ci.currency = e.exchangeid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid 
							FROM custinfo (NOLOCK)
							WHERE custid IN (SELECT custid 
											FROM custaccount WITH (NOLOCK) 
											WHERE groupid IN (60,515))--ETUS,ZU01 headline								
						)
	AND s.islicensee = 0
	--dont get site KORIBC, INDO
	AND s.site NOT IN ('KORIBC','INDO')	
	AND ci.custid <= @max_custid
	
SELECT	'IDR'	 code,	18	MinBet,	36000	MaxBet,	360000 MaxPerMatch
INTO #tmpBetSetting
UNION SELECT	'USD'	,	2	,	2700	,	27000
UNION SELECT	'KRW'	,	2751	,	3000000	,	30000000
UNION SELECT	'HKD'	,	13	,	20000	,	200000
UNION SELECT	'THB'	,	60	,	90000	,	900000
UNION SELECT	'MYR'	,	10	,	12000	,	120000
UNION SELECT	'EUR'	,	1	,	2400	,	24000
UNION SELECT	'CNY'	,	11	,	20000	,	200000
UNION SELECT	'MMK'	,	2	,	3600	,	36000
UNION SELECT	'SGD'	,	3	,	4000	,	40000
UNION SELECT	'GBP'	,	2	,	2221	,	22206
UNION SELECT	'CAD'	,	1	,	1714	,	17143
UNION SELECT	'TWD'	,	75	,	89419	,	894188
UNION SELECT	'JPY'	,	265	,	317460	,	3174603
UNION SELECT	'PHP'	,	128	,	153257	,	1532567
UNION SELECT	'NZD'	,	4	,	4254	,	42537
 	

DELETE #Supers
WHERE code NOT IN (SELECT code FROM #tmpBetSetting)

UPDATE s
SET s.MinBet = t.MinBet,
	s.MaxBet = t.MaxBet,
	s.MaxPerMatch = t.MaxPerMatch
FROM #supers s
	INNER JOIN #tmpBetSetting t ON s.code = t.code
WHERE s.currency <> 50 --exclude CAN currency

	
UPDATE s
SET s.MinBet = 3,
	s.MaxBet = 3901,
	s.MaxPerMatch = 39014
FROM #supers s
WHERE currency = 50--CurrenyName = CAN	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0, @maxpermatch MONEY

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
		,@maxpermatch = maxpermatch
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,
			@maxpermatch = @maxpermatch,
			@target = 'REPLICATED' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO
-- END STEP 3: Run this SP at replicated DB exclude DBTXN-----
-------------------------------------------------

---
-- BEGIN STEP 4: Run this SP at DBCust -----
-------------------------------------------------

CREATE TABLE #supers (custid INT, currency INT, code VARCHAR(20), MinBet MONEY, MaxBet Money, MaxPerMatch MONEY, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid,currency, code)
SELECT ci.custid, ci.currency,e.code
FROM customer ci WITH (NOLOCK) 
	INNER JOIN exchange e WITH(NOLOCK) ON ci.currency = e.exchangeid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid 
							FROM custinfo (NOLOCK)
							WHERE custid IN (SELECT custid 
											FROM custaccount WITH (NOLOCK) 
											WHERE groupid IN (60,515))--ETUS,ZU01 headline								
						)
	AND s.islicensee = 0
	--dont get site KORIBC, INDO
	AND s.site NOT IN ('KORIBC','INDO')	
	AND ci.custid <= @max_custid
	
SELECT	'IDR'	 code,	18	MinBet,	36000	MaxBet,	360000 MaxPerMatch
INTO #tmpBetSetting
UNION SELECT	'USD'	,	2	,	2700	,	27000
UNION SELECT	'KRW'	,	2751	,	3000000	,	30000000
UNION SELECT	'HKD'	,	13	,	20000	,	200000
UNION SELECT	'THB'	,	60	,	90000	,	900000
UNION SELECT	'MYR'	,	10	,	12000	,	120000
UNION SELECT	'EUR'	,	1	,	2400	,	24000
UNION SELECT	'CNY'	,	11	,	20000	,	200000
UNION SELECT	'MMK'	,	2	,	3600	,	36000
UNION SELECT	'SGD'	,	3	,	4000	,	40000
UNION SELECT	'GBP'	,	2	,	2221	,	22206
UNION SELECT	'CAD'	,	1	,	1714	,	17143
UNION SELECT	'TWD'	,	75	,	89419	,	894188
UNION SELECT	'JPY'	,	265	,	317460	,	3174603
UNION SELECT	'PHP'	,	128	,	153257	,	1532567
UNION SELECT	'NZD'	,	4	,	4254	,	42537
 	

DELETE #Supers
WHERE code NOT IN (SELECT code FROM #tmpBetSetting)

UPDATE s
SET s.MinBet = t.MinBet,
	s.MaxBet = t.MaxBet,
	s.MaxPerMatch = t.MaxPerMatch
FROM #supers s
	INNER JOIN #tmpBetSetting t ON s.code = t.code
WHERE s.currency <> 50 --exclude CAN currency

	
UPDATE s
SET s.MinBet = 3,
	s.MaxBet = 3901,
	s.MaxPerMatch = 39014
FROM #supers s
WHERE currency = 50--CurrenyName = CAN	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0, @maxpermatch MONEY

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
		,@maxpermatch = maxpermatch
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@srecommend = @srecommend, 			
			@max_custid=@max_custid,
			@maxpermatch = @maxpermatch,
			@target = 'DBCUST' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO
-- END STEP 4: Run this SP at DBCust -----
-------------------------------------------------