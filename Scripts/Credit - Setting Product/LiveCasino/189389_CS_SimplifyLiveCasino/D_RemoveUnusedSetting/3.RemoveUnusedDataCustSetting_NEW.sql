
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

	DECLARE @max_custid			INT
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


	-- Create Temp Table stored WinLostLimit and Discount
	CREATE TABLE #TmpCustSettingWL_Comm	(CustID INT, SportType SMALLINT, BetType SMALLINT,
											PRIMARY KEY CLUSTERED (CustID , SportType , BetType))


	-- Create Temp Table stored PositionTaking
	CREATE TABLE #TmpCustSettingPT	(CustID INT, SportType SMALLINT, BetType SMALLINT, Islive BIT DEFAULT 0,
											PRIMARY KEY CLUSTERED (CustID , SportType , BetType , Islive))



	---------------------------------------Declare Deployed Info---------------------------------------
	DECLARE @Batch							INT = 5000 
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

	 --PositionTaking Casino (Ignore SportType 242 - IBCBet Live Casino of Site IBCIndo )
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

	 --Discount Live Casino (Ignore SportType 242 - IBCBet Live Casino of Site IBCIndo )
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
		AND cu.custid <= @max_custid

	SET @Count_User = (SELECT COUNT(1) FROM #TmpSuperInfo )
	RAISERROR (@msg_total, 0, 1, @Count_User) WITH NOWAIT


	---------------------------------------Collect CustSetting Infor: WinLossLimit - SettingType = 6,12---------------------------------------
	PRINT N'Step 2.1: Start on Remove Unused WinLostLimit Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	-- Collect Super, Master, Agent Setting WinLostLimit Need Remove
	INSERT INTO #TmpCustSettingWL_Comm (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType  
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustWinLossLimit_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType IN (6,12)				
	AND c.roleid IN (2,3,4)
	AND c.Enabled = 1


	SET @Count_User = (SELECT COUNT(1) FROM #TmpCustSettingWL_Comm )
	RAISERROR (@msg_total_SMAWL, 0, 1, @Count_User) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected (CustID , SportType , BetType)
		FROM #TmpCustSettingWL_Comm s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
			
		EXEC dbo.[Acc_DynamicCustSetting3rd_09] @ModeCode = 'WLAgent' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_SMAWL = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_SMAWL, 0, 1) WITH NOWAIT
	END

	-- Collect Member Setting WinLostLimit Need Remove
	INSERT INTO #TmpCustSettingWL_Comm (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType  
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustWinLossLimit_Member		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType IN (6,12)				
	AND c.roleid = 1
	AND c.Enabled = 1


	SET @Count_User = (SELECT COUNT(1) FROM #TmpCustSettingWL_Comm )
	RAISERROR (@msg_total_MemberWL, 0, 1, @Count_User) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected (CustID , SportType , BetType)
		FROM #TmpCustSettingWL_Comm s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
		
		EXEC dbo.[Acc_DynamicCustSetting3rd_09] @ModeCode = 'WLMember' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_MemberWL = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_MemberWL, 0, 1) WITH NOWAIT
	END



	-----------------------------------------Collect Super Infor: Discount - SettingType = 19---------------------------------------
	
	PRINT N'Step 2.2: Start on Remove Unused Discount Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	-- Collect Super, Master, Agent Setting Discount Need Remove
	INSERT INTO #TmpCustSettingWL_Comm (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType  
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustDiscount3rd_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType = 19				
	AND c.roleid IN (2,3,4)
	AND c.Enabled = 1

	SET @Count_User = (SELECT COUNT(1) FROM #TmpCustSettingWL_Comm )
	RAISERROR (@msg_total_SMADiscount, 0, 1, @Count_User) WITH NOWAIT


	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected (CustID , SportType , BetType)
		FROM #TmpCustSettingWL_Comm s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		EXEC dbo.[Acc_DynamicCustSetting3rd_09] @ModeCode = 'DiscountAgent' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_SMADiscount = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_SMADiscount, 0, 1) WITH NOWAIT
	END

	---- Collect Member Setting Discount Need Remove
	INSERT INTO #TmpCustSettingWL_Comm (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType  
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustDiscount3rd_Member		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE sb.SettingType = 19		
	AND c.roleid = 1
	AND c.Enabled = 1

	SET @Count_User = (SELECT COUNT(1) FROM #TmpCustSettingWL_Comm )
	RAISERROR (@msg_total_MemberDiscount, 0, 1, @Count_User) WITH NOWAIT


	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected (CustID , SportType , BetType)
		FROM #TmpCustSettingWL_Comm s
		
		IF @@ROWCOUNT = 0 
			BREAK ;

		EXEC dbo.[Acc_DynamicCustSetting3rd_09] @ModeCode = 'DiscountMember' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_MemberDiscount = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_MemberDiscount, 0, 1) WITH NOWAIT
	END


	DROP TABLE #TmpCustSettingWL_Comm

	-----------------------------------------Collect Super Infor: PT - SettingType = 18---------------------------------------

	PRINT N'Step 2.3: Start on Remove Unused PT Setting ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	-- Collect Super, Master, Agent Setting PT Need Remove
	INSERT INTO #TmpCustSettingPT (CustID , SportType , BetType , Islive)
	SELECT ca.CustID , ca.SportType , ca.BetType , ca.Islive
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustPTSetting3rd_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType = 18			
	AND c.roleid IN (2,3,4)
	AND c.Enabled = 1

	SET @Count_User = (SELECT COUNT(1) FROM #TmpCustSettingPT )
	RAISERROR (@msg_total_SMAPT, 0, 1, @Count_User) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.Islive
			INTO #CustAffected (CustID , SportType , BetType , IsLive)
		FROM #TmpCustSettingPT s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
			
		EXEC dbo.[Acc_DynamicCustSetting3rd_09] @ModeCode = 'PTSMA' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_SMAPT = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_SMAPT, 0, 1) WITH NOWAIT
	END

	---- Collect Agent Setting PT Need Remove
	INSERT INTO #TmpCustSettingPT (CustID , SportType , BetType , Islive)
	SELECT ca.AgentID , ca.SportType , ca.BetType , ca.Islive
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si							ON si.CustID = c.srecommend
	INNER JOIN	CustPTGroupSetting3rd_Member		ca WITH (NOLOCK)	ON c.custid = ca.AgentID
	INNER JOIN #Tmp_ProductSetting			sb							ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE  sb.SettingType = 18			
	AND c.roleid = 2
	AND c.Enabled = 1

	SET @Count_User = (SELECT COUNT(1) FROM #TmpCustSettingPT )
	RAISERROR (@msg_total_AgentPT, 0, 1, @Count_User) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.Islive
			INTO #CustAffected (CustID , SportType , BetType , IsLive)
		FROM #TmpCustSettingPT s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		EXEC dbo.[Acc_DynamicCustSetting3rd_09] @ModeCode = 'PTAgent' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_AgentPT = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_AgentPT, 0, 1) WITH NOWAIT
	END

	-- Collect Member Setting PT Need Remove
	INSERT INTO #TmpCustSettingPT (CustID , SportType , BetType , Islive)
	SELECT ca.CustID , ca.SportType , ca.BetType , ca.IsLive
	FROM custInfo c WITH (NOLOCK)
	INNER JOIN	#TmpSuperInfo				si					ON si.CustID = c.srecommend
	INNER JOIN	CustPTSetting3rd_Member		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN #Tmp_ProductSetting			sb					ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE sb.SettingType = 18		
	AND c.roleid = 1
	AND c.Enabled = 1

	SET @Count_User = (SELECT COUNT(1) FROM #TmpCustSettingPT )
	RAISERROR (@msg_total_MemberPT, 0, 1, @Count_User) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.Islive
			INTO #CustAffected (CustID , SportType , BetType , IsLive)
		FROM #TmpCustSettingPT s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		EXEC dbo.[Acc_DynamicCustSetting3rd_09] @ModeCode = 'PTMember' , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_MemberPT = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_MemberPT, 0, 1) WITH NOWAIT
	END

	
	DROP TABLE #TmpCustSettingPT
	
	DROP TABLE #CustAffected
	DROP TABLE #TmpSuperInfo
	DROP TABLE #Tmp_ProductSetting

END