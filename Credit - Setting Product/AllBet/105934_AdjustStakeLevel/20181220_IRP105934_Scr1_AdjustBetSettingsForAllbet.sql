/*
	Created: Johnson
	Date: 2018-12-20
	Task: Adjust Allbet bet settings for customers under HKD group
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
	
	DECLARE @stakeLevelID_Excluded INT
	
	SELECT @StakeLevelID_Excluded = StakeLevelID
	FROM dbo.StakeLevel WITH(NOLOCK)
	WHERE exchangeid = @currency
		AND GameTypeID = 2401
		AND MinStake = CASE WHEN @currency IN (1,3,6,12,16,17,35,40,64,74) THEN 250 --$US, NTD, US$, UT, Yen, IRR, EURO, SD$, GBP, TH
							WHEN @currency = 67 THEN 500 END
		AND MaxStake = CASE WHEN @currency IN (1,3,6,12,16,17,35,40,64,74) THEN 10000 --$US, NTD, US$, UT, Yen, IRR, EURO, SD$, GBP, TH
							WHEN @currency = 67 THEN 25000 END				
	
	IF @@ROWCOUNT =0 RETURN						
	
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
		AND roleid IN (2,3,4)
		AND Bettype = 2401
		
	UNION ALL
	SELECT ci.custid,
		  recommend as DirectUplineID,		
		 ci.roleid,cs.bettype,cs.StakeLevelList,cs.StakeLevelList
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Member cs WITH(NOLOCK) ON ci.custid = cs.custid			
	WHERE ci.srecommend = @srecommend
		AND ci.roleid = 1
		AND Bettype = 2401
	
	--Remove exclude stakelevel for downlines
	UPDATE cs
	SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(@StakeLevelID_Excluded as VARCHAR(10))+',','')),1,1,'')),'')
	FROM #CustStakeLevelDownlines cs 

	--Apply lowest stakelevel if new stakelevel doesnt have any	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM dbo.StakeLevel SL WITH(NOLOCK) 
					WHERE SL.GameTypeID = 2401
						AND exchangeid = @currency
						AND StakeLevelID <> @StakeLevelid_Excluded
						AND MinStake <> 0 
						AND MaxStake <> 0
					ORDER BY minstake , maxstake
					) T1 -- Direct Upline
	WHERE t.roleid = 4
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining	
		
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND Upline.StakeLevelList_new <> ''			 		
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
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND Upline.StakeLevelList_new <> ''			 
		
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
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND Upline.StakeLevelList_new <> ''			 
		
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
	
	DELETE #CustStakeLevelDownlines
	WHERE StakeLevelList = StakeLevelList_new
	
	UPDATE cs
	SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
	FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustStakeLevelDownlines dl ON cs.CustID = dl.CustID 
												AND cs.bettype = dl.bettype
	WHERE dl.StakeLevelList <> dl.StakeLevelList_new
		
	UPDATE cs
	SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
	FROM dbo.CustStakeLevel_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustStakeLevelDownlines dl ON cs.CustID = dl.CustID 
												AND cs.bettype = dl.bettype
	WHERE dl.StakeLevelList <> dl.StakeLevelList_new	
	
	DROP TABLE #CustStakeLevelDownlines	
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
WHERE exchangeid IN (1,3,6,12,16,17,35,40,64,74, 67) --$US, NTD, US$, UT, Yen, IRR, EURO, SD$, GBP, TH, HKK
	AND GameTypeID = 2401
	AND MinStake = CASE WHEN exchangeid IN (1,3,6,12,16,17,35,40,64,74) THEN 250
						WHEN exchangeid = 67 THEN 500 END
	AND MaxStake = CASE WHEN exchangeid IN (1,3,6,12,16,17,35,40,64,74) THEN 10000
						WHEN exchangeid = 67 THEN 25000 END

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
	AND ci.currency IN (1,3,6,12,16,17,35,40,64,74,67)--UT, Yen, US$, $US, TH, NTD, EURO, IRR, AUD, GBP, SD,HKK
	
INSERT INTO #supers(custid,currency)
SELECT DISTINCT cs.custid, t.currency
FROM dbo.CustStakeLevel_Agent cs WITH(NOLOCK)
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	CROSS APPLY strSplit(ISNULL(StakeLevelList,''),',') st
WHERE bettype = 2401
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
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@target = 'REPLICATED' 	
	--run in UM so dont need to delay 280ms			
	WAITFOR DELAY '00:00:00.100'			
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
WHERE exchangeid IN (1,3,6,12,16,17,35,40,64,74, 67) --$US, NTD, US$, UT, Yen, IRR, EURO, SD$, GBP, TH, HKK
	AND GameTypeID = 2401
	AND MinStake = CASE WHEN exchangeid IN (1,3,6,12,16,17,35,40,64,74) THEN 250
						WHEN exchangeid = 67 THEN 500 END
	AND MaxStake = CASE WHEN exchangeid IN (1,3,6,12,16,17,35,40,64,74) THEN 10000
						WHEN exchangeid = 67 THEN 25000 END

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
	AND ci.currency IN (1,3,6,12,16,17,35,40,64,74,67)--UT, Yen, US$, $US, TH, NTD, EURO, IRR, AUD, GBP, SD,HKK
	
INSERT INTO #supers(custid,currency)
SELECT DISTINCT cs.custid, t.currency
FROM dbo.CustStakeLevel_Agent cs WITH(NOLOCK)
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	CROSS APPLY strSplit(ISNULL(StakeLevelList,''),',') st
WHERE bettype = 2401
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
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@target = 'DBCUST' 	
	--run in UM so dont need to delay 280ms			
	WAITFOR DELAY '00:00:00.100'			
END		
GO	
-- END STEP 3: Run this SP at DBCUST -----
-----------------------------------------------------------------------------------	