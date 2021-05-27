/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210514
	Task:  Update Stake New User for AdvantPlay Mini RedmineID:#155133
	DB: DBCust/CustDB
	P/s : Step 7 Update Stake New User  
*/
	PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
	CREATE TABLE #CustListAgent (CustID INT PRIMARY KEY,currency INT,StakeLevelID INT)
	CREATE TABLE #CustListMember (CustID INT PRIMARY KEY CLUSTERED,currency INT,StakeLevelID INT,isfinished BIT DEFAULT(0))
		
	DECLARE @GameTypeID	 INT,@GameGroupID INT,@SportType SMALLINT,@StakeLevelID INT,@MaxCustID INT
	SELECT @GameTypeID = 7801,@SportType = 174,@GameGroupID = 29, @MaxCustID = xxx 
	
	CREATE TABLE #supers (custid int)

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
				AND s.site NOT IN ('CN88','76666B')
				AND ci.currency IN (2,3,5,6,7,12,13,15,16,22,33,34,35,43,45,47,51,64,67,69,95)
		--RM,US$,HK$,EURO,DON,GBP,RMB,IN,Yen,IND,IDD,IDR,$US,THB,Won,DDD,INH,UT,HKK,MMK,USD
	--====================== Check Data
	SELECT DISTINCT cg.custid 
	INTO #CustStakeLevel_Agent
	FROM dbo.CustStakeLevel_Agent cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND ci.custid > @maxcustid

	SELECT DISTINCT cg.custid 
	INTO #CustStakeLevel_Member
	FROM dbo.CustStakeLevel_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE SportType = @Sporttype AND ci.custid > @maxcustid
	
	DELETE cg
	FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)		
		INNER JOIN #CustStakeLevel_Agent ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype

	DELETE cg
	FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
		INNER JOIN #CustStakeLevel_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype
	--======================	
	INSERT INTO #CustListAgent(CustID,currency,StakeLevelID)
	SELECT ci.custid,ci.currency,sl.StakeLevelID
	FROM dbo.customer ci WITH (NOLOCK)
	INNER JOIN	dbo.StakeLevel sl WITH (NOLOCK) on ci.currency = sl.ExchangeId
	WHERE sl.GameTypeID = @GameTypeID
		AND sl.GameGroupID = @GameGroupID 
		AND ci.roleid in (2,3,4)
		AND ci.custid > @maxcustid
		AND ci.srecommend IN (SELECT custid FROM #supers)

	INSERT INTO #CustListMember(CustID,currency,StakeLevelID)
	SELECT ci.custid,ci.currency,sl.StakeLevelID
	FROM dbo.customer ci WITH (NOLOCK)
	INNER JOIN	dbo.StakeLevel sl WITH (NOLOCK) on ci.currency = sl.ExchangeId
	WHERE sl.GameTypeID = @GameTypeID
		AND sl.GameGroupID = @GameGroupID  
		AND ci.roleid = 1	
		AND ci.custid > @maxcustid
		AND ci.srecommend IN (SELECT custid FROM #supers)
	--------------------------------- BetSetting ---------------------------------
	INSERT INTO dbo.CustStakeLevel_Agent  ([CustID]
										   ,[SportType]
										   ,[BetType]
										   ,[StakeLevelList])
	SELECT CustID , @SportType,@GameTypeID,StakeLevelID as [StakeLevelList]
	FROM #CustListAgent 

	DECLARE @Cust_Temp TABLE(CustID INT,StakeLevelID INT)
	DECLARE @BatchSize SMALLINT = 5000

	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.StakeLevelID INTO @Cust_Temp(CustID,StakeLevelID)
		FROM #CustListMember c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	
			
		INSERT INTO dbo.CustStakeLevel_Member([CustID]
										   ,[SportType]
										   ,[BetType]
										   ,[StakeLevelList]
										   ,LastUpdated) 
		SELECT CustID , @SportType,@GameTypeID,StakeLevelID as [StakeLevelList],GETDATE() as LastUpdated
		FROM @Cust_Temp	
		
		DELETE FROM @Cust_Temp
	END
	PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 