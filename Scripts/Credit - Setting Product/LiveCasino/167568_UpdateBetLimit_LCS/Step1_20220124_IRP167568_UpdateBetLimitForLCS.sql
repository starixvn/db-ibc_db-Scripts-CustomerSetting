/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220124@Johnson
	Task: BigGaming & WM Live Casino - Request to remove bet limit range for THB, HKK, HK$, RM
	DB: DBCust/CustDB
*/


-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]	
	@srecommend INT
	,@currency INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbtrans only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	
	DECLARE @tmpStakeExcluded TABLE (StakeLevelID INT, GameTypeID INT)
	
	INSERT INTO @tmpStakeExcluded(StakeLevelID,GameTypeID)
	SELECT StakeLevelID,GameTypeID
	FROM StakeLevel WITH(NOLOCK)
	WHERE GameTypeID IN (3401,3501)
		AND ExchangeId = @currency
		AND 1= CASE WHEN @currency = 43 AND ((GameTypeID = 3401 AND MinStake = 500 AND MaxStake = 50000)
											OR (GameTypeID = 3501 AND MinStake = 5000 AND MaxStake = 100000)) THEN 1
					WHEN @currency IN (2,5,67) AND MinStake = 100 AND MaxStake = 10000 THEN 1
					ELSE 0 END
		
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
		AND Bettype IN (SELECT GameTypeID FROM @tmpStakeExcluded)
	UNION ALL
	SELECT ci.custid,
		  recommend as DirectUplineID,		
		 ci.roleid,cs.bettype,cs.StakeLevelList,cs.StakeLevelList
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Member cs WITH(NOLOCK) ON ci.custid = cs.custid			
	WHERE ci.srecommend = @srecommend
		AND ci.roleid = 1
		AND Bettype IN (SELECT GameTypeID FROM @tmpStakeExcluded)
	
	--Remove exclude stakelevel for downlines
	UPDATE cs
	SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(t.StakeLevelID as VARCHAR(10))+',','')),1,1,'')),'')
	FROM #CustStakeLevelDownlines cs
		INNER JOIN @tmpStakeExcluded t ON cs.bettype = t.GameTypeID
	
	--Apply highest stakelevel if new stakelevel doesnt have any	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN @tmpStakeExcluded s ON t.Bettype = s.GameTypeID
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM dbo.StakeLevel SL WITH(NOLOCK) 
					WHERE SL.GameTypeID = s.GameTypeID
						AND exchangeid = @currency
						AND SL.StakeLevelID <> s.StakeLevelID
						AND MinStake <> 0 
						AND MaxStake <> 0
					ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 4
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining	
		
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND T.Bettype = Upline.Bettype
												AND Upline.StakeLevelList_new <> ''											
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(Upline.StakeLevelList_new,','))  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 3
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining	
	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND Upline.StakeLevelList_new <> ''			 
												AND T.Bettype = Upline.Bettype
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(Upline.StakeLevelList_new,','))  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 2
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining	
	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND Upline.StakeLevelList_new <> ''			 
												AND t.Bettype = Upline.Bettype
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(Upline.StakeLevelList_new,','))  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY maxstake DESC
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
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @srecommend INT,		
		@currency INT,	
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))

--get affected stakelevel will be removed				
SELECT * 
INTO #StakeLevel
FROM StakeLevel WITH(NOLOCK)
WHERE GameTypeID IN (3401,3501)
	AND ExchangeId IN (2,5,43,67)
	AND 1= CASE WHEN ExchangeId = 43 AND ((GameTypeID = 3401 AND MinStake = 500 AND MaxStake= 50000)
										OR (GameTypeID = 3501 AND MinStake = 5000 AND MaxStake = 100000)) THEN 1
				WHEN ExchangeId IN (2,5,67) AND MinStake = 100 AND MaxStake = 10000 THEN 1
				ELSE 0 END

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
	AND ci.currency IN (2,5,43,67)
	
INSERT INTO #supers(custid,currency)
SELECT DISTINCT cs.custid, t.currency
FROM dbo.CustStakeLevel_Agent cs WITH(NOLOCK)
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	INNER JOIN #StakeLevel s ON cs.Bettype = s.GameTypeID
	CROSS APPLY strSplit(ISNULL(StakeLevelList,''),',') st
WHERE st.val IN (SELECT stakelevelid FROM #StakeLevel)	

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
			@target = @target
	--run in UM so dont need to delay 280ms			
	WAITFOR DELAY '00:00:00.100'			
END		

DROP TABLE #tmpCust
DROP TABLE #supers
DROP TABLE #StakeLevel
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	
		