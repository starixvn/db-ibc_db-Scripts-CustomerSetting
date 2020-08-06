/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Update Stake New User PG [PG Game] RedmineID:#137763
	DB: DBCust/CustDB
*/			
	CREATE TABLE #CustListAgent (CustID INT PRIMARY KEY,currency INT,StakeLevelID INT)
	CREATE TABLE #CustListMember (CustID INT PRIMARY KEY CLUSTERED,currency INT,StakeLevelID INT,isfinished BIT DEFAULT(0))
		
	DECLARE @GameTypeID	 INT,@GameGroupID INT,@SportType SMALLINT,@StakeLevelID INT,@MaxCustID INT
	SELECT @GameTypeID = 6001,@SportType = 232, @MaxCustID = xxx 
		
	INSERT INTO #CustListAgent(CustID,currency,StakeLevelID)
	SELECT ci.custid,ci.currency,sl.StakeLevelID
	FROM dbo.customer ci WITH (NOLOCK)
	INNER JOIN	dbo.StakeLevel sl WITH (NOLOCK) on ci.currency = sl.ExchangeId
	WHERE sl.GameTypeID = GameTypeID
		AND sl.GameGroupID = @GameGroupID 
		AND ci.roleid in (2,3,4)
		AND ci.custid > @maxcustid
		AND ci.Site IN ('755555','IBCIndo','Indo','KORIBC','789y')
		AND ci.currency IN (15 --IN
							,22 --IND
							,33 --IDD
							,34 --IDR
							,47 --DDD
							,45 --Won
							,4  --TB
							,43 --THB
							,95 --USD
							,3 --US$
							,16 --Yen
							,64 --UT
							)

	INSERT INTO #CustListMember(CustID,currency,StakeLevelID)
	SELECT ci.custid,ci.currency,sl.StakeLevelID
	FROM dbo.customer ci WITH (NOLOCK)
	INNER JOIN	dbo.StakeLevel sl WITH (NOLOCK) on ci.currency = sl.ExchangeId
	WHERE sl.GameTypeID = GameTypeID
		AND sl.GameGroupID = @GameGroupID  
		AND ci.roleid = 1	
		AND ci.custid > @maxcustid
		AND ci.Site IN ('755555','IBCIndo','Indo','KORIBC','789y')
		AND ci.currency IN (15 --IN
							,22 --IND
							,33 --IDD
							,34 --IDR
							,47 --DDD
							,45 --Won
							,4  --TB
							,43 --THB
							,95 --USD
							,3 --US$
							,16 --Yen
							,64 --UT
							) 
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


