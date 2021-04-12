/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Adjust Setting API Licensee Deposit for Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 5 Adjust Setting API Licensee Deposit
*/
-- BEGIN STEP 5.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	@target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
	   )
		RETURN

	DECLARE	  @fSportType SMALLINT	= 220
			, @fBetType SMALLINT	= 1021
			, @tSportType SMALLINT	= 169
			, @tBetType SMALLINT	= 3611
	CREATE TABLE #Super_adjust (custid INT PRIMARY KEY)
	INSERT INTO #Super_adjust(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN('mansion88','W88','368Cash','alog','12Bet','asiabet88','Lucky88','GamingSoft','Newhonbet','365online','Dawoo','11bet','HONBET',
					  'Wanbo','KeenOcean','IBO','Bobbet','Bodog','SunGame','PKbet','Yibo','Mayfair','BOSSB','AG','HuangMa','Liga','iBET','Happy1668',
					  'KUTECH','TLC','Tianbo','KhmerG','BigGaming','IONclub','Mayayule','Fabet','Mopgaming','Abcasino','MANBETX','zt828','HonorW',
					  'Mybet88','Gampag','CGame','Royal','AEUG','IGPTech','YAYOU','Ae88','Zbet','Boying','BETSUN','WKCUR','396Club','OLE777','Sunwin',
					  'Five88','BSSB168','Wanfang','Bobo88','webet88','FLC','Callmeboss','Red88','Aplus','633esports','MTech','One88','A1game','Sun988',
					  'GMASTER','9Club','HL8','txwl002','Yunji','Sky88','VN88','TGO','24TECH','WKPHIL','3star88','Senibet','Nbbet','MRCATSB','DEWA','FB88',
					  'gbkj','GPIGAME','Nbet','ALPHA88','YTX','Heaven','Boma365','Hecbet','Debet','DingTai','ECLBET','Salon365','Tripleone','Kraton','UwinY',
					  'WINCLUB88','Soon88','ENTAPLAY','B24VN','OPEBET','88Macao','JIBET','N8G','N8B','liv66','OCMS','GGBOOK','e8casino','WBS','weicai','TopGame',
					  'PanguGame','SV88','OXbet','N88','Leng4D','YongBao','TSEnter','TangChao','TCbet','VCBA','Raisetech','ANGbet','AnvoFH','818Bet','Taipanbet',
					  'MYGAME','win365','Onegaming','Champion','XinYo','NukeGaming','US8YAYOU','Zowin','MAX88','hjccasino','Okada','HC6YAYOU','TitanCraft','Gameroom',
					  'Xinbo','MICL','allwincity','erhaozhan','CGame4','HCVIP','Swin','ID88','MFgame','N8BK','Jarvis','BPLE','Kzing2','ManCity','GESAB','Hengcai88',
					  'Lode88','Gaobet','INSERTGAME','HeleThai','Mayibet','7kplatform','Starnet','afb99','BetDeal','ENT22','GAMEBee','Hong88','TitanOne','SSSGaming',
					  '568Win','Bsdbet','Siamgame','BoinGroup','Hejiyongle','TaoCai','Dade','Datang001','NewFuture','bdtt','SDY','JIDU','Jinyazhou','Win88','Sin88',
					  'Uwoniwin','DF88','Brown888','AMG','IBG','Pinbo','BoAPI09','BWGaming','OBline','Asian88','XTDGT','wmcasino','sbt88','HOT99','JZFortune','FHLMSABA',
					  'G2Win','Datang','Bonanza88','Saba789','Man1878','starsoccer','Diamond','WGAMING','QASite','HJTK','WUYICP','Alphalota','iuplay1','TYCgame','pmwint',
					  'GOATbet','BananaTech','BB3','88Goals','DTGW','Newbet','9wickets','Mbet','WKIBPH','Apollo','Bigwiner','Win68Club','Dachen','MSbet','GPgaming88',
					  'Lefu','Weiwei','369588vip','3ge888','7Kplatfrom','Easywin22','XINSHNEG','WBG88','WB101','9wtest','M88ASIA','9w','HOT88','TXG','Sunbet138','UN168',
					  'UNOGAMING','Vwin88','KingBet','LS88','skykey','Comebet','Yabo3','AOGcasino','Pay4d','7Konline','ECBet88','HY6','Opadmin','RICbet','Dabet','Kbet',
					  'TIC88','XO88','Cali','SampleSite')
	----------------------------------------Bet Setting-------------------------------------------------	
	SELECT f.CustID, f.MinBet, f.MaxBet, f.MaxPerMatch
	INTO #CustBetSetting_Agent
	FROM dbo.Dep_CustBetSetting_Agent f WITH (NOLOCK)
		INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = f.CustID
		INNER JOIN Dep_CustBetSetting_Agent t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.MinBet		<> t.MinBet				
		OR f.MaxBet		<> t.MaxBet		
		OR f.MaxPerMatch<> t.MaxPerMatch)
	AND EXISTS (SELECT 1 FROM #Super_adjust WITH (NOLOCK) WHERE CustID = C.srecommend)
	
	SELECT f.CustID, f.MinBet, f.MaxBet, f.MaxPerMatch
	INTO #CustBetSetting_Member
	FROM dbo.Dep_CustBetSetting_Member f WITH (NOLOCK)
		INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = f.CustID
		INNER JOIN Dep_CustBetSetting_Member t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   f.MinBet		<> t.MinBet				
		OR f.MaxBet		<> t.MaxBet		
		OR f.MaxPerMatch<> t.MaxPerMatch)
	AND EXISTS (SELECT 1 FROM #Super_adjust WITH (NOLOCK) WHERE CustID = C.srecommend)

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
		 ,a.MaxPerMatch	= t.MaxPerMatch
	FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Agent t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
		 ,a.MaxPerMatch	= t.MaxPerMatch
	FROM Dep_CustBetSetting_Member a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Member t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	DROP TABLE #CustBetSetting_Agent
	DROP TABLE #CustBetSetting_Member
END
GO
-- END STEP 5.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 5.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

-- BEGIN STEP 4.3: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'

PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'