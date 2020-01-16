/*
	Created: Tiara
	Date: 2020-01-16
	Task: Update Allbet bet settings for customers under defined currency group
	DB: DBCUST/CUSTDB
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@currency INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN

	--Set Stakelevelid that need to be updated
	DECLARE @StakeLevelID_Update INT
	
	SELECT @StakeLevelID_Update = StakeLevelID
	FROM dbo.StakeLevel WITH(NOLOCK)
	WHERE exchangeid = @currency
		AND GameTypeID = 2401
		AND MinStake = 2
		AND MaxStake = 200
		AND ResourceId = 25
	SELECT @StakeLevelID_Update

	IF @@ROWCOUNT =0 RETURN	
	--Get list of downline whose StakeLevelList need to be updated 
	CREATE TABLE #CustStakeLevelDownlines (
			CustID INT 
			,DirectUplineID INT		
			,roleid TINYINT
			,Bettype INT
			,StakeLevelList VARCHAR(100)
			,StakeLevelList_new VARCHAR(100)							
			, PRIMARY KEY CLUSTERED (CustID,Bettype)
		)
	
	INSERT INTO #CustStakeLevelDownlines (CustID,DirectUplineID, roleid ,Bettype ,StakeLevelList,StakeLevelList_new)
	SELECT ci.custid,
		  CASE 
				WHEN ci.roleid = 3 THEN srecommend
				WHEN ci.roleid = 2 THEN mrecommend				 	
		  END AS DirectUplineID,		
		 ci.roleid,cs.Bettype,cs.StakeLevelList,cs.StakeLevelList
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Agent cs WITH(NOLOCK) ON ci.custid = cs.custid			
	WHERE ci.srecommend = @srecommend
		AND roleid IN (2,3)
		AND Bettype = 2401
		AND CS.StakeLevelList <> '' 
		AND CS.StakeLevelList IS NOT NULL
		
	UNION ALL
	SELECT ci.custid,
		  recommend as DirectUplineID,		
		 ci.roleid,cs.bettype,cs.StakeLevelList,cs.StakeLevelList
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Member cs WITH(NOLOCK) ON ci.custid = cs.custid			
	WHERE ci.srecommend = @srecommend
		AND ci.roleid = 1
		AND Bettype = 2401
		AND CS.StakeLevelList <> '' 
		AND CS.StakeLevelList IS NOT NULL
		

	--Apply highest stakelevel from upline when downline has only new stakelevel
	--Update master
	UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 		 		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(Upline.StakeLevelList_new,','))  CD
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY MaxStake DESC
					) T1 -- Direct Upline
	WHERE T.roleid = 3
		AND T.StakeLevelList_new LIKE @StakeLevelID_Update
	--Update Agent
	UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 		 		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(Upline.StakeLevelList_new,','))  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE T.roleid = 2
		AND T.StakeLevelList_new LIKE @StakeLevelID_Update
	--Update member
	UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 		 		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(Upline.StakeLevelList_new,','))  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE T.roleid = 1
		AND T.StakeLevelList_new LIKE @StakeLevelID_Update

	DELETE #CustStakeLevelDownlines
	WHERE StakeLevelList = StakeLevelList_new
	
	UPDATE CS
	SET CS.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
	FROM dbo.CustStakeLevel_Agent CS WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustStakeLevelDownlines DL ON CS.CustID = DL.CustID 
												AND CS.bettype = DL.bettype
	WHERE DL.StakeLevelList <> DL.StakeLevelList_new
		
	UPDATE CS
	SET CS.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
	FROM dbo.CustStakeLevel_Member CS WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustStakeLevelDownlines DL ON CS.CustID = DL.CustID 
												AND CS.bettype = DL.bettype
	WHERE DL.StakeLevelList <> DL.StakeLevelList_new	
	
	DROP TABLE #CustStakeLevelDownlines	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB ----------------------
-------------------------------------------------------------------

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS --------
-------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@super_cnt INT, 
		@index INT = 0

--Get Stakelevel 
SELECT * 
INTO #StakeLevel
FROM dbo.StakeLevel ST WITH(NOLOCK)
WHERE ST.ExchangeId IN (35,3,17,64,16,40,6,1,12,74) --$US, NTD, US$, UT, Yen, IRR, EURO, SD$, GBP, TH
	AND ST.GameTypeID = 2401
	AND ST.MinStake = 2
	AND ST.MaxStake = 200

--Get list of Super under defined currency
SELECT CI.custid, CI.currency 
INTO #tmpCust
FROM dbo.customer C WITH (Nolock) 
	INNER JOIN dbo.custinfo CI WITH(NOLOCK) ON C.custid = CI.custid
	INNER JOIN dbo.site S WITH(NOLOCK) ON C.site = S.site
WHERE CI.roleid = 4
	AND CI.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND CI.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND CI.Enabled = 1
	AND S.islicensee = 0
	AND C.username NOT LIKE '3rdSuper%'
	AND CI.currency IN (35,3,17,64,16,40,6,1,12,74)--$US, NTD, US$, UT, Yen, IRR, EURO, SD$, GBP, TH

--Get list of Supers who are assigned only bet limit 2-200
CREATE TABLE #SupersExcluded(CustID INT, currency INT)

INSERT INTO #SupersExcluded(custid,currency)
SELECT DISTINCT CS.custid, T.currency
FROM dbo.CustStakeLevel_Agent CS WITH(NOLOCK)
	INNER JOIN #tmpCust T ON CS.custid = T.custid
	INNER JOIN #StakeLevel S ON CS.StakeLevelList LIKE S.StakeLevelID
WHERE bettype = 2401

--Get list of Supers
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
INSERT INTO #Supers(custid,currency)
SELECT DISTINCT C.CustID,S.ExchangeId
FROM CustStakeLevel_Agent C WITH (NOLOCK)
	INNER JOIN #tmpCust T WITH (NOLOCK) ON T.custid = C.CustID
	CROSS APPLY strSplit(ISNULL(StakeLevelList,''),',') ST
	INNER JOIN StakeLevel S WITH (NOLOCK) ON S.StakeLevelID = ST.val
WHERE  BetType = 2401 
AND ST.val IN (SELECT stakelevelid FROM #StakeLevel)
EXCEPT
SELECT * FROM #SupersExcluded

SELECT @super_cnt = @@ROWCOUNT
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@currency = currency
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@target = 'REPLICATED' 	
	--Run in UM so dont need to delay 280ms			
	WAITFOR DELAY '00:00:00.100'			
END		
GO
-- END STEP 2: Run this SP at replicated DB -----
---------------------------------------------------------------------------------

-- BEGIN STEP 3: Run this SP at DBCust -----
---------------------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@super_cnt INT, 
		@index INT = 0

--Get Stakelevel 
SELECT * 
INTO #StakeLevel
FROM dbo.StakeLevel ST WITH(NOLOCK)
WHERE ST.ExchangeId IN (35,3,17,64,16,40,6,1,12,74) --$US, NTD, US$, UT, Yen, IRR, EURO, SD$, GBP, TH
	AND ST.GameTypeID = 2401
	AND ST.MinStake = 2
	AND ST.MaxStake = 200

--Get list of Super under defined currency
SELECT CI.custid, CI.currency 
INTO #tmpCust
FROM dbo.customer C WITH (Nolock) 
	INNER JOIN dbo.custinfo CI WITH(NOLOCK) ON C.custid = CI.custid
	INNER JOIN dbo.site S WITH(NOLOCK) ON C.site = S.site
WHERE CI.roleid = 4
	AND CI.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND CI.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND CI.Enabled = 1
	AND S.islicensee = 0
	AND C.username NOT LIKE '3rdSuper%'
	AND CI.currency IN (35,3,17,64,16,40,6,1,12,74) --$US, NTD, US$, UT, Yen, IRR, EURO, SD$, GBP, TH

--Get list of Supers who are assigned only bet limit 2-200
CREATE TABLE #SupersExcluded(CustID INT, currency INT)

INSERT INTO #SupersExcluded(custid,currency)
SELECT DISTINCT CS.custid, T.currency
FROM dbo.CustStakeLevel_Agent CS WITH(NOLOCK)
	INNER JOIN #tmpCust T ON CS.custid = T.custid
	INNER JOIN #StakeLevel S ON CS.StakeLevelList LIKE S.StakeLevelID
WHERE bettype = 2401

--Get list of Supers
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
INSERT INTO #Supers(custid,currency)
SELECT DISTINCT C.CustID,S.ExchangeId
FROM CustStakeLevel_Agent C WITH (NOLOCK)
	INNER JOIN #tmpCust T WITH (NOLOCK) ON T.custid = C.CustID
	CROSS APPLY strSplit(ISNULL(StakeLevelList,''),',') ST
	INNER JOIN StakeLevel S WITH (NOLOCK) ON S.StakeLevelID = ST.val
WHERE  BetType = 2401 
AND ST.val IN (SELECT stakelevelid FROM #StakeLevel)
EXCEPT
SELECT * FROM #SupersExcluded

SELECT @super_cnt = @@ROWCOUNT
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@currency = currency
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@target = 'REPLICATED' 	
	--Run in UM so dont need to delay 280ms			
	WAITFOR DELAY '00:00:00.100'			
END		
GO
-- END STEP 3: Run this SP at DBCUST -----
-----------------------------------------------------------------------------------	