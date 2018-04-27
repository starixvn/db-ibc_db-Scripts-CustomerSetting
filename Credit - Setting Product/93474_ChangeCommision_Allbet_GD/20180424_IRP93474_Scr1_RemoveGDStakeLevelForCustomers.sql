/*
	Created: Johnson
	Date: 2018-04-24
	Task: Remove GD stakelevel for customers
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@currency	INT,	
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	
	CREATE TABLE #CustGameTypeDownlines (
				CustID INT 
				,DirectUplineID INT		
				,roleid TINYINT
				,GameTypeID INT
				,StakeLevelList varchar(100)
				,StakeLevelList_new varchar(100)							
				, PRIMARY KEY CLUSTERED (CustID,GameTypeID)
		)
	
	DECLARE @tmpStakeLevel_Exclude TABLE(GameTypeID INT PRIMARY KEY, StakeLevelID_Exclude VARCHAR(100))
	
	INSERT INTO @tmpStakeLevel_Exclude (GameTypeID, StakeLevelID_Exclude)
	SELECT GameTypeID, StakeLevelID
	FROM dbo.StakeLevel WITH(NOLOCK)
	WHERE ExchangeId = @currency		
		AND 1 = CASE WHEN (GameTypeID = 1701 AND MinStake = 100 AND MaxStake = 5000 )														
						OR (GameTypeID = 1702 AND MinStake = 5 AND MaxStake = 5000) THEN 1 ELSE 0 END										
			
	INSERT INTO #CustGameTypeDownlines (CustID,DirectUplineID, roleid ,GameTypeID ,StakeLevelList,StakeLevelList_new)
	SELECT ci.custid,
		  CASE 
				WHEN ci.roleid = 3 THEN srecommend
				WHEN ci.roleid = 2 THEN mrecommend
				WHEN ci.roleid = 1 THEN recommend 	
		  END AS DirectUplineID,		
		 ci.roleid,cg.GameTypeID,cg.StakeLevelList,cg.StakeLevelList
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustGameType cg WITH(NOLOCK) ON ci.custid = cg.custid	
		INNER JOIN @tmpStakeLevel_Exclude s ON cg.GameTypeID = s.GameTypeID	
	WHERE ci.srecommend = @srecommend
		AND cg.GameTypeID IN (1701,1702)
	
	--Remove exclude stakelevel for downlines
	UPDATE cg
	SET cg.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cg.StakeLevelList+',',t.StakeLevelID_Exclude+',','')),1,1,'')),'')
	FROM #CustGameTypeDownlines cg 
		INNER JOIN @tmpStakeLevel_Exclude t ON cg.GameTypeID = t.GameTypeID
			
	--Apply lowest stakelevel if new stakelevel doesnt have any
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustGameTypeDownlines T
		INNER JOIN #CustGameTypeDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND T.GameTypeID =Upline.GameTypeID AND Upline.StakeLevelList_new <> ''			 
		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(Upline.StakeLevelList_new,','))  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY minstake , maxstake
					) T1 -- Direct Upline
	WHERE t.roleid = 3
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining
	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustGameTypeDownlines T
		INNER JOIN #CustGameTypeDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND T.GameTypeID =Upline.GameTypeID AND Upline.StakeLevelList_new <> ''			 
		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(Upline.StakeLevelList_new,','))  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY minstake , maxstake
					) T1 -- Direct Upline
	WHERE t.roleid = 2
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining
	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustGameTypeDownlines T
		INNER JOIN #CustGameTypeDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND T.GameTypeID =Upline.GameTypeID AND Upline.StakeLevelList_new <> ''			 
		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(Upline.StakeLevelList_new,','))  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY minstake , maxstake
					) T1 -- Direct Upline
	WHERE t.roleid = 1
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining
	
	UPDATE cg
	SET cg.StakeLevelList = dl.StakeLevelList_new
	FROM dbo.CustGameType cg WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustGameTypeDownlines dl ON cg.CustID = dl.CustID 
												AND cg.GameTypeID = dl.GameTypeID
	WHERE dl.StakeLevelList <> dl.StakeLevelList_new												
	
	DROP TABLE #CustGameTypeDownlines
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))

--get affected stakelevel will be removed				
SELECT * 
INTO #StakeLevel
FROM dbo.StakeLevel st WITH(NOLOCK)
WHERE exchangeid IN (3,6,9,12,16,17,35,64,74)--UT, Yen, US$, $US, TH, NTD, EURO, AUD, GBP, SD
	AND GameTypeID IN (1701,1702)
	AND 1 = CASE WHEN (MinStake = 100 AND MaxStake = 5000 )
					OR (MinStake = 5 AND MaxStake = 5000) THEN 1 ELSE 0 END

SELECT ci.custid, ci.currency 
INTO #tmpCust
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND ci.currency IN (3,6,9,12,16,17,35,64,74)--UT, Yen, US$, $US, TH, NTD, EURO, AUD, GBP, SD
	
INSERT INTO #supers(custid,currency)
SELECT DISTINCT cs.custid, t.currency
FROM dbo.CustGameType cs WITH(NOLOCK)
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	CROSS APPLY strSplit(StakeLevelList,',') st
WHERE gametypeid IN (1701,1702)
	AND st.val IN (SELECT stakelevelid FROM #StakeLevel)	

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
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END		
GO	
-- END STEP 2: Run this SP at replicated DB -----
-----------------------------------------------------------------------------------

---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))

--get affected stakelevel will be removed				
SELECT * 
INTO #StakeLevel
FROM dbo.StakeLevel st WITH(NOLOCK)
WHERE exchangeid IN (3,6,9,12,16,17,35,64,74)--UT, Yen, US$, $US, TH, NTD, EURO, AUD, GBP, SD
	AND GameTypeID IN (1701,1702)
	AND 1 = CASE WHEN (MinStake = 100 AND MaxStake = 5000 )
					OR (MinStake = 5 AND MaxStake = 5000) THEN 1 ELSE 0 END

SELECT ci.custid, ci.currency 
INTO #tmpCust
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND ci.currency IN (3,6,9,12,16,17,35,64,74)--UT, Yen, US$, $US, TH, NTD, EURO, AUD, GBP, SD
	
INSERT INTO #supers(custid,currency)
SELECT DISTINCT cs.custid, t.currency
FROM dbo.CustGameType cs WITH(NOLOCK)
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	CROSS APPLY strSplit(StakeLevelList,',') st
WHERE gametypeid IN (1701,1702)
	AND st.val IN (SELECT stakelevelid FROM #StakeLevel)	

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
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END		
GO	

-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------		
	