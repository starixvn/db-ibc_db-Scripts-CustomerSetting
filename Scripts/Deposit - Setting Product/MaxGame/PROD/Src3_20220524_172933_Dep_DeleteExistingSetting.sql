/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220524
	Task:  Insert Setting StakeLevelGroupDetail [MaxGame] real currency - deposit RedmineID:#172933
	DB: DBCUST/CustDB
	
	P/s : Step 3 Delete existing data MaxGame for all currency
*/
-- BEGIN STEP 3.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN
	
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	DECLARE @sportType SMALLINT , @BetType  SMALLINT
	SELECT @sportType = 237 , @BetType = 5401
	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND ((cs.site IN('4300', '0sServices', '12bet', '365online', '368Cash', '383sport', '3ge888', '3Star88', '5ATech', '633esports', '88Macao', '9Bet', '9Club', '9w', '9wtest', 'A1game', 'ab6688', 'ABcasino', 'AE88', 'AEUG', 'AG', 'Aladdin99', 'ALog', 'ALPHA88', 'Alphalota', 'ANGbet', 'AnvoFH', 'AOGcasino', 'Aoncash', 'AsiaBet88', 'B24VN', 'Barcelo9', 'BE7', 'beplay', 'Betway', 'BigGaming', 'Bigwiner', 'bmwbet', 'Bobo88', 'Bolanation', 'Boma365', 'Bonanza88', 'BPLE', 'BWGaming', 'CGame', 'CGame4', 'Dabet', 'Datang001', 'Dawoo', 'Dawooxin', 'DEWA', 'dj888', 'DongYing', 'e8casino', 'ECBet88', 'ECLBET', 'erhaozhan', 'F88IN1SW', 'FB88', 'GAMEBee', 'Gaobet', 'GESAB', 'GMASTER', 'GMDFD', 'GoldenF', 'GoldenF2', 'GPIgame', 'Happy1668', 'HBPT', 'Hecbet', 'Hejiyongle', 'HFYX', 'HIDZ', 'HL8', 'HonorW', 'HY6', 'iBET', 'IBO', 'ID88', 'IGPTech', 'infini88', 'INSERTGAME', 'ITCBET', 'JBO', 'JIBET', 'Jiuyou', 'JJBGAME', 'JUNBOVN', 'JUYOU', 'Kbet', 'kgsports', 'KingBet', 'Kingfun', 'KSTECH', 'KSTECH2', 'Kzing2', 'KZSW', 'LegendWin', 'LEIHUO', 'Leng4D', 'Liga', 'LIGAWLHKB', 'LLgaming', 'loc', 'Lode88', 'm8bola', 'Macaubet', 'MANBETX', 'ManCity', 'Mancity2', 'MAX88', 'Mayayule', 'mbxusdt', 'MICL', 'Million', 'MTech', 'Mybet88', 'MYGAME', 'N88', 'n88clubSW', 'N8B', 'N8BK', 'N8G', 'Nexus', 'Niu8gaming', 'OBGM', 'OCMSS', 'Okada', 'Ole777', 'Opadmin', 'OXbet', 'PINT', 'PKbet', 'PLAYES', 'Q8Bola', 'QASite', 'Rakyat4DSW', 'RICbet', 'Rio66', 'Riverich', 'ROYAL88', 'Saba789', 'SDYSW', 'SEAGaming', 'Senibet', 'Sin88', 'Sky88', 'SL88SW', 'SM88', 'Soon88', 'starsoccer', 'STEBBCBI', 'Sunwin', 'SWDemo', 'SWSite', 'TangChao', 'TaoCai', 'TCbet', 'TH3', 'TIC88', 'Titanbet', 'TLC', 'Towin', 'Tripleone', 'TSEnter', 'TSLA', 'Twowin', 'txwl002', 'UG2', 'ug396', 'UGaming', 'Unobet', 'UNOGAMING', 'Uwoniwin', 'V03', 'VCBA', 'VEGA77', 'VKGAME', 'VN88', 'W88', 'WBG88', 'WBS', 'Wcasino', 'Wcasino88', 'Webet88', 'weicai', 'win365', 'WINCLUB88', 'WINHX1', 'Winsplay', 'WKCUR', 'WKPHIL', 'wmcasino', 'wmcasinoS', 'WRSeamless', 'WRServices', 'WSlots', 'X33Asia', 'Xiaojin', 'Xiaoxiang', 'Xinbo', 'XLMEDIA', 'XmenSW', 'XO88', 'XTDGT', 'YakaGaming', 'Yibo', 'Yintai', 'YongBao', 'YSYBO688', 'YYHbet', 'ZhiFeng132', 'Zowin', 'zt828', 'ZTech')
		AND ci.currency IN (2,3,4,6,12,13,15,45,46,51,56,61,70,72,94,96))--RM,US$,TB,EURO,GBP,RMB,IN,Won,BND,INH,PLN,INR,MKK,YNG,MK,USDT
		OR (cs.site IN('spondemo','Athena000')	AND ci.currency in (2,3,4,6,12,13,15,45,46,51,56,61,70,94,96))) --RM,US$,TB,EURO,GBP,RMB,IN,Won,BND,INH,PLN,INR,MKK,MK,USDT
	ORDER BY ci.custid 
	CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustStakeLevel_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustStakeLevel_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustStakeLevel_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustStakeLevel_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
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

	INSERT INTO #Dep_CustStakeLevel_Agent(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #Dep_CustStakeLevel_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType 

	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID,dl.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
			INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE dp.ProductID = 60

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
			
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Agent)
	BEGIN		
			
		DELETE TOP (@batch) #Dep_CustStakeLevel_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustStakeLevel_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustStakeLevel_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

		TRUNCATE TABLE #Dep_CustStakeLevel_AgentTemp				
	END 

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustStakeLevel_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustStakeLevel_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustStakeLevel_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)	
		
		TRUNCATE TABLE #Dep_CustStakeLevel_MemberTemp
			
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
	DROP TABLE #Dep_CustStakeLevel_Agent
	DROP TABLE #Dep_CustStakeLevel_Member
	DROP TABLE #Dep_LicenseeProductSetting
END	
GO
-- END STEP 3.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 3.2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

-- BEGIN STEP 3.3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'
