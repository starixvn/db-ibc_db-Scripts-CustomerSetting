/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: 20251016@Tacy
	Task: Scan dormant members amount
	DB: DBACC-bodb02
*/
/*
	- Terminated licensees will be get data from the OIC team, and cross-check [Status] in bodb_licensee
	- Excluded licensees: 12Bet, N88, N8G, N8B, N8BK, N8Y, N8I, Saba789, SEAL888, SabaCoins, Jioo, CN88.
	- Single Wallet licensees will not be concerned with their members' balances.
	- Licensees Test: Athena000, SampleSite, spondemo, SWSite --> Follow rule #2

	** RULES:
		1. Single Wallet Sites:
		_ Members who have had no tickets and transfers in the past 1 year will be archived.
		_ For the top 5 licensees (highlighted in the list) with a high number of inactive members, to optimize system performance, 
		we plan to archive members who have had no tickets and transfers in the past 6 months. (need to review and confirm from PO)

		2. Normal Sites:
		_ Members with no tickets and transfers in the past 1 year and with a balance <= 0 will be archived.

		3. Terminated Sites
		_ All members will be archived.
*/
/*
		--> 1. Get Licensee Type: Normal / Single Wallet
		-- Run on: DBCUST.bodb_Licensee

		;WITH SingleWallet AS (
			SELECT  VendorID, SiteName, Display_SiteName
			FROM siteconfig..ConfigDetail d  WITH (NOLOCK)  
			INNER JOIN siteconfig..ConfigMaster f  WITH (NOLOCK)  ON f.ConfigID=d.ConfigID
			INNER JOIN siteconfig..LicVendorProfile l WITH (NOLOCK) ON l.SiteId=f.SiteID
			WHERE KeyName LIKE '%EnableSingleWallet%' AND KeyValue='True'
		)
		SELECT DISTINCT
			l.LicenseeName, s.siteid
			,CASE WHEN sw.SiteName IS NOT NULL THEN 'SingleWallet' ELSE  'Normal' END [Type]
		FROM Licensees l WITH (NOLOCK)
		INNER JOIN CustDB.dbo.Site s WITH (NOLOCK) ON s.site=l.LicenseeName
		LEFT JOIN SingleWallet sw WITH (NOLOCK) ON sw.SiteName=s.site

		--------------------------------------------------------------------------------------------
		--------------------------------------------------------------------------------------------
		--> 2. Get Licensee Status:
		-- Run on: DB05HA1G1L.bodb_OIC

		SELECT RegisteredLicenseeName AS LicenseeName, LicenseeStatusName, TerminatedDate
		INTO #tmp_OIC_Licensee
		FROM bodb_OIC.dbo.Licensee l WITH(NOLOCK)
		INNER JOIN bodb_OIC..LicenseeStatus ls WITH(NOLOCK) ON ls.LicenseeStatusId = l.LicenseeStatusId

		SELECT l.LicenseeID, l.LicenseeName
		  , CASE WHEN t.LicenseeName IS NOT NULL AND t.LicenseeStatusName='Terminated' THEN 'Terminated'
				 WHEN t.LicenseeName IS NOT NULL AND t.LicenseeStatusName<>'Terminated' THEN 'Active (' + t.LicenseeStatusName + ')'
				 WHEN l.IsActive = 1 THEN 'Active' ELSE 'Terminated' END Status
		  --, l.Affecteddate
		  --, t.TerminatedDate
		--INTO #tmp_Licensees
		FROM bodb_licensee.dbo.Licensees l WITH (NOLOCK)
		LEFT JOIN #tmp_OIC_Licensee t ON t.LicenseeName=l.LicenseeName
*/

--------------------------------------------------------------------------------------------
--DBACC.bodb02
USE bodb02
GO

--SingleWallet licensees
DECLARE @SingleWallet TABLE (LicenseeName VARCHAR(50), LicenseeStatus VARCHAR(50))

INSERT INTO @SingleWallet (LicenseeName)
VALUES	 ('12Bet'),('W88'),('asiabet88'),('GPIGAME'),('ALPHA88'),('TLC'),('Mybet88'),('Bonanza88'),('VN88'),('Happy8'),('CGame4'),('N88'),('N8G'),('N8B'),('Weiwei')
		,('awc'),('awc2'),('998bet'),('ZFRT080'),('ig128s'),('Asia999'),('ug396'),('NukeGaming'),('Pay4d'),('24AVIASL'),('M88ASIA'),('X2Dynamic'),('ZFRT129'),('WGAMING'),('568WinSW')
		,('liv66SW'),('OkadaSW'),('IGSW'),('ZFRT115'),('ZhiFeng076'),('khmer'),('UNOGAMING'),('livv88sw'),('THECLUB'),('THEDEN'),('JIB88'),('SAGAME88'),('EasywinSW'),('khmerA2'),('368CashSW')
		,('GoToWin'),('Omni88'),('GSCSW'),('Apollo369'),('SM88'),('IgameTech'),('CENTRAL168'),('ARYA'),('ZhiFeng106'),('Winsplay'),('ZhiFeng055'),('ZhiFeng122'),('ABEMT'),('Peakk'),('b88club')
		,('X33Asia'),('KOKVN2'),('AEUGSW'),('ZF057SQ24'),('ZF057Celeb'),('ZFRT179'),('ZFRT167'),('Aongroup'),('De365'),('GoldenF'),('JDYGaming'),('LEIHUO'),('OCMSS'),('ZFRT175'),('SL88SW')
		,('DongYing'),('LSM99'),('W88CV'),('ZhiFeng116'),('442ball'),('ZhiFeng133'),('GmasterS'),('V9betSW'),('Titan365'),('0sServices'),('ZhiFeng084'),('FHLMSABAS'),('ZhiFeng173'),('ZhiFeng107'),('Rakyat4DSW')
		,('Xinli2CV'),('ZhiFeng168'),('Titanbet'),('bigbet'),('Nexus'),('yuanbao'),('Riverich'),('yuanbaoCV'),('XLMEDIA'),('SWDemo'),('WSlots'),('Betway'),('JBO'),('GoldenFCV'),('ZhiFeng200')
		,('ZhiFeng208'),('ZhiFeng204'),('ZFRT152'),('PINT'),('SDYSW'),('Zhifeng215'),('F88IN1SW'),('UGaming'),('FLCSW'),('GoldenF2'),('GoldenF2CV'),('KSTECH'),('Asiasigma'),('JUNBOVN'),('n88clubSW')
		,('XmenSW'),('Niu8gaming'),('SWSite'),('CMBSW'),('KingFun'),('ZFRT166SW'),('wmcasinoS'),('Twowin'),('WRSeamless'),('OXPLAY'),('KZSW'),('Xinli3CV'),('ZhiFeng248'),('ABCGAME'),('ZhiFeng094')
		,('MultiSL88'),('KzingP88'),('ZhiFeng050'),('FKsport'),('ZFRT240'),('EclipseSW'),('IDNSPORT'),('Happistar'),('lionsclub'),('ZhiFeng255'),('ZFRT259'),('SENBKK'),('ZhiFeng262'),('Bet88CV'),('TWWIN')
		,('CandyA18'),('aws03'),('TYgamingSW'),('B8KRW'),('ZF267SW'),('IDNUPVND'),('ABCgamevip'),('HOHPLAY'),('ScaleDemo1'),('Fabbet'),('Belegend'),('AWS08'),('WinboxSW'),('HaHaGaming'),('ZF271SW')
		,('M18SW'),('T1SOFTSW'),('LG777'),('ZhiFeng282'),('ScaleDemo2'),('K8ioSW'),('ZhiFeng299'),('KzingJ51'),('ZhiFeng302'),('i88SW'),('ZF183SW'),('mxvt'),('ZhiFeng306'),('Pay4d2'),('Pay4d3')
		,('Slot7777'),('ZFRT292'),('B2YCLUB'),('ZhiFeng317'),('ZFRT179SW'),('ZF316SW'),('dewatatoto'),('HL8IDSW'),('vedagaming'),('XinliDivCV'),('18LuckV2'),('NeftsoftSW'),('IXGAMING'),('48Pacific'),('ZhiFeng371')
		,('LABTESTING'),('Kingdom'),('ZhiFeng381'),('BET9S'),('YHTY'),('SGWINS'),('newtitan'),('didihub'),('NEWQC'),('SKGAMING'),('wsgaming'),('Cryptocity'),('crmps'),('ZhiFeng428'),('OneLive')
		,('SKGROUP'),('WGAME'),('ZhiFeng475'),('NeuronDemo'),('ZhiFeng312'),('ZFRT276SW'),('ZhiFeng112'),('aws06'),('FYT'),('JudoSlot'),('PlayBetzSW'),('CRYPTO88'),('w84sw'),('ASKMEBETSD'),('Betlead')
		,('N8I'),('ASKMEBETS'),('bolaroyal'),('ZF365SW'),('IW5'),('ZFRT399'),('DSBtech'),('leobet'),('CVFSW'),('ZT001asia'),('ZT001eur'),('CIKAtech'),('WGsports'),('CCLVS'),('ZF462B')
		,('18LuckDiv'),('winwinsw'),('ZhiFeng484'),('Owin'),('Powerslot'),('OGGRPSW'),('CAT01'),('LT02'),('IDNUPB2KRW'),('XINGFA'),('SGALabel'),('ZhiFeng088'),('ZhiFeng543'),('ZF112D'),('SWDFBET')
		,('CT2U99'),('filbet'),('Taya'),('TayaCV'),('VIPGAMING'),('ZhiFeng601'),('sogogo'),('Sengroup'),('MetaltexSW'),('OXPLAY2'),('Cullinan'),('OlaTigerSW'),('BBBet'),('BBBetCV'),('ZhiFeng164')
		,('BDVNSW'),('zincbet'),('ZF035SW'),('Ole7SW'),('KDSLOTS'),('MXMSW'),('WINGAMING'),('ZhiFeng689'),('GSOFTJSSW'),('KK8SW'),('OMGINR'),('DSTPLAY'),('w688'),('Dogzilla'),('bmengine')
		,('ZhiFeng613'),('ZhiFeng476'),('ZhiFeng727'),('ZFRT495'),('ZFRT443'),('ZFRT090SW'),('ZFRT506'),('TSLAASD'),('CGIEngine'),('King855'),('ISLOT'),('Indolabel'),('ZhiFeng487'),('LiBo'),('JBbet')
		,('IN2GAME'),('Stavki'),('yongleCV'),('Mabe88'),('TFTECH'),('BDGAME'),('zt828SW'),('iProBET'),('BET168GAME'),('ZhiFeng831'),('NCCloudSW'),('ZFRT534SW'),('ZhiFeng793'),('i8MYlive'),('BetleadJS')
		,('W88KES'),('PPGSW'),('easydream'),('SBCHOSSW'),('88Gaming'),('ac88sw'),('ZF881SW'),('ZF596bSW'),('dddbet'),('LuckyTown'),('TGXISW'),('TGXICVSW'),('wmwmsw'),('Dreamland'),('N8Y')
		,('FYISL'),('ZFRT552'),('ZhiFeng784'),('YYGacorSW'),('LDPROSW'),('88GamingCV'),('88GamingJS'),('ZFRT213SW'),('Platform23'),('ZFRT524'),('gwtwrSW'),('ZF310b'),('Bindasbet'),('dylive'),('sino88')
		,('TIP88'),('ATGCLUB'),('BLESSED'),('ZFRT485'),('JunosoTech'),('Goldstar'),('ABCGAMING'),('ZFRT611'),('ZFRT549SW'),('ZFRT601'),('777betSW'),('ZhiFeng758'),('ZT001CIS'),('ZFRT549'),('CexseaSw')
		,('ZF1013'),('ZhiFeng858'),('ZT001NEA'),('KZV40SW'),('LTECH'),('ZF1002SW'),('ZhiFeng726'),('gwtdmJS'),('online88'),('ZABBET'),('gwtcgSW'),('ZF1001'),('ZFRT644'),('DOBET'),('FBSLOTS')
		,('ZFRT643SW'),('okok'),('ZF1068'),('reibrail77'),('ZhiFeng981'),('SSSBONG'),('dwgameSW'),('CP9'),('Sunlogic'),('TTGamingSW'),('AAGamingSW'),('Playtime'),('AFBKG'),('DAAGaming'),('3QAPPSJS')
		,('ZF379b'),('xagame'),('ZFRT664'),('ZhiFeng565'),('PCTOP'),('Mekong'),('Score8CV'),('Score8SCV'),('ZhiFeng948'),('ZFRT399SW'),('cg670game'),('5698cp'),('Rivalo'),('ZFRT689'),('ZF1131')
		,('ZF1001b'),('km777SW'),('ZFRT534B'),('KGON'),('km777JS'),('HQ8GAMESW'),('mpsphJS'),('TNS999'),('ZFRT693'),('MMISW'),('2345sport'),('PLAYXOS'),('CasinerX'),('ZFRT680'),('AdminKR')
		,('ZFRT649SW'),('JHGROUP'),('W3bets'),('ARENA'),('ZFRT645'),('ZFRT563SW'),('JINGHE'),('aneka4d'),('Luckyking'),('ZF1170'),('ZF1172'),('RS3T616SW'),('ZhiFeng490'),('ig128JSSW'),('N8Tuk')
		,('ZFRT443SW'),('gwtyqSWJS'),('ZF1163SW'),('RichBets'),('okhash'),('ABCGAMEXBY'),('ABCGAMEDXY'),('MS88SW'),('KTOasia'),('VedaSoft'),('ZFRT730'),('Starix1SW'),('KM777'),('PKKINGSW'),('stavkisw')
		,('ZFRT490'),('GTRGaming'),('Pay4dJS'),('Zsports'),('LUNA88'),('MDgaming'),('EGgaming'),('WealthGame'),('ZFRT693B'),('SumClub'),('Silkroad'),('ZFRT739'),('Veligames'),('DWJS'),('Yolo247')
		,('ZhiFeng310'),('ZF1263'),('Sgame'),('YCGAMESW'),('ZFRT738'),('PRSGA'),('T619'),('igxbsw'),('Action123'),('ZF1286'),('Taiaiwan'),('ZF1256'),('Nexobet'),('MEECHOK24'),('TCGCNYSW')
		,('vggstaguse'),('ZF1087'),('Jack567'),('K36JSSW'),('ZT001eurr'),('NSDemo1SW'),('TWSABA'),('gwtyqSW'),('ZFRT752'),('whiskey'),('rum'),('champagne'),('PAKDE'),('Nautilus'),('whiskey899')
		,('rum899'),('champ899'),('JINGHE2'),('ZFRT664SW'),('sportslive'),('ZhiFeng421'),('zt828BRSW'),('88G01CV'),('ZF1341'),('N11S'),('asiawegame'),('INFI688SW'),('Winnersoft'),('ZFRT802'),('Casa')
		,('ZFRT299SW'),('M88BET'),('CasinoPlus'),('ZhiFeng835'),('ZF446c'),('OV88'),('ZFRT786JS'),('AWS123'),('SolidGame'),('ZF1399'),('ZEN01APAC'),('ZEN0LATAM'),('wealth'),('SG8SW'),('BRI303')
		,('ZF183SWJS'),('CJIGO'),('BsportsPH'),('glo365s'),('SoftGaming'),('IGO'),('EVOIO'),('TCGVNDKSW'),('DBOX'),('Indusbet'),('Okvip88'),('SlotsAPI'),('BetHubS'),('KINGGROUP'),('unicorn66')
		,('DXYOU'),('Wellbet'),('WinkaSW'),('Asgard'),('SunriseSW'),('ZFRT774'),('Simbarbet'),('Simbar'),('Trillion'),('NukeGame'),('ZhiFeng669'),('SKYONE'),('ZFRT446'),('ZF1367'),('ZFRT811')
		,('AURORASW'),('MibosSW'),('JovemSW'),('vgames'),('VLUNA'),('rgidr'),('HengGrp'),('ZFRT805B'),('SWSS001JS'),('ZF1398'),('ZFRT873'),('ZF1474')


--DECLARE @__Inactive3M DATETIME = DATEADD(M, -3,GETDATE())
DECLARE @__Inactive6M DATETIME = DATEADD(M, -6,GETDATE())
DECLARE @__Inactive9M DATETIME = DATEADD(M, -9,GETDATE())
DECLARE @__Inactive1y DATETIME = DATEADD(M, -12,GETDATE())
DECLARE @__Inactive2y DATETIME = DATEADD(M, -24,GETDATE())

SELECT ci.srecommend
, COUNT(1) AS InactiveCust_6M
, SUM( CASE WHEN (t.LastBetDate IS NULL OR t.LastBetDate < = @__Inactive9M) AND c.creatdate  < = @__Inactive9M	THEN 1 ELSE 0 END) AS InactiveCust_9M
, SUM( CASE WHEN (t.LastBetDate IS NULL OR t.LastBetDate < = @__Inactive1y) AND c.creatdate  < = @__Inactive1y	THEN 1 ELSE 0 END) AS InactiveCust_1yr
, SUM( CASE WHEN (t.LastBetDate IS NULL OR t.LastBetDate < = @__Inactive2y) AND c.creatdate  < = @__Inactive1y	THEN 1 ELSE 0 END) AS InactiveCust_2yr
INTO #Tmp
FROM  custInfo ci  WITH (NOLOCK) 
        INNER JOIN vw_Customer c WITH (NOLOCK) ON ci.CustID = c.custid
		INNER JOIN bodb_Licensee..Licensees l WITH (NOLOCK) ON c.site=l.LicenseeName
		LEFT JOIN @SingleWallet sw ON sw.LicenseeName=l.LicenseeName
		LEFT JOIN bodb02..Cust_TrackingLastBetDate t WITH (NOLOCK) ON t.custid = ci.custid
		OUTER APPLY (
				SELECT custid, ISNULL(SUM(winlost-actual_stake+playercomm),0) as MemberBalance
				FROM bodb02..transfer  WITH (NOLOCK)
				WHERE custid = ci.custid
				GROUP BY custid
				) b
WHERE (t.LastBetDate IS NULL OR t.LastBetDate < = @__Inactive6M)
        AND ci.currency <> 20
        AND c.creatdate  < = @__Inactive6M
		and ci.roleid = 1 
		AND NOT(ci.username LIKE '%BetTrade%' OR ci.username LIKE '%CashOut%' OR ci.username LIKE '%ClearBal%' OR ci.username LIKE '%01OddsAdj%')
		AND ISNULL(b.MemberBalance,'') <= CASE WHEN sw.LicenseeName IS NULL AND l.isActive=1 THEN 0 ELSE 1000000000 END
		AND C.site NOT IN ('12Bet', 'N88', 'N8G', 'N8B', 'N8BK', 'N8Y', 'N8I'
							,'CN88', 'Saba789', 'SEAL888', 'SabaCoins', 'Jioo'
							,'Athena000', 'SampleSite', 'spondemo', 'SWSite'
							)
GROUP BY ci.srecommend

SELECT c.site
, SUM(t.InactiveCust_6M)	AS InactiveCust_6M
, SUM(t.InactiveCust_9M)    AS InactiveCust_9M
, SUM(t.InactiveCust_1yr)   AS InactiveCust_1yr
, SUM(t.InactiveCust_2yr)   AS InactiveCust_2yr
INTO #temp2
FROM #Tmp t
INNER JOIN vw_Customer c  WITH (NOLOCK) 
        ON t.srecommend = c.custid
GROUP BY c.site
--ORDER BY SUM(t.InactiveCust_1yr) DESC

--select * from #temp2
;WITH TEMP3 AS (
	SELECT         l.LicenseeName
	,l.BrandName AS [Registered Name]
	,CASE WHEN sw.LicenseeName IS NULL then 'Normal' ELSE 'SingleWallet' END [Type]
	,CASE WHEN l.IsActive = 1 then 'Active' ELSE 'Terminated' END Status
	,tot.TotalMember 
	,t.InactiveCust_6M
	,t.InactiveCust_9M
	,t.InactiveCust_1yr  
	,t.InactiveCust_2yr  
	,ROW_NUMBER() OVER (PARTITION BY CASE WHEN sw.LicenseeName IS NULL then 'Normal' ELSE 'SingleWallet' END ORDER BY TotalMember DESC) AS RowNum
	FROM bodb_Licensee..Licensees        l WITH (NOLOCK)
			LEFT JOIN @SingleWallet sw ON sw.LicenseeName=l.LicenseeName
			INNER JOIN #temp2  t ON l.LicenseeName = t.site
			CROSS APPLY( SELECT COUNT(1) TotalMember from vw_customer c WITH (NOLOCK) WHERE c.site = t.site AND c.roleid = 1) tot
)
SELECT '---All Licensee---' AS LicenseeName
	,'---' AS [Registered Name]
	,'---' AS [Type]
	,'---' AS Status
	,SUM(tot.TotalMember) AS TotalMember
	,SUM(t.InactiveCust_6M) AS InactiveCust_6M
	,SUM(t.InactiveCust_9M) AS InactiveCust_9M
	,SUM(t.InactiveCust_1yr) AS InactiveCust_1yr
	,SUM(t.InactiveCust_1yr) AS InactiveCust_2yr
	FROM #temp2  t 
			CROSS APPLY( SELECT COUNT(1) TotalMember from vw_customer c WITH (NOLOCK) WHERE c.site = t.site AND c.roleid = 1) tot
UNION ALL
SELECT LicenseeName, [Registered Name], Type, Status
	, TotalMember
	, InactiveCust_6M
	, InactiveCust_9M
	, InactiveCust_1yr
	, InactiveCust_2yr
FROM TEMP3
WHERE  1 = CASE -- Top 5 Single Wallet Sites (6 months inactive)
				WHEN Type='SingleWallet' AND Status='Active' AND RowNum<=5 AND InactiveCust_6M>0 THEN 1
				-- Other Single Wallet Sites (1 year inactive)
				WHEN Type='SingleWallet' AND Status='Active' AND RowNum>5 AND InactiveCust_1yr>0 THEN 1
				-- Normal Sites (1 year inactive + balance <= 0)
				WHEN Type='Normal' AND Status='Active' AND InactiveCust_1yr>0 THEN 1
				-- Terminated Sites
				WHEN Status='Terminated' AND TotalMember>0 THEN 1
			ELSE 0 END
ORDER  BY TotalMember DESC

DROP TABLE #temp2
DROP TABLE #Tmp