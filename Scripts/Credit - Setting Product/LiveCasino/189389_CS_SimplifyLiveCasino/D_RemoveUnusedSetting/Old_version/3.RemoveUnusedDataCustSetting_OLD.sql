
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
  Created by: Helios
  Date: 2023/08/11
  Task: Remove Unused Data Customer Setting - Simplify Live Casino Customer Setting [redmine : #189389] 
  DB: DBCUST/CustDB
  Revisions: Initial Script
*/

 ----- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST and ALL REPLICATED SERVERS -----

BEGIN   
	SET NOCOUNT ON  

	DECLARE @SettingStatus		TINYINT = 0
		,	@ProductID			INT = 18
		,	@max_custid			INT
		,	@target				VARCHAR(20) 

	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST')
		SET @target = 'DBCUST' 
	ELSE 
		SET @target = 'REPLICATED'
	Print 'Server Name : ' + @target

	SELECT @max_custid = xxx

	---------------------------------------CREARE TEMP TABLE---------------------------------------

	-- Create Temp Table stored SportType - BetType...
	CREATE TABLE #Tmp_ProductSetting (SettingType SMALLINT , SportType SMALLINT, BetType SMALLINT, Islive BIT DEFAULT 0,
											PRIMARY KEY CLUSTERED (SettingType , SportType , BetType , Islive))


	-- Create Temp Table stored SuperInfo
	CREATE TABLE #TmpSuperInfo		 (CustID INT 
											PRIMARY KEY CLUSTERED (CustID))


	-- Create Temp Table stored WinLostLimit
	CREATE TABLE #TmpWinLostLimit_Agent		(CustID INT, SportType SMALLINT, BetType SMALLINT,
											PRIMARY KEY CLUSTERED (CustID , SportType , BetType))


	CREATE TABLE #TmpWinLostLimit_Member	(CustID INT, SportType SMALLINT, BetType SMALLINT,
											PRIMARY KEY CLUSTERED (CustID , SportType , BetType))


	-- Create Temp Table stored Discount
	CREATE TABLE #TmpDiscount_Agent		(CustID INT, SportType SMALLINT, BetType SMALLINT,
											PRIMARY KEY CLUSTERED (CustID , SportType , BetType))


	CREATE TABLE #TmpDiscount_Member	(CustID INT, SportType SMALLINT, BetType SMALLINT,
											PRIMARY KEY CLUSTERED (CustID , SportType , BetType))



	-- Create Temp Table stored PositionTaking
	CREATE TABLE #TmpPTSetting_Agent		(CustID INT, SportType SMALLINT, BetType SMALLINT, Islive BIT DEFAULT 0,
											PRIMARY KEY CLUSTERED (CustID , SportType , BetType , Islive))


	CREATE TABLE #TmpPTSetting_Member		(CustID INT, SportType SMALLINT, BetType SMALLINT, Islive BIT DEFAULT 0,
											PRIMARY KEY CLUSTERED (CustID , SportType , BetType , Islive))


	CREATE TABLE #TmpPTGroupSetting_Member	(CustID INT, SportType SMALLINT, BetType SMALLINT, Islive BIT DEFAULT 0,
											PRIMARY KEY CLUSTERED (CustID , SportType , BetType , Islive))



	---------------------------------------Declare Deployed Info---------------------------------------
	DECLARE @Batch							INT = 5000 
	,		@AffectedList					VARCHAR(MAX) = ''
	,		@Count_User						INT
	,		@msg_total						NVARCHAR(200) = 'Total of Super Headline: %d.'

	,		@msg_total_SMAWL				NVARCHAR(200) = 'Total of SMA WinLostLimit Affected: %d.'
	,		@msg_total_MemberWL				NVARCHAR(200) = 'Total of Member WinLostLimit Affected: %d.'

	,		@msg_total_SMADiscount			NVARCHAR(200) = 'Total of SMA Discount Affected: %d.'
	,		@msg_total_MemberDiscount		NVARCHAR(200) = 'Total of Member Discount Affected: %d.'

	,		@msg_total_SMAPT				NVARCHAR(200) = 'Total of SMA PT Affected: %d.'
	,		@msg_total_AgentPT				NVARCHAR(200) = 'Total of Agent PT Affected: %d.'
	,		@msg_total_MemberPT				NVARCHAR(200) = 'Total of Member PT Affected: %d.'
		
	CREATE TABLE #CustAffected (
		Custid				INT , 
		SportType			INT ,
		BetType				INT 
	)

	CREATE TABLE #CustAffectedPT (
		Custid				INT , 
		SportType			INT ,
		BetType				INT ,
		IsLive				BIT
	)

	---------------------------------------Initial SportType-BetType---------------------------------------
	
	INSERT INTO #Tmp_ProductSetting (SettingType ,SportType , BetType )
	--Win Loss Limit Live Casino
		   SELECT 6  , 159 , 3151   
	 UNION SELECT 6  , 170 , 3701   
	 UNION SELECT 6  , 211 , 2401   
	 UNION SELECT 6  , 225 , 5601   
	 UNION SELECT 6  , 233 , 3401   
	 UNION SELECT 6  , 236 , 5701   
	 UNION SELECT 6  , 239 , 3501   
	 UNION SELECT 6  , 242 , 3201   
	 UNION SELECT 6  , 243 , 3101   
	 UNION SELECT 6  , 244 , 3001   
	 UNION SELECT 12  , 241 , 3300   

	 --PositionTaking Casino (Egnor IBCBet Live Casino - 242)
	 UNION SELECT 18  , 159 , 3151   
	 UNION SELECT 18  , 170 , 3701   
	 UNION SELECT 18  , 211 , 2401   
	 UNION SELECT 18  , 225 , 5601   
	 UNION SELECT 18  , 233 , 3401   
	 UNION SELECT 18  , 236 , 5701   
	 UNION SELECT 18  , 239 , 3501   
	 UNION SELECT 18  , 241 , 3300   
	 UNION SELECT 18  , 243 , 3101   
	 UNION SELECT 18  , 244 , 3001   

	 --Discount Live Casino (Egnor IBCBet Live Casino - 242)
	 UNION SELECT 19  , 159 , 3151   
	 UNION SELECT 19  , 170 , 3701   
	 UNION SELECT 19  , 211 , 2401   
	 UNION SELECT 19  , 225 , 5601   
	 UNION SELECT 19  , 233 , 3401   
	 UNION SELECT 19  , 236 , 5701   
	 UNION SELECT 19  , 239 , 3501   
	 UNION SELECT 19  , 241 , 3300   
	 UNION SELECT 19  , 243 , 3101   
	 UNION SELECT 19  , 244 , 3001   


	---------------------------------------Collect Super Infor:---------------------------------------

	PRINT N'Step 2.0: Start on Count Total Super Headline: ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	INSERT INTO #TmpSuperInfo (CustID)
	SELECT cu.CustId
	FROM Customer cu WITH (NOLOCK)
	INNER JOIN Site s WITH (NOLOCK)
				ON cu.site = s.site
	INNER JOIN exchange e WITH (NOLOCK)
				ON cu.currency = e.ExchangeId AND e.IsActive = 1 AND e.OfferSite IN (0,1)
	LEFT JOIN custsuper cs WITH (NOLOCK) 
				ON cu.custid = cs.custid
	WHERE cu.roleid = 4  
		AND s.islicensee = 0
		AND s.isActive = 1
		AND cu.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND cu.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND cu.currency <> 20 
		AND cu.custid <= @max_custid

	SET @Count_User = (SELECT COUNT(1) FROM #TmpSuperInfo )
	RAISERROR (@msg_total, 0, 1, @Count_User) WITH NOWAIT


	---------------------------------------Collect CustSetting Infor: WinLossLimit - SettingType = 6,12---------------------------------------
	PRINT N'Step 2.1: Start on Remove Unused WinLostLimit Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	-- Collect Super, Master, Agent Setting WinLostLimit Need Remove
	INSERT INTO #TmpWinLostLimit_Agent (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType  
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustWinLossLimit_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType IN (6,12)				
	AND c.roleid IN (2,3,4)
	AND c.Enabled = 1


	SET @Count_User = (SELECT COUNT(1) FROM #TmpWinLostLimit_Agent )
	RAISERROR (@msg_total_SMAWL, 0, 1, @Count_User) WITH NOWAIT


	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected (CustID , SportType , BetType)
		FROM #TmpWinLostLimit_Agent s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
									CustID			as '@C' 			-- @CustID
								,	SportType		as '@S' 			-- @SportType
								,	BetType			as '@B'				-- @BetType
								FROM #CustAffected
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @ModeCode = 'WLAgent' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_SMAWL = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_SMAWL, 0, 1) WITH NOWAIT
	END


	-- Collect Member Setting WinLostLimit Need Remove
	INSERT INTO #TmpWinLostLimit_Member (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType  
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustWinLossLimit_Member		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType IN (6,12)				
	AND c.roleid = 1
	AND c.Enabled = 1


	SET @Count_User = (SELECT COUNT(1) FROM #TmpWinLostLimit_Member )
	RAISERROR (@msg_total_MemberWL, 0, 1, @Count_User) WITH NOWAIT


	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected (CustID , SportType , BetType)
		FROM #TmpWinLostLimit_Member s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
									CustID			as '@C' 			-- @CustID
								,	SportType		as '@S' 			-- @SportType
								,	BetType			as '@B'				-- @BetType
								FROM #CustAffected
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @ModeCode = 'WLMember' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_MemberWL = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_MemberWL, 0, 1) WITH NOWAIT
	END


	DROP TABLE #TmpWinLostLimit_Agent
	DROP TABLE #TmpWinLostLimit_Member

	-----------------------------------------Collect Super Infor: Discount - SettingType = 19---------------------------------------
	
	PRINT N'Step 2.2: Start on Remove Unused Discount Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	-- Collect Super, Master, Agent Setting Discount Need Remove
	INSERT INTO #TmpDiscount_Agent (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType  
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustDiscount3rd_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType = 19				
	AND c.roleid IN (2,3,4)
	AND c.Enabled = 1

	

	SET @Count_User = (SELECT COUNT(1) FROM #TmpDiscount_Agent )
	RAISERROR (@msg_total_SMADiscount, 0, 1, @Count_User) WITH NOWAIT


	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected (CustID , SportType , BetType)
		FROM #TmpDiscount_Agent s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
									CustID			as '@C' 			-- @CustID
								,	SportType		as '@S' 			-- @SportType
								,	BetType			as '@B'				-- @BetType
								FROM #CustAffected
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @ModeCode = 'DiscountAgent' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_SMADiscount = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_SMADiscount, 0, 1) WITH NOWAIT
	END


	---- Collect Member Setting Discount Need Remove
	INSERT INTO #TmpDiscount_Member (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType  
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustDiscount3rd_Member		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE sb.SettingType = 19		
	AND c.roleid = 1
	AND c.Enabled = 1


	SET @Count_User = (SELECT COUNT(1) FROM #TmpDiscount_Member )
	RAISERROR (@msg_total_MemberDiscount, 0, 1, @Count_User) WITH NOWAIT


	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected (CustID , SportType , BetType)
		FROM #TmpDiscount_Member s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
									CustID			as '@C' 			-- @CustID
								,	SportType		as '@S' 			-- @SportType
								,	BetType			as '@B'				-- @BetType
								FROM #CustAffected
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @ModeCode = 'DiscountMember' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_MemberDiscount = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_MemberDiscount, 0, 1) WITH NOWAIT
	END


	DROP TABLE #TmpDiscount_Agent
	DROP TABLE #TmpDiscount_Member
	-----------------------------------------Collect Super Infor: PT - SettingType = 18---------------------------------------

	PRINT N'Step 2.3: Start on Remove Unused PT Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	-- Collect Super, Master, Agent Setting PT Need Remove
	INSERT INTO #TmpPTSetting_Agent (CustID , SportType , BetType , Islive)
	SELECT ca.CustID , ca.SportType , ca.BetType , ca.Islive
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustPTSetting3rd_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType = 18			
	AND c.roleid IN (2,3,4)
	AND c.Enabled = 1

	SET @Count_User = (SELECT COUNT(1) FROM #TmpPTSetting_Agent )
	RAISERROR (@msg_total_SMAPT, 0, 1, @Count_User) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffectedPT

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.Islive
			INTO #CustAffectedPT (CustID , SportType , BetType , IsLive)
		FROM #TmpPTSetting_Agent s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
									CustID			as '@C' 			-- @CustID
								,	SportType		as '@S' 			-- @SportType
								,	BetType			as '@B'				-- @BetType
								,	IsLive			as '@I'				-- @IsLive
								FROM #CustAffectedPT
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @ModeCode = 'PTSMA' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_SMADiscount = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_SMADiscount, 0, 1) WITH NOWAIT
	END


	---- Collect Agent Setting PT Need Remove
	INSERT INTO #TmpPTGroupSetting_Member (CustID , SportType , BetType , Islive)
	SELECT ca.AgentID , ca.SportType , ca.BetType , ca.Islive
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si							ON si.CustID = c.srecommend
	INNER JOIN	CustPTGroupSetting3rd_Member		ca WITH (NOLOCK)	ON c.custid = ca.AgentID
	INNER JOIN #Tmp_ProductSetting			sb							ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType = 18			
	AND c.roleid = 2
	AND c.Enabled = 1


	SET @Count_User = (SELECT COUNT(1) FROM #TmpPTGroupSetting_Member )
	RAISERROR (@msg_total_AgentPT, 0, 1, @Count_User) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffectedPT

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.Islive
			INTO #CustAffectedPT (CustID , SportType , BetType , IsLive)
		FROM #TmpPTGroupSetting_Member s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
									CustID			as '@C' 			-- @CustID
								,	SportType		as '@S' 			-- @SportType
								,	BetType			as '@B'				-- @BetType
								,	IsLive			as '@I'				-- @IsLive
								FROM #CustAffectedPT
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @ModeCode = 'PTAgent' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_SMADiscount = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_SMADiscount, 0, 1) WITH NOWAIT
	END

	-- Collect Member Setting PT Need Remove
	INSERT INTO #TmpPTSetting_Member (CustID , SportType , BetType , Islive)
	SELECT ca.CustID , ca.SportType , ca.BetType , ca.IsLive
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustPTSetting3rd_Member		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE sb.SettingType = 18		
	AND c.roleid = 1
	AND c.Enabled = 1


	SET @Count_User = (SELECT COUNT(1) FROM #TmpPTSetting_Member )
	RAISERROR (@msg_total_MemberPT, 0, 1, @Count_User) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffectedPT

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.Islive
			INTO #CustAffectedPT (CustID , SportType , BetType , IsLive)
		FROM #TmpPTSetting_Member s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
									CustID			as '@C' 			-- @CustID
								,	SportType		as '@S' 			-- @SportType
								,	BetType			as '@B'				-- @BetType
								,	IsLive			as '@I'				-- @IsLive
								FROM #CustAffectedPT
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @ModeCode = 'PTMember' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_SMADiscount = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_SMADiscount, 0, 1) WITH NOWAIT
	END


	DROP TABLE #Tmp_ProductSetting
	DROP TABLE #TmpSuperInfo
	DROP TABLE #CustAffected
	DROP TABLE #CustAffectedPT
	DROP TABLE #TmpPTGroupSetting_Member
	DROP TABLE #TmpPTSetting_Agent
	DROP TABLE #TmpPTSetting_Member

END