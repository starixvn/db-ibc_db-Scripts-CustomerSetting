/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230731
	Task: YeeBet - Change Bet Limit [Redmine: #191947]
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST--
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT
	,@currency INT
	,@target VARCHAR(20)
	,@max_custid INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN

	DECLARE @excludedStakeLevelID INT 
	SELECT @excludedStakeLevelID = StakeLevelID
	FROM dbo.StakeLevel WITH(NOLOCK)									
	WHERE exchangeid = @currency
		AND GameTypeID = 3151
		AND MinStake = CASE WHEN @currency IN (67, 5, 2, 13) THEN 100	--HKK, HK$, RM, RMB
							WHEN @currency IN (16, 64, 3, 69) THEN 50	--Yen, UT, US$, MMK
							WHEN @currency = 45 THEN 30000 END			--Won
		AND MaxStake = CASE WHEN @currency IN (67, 5, 2, 13) THEN 40000
							WHEN @currency IN (16, 64, 3, 69) THEN 10000 
							WHEN @currency = 45 THEN 10000000 END

	DECLARE @lowerStakeLevelID INT 
	SELECT @lowerStakeLevelID = StakeLevelID
	FROM dbo.StakeLevel WITH(NOLOCK)									
	WHERE exchangeid = @currency
		AND GameTypeID = 3151
		AND MinStake = CASE WHEN @currency IN (67, 5, 2, 13) THEN 50	--HKK, HK$, RM, RMB
							WHEN @currency IN (16, 64, 3, 69) THEN 20	--Yen, UT, US$, MMK
							WHEN @currency = 45 THEN 20000 END			--Won
		AND MaxStake = CASE WHEN @currency IN (67, 5, 2, 13) THEN 20000
							WHEN @currency IN (16, 64, 3, 69) THEN 5000 
							WHEN @currency = 45 THEN 5000000 END
	
	IF @@ROWCOUNT = 0 RETURN 

	CREATE TABLE #CustStakeLevelDownlines (
				CustID INT 
				,DirectUplineID INT		
				,roleid TINYINT
				,Bettype SMALLINT
				,StakeLevelList VARCHAR(100)
				,StakeLevelList_new VARCHAR(100)							
				, PRIMARY KEY CLUSTERED(CustID,Bettype)
		)
		
	INSERT INTO #CustStakeLevelDownlines(CustID, DirectUplineID, roleid, Bettype, StakeLevelList, StakeLevelList_new)
	SELECT ci.custid,
			CASE 
				WHEN ci.roleid = 3 THEN srecommend
				WHEN ci.roleid = 2 THEN mrecommend				 	
			END AS DirectUplineID,		
			ci.roleid,cs.Bettype,cs.StakeLevelList,cs.StakeLevelList
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Agent cs WITH(NOLOCK) ON ci.custid = cs.custid			
	WHERE ci.srecommend = @srecommend
		AND ci.custid <= @max_custid
		AND roleid IN (2,3,4)
		AND Bettype = 3151
		
	UNION ALL
	SELECT ci.custid,
			recommend as DirectUplineID,		
			ci.roleid,cs.bettype,cs.StakeLevelList,cs.StakeLevelList
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Member cs WITH(NOLOCK) ON ci.custid = cs.custid				
	WHERE ci.srecommend = @srecommend
		AND ci.roleid = 1
		AND Bettype = 3151

	--Current customer is assigned several bet limits which contain the removed bet limit => Remove the required bet limit
	UPDATE cs
	SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(@excludedStakeLevelID as VARCHAR(10))+',','')),1,1,'')),'')
	FROM #CustStakeLevelDownlines cs 

	--Current customer is assigned only the bet limit which needs to be removed => Remove it and assign the adjacent lower bet limit from the upline
	--Current customer is super => Remove and assign adjacent lower bet limit in gdoc
	UPDATE cs
	SET cs.StakeLevelList_new = CAST(@lowerStakeLevelID as VARCHAR(10)) 
	FROM #CustStakeLevelDownlines cs 
	WHERE StakeLevelList <> StakeLevelList_new
		AND StakeLevelList_new = ''
		AND cs.roleid = 4

	--Current customer is assigned only the bet limit which needs to be removed => Remove it and assign the adjacent lower bet limit from the upline
	--Master	
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
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 3
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new

	--Agent		
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
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 2
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new

	--Member		
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
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 1
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new
	
	--Current customer doesn't have bet limit => Unchange
	DELETE t											
	FROM #CustStakeLevelDownlines t
	WHERE t.StakeLevelList = t.StakeLevelList_new

	DECLARE @batchSize INT = 3000
	CREATE TABLE #BatchCustStakeLevelDownlines (
				CustID INT 
				,Bettype INT
				,StakeLevelList VARCHAR(100)
				,StakeLevelList_new VARCHAR(100)							
				, PRIMARY KEY CLUSTERED (CustID,Bettype)
		)
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #BatchCustStakeLevelDownlines
		DELETE TOP (@batchSize) s
		OUTPUT DELETED.CustID, DELETED.Bettype, DELETED.StakeLevelList, DELETED.StakeLevelList_new
		INTO #BatchCustStakeLevelDownlines(CustID, Bettype, StakeLevelList, StakeLevelList_new)
		FROM #CustStakeLevelDownlines s
		WHERE roleid = 1

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE cs
		SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
		FROM dbo.CustStakeLevel_Member cs WITH(UPDLOCK,ROWLOCK)		
			INNER JOIN #BatchCustStakeLevelDownlines dl ON cs.CustID = dl.CustID 
													AND cs.bettype = dl.bettype

		WAITFOR DELAY '00:00:00.280'
	END

	UPDATE cs
	SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
	FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)			
		INNER JOIN #CustStakeLevelDownlines dl ON cs.CustID = dl.CustID 
												AND cs.bettype = dl.bettype

	DROP TABLE #CustStakeLevelDownlines, #BatchCustStakeLevelDownlines
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

--------------------------------------------------------------------------------------
-- BEGIN STEP 2: Run this script at DBCUST & all replicated servers----- -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int, currency int, isfinished bit default(0))

DECLARE @srecommend INT, 
		@currency INT,
		@max_custid INT,
		@target NVARCHAR(20)

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

SELECT @max_custid = xxx

SELECT StakeLevelID
INTO #stakeLevel
FROM dbo.Stakelevel WITH (NOLOCK)
WHERE ExchangeId IN (67, 5, 2, 13, 16, 64, 3, 69, 45)
	AND GameTypeID = 3151
	AND MinStake = CASE WHEN exchangeid IN (67, 5, 2, 13) THEN 100	--HKK, HK$, RM, RMB
						WHEN exchangeid IN (16, 64, 3, 69) THEN 50	--Yen, UT, US$, MMK
						WHEN exchangeid = 45 THEN 30000 END			--Won
	AND MaxStake = CASE WHEN exchangeid IN (67, 5, 2, 13) THEN 40000
						WHEN exchangeid IN (16, 64, 3, 69) THEN 10000 
						WHEN exchangeid = 45 THEN 10000000 END

INSERT INTO #supers(custid, currency)
SELECT ci.custid, ci.currency
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN CustSuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN CustStakeLevel_Agent ca WITH (NOLOCK) ON ci.custid = ca.CustID
	CROSS APPLY strSplit(ISNULL(StakelevelList,''),',') st
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.CustID <= @max_custid
	AND ci.Enabled = 1
	AND ci.currency IN (67, 5, 2, 13, 16, 64, 3, 69, 45)
	AND Sporttype = 159 AND Bettype = 3151
	AND st.val IN (SELECT stakelevelid FROM #stakeLevel)

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
		,@currency = currency
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 
			@srecommend = @srecommend
			,@currency = @currency
			,@target = @target
			,@max_custid = @max_custid
					
	waitfor delay '00:00:00.280'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- END STEP 2: Run this script at DBCUST & all replicated servers-----
-----------------------------------------------------------------------------------