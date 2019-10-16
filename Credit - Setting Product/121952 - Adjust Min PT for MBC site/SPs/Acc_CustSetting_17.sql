 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSetting (SportBook and SportBook2)
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_CustSetting_17]
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustOverride') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSetting') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	

	CREATE TABLE #CustList (CustID INT PRIMARY KEY, PT smallmoney, roleID tinyint)
	INSERT INTO #CustList(custid, PT)					
		  SELECT 211567		, 0.85	--S33E			
	UNION SELECT 368537		, 0.85	--S8U
	UNION SELECT 390567		, 0.85	--S33SM
	UNION SELECT 507226		, 0.85	--S188RM
	UNION SELECT 527906		, 0.85	--S6EU
	UNION SELECT 570302		, 0.85	--IMBUSD
	UNION SELECT 604044		, 0.85	--S7RM
	UNION SELECT 695131		, 0.85	--S51SM
	UNION SELECT 706886		, 0.85	--S6US
	UNION SELECT 753624		, 0.85	--SOGO
	UNION SELECT 817188		, 0.85	--S42RM
	UNION SELECT 1201561	, 0.85	--SWU
	UNION SELECT 1717148	, 0.85	--SA-12IBCBP
	UNION SELECT 1807421	, 0.85	--MTESTEU
	UNION SELECT 2252615	, 0.85	--STEU
	UNION SELECT 2383816	, 0.85	--SAS
	UNION SELECT 2904839	, 0.85	--330GBP
	UNION SELECT 3026431	, 0.85	--MIRI RM
	UNION SELECT 3026459	, 0.85	--MIRI SD
	UNION SELECT 3026476	, 0.85	--MIRI USD
	UNION SELECT 3026484	, 0.85	--MIRI HKD
	UNION SELECT 3026489	, 0.85	--MIRI RMB
	UNION SELECT 3026492	, 0.85	--MIRI EU
	UNION SELECT 3026495	, 0.85	--MIRI BP
	UNION SELECT 3676675	, 0.85	--S6H
	UNION SELECT 5283781	, 0.85	--SATE
	UNION SELECT 5711971	, 0.85	--S6BP
	UNION SELECT 7604170	, 0.85	--S99HKD
	UNION SELECT 7772435	, 0.85	--2EU
	UNION SELECT 7781015	, 0.85	--SATM
	UNION SELECT 8551070	, 0.85	--gtwrong
	UNION SELECT 9342128	, 0.85	--S69E
	UNION SELECT 10321289	, 0.85	--SAE
	UNION SELECT 10440396	, 0.85	--S999S
	UNION SELECT 10933415	, 0.85	--SVVG
	UNION SELECT 12048828	, 0.85	--KPW
	UNION SELECT 13893053	, 0.85	--AKO2
	UNION SELECT 15252449	, 0.85	--S69BP
	UNION SELECT 15530229	, 0.85	--S9KW
	UNION SELECT 16645316	, 0.85	--SVE
	UNION SELECT 17066207	, 0.85	--BYU
	UNION SELECT 17120967	, 0.85	--AKO3
	UNION SELECT 17200168	, 0.85	--S9EU
	UNION SELECT 22534793	, 0.85	--FNG
	UNION SELECT 22535487	, 0.85	--FNU
	UNION SELECT 25196109	, 0.85	--OPS-US$
	UNION SELECT 25196224	, 0.85	--OPS-GBP
	UNION SELECT 25266465	, 0.85	--AGC
	UNION SELECT 25274162	, 0.85	--AGN
	UNION SELECT 25722901	, 0.85	--TestRM
	UNION SELECT 26269491	, 0.85	--S7G
	UNION SELECT 26575473	, 0.85	--M6M
	UNION SELECT 26614261	, 0.85	--B14-TEST
	UNION SELECT 26758668	, 0.85	--RGU
	UNION SELECT 28318108	, 0.85	--N8E
	UNION SELECT 29671917	, 0.85	--S7U
	UNION SELECT 33882079	, 0.85	--ANTE
	UNION SELECT 5664		, 0.85	--MMMRM
	UNION SELECT 14943		, 0.85	--M12RM
	UNION SELECT 15219		, 0.85	--M6HK
	UNION SELECT 15515		, 0.85	--M39IRMB
	UNION SELECT 27026		, 0.85	--MAMRM
	UNION SELECT 33903		, 0.85	--M96RM
	UNION SELECT 47030		, 0.85	--M6SD
	UNION SELECT 96138		, 0.85	--M359BP
	UNION SELECT 108601		, 0.85	--M62RM
	UNION SELECT 121951		, 0.85	--MQRM
	UNION SELECT 141928		, 0.85	--MYMRM
	UNION SELECT 156071		, 0.85	--MQARM
	UNION SELECT 214696		, 0.85	--MPTUS
	UNION SELECT 268037		, 0.85	--M26RM
	UNION SELECT 499392		, 0.85	--M37RM
	UNION SELECT 524095		, 0.85	--MSWEU
	UNION SELECT 610550		, 0.85	--M797M
	UNION SELECT 638302		, 0.85	--M3BP
	UNION SELECT 667341		, 0.85	--MOH99M
	UNION SELECT 692439		, 0.85	--M116ARM
	UNION SELECT 835906		, 0.85	--M169RM
	UNION SELECT 877377		, 0.85	--TPBP
	UNION SELECT 947130		, 0.85	--M6RM
	UNION SELECT 1097033	, 0.85	--m339irmb
	UNION SELECT 1166414	, 0.85	--MTRE
	UNION SELECT 1216829	, 0.85	--ME9
	UNION SELECT 1365240	, 0.85	--M3GP
	UNION SELECT 1407713	, 0.85	--M72H
	UNION SELECT 1559469	, 0.85	--SA-EURO01
	UNION SELECT 1827507	, 0.85	--M169BR
	UNION SELECT 2114197	, 0.85	--MMYBH
	UNION SELECT 2850476	, 0.85	--M53H
	UNION SELECT 3144085	, 0.85	--MPH
	UNION SELECT 3144218	, 0.85	--JPG
	UNION SELECT 3191187	, 0.85	--DKE
	UNION SELECT 3411725	, 0.85	--WBR
	UNION SELECT 3645792	, 0.85	--M9999RM
	UNION SELECT 3686314	, 0.85	--M818RA
	UNION SELECT 3869873	, 0.85	--M69H
	UNION SELECT 4348440	, 0.85	--WBRR
	UNION SELECT 4430377	, 0.85	--M527
	UNION SELECT 4600902	, 0.85	--MHK9
	UNION SELECT 4708570	, 0.85	--MTRU
	UNION SELECT 4712010	, 0.85	--M7RRMB
	UNION SELECT 5086318	, 0.85	--JGBP
	UNION SELECT 5124437	, 0.85	--M79V
	UNION SELECT 6201631	, 0.85	--M6ihk
	UNION SELECT 7141855	, 0.85	--JTRIHK
	UNION SELECT 8218187	, 0.85	--JTRIEU
	UNION SELECT 8218288	, 0.85	--JTRIUSD
	UNION SELECT 8551148	, 0.85	--GT
	UNION SELECT 12146012	, 0.85	--STELIM
	UNION SELECT 15345622	, 0.85	--BPRM
	UNION SELECT 15819243	, 0.85	--A919IHK
	UNION SELECT 16088600	, 0.85	--MBY
	UNION SELECT 16311955	, 0.85	--ASB
	UNION SELECT 16597391	, 0.85	--M999RM
	UNION SELECT 17149327	, 0.85	--SBET339
	UNION SELECT 19626855	, 0.85	--MHK1
	UNION SELECT 22775533	, 0.85	--FRARM
	UNION SELECT 27899314	, 0.85	--AH501
	UNION SELECT 29398368	, 0.85	--SKRMB
	UNION SELECT 30293403	, 0.85	--QZ3WCRMB
	UNION SELECT 33287715	, 0.85	--RS21
	UNION SELECT 1412		, 0.85	--339BHK
	UNION SELECT 2690		, 0.85	--6666HK
	UNION SELECT 3023		, 0.85	--6666BP
	UNION SELECT 3290		, 0.85	--6599RM
	UNION SELECT 3556		, 0.85	--PHRM
	UNION SELECT 3802		, 0.85	--266HK
	UNION SELECT 4170		, 0.85	--BRM
	UNION SELECT 4295		, 0.85	--TKRM
	UNION SELECT 9636		, 0.85	--6666EU
	UNION SELECT 10793		, 0.85	--ywrm
	UNION SELECT 15267		, 0.85	--6hk6601
	UNION SELECT 32422		, 0.85	--SORM
	UNION SELECT 52466		, 0.85	--8RM
	UNION SELECT 74299		, 0.85	--mbrm55
	UNION SELECT 97995		, 0.85	--PHIRM
	UNION SELECT 102085		, 0.85	--CBUS
	UNION SELECT 106169		, 0.85	--THIRMB
	UNION SELECT 183716		, 0.85	--MBRMB44
	UNION SELECT 210710		, 0.85	--CJEU
	UNION SELECT 577870		, 0.85	--9222EU
	UNION SELECT 704984		, 0.85	--MEU01
	UNION SELECT 1052570	, 0.85	--2588SD
	UNION SELECT 1234393	, 0.85	--LON1SD
	UNION SELECT 1352383	, 0.85	--mbrm07
	UNION SELECT 1352383	, 0.85	--mbrm07
	UNION SELECT 1352383	, 0.85	--mbrm07
	UNION SELECT 1366556	, 0.85	--A52R
	UNION SELECT 1937408	, 0.85	--6666AHK
	UNION SELECT 2831919	, 0.85	--312BP
	UNION SELECT 3080407	, 0.85	--A7HK
	UNION SELECT 5707545	, 0.85	--BARM
	UNION SELECT 6173472	, 0.85	--MBRM56
	UNION SELECT 7702947	, 0.85	--AA0312
	UNION SELECT 8217709	, 0.85	--AXR312
	UNION SELECT 8451869	, 0.85	--BARM002
	UNION SELECT 10231287	, 0.85	--REU
	UNION SELECT 10407893	, 0.85	--ESHK
	UNION SELECT 11941110	, 0.85	--BBC
	UNION SELECT 11999779	, 0.85	--A68US
	UNION SELECT 12143282	, 0.85	--A68H
	UNION SELECT 16642055	, 0.85	--BBM
	UNION SELECT 17059868	, 0.85	--MBRM53
	UNION SELECT 26603367	, 0.85	--MC-MTD
	UNION SELECT 26603420	, 0.85	--MC-PH
	UNION SELECT 26603420	, 0.85	--MC-PH
	UNION SELECT 26603479	, 0.85	--MC-OS
	UNION SELECT 27789477	, 0.85	--xyz100RM
	UNION SELECT 28014110	, 0.85	--MC-C1X2
	UNION SELECT 28014110	, 0.85	--MC-C1X2
	UNION SELECT 28455578	, 0.85	--2588ARM
	UNION SELECT 29270764	, 0.85	--MOLLYBET
	UNION SELECT 29700094	, 0.85	--MBET
	UNION SELECT 29871763	, 0.85	--WC18
	UNION SELECT 29958560	, 0.85	--WCBill
	UNION SELECT 30008227	, 0.85	--WC2018HK
	UNION SELECT 30016073	, 0.85	--WC2018RMB
	UNION SELECT 30143280	, 0.85	--VTINUS
	UNION SELECT 30258967	, 0.85	--TFHKD
	UNION SELECT 30457243	, 0.85	--ChesterHK
	UNION SELECT 30999013	, 0.85	--OLD-RM
	UNION SELECT 32064613	, 0.85	--6666PEU
	UNION SELECT 33279274	, 0.85	--ccti
	UNION SELECT 38560029	, 0.85	--CASHTEST
	UNION SELECT 38560029	, 0.85	--CASHTEST	 

	UPDATE tmp 
	SET tmp.roleID = ci.roleid
	FROM #CustList tmp 
		INNER JOIN custinfo ci WITH(NOLOCK) ON tmp.CustID = ci.custid 

	-------------------------------Normal account ----------------------------
	--> FOR SportBook
	UPDATE cs 
	SET cs.spositiontaking = tmp.PT ,
		cs.mpositiontaking = cs.mpositiontaking + tmp.PT - cs.spositiontaking ,
		cs.apositiontaking = cs.apositiontaking + tmp.PT - cs.spositiontaking,
		cs.slivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT ELSE cs.slivepositiontaking END,
		cs.mlivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN cs.mlivepositiontaking + tmp.PT - cs.slivepositiontaking ELSE cs.mlivepositiontaking END,
		cs.alivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN cs.alivepositiontaking + tmp.PT - cs.slivepositiontaking ELSE cs.alivepositiontaking END
	FROM CustSetting cs WITH (ROWLOCK)
		INNER JOIN #CustList tmp ON cs.custid = tmp.CustID
	WHERE tmp.roleID = 4

	UPDATE cs 
	SET maxpositiontaking = CASE WHEN tmp.PT > maxpositiontaking THEN tmp.PT ELSE maxpositiontaking END,
		maxlivepositiontaking = CASE WHEN tmp.PT > maxlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT ELSE maxlivepositiontaking END
	FROM custoverride cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #CustList tmp ON cs.custid = tmp.CustID
	WHERE tmp.roleID = 4 

	--> FOR Muay Thai, E-Sports
	UPDATE cs 
	SET cs.MaxPT = PS.MaxPT, --Profiles
		cs.SuperPT  =  tmp.PT * 100 ,
		cs.MasterPT =  cs.MasterPT + tmp.PT * 100 - cs.SuperPT ,
		cs.AgentPT  =  cs.AgentPT + tmp.PT * 100 - cs.SuperPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #CustList tmp ON cs.custid = tmp.CustID
		INNER JOIN ProductSettingDetail ps  WITH (NOLOCK)
			ON ps.SportType = cs.SportType and cs.BetType = ps.BetType and ps.SettingType = 1
	WHERE cs.SportType IN (43,44) AND tmp.roleID = 4


	-------------------dummy account -----------------------------

	--CREATE TABLE #DummyCustList (CustID INT PRIMARY KEY, PT smallmoney, roleID tinyint)
	CREATE TABLE #DirectCustList (CustID INT PRIMARY KEY, PT smallmoney, roleID tinyint)

	INSERT INTO #DirectCustList(CustID, PT, RoleID)
	SELECT CustID, PT, RoleID FROM #CustList WHERE roleid IN (2,3)

	--INSERT INTO #DummyCustList(CustID,PT,roleID)
	--SELECT DISTINCT ci.srecommend,tmp.PT,4 -- Dummy super
	--FROM #DirectCustList tmp 
	--	INNER JOIN custinfo ci WITH(NOLOCK) ON tmp.CustID = ci.custid 


	--INSERT INTO #DummyCustList(CustID,PT,roleID)
	--SELECT DISTINCT ci.mrecommend,tmp.PT,3 -- Dummy master
	--FROM #DirectCustList tmp 
	--	INNER JOIN custinfo ci WITH(NOLOCK) ON tmp.CustID = ci.custid AND ci.roleid = 2

	----> FOR SportBook
	--UPDATE cs 
	--SET cs.spositiontaking = CASE WHEN tmp.roleid = 4 THEN tmp.PT ELSE cs.spositiontaking END,
	--	cs.mpositiontaking = CASE WHEN tmp.roleid = 4 THEN tmp.PT
	--								WHEN tmp.roleid = 3 THEN tmp.PT 
	--								ELSE cs.mpositiontaking END,
	--	cs.apositiontaking = CASE WHEN tmp.roleid = 4 THEN tmp.PT
	--								ELSE cs.apositiontaking END,
	--	cs.slivepositiontaking = CASE WHEN tmp.roleid = 4 AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT ELSE cs.slivepositiontaking END,
	--	cs.mlivepositiontaking = CASE WHEN tmp.roleid = 4 AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT
	--								WHEN tmp.roleid = 3 AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT 
	--								ELSE cs.mlivepositiontaking END,
	--	cs.alivepositiontaking = CASE WHEN tmp.roleid = 4 AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT
	--								ELSE cs.alivepositiontaking END
	--FROM CustSetting cs WITH (ROWLOCK)
	--	INNER JOIN #DummyCustList tmp ON cs.custid = tmp.CustID

	----> FOR Muay Thai, E-Sports
	--UPDATE cs 
	--SET cs.SuperPT = CASE WHEN tmp.roleid = 4 THEN tmp.PT * 100  ELSE cs.SuperPT END,
	--	cs.MasterPT = CASE WHEN tmp.roleid = 4 THEN tmp.PT * 100 
	--								WHEN tmp.roleid = 3 THEN tmp.PT * 100  
	--								ELSE cs.MasterPT END,
	--	cs.AgentPT = CASE WHEN tmp.roleid = 4 THEN tmp.PT * 100 
	--								ELSE cs.AgentPT END
	--FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	--	INNER JOIN #DummyCustList tmp ON cs.custid = tmp.CustID
	--WHERE cs.SportType IN (43,44)
	
	------------------------dirrect account---------------------------

	--> FOR SportBook
	UPDATE cs 
	SET cs.mpositiontaking = CASE WHEN tmp.roleid = 3 THEN tmp.PT ELSE cs.mpositiontaking END,
		cs.apositiontaking = CASE WHEN tmp.roleid = 2 THEN tmp.PT ELSE cs.apositiontaking END,
		cs.mlivepositiontaking = CASE WHEN tmp.roleid = 3 AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT ELSE cs.mlivepositiontaking END,
		cs.alivepositiontaking = CASE WHEN tmp.roleid = 2 AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT ELSE cs.alivepositiontaking END
	FROM CustSetting cs WITH (ROWLOCK)
		INNER JOIN #DirectCustList tmp ON cs.custid = tmp.CustID
	
	UPDATE cs 
	SET maxpositiontaking = CASE WHEN tmp.PT > maxpositiontaking THEN tmp.PT ELSE maxpositiontaking END,
		maxlivepositiontaking = CASE WHEN tmp.PT > maxlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT ELSE maxlivepositiontaking END
	FROM custoverride cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #DirectCustList tmp ON cs.custid = tmp.CustID

	--> FOR Muay Thai, E-Sports
	UPDATE cs 
	SET cs.MasterPT = CASE WHEN tmp.roleid = 3 THEN tmp.PT * 100  ELSE cs.MasterPT END,
		cs.AgentPT = CASE WHEN tmp.roleid = 2 THEN tmp.PT * 100  ELSE cs.AgentPT END,
		cs.MaxPT = PS.MaxPT --Profiles
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #DirectCustList tmp ON cs.custid = tmp.CustID
		INNER JOIN ProductSettingDetail ps  WITH (NOLOCK)
			ON ps.SportType = cs.SportType and cs.BetType = ps.BetType and ps.SettingType = 1
	WHERE cs.SportType IN (43,44)

	
	DROP TABLE #CustList
	--DROP TABLE #DummyCustList
	DROP TABLE #DirectCustList

END    
GO