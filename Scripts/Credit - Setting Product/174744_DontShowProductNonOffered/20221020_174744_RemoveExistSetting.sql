/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Non Offer - Delete setting for EXISTS users [#RM:174744]
	DB: DBCUST/CustDB 
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT
	,@maxcustid INT
	,@bitmapOrder VARCHAR(100)
	,@isRNGKeno INT
	,@ProductID VARCHAR(100)
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN

	CREATE TABLE #ProductSettingDetail (SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT, IsLive bit, ProductID TINYINT, RealProductId TINYINT)
	CREATE TABLE #Member (CustID INT PRIMARY KEY CLUSTERED )
	CREATE TABLE #SMATemp (	CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT)

	INSERT INTO #ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, RealProductId)
	SELECT SettingType, SportType, BetType, IsLive, ProductID, RealProductId
	FROM ProductSettingDetail WITH(NOLOCK)
	WHERE SettingType NOT IN (4,11,13,21) 
	AND RealProductId  IN (SELECT VALUE AS ProductID FROM STRING_SPLIT(@ProductID,',') WHERE VALUE <> '')

	INSERT INTO #Member (CustID  )
	SELECT custid 
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

	DECLARE @batch int = 3000
	--PositionTaking
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (1,18))
	BEGIN
		CREATE TABLE #CustPTSetting3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
		CREATE TABLE #CustPTSetting3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
		CREATE TABLE #CustPTGroupSetting3rd_Member(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(AgentID ,Sporttype ,Bettype ,IsLive))

		CREATE TABLE #CustPTSetting3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
		CREATE TABLE #CustPTSetting3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
		CREATE TABLE #CustPTGroupSetting3rd_MemberTemp(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
												PRIMARY KEY(AgentID ,Sporttype ,Bettype ,IsLive))
		
		INSERT INTO #CustPTSetting3rd_Agent(CustID, SportType, BetType, IsLive)
		SELECT a.CustID, a.SportType, a.BetType, a.IsLive
		FROM CustPTSetting3rd_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (1,18)
		
		INSERT INTO #CustPTSetting3rd_Member(CustID, SportType, BetType, IsLive)
		SELECT a.CustID, a.SportType, a.BetType, a.IsLive
		FROM CustPTSetting3rd_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (1,18)

		INSERT INTO #CustPTGroupSetting3rd_Member(AgentID, SportType, BetType, IsLive)
		SELECT a.AgentID, a.SportType, a.BetType, a.IsLive
		FROM CustPTGroupSetting3rd_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.AgentID = ci.custid
		WHERE t.SettingType IN (1,18) AND ci.roleid = 2
		
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTSetting3rd_Agent)
		BEGIN
			DELETE TOP (@batch) #CustPTSetting3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
			INTO #CustPTSetting3rd_AgentTemp(CustID, SportType, BetType, IsLive)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustPTSetting3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

			TRUNCATE TABLE #CustPTSetting3rd_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTSetting3rd_Member)
		BEGIN
			DELETE TOP (@batch) #CustPTSetting3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
			INTO #CustPTSetting3rd_MemberTemp(CustID, SportType, BetType, IsLive)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustPTSetting3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

			TRUNCATE TABLE #CustPTSetting3rd_MemberTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTGroupSetting3rd_Member)
		BEGIN
			DELETE TOP (@batch) #CustPTGroupSetting3rd_Member OUTPUT DELETED.AgentID, DELETED.SportType,DELETED.BetType,DELETED.IsLive 
			INTO #CustPTGroupSetting3rd_MemberTemp(AgentID, SportType, BetType, IsLive)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustPTGroupSetting3rd_MemberTemp ci ON ci.AgentID = cg.AgentID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

			TRUNCATE TABLE #CustPTGroupSetting3rd_MemberTemp
		END

		DROP TABLE #CustPTSetting3rd_Agent
		DROP TABLE #CustPTSetting3rd_Member
		DROP TABLE #CustPTGroupSetting3rd_Member
		DROP TABLE #CustPTSetting3rd_AgentTemp
		DROP TABLE #CustPTSetting3rd_MemberTemp
		DROP TABLE #CustPTGroupSetting3rd_MemberTemp
	END

	--BetLimit	
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (2,9,16,20))
	BEGIN
		CREATE TABLE #CustBetSetting3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
		CREATE TABLE #CustBetSetting3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))

		CREATE TABLE #CustBetSetting3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		CREATE TABLE #CustBetSetting3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
		INSERT INTO #CustBetSetting3rd_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustBetSetting3rd_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (2,9,16,20)
		
		INSERT INTO #CustBetSetting3rd_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustBetSetting3rd_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (2,9,16,20)

		WHILE EXISTS(SELECT TOP 1 1 FROM #CustBetSetting3rd_Agent)
		BEGIN
			DELETE TOP (@batch) #CustBetSetting3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustBetSetting3rd_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustBetSetting3rd_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustBetSetting3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustBetSetting3rd_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustBetSetting3rd_Member)
		BEGIN
			DELETE TOP (@batch) #CustBetSetting3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustBetSetting3rd_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustBetSetting3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustBetSetting3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustBetSetting3rd_MemberTemp
		END

		DROP TABLE #CustBetSetting3rd_Agent
		DROP TABLE #CustBetSetting3rd_Member
		DROP TABLE #CustBetSetting3rd_AgentTemp
		DROP TABLE #CustBetSetting3rd_MemberTemp
	END

	--Commission		
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (3,19,5,14))
	BEGIN
		CREATE TABLE #CustDiscount3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
		CREATE TABLE #CustDiscount3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))

		CREATE TABLE #CustDiscount3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		CREATE TABLE #CustDiscount3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
		INSERT INTO #CustDiscount3rd_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustDiscount3rd_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (3,19,5,14)
		
		INSERT INTO #CustDiscount3rd_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustDiscount3rd_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (3,19,5,14)

		WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscount3rd_Agent)
		BEGIN
			DELETE TOP (@batch) #CustDiscount3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustDiscount3rd_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustDiscount3rd_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustDiscount3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustDiscount3rd_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscount3rd_Member)
		BEGIN
			DELETE TOP (@batch) #CustDiscount3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustDiscount3rd_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustDiscount3rd_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustDiscount3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustDiscount3rd_MemberTemp
		END

		DROP TABLE #CustDiscount3rd_Agent
		DROP TABLE #CustDiscount3rd_Member
		DROP TABLE #CustDiscount3rd_AgentTemp
		DROP TABLE #CustDiscount3rd_MemberTemp
	END
	
	--Win Loss Limit		
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (6,12))
	BEGIN
		CREATE TABLE #CustWinLossLimit_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
		CREATE TABLE #CustWinLossLimit_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))

		CREATE TABLE #CustWinLossLimit_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		CREATE TABLE #CustWinLossLimit_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
		INSERT INTO #CustWinLossLimit_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustWinLossLimit_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (6,12)
		
		INSERT INTO #CustWinLossLimit_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustWinLossLimit_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (6,12)

		WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLossLimit_Agent)
		BEGIN
			DELETE TOP (@batch) #CustWinLossLimit_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustWinLossLimit_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustWinLossLimit_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustWinLossLimit_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLossLimit_Member)
		BEGIN
			DELETE TOP (@batch) #CustWinLossLimit_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustWinLossLimit_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustWinLossLimit_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustWinLossLimit_MemberTemp
		END

		DROP TABLE #CustWinLossLimit_Agent
		DROP TABLE #CustWinLossLimit_Member
		DROP TABLE #CustWinLossLimit_AgentTemp
		DROP TABLE #CustWinLossLimit_MemberTemp
	END
	
	--Stake Level		
	IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (7,8,17))
	BEGIN
		CREATE TABLE #CustStakeLevel_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype ))
		CREATE TABLE #CustStakeLevel_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))

		CREATE TABLE #CustStakeLevel_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		CREATE TABLE #CustStakeLevel_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
												PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
		INSERT INTO #CustStakeLevel_Agent(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustStakeLevel_Agent a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (7,8,17)
		
		INSERT INTO #CustStakeLevel_Member(CustID, SportType, BetType)
		SELECT a.CustID, a.SportType, a.BetType
		FROM CustStakeLevel_Member a WITH(NOLOCK)
			INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
			INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		WHERE t.SettingType IN (7,8,17)

		WHILE EXISTS(SELECT TOP 1 1 FROM #CustStakeLevel_Agent)
		BEGIN
			DELETE TOP (@batch) #CustStakeLevel_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustStakeLevel_AgentTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)		
				INNER JOIN #CustStakeLevel_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustStakeLevel_AgentTemp
		END
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #CustStakeLevel_Member)
		BEGIN
			DELETE TOP (@batch) #CustStakeLevel_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
			INTO #CustStakeLevel_MemberTemp(CustID, SportType, BetType)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
				INNER JOIN #CustStakeLevel_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

			TRUNCATE TABLE #CustStakeLevel_MemberTemp
		END

		DROP TABLE #CustStakeLevel_Agent
		DROP TABLE #CustStakeLevel_Member
		DROP TABLE #CustStakeLevel_AgentTemp
		DROP TABLE #CustStakeLevel_MemberTemp
	END
	
	DROP TABLE #ProductSettingDetail	
	DROP TABLE #Member
	DROP TABLE #SMATemp
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid INT, site VARCHAR(10), currency TINYINT,isfinished BIT DEFAULT(0))
CREATE TABLE #TempSite(site nvarchar(50),	currency nvarchar(50),	bitmapOrder	varchar(100),	ProductID	varchar(100), isRNGKeno	INT)

INSERT INTO #TempSite(site , currency ,	bitmapOrder , ProductID , isRNGKeno )
		  SELECT '222223' AS site, 2 AS currency ,'25,4,8'  AS bitmapOrder                                 ,'23,24,46'  AS ProductID                                                , 0   AS isRNGKeno
UNION ALL SELECT '222223'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '222223'    , 67 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '611111'    , 2  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '611111'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '611111'    , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT '611111'    , 42 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '722222'    , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '722222'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '722222'    , 13 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '722222'    , 67 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '733333'    , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '733333'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '733333'    , 13 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '733333'    , 67 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '755555'    , 43 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '76666B'    , 69 ,'21,24,25,29,34,4,8'                                                    ,'23,24,42,46,47,51,66'                                                  , 0  
UNION ALL SELECT '789y'      , 2  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '789y'      , 3  ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '789y'      , 6  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '789y'      , 16 ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '789y'      , 35 ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '789y'      , 64 ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '7aa666'    , 2  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '7aa666'    , 69 ,'24,25,29,4,8'                                                          ,'23,24,46,47,51'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'BEST-ODDS' , 3  ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 6  ,'25,29,31,4,8'                                                          ,'23,24,46,51,59'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 9  ,'21,22,24,25,27,29,30,31,33,34,37,38,4,8'                               ,'23,24,42,45,46,47,51,52,57,59,6,65,66,70'                              , 0  
UNION ALL SELECT 'BEST-ODDS' , 10 ,'21,25,4,8'                                                             ,'23,24,42,46'                                                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 12 ,'25,29,31,37,38,4,8'                                                    ,'23,24,46,51,59,6,70'                                                   , 0  
UNION ALL SELECT 'BEST-ODDS' , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 15 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 16 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 22 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 33 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 34 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 35 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 41 ,'20,21,22,24,25,27,29,30,31,33,34,37,38,4,8'                            ,'23,24,39,42,45,46,47,51,52,57,59,6,65,66,70'                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 42 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT 'BEST-ODDS' , 43 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 45 ,'20,25,30,31,4,8'                                                       ,'23,24,39,46,57,59'                                                     , 0  
UNION ALL SELECT 'IBCIndo'   , 22 ,'4,8'                                                                   ,'23,24'                                                                 , 0  
UNION ALL SELECT 'IBCIndo'   , 33 ,'4,8'                                                                   ,'23,24'                                                                 , 0  
UNION ALL SELECT 'IBCIndo'   , 34 ,'4,8'                                                                   ,'23,24'                                                                 , 0  
UNION ALL SELECT 'IMBC'      , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT 'indo'      , 15 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 22 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 33 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 34 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 47 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'KORIBC'    , 45 ,'20,25,30,31,4,8'                                                       ,'23,24,39,46,57,59'                                                     , 0  
UNION ALL SELECT 'XYZBET'    , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'XYZBET'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT 'XYZBET'    , 6  ,'25,29,31,4,8'                                                          ,'23,24,46,51,59'                                                        , 0  
UNION ALL SELECT 'XYZBET'    , 12 ,'25,29,31,37,38,4,8'                                                    ,'23,24,46,51,59,6,70'                                                   , 0  
UNION ALL SELECT 'XYZBET'    , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT 'XYZBET'    , 15 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  


DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

DECLARE @max_custid INT, @srecommend INT , @currency TINYINT , @site VARCHAR(10), @bitmapOrder varchar(100), @ProductID varchar(100), @isRNGKeno INT
SELECT @max_custid = xxx

INSERT INTO #supers(custid, site,currency)
SELECT ci.custid, ci.site,ci.currency
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		AND (  ( ci.Site IN ('222223') AND ci.currency IN (2,5,67))
			OR ( ci.Site IN ('611111') AND ci.currency IN (13,2,42,5))
			OR ( ci.Site IN ('722222') AND ci.currency IN (13,2,5,67))
			OR ( ci.Site IN ('733333') AND ci.currency IN (13,2,5,67))
			OR ( ci.Site IN ('755555') AND ci.currency IN (43))
			OR ( ci.Site IN ('76666B') AND ci.currency IN (69))
			OR ( ci.Site IN ('789y') AND ci.currency IN (16,2,3,35,6,64))
			OR ( ci.Site IN ('7aa666') AND ci.currency IN (2,69))
			OR ( ci.Site IN ('BEST-ODDS') AND ci.currency IN (10,12,13,15,16,2,22,3,33,34,35,41,42,43,45,5,6,9))
			OR ( ci.Site IN ('IBCIndo') AND ci.currency IN (22,33,34))
			OR ( ci.Site IN ('IMBC') AND ci.currency IN (13))
			OR ( ci.Site IN ('indo') AND ci.currency IN (15,22,33,34,47))
			OR ( ci.Site IN ('KORIBC') AND ci.currency IN (45))
			OR ( ci.Site IN ('XYZBET') AND ci.currency IN (12,13,15,2,5,6)))
		
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
		,@site  = site
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	SELECT 
		@bitmapOrder = bitmapOrder,
		@isRNGKeno  = isRNGKeno	  ,
		@ProductID	= ProductID
	FROM #TempSite 
	WHERE Site = @site AND currency = @currency

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@bitmapOrder = @bitmapOrder
			,@isRNGKeno = @isRNGKeno
			,@ProductID = @ProductID
			,@target = @target
			
	waitfor delay '00:00:0.100'
END

DROP TABLE #TempSite

GO