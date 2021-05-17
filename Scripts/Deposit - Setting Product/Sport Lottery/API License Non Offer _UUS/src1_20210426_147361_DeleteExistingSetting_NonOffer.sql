/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210517
	Task: Delete existing data for New API Licensee Deposit Sports Lottery Non Offer lottery -  UUS RedmineID:#147361
	DB: DBCUST/CustDB
	
	P/s : Step 1 Delete existing for New API Licensee Deposit -  UUS
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	DECLARE @sportType SMALLINT , @BetType SMALLINT
	SELECT @sportType = 169 , @BetType = 3611
	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN( '12B', '18Luck', '24AVIA', '24AVIASL', '368CashSW', '568WinSW', '998bet', '9Wsports', 'Apollo369', 'Asia999', 'awc', 'awc2', 'Baji', 'BBIN2', 'BBIN3', 'BBIN4', 'bdtt2', 'BoAPI10', 'BoAPI11', 'BOG22', 'CENTRAL168', 'dabo88', 'DBP', 'directapi', 'EasywinSW', 'GGBOOKES', 'GoToWin', 'GSCSW', 'HAIFA', 'Happy8', 'Heji888', 'ig128', 'ig128s', 'IgameTech', 'IGSW', 'ISC888', 'iuplay2', 'IvoryBet', 'J9YAYOU', 'JGQP8', 'JIB88', 'Junbet', 'K8VN', 'khmer', 'khmerA2', 'KUTECH', 'liv66SW', 'livv88sw', 'LLGAME', 'M8Credit', 'MARS', 'Monaco', 'mtegames', 'NextBet', 'Nova88', 'Omni88', 'OneSports', 'Opal88', 'OSUSDT', 'PKKing', 'Sabademo', 'SAGAME88', 'SampleTest', 'SBObet', 'shengboyun', 'SM88', 'Storm88', 'Sunrise', 'Sunriseb2b', 'THECLUB', 'THEDEN', 'TT128', 'ug396', 'VWIN66', 'WABET', 'Wanfang', 'Winbox', 'X2Dynamic', 'XTD3', 'Xtu168', 'YBTech', 'ZFRT069', 'ZFRT080', 'ZFRT081', 'ZFRT082', 'ZFRT115', 'ZFRT124', 'ZFRT125', 'ZFRT125MGT', 'ZFRT127', 'ZFRT128', 'ZFRT129', 'ZFRT132', 'ZFRT133', 'ZFRT142', 'ZFRT144', 'ZFRT150', 'ZFRT155', 'ZFRT80GPGT', 'ZhiFeng009', 'ZhiFeng012', 'ZhiFeng021', 'ZhiFeng030', 'ZhiFeng032', 'ZhiFeng035', 'ZhiFeng036', 'ZhiFeng037', 'ZhiFeng040', 'ZhiFeng046', 'ZhiFeng051', 'ZhiFeng076', 'Happy8', 'HongChow', 'Hongtubet', 'OkadaSW', 'Saibo', 'tcycyl', 'TGame', 'Zzun88','ARYA','OYO','ZhiFeng106','ZFRT156','NEWBALL','d3sports','ZFRT143','Tesla')
		AND ci.currency IN (20)  -- UUS
		
	CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustBetSetting_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustBetSetting_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustBetSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustBetSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSettingTemp(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	INSERT INTO #Dep_CustPTSetting_Agent(CustID,Sporttype,Bettype,IsLive)
	SELECT s.Custid,SportType,BetType,IsLive 
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #Dep_CustPTSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.CustID,Sporttype,Bettype,IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #Dep_CustPTGroupSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT AgentID,SportType,BetType,IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType 

	INSERT INTO #Dep_CustBetSetting_Agent(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #Dep_CustBetSetting_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID,dl.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
			INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE dp.ProductID = 63

	DECLARE @batch int = 3000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustPTSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive INTO #Dep_CustPTSetting_AgentTemp(CustID,Sporttype,Bettype,IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive

		TRUNCATE TABLE #Dep_CustPTSetting_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Member)
	BEGIN	
	
		DELETE TOP (@batch) #Dep_CustPTSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive INTO #Dep_CustPTSetting_MemberTemp(CustID,Sporttype,Bettype,IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
		OPTION(MAXDOP 1)
		
		TRUNCATE TABLE #Dep_CustPTSetting_MemberTemp
				
	END  
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTGroupSetting_Member)
	BEGIN	
		DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive INTO #Dep_CustPTGroupSetting_MemberTemp(CustID,Sporttype,Bettype,IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTGroupSetting_MemberTemp  t 
				ON cg.AgentID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
			
		TRUNCATE TABLE #Dep_CustPTGroupSetting_MemberTemp			
	END 		
			
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustBetSetting_Agent)
	BEGIN		
			
		DELETE TOP (@batch) #Dep_CustBetSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustBetSetting_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustBetSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

		TRUNCATE TABLE #Dep_CustBetSetting_AgentTemp				
	END 

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustBetSetting_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustBetSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustBetSetting_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustBetSetting_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)	
		
		TRUNCATE TABLE #Dep_CustBetSetting_MemberTemp
			
	END	
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
	BEGIN	
		DELETE TOP (@batch) #Dep_LicenseeProductSetting OUTPUT DELETED.CustID,DELETED.ProductSettingID INTO #Dep_LicenseeProductSettingTemp(CustID,ProductSettingID)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_LicenseeProductSetting cg WITH(ROWLOCK)		
		INNER JOIN #Dep_LicenseeProductSettingTemp  t 
			ON cg.CustID=t.CustID AND cg.ProductSettingID=t.ProductSettingID	
	
		TRUNCATE TABLE #Dep_LicenseeProductSettingTemp			
	END
	
	DROP TABLE #Dep_CustPTSetting_Agent
	DROP TABLE #Dep_CustPTSetting_Member
	DROP TABLE #Dep_CustPTGroupSetting_Member
	DROP TABLE #Dep_CustBetSetting_Agent
	DROP TABLE #Dep_CustBetSetting_Member
	DROP TABLE #Dep_LicenseeProductSetting
END	
GO
-- END STEP 1.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 1.2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

-- BEGIN STEP 1.3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'
