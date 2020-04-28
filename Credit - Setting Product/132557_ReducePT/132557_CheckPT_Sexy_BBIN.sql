/*	
	DROP TABLE #MemberPT
	DROP TABLE #AgentPT
	DROP TABLE #MasterPT
	DROP TABLE #SuperPT
		
	select count(1) from #CheckPTResult_Credit	
	SELECT ca.username AS UsernameA, ca.roleid AS roleidA, cb.username AS UsernameB, cb.roleid AS roleidB, cs.* 
	FROM #CheckPTResult_Credit cs
		INNER JOIN CustInfo ca WITH (NOLOCK) ON cs.custidA = ca.custid
		INNER JOIN CustInfo cb WITH (NOLOCK) ON cs.custidB = cb.custid
	ORDER BY ruleid	
	
	DROP TABLE #CheckPTResult_Credit
	GO
	
	CREATE TABLE #CheckPTResult_Credit(
		[RuleId] [smallint] NULL,
		[SportType] [smallint] NULL,
		[BetType] [smallint] NULL,
		[CustIdA] [int] NULL,
		[CustIdB] [int] NULL,
		[ValueA] [smallmoney] NULL,
		[ValueB] [smallmoney] NULL,
		[CreatedDate] [datetime] NULL,
		[IsLive] [bit] NULL
	)

	GO

	ALTER TABLE #CheckPTResult_Credit ADD DEFAULT (getdate()) FOR [CreatedDate]
	GO
	ALTER TABLE #CheckPTResult_Credit ADD DEFAULT ((0)) FOR [IsLive]
		
	SELECT DISTINCT sporttype 
	INTO #SportType 
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE SportType in (43,44, 212,220,180,181,182,183,184,185,186,190,191,192,193) -- SB2, Esports,Macau, Lottery, Virtual Sports 
		AND SettingType = 1

	CREATE TABLE #supers (custid int)
	CREATE TABLE #DirectMaster (CustID INT)
	
	INSERT INTO #supers(custid)
	SELECT ci.custid 
	FROM vw_customer ci WITH (NOLOCK) 
	inner join custinfo cu with (nolock) on cu.custid=ci.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  	
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.currency<>20
		and cs.IsInternal=0
		and ci.username not like '3rdSuper%'
		and ci.username not IN ( 'STAFF')
		and ci.username not like 'SuperTest%'
		and ci.username not like 'STEST%'
		and ci.username not like 'SIBC%'
		and ci.username not like '%ACCSuper%'
		and ci.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')

	-- get dummy super list
	SELECT DISTINCT srecommend custid INTO #dummySuper
	FROM CustDirectAccount da WITH (NOLOCK)
		 INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
	WHERE  ci.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')
	and ci.roleid IN (2, 3) AND ci.currency <> 20
	UNION
	SELECT DISTINCT ci.srecommend
	FROM CustDirectAccount da WITH (NOLOCK)
		 INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
		 INNER JOIN vw_customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
	WHERE ca.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')
		 AND ci.roleid IN (1) AND ci.currency <> 20	

	INSERT INTO #DirectMaster(custid)
	SELECT custid
	FROM dbo.custInfo ci WITH(NOLOCK) 										
	WHERE  EXISTS (SELECT custid 
					FROM dbo.CustDirectAccount WITH(NOLOCK) 
					WHERE CustID = ci.custid)													
		AND ci.roleid=3 
		AND ci.srecommend in (select custid from #dummySuper)

*/	

	SET NOCOUNT ON   	
	CREATE TABLE #supers (custid int)
	CREATE TABLE #DirectMaster (CustID INT)

	INSERT INTO #supers(custid)
	SELECT custid
	FROM dbo.custInfo ci WITH (NOLOCK) 
	WHERE ci.custid IN (194355,726562,674248,838201,838203,838215,838370,840993,840999,844818,835299,984326,877004,882346,897682,900371,900801,
					901840,913628,944306,932905,1001999,1020356,1069683,1437413,1923414,2345677,1011974,1220882,1262078,1266057,1416231,
					1419459,2926808,3158177,3161673,3592236,3592237,3592239,3033727,3801635,3803986,3992866,4213345,4253518,3581309,4286209,
					4356717,7665277,7757683,7945539,8864778,8270016,11400410,11581838,11644965,11734366,12343335,12968884,12172555,13549891,
					13724582,14374442,14776453,14783808,14804092,14822871,14846867,15211772,15296297,15368528,15459128,15464062,15472987,
					15479306,15479653,15493382,15523574,15534612,15568896,15588279,15589773,15615804,15643773,15657898,15678760,15691361,
					15691505,15731785,15814766,15833836,15852092,15862762,15882372,15905075,15926983,15973870,16007063,16094466,16110555,
					16155418,16173167,16178052,16179977,16185668,16189265,16288719,16312762,16350958,16376143,16403843,16406591,16406680,
					16429517,16542371,16629424,16632862,16639418,16651313,16660203,16683803,16697599,16723695,16781864,16797404,16996685,
					17004016,17065592,17131337,17131340,17281063,17330507,17371180,17519042,17550987,17568160,17598313,17639099,17721601,
					17775457,17776283,17776367,17776495,17777353,17778173,17778362,17778388,17779555,17779619,17781054,17784234,17784271,
					17784276,17786873,17786927,17789265,17792653,17795687,17796320,17797400,17804081,17810293,17818490,17818626,17827873,
					17845566,17846794,17854000,17882815,17902977,17903086,17905676,17914974,18002604,18014405,18029378,18030099,18046689,
					18065547,18119949,18126874,18150604,18169991,18201422,18204791,18211140,18249693,18306101,18349711,18349786,18371107,
					18371232,18377901,18384488,18384911,18403883,18436582,18453553,18526083,18579401,18589765,18608070,18615641,18671366,
					18739832,18758376,18800986,18826146,18882011,18889582,19132049,19168312,19249404,19253656,19287667,19290808,19290859,
					19342491,19450953,19562439,19865717,19872670,19979621,19979695,19979697,19979702,19979703,20054131,20054183,20121054,
					20384651,20447615,20461064,20495016,20505414,20520948,20641055,20643383,20655838,20726461,20735169,20808833,20904250,
					20957323,20988406,20988628,21016199,21052868,21082053,21091788,21142690,21163975,21170614,21185719,21209690,21218178,
					21290487,21301650,21336723,21386610,21388038,21489806,21489839,21501445,21517528,21526946,21539100,21590068,21590151,
					21590182,21676380,21696628,21773945,21805173,21810157,21819432,21822488,21824947,21831858,21879594,21896144,21899026,
					21958750,21962433,21964064,21968562,21995758,22018619,22064996,22103955,22104119,22116421,22147000,22150569,22150668,
					22150801,22203521,22252377,22319896,22367369,22378516,22445472,22530061,22549720,22552845,22588119,22588844,22594170,
					22597510,22635035,22645062,22661835,22713899,22809696,22819876,22830356,22873070,22893016,22895090,22963208,22981202,
					23037811,23043789,23064358,23125994,23137628,23144849,23145834,23170071,23203259,23227126,23242311,23277139,23303382,
					23303386,23324863,23362784,23397135,23442442,23475292,23494009,23757509,23771767,23794762,23855542,23875484,23876922,
					23881900,23889903,23896660,24052789,24093960,24231774,24247226,24297053,24307463,24382395,24400636,24404342,24405134,
					24507593,24516608,24542345,24605112,24641165,24648313,24676096,24749916,24757066,24779155,24785718,24847338,25027203,
					25095113,25176134,25197688,25216716,25225767,25307522,25322811,25322946,25393677,25412733,25479976,25523404,25630543,
					25747624,25906115,25990436,26057285,26145714,26279036,26305125,26371960,26393456,26523095,26625387,26771163,26778565,
					26780783,26858222,27032853,27152134,27185813,27202508,27325472,27377389,27429771,27505238,27576932,27619573,27693622,
					27711715,27712367,27744128,27936296,27936415,27936420,27936425,27976293,28068363,28068431,28229771,28311145,28341093,
					28349651,28364424,28367465,28380874,28421898,28435285,28523343,28539717,28590148,28601169,28652628,28781479,28784893,
					28863269,28885463,28919117,28947405,28973860,28974179,28974264,28974269,28974270,29038225,29104895,29195279,29209935,
					29210023,29220235,29233791,29265231,29332687,29373341,29381497,29399008,29400292,29400604,29401764,29418666,29471935,
					29517704,29543144,29630009,29633146,29643933,29698164,29714932,29722322,29731246,29740022,29740250,29742191,29742342,
					29766442,29767978,29802745,29806269,29813893,29814421,29828834,29838942,29854759,29866613,29871946,29879442,29881681,
					29886115,29900460,29981955,29999807,30005435,30024807,30039712,30053657,30054052,30068766,30080032,30118093,30194866,
					30480498,30518480,30697649,30854317,30883804,31180837,31255482,31322782,31381376,31395307,31571444,31593908,31694381,
					31698636,31792340,31845614,31846492,31867633,31890071,31996146,32029644,32043292,32048940,32072410,32116807,32139652,
					32155569,32168282,32217184,32225924,32237684,32237777,32242879,32267708,32312292,32353582,32374296,32377325,32481317,
					32481582,32481647,32482121,32489475,32489646,32497158,32506252,32546605,32567120,32571313,32576183,32595261,32602789,
					32602861,32633946,32648852,32655592,32686406,32772757,32830876,32855031,32868636,32933719,32951393,32955864,33011118,
					33105928,33108422,33109282,33111269,33147917,33181773,33184277,33194639,33245791,33247501,33280723,33336592,33337967,
					33458875,33525720,33540349,33540405,33651661,33670199,33749320,33782382,33786140,33804052,33862521,33906404,34002452,
					34077748,34126034,34131202,34147727,34175825,34176539,34383807,34913473,35137176,35411546,35463595,35478639,35479625,
					35488596,35561884,35576905,35663207,35740565,35775827,36077034,36183307,36209180,36223755,36235740,36279722,36288062,
					36339758,36368431,36409145,36428160,36501450,36502994,36576669,36580288,36584443,36750496,36784453,36846736,36852048,
					37167237,37348650,37382114,37518492,37665833,37840784,37913561,37927511,38003207,38177737,38206531,38332507,38437991,
					38506669,38586098,38589176,38589340,38589342,38633227,38633360,38649742,38720314,38785607,38787046,38787049,38828158,
					38853305,38853409,38853410,38853412,38853414,38853416,38853417,38855012,38871640,38871641,38871646,38871650,38871651,
					38921520,38921685,38969513,38969566,38969567,38969569,38969570,39010647,39065932,39269477,39360190,39371609,39372750,
					39399163,39428597,39745767,39761475,39812860,40059371,40174317,40198456,40198547,40304417,40307271,40343794,40388801,
					40424725,40516415,40701277,40710523,40731369,40884281,40906204,41045731,41062631,41216051,41443176,41444140,41472185,
					41487628,41513660,41534876,41534929,41554022,41561692,41592110,41635385,41647794,41648310,41674065,41885459,41900443,
					41985826,41988030,41988201,41990583,41991022,42063499,42064851,42065610,14393371,14479158,14487413,14493592,14500765,
					14521186,14600271,14611891,14629438,14645537,14653772,14654561,14672236,13864417,13877914,13916569,13947290,13959383,
					13964983,13999461,14056309,14056457,14084599,14117461,14117558,14168098,14210898,14219614,14219726,14249373,14288020,
					14291649,13552912,13589028,13650701,13658529,12267541,12276108,12276215,12276311,12285701,12334841,12969157,13053739,
					13068960,13216677,13294314,13308147,13323754,12368437,12551127,12645956,12673044,12677536,12697102,12698394,12747449,
					12957917,11747087,11779389,11895734,11930116,11998757,12033438,12042691,12162858,11674120,11639821,11449326,7643291,
					7655254,7657763,8314515,8363406,8444096,8452415,8591808,8646071,8660821,8811657,9178183,9368991,9732491,9748538,10228419,
					10229689,10346439,10369357,10369510,10398791,10419083,10488307,10528317,10630381,10719518,10776607,10844414,10851205,
					10851237,10932984,10945672,11028100,11213414,11395466,8014689,8119664,8212440,8226456,7763508,7768121,7912978,7925352,
					7694826,7744897,7752444,7752889,7754066,7754182,7756567,7756579,7756983,7757433,4362130,4371323,4374817,4501066,4542800,
					4553978,4554012,4568298,4582761,4638100,4770359,4780138,4793213,4910597,4910667,4957465,5049084,5061164,5187839,5205926,
					5232827,5239932,5294161,5375143,5395806,5430927,5484091,5551253,5591058,5780740,5831527,6032952,6129341,6164108,6379932,
					6512733,6520522,6552366,6621107,6647416,6660062,6660080,7146892,7165270,7204275,7541492,4290320,4339154,3589741,4262711,
					4262766,4002647,4011723,4022510,4106468,4115476,4127035,4134975,4154452,4155328,4181480,4181669,4204345,3872549,3934718,
					3988315,3988331,3040566,3043793,3046451,3131329,3140232,3634274,3637466,3673145,3721876,3741448,3752852,3775566,3775579,
					3780034,3800272,3175356,3202337,3212166,3230597,3230605,3254803,3299391,3299401,3299716,3352151,3387915,3498147,3517988,
					3543954,3560324,2953285,2959987,2967035,3026741,1419577,1427766,1272134,1294410,1348932,1362437,1374344,1244484,1013342,
					1019793,2394977,2400612,2400801,2468871,2468882,2487351,2491953,2572491,2574511,2586897,2644737,2732315,2775382,2798591,
					2800652,2849735,2850808,2864145,2864842,2895571,2924293,1927603,1985118,2033407,2045218,2075164,2101733,2114958,2122304,
					2138601,2140377,2178402,2181729,2197674,2221671,2260222,2267229,2278343,2284508,2285864,2300662,2341316,1441097,1456925,
					1457236,1465925,1501259,1551473,1568705,1574950,1584511,1590290,1601946,1607683,1628290,1639382,1650176,1652112,1698383,
					1720567,1731921,1755451,1788386,1833046,1867721,1071794,1074882,1074884,1088459,1127269,1156957,1194960,1022404,1026354,
					1029732,1030116,1031455,1031457,1036451,1069029,1005645,941026,941038,965631,966501,972747,914839,889147,877768,984549,
					984745,984746,985943,987102,987497,987499,987501,987804,989898,993226,994735,997137,997149,997151,997152,997155,997237,
					998346,998349,836410,837904,838051,771942,774701,805450,832992,857802,859594,838210,726483,324336,324557,324558,324559,
					324564,356937,356948,365486,461775,461780,463265,478396,506057,528691,533951,572607,595962,7604170,67)
	
	CREATE TABLE #CheckPTResult_Credit(
		[RuleId] [smallint] NULL,
		[SportType] [smallint] NULL,
		[BetType] [smallint] NULL,
		[CustIdA] [int] NULL,
		[CustIdB] [int] NULL,
		[ValueA] [smallmoney] NULL,
		[ValueB] [smallmoney] NULL,
		[CreatedDate] [datetime] NULL,
		[IsLive] [bit] NULL
	)

	GO

	ALTER TABLE #CheckPTResult_Credit ADD DEFAULT (getdate()) FOR [CreatedDate]
	GO
	ALTER TABLE #CheckPTResult_Credit ADD DEFAULT ((0)) FOR [IsLive]

	SELECT DISTINCT sporttype 
	INTO #SportType 
	FROM ProductSettingDetail WITH (NOLOCK)
	WHERE SportType in (243,241) -- Sexy, BBIN
		AND SettingType = 1

	DECLARE @RuleId SMALLINT = 0	

	-- Starting DATA PREPARATION
	--TRUNCATE TABLE CheckPTResult_Credit	
	CREATE TABLE #MemberPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, SuperPT TINYINT, MasterPT TINYINT, AgentPT TINYINT, IsAutoMasterPT BIT, AutoMasterPT TINYINT, IsAutoSuperPT BIT, AutoSuperPT TINYINT, IsGroup BIT)
	CREATE TABLE #AgentPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, SuperPT TINYINT, MasterPT TINYINT, AgentPT TINYINT, IsAutoMasterPT BIT, AutoMasterPT TINYINT, IsAutoSuperPT BIT, AutoSuperPT TINYINT, MinPT TINYINT, MaxPT TINYINT)
	CREATE TABLE #MasterPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, SuperPT TINYINT, MasterPT TINYINT, AgentPT TINYINT, IsAutoMasterPT BIT, AutoMasterPT TINYINT, IsAutoSuperPT BIT, AutoSuperPT TINYINT, MinPT TINYINT, MaxPT TINYINT)
	CREATE TABLE #SuperPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, SuperPT TINYINT, MasterPT TINYINT, AgentPT TINYINT, IsAutoMasterPT BIT, AutoMasterPT TINYINT, IsAutoSuperPT BIT, AutoSuperPT TINYINT, MinPT TINYINT, MaxPT TINYINT)
			
	DECLARE @isDummySuper BIT = 0
	
	IF EXISTS (SELECT 1 FROM #DirectMaster)
		SELECT @isDummySuper = 1
		
	INSERT INTO #MemberPT (CustID, recommend,mrecommend,srecommend,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT,IsAutoMasterPT,AutoMasterPT,IsAutoSuperPT,AutoSuperPT,IsGroup)
	SELECT cs.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,0 IsGroup
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustPTSetting3rd_Member cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype AND prf.bettype = cs.bettype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers)
			AND ci.roleid = 1  
			AND ci.Enabled = 1
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType in (select sporttype from #SportType)			
			AND (
					ISNULL(bitmapOrder,0) < 5 --From VB onwards
					OR 
					CASE substring(bitmapHasSynced, 1+((bitmapOrder-1)/8), 1) & POWER(2, (bitmapOrder-1)%8) WHEN 0 THEN 0 ELSE 1 END = 1		 
				)
	
	INSERT INTO #MemberPT (CustID, recommend,mrecommend,srecommend,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT,IsAutoMasterPT,AutoMasterPT,IsAutoSuperPT,AutoSuperPT,IsGroup)
	SELECT ci.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,1
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustSettingMode3rd csm WITH (NOLOCK) ON ci.custid = csm.CustID AND csm.IsGrouped = 1
		INNER JOIN dbo.CustPTGroupSetting3rd_Member cs WITH (NOLOCK) ON cs.AgentID = ci.recommend  
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype AND prf.bettype = cs.bettype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers)
			AND ci.roleid = 1  
			AND ci.Enabled = 1
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType in (select sporttype from #SportType)			
			AND (
					ISNULL(bitmapOrder,0) < 5 --From VB onwards
					OR 
					CASE substring(bitmapHasSynced, 1+((bitmapOrder-1)/8), 1) & POWER(2, (bitmapOrder-1)%8) WHEN 0 THEN 0 ELSE 1 END = 1		 
				)
	
	INSERT INTO #AgentPT (CustID, recommend,mrecommend,srecommend,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT,IsAutoMasterPT,AutoMasterPT,IsAutoSuperPT,AutoSuperPT, MinPT, MaxPT)			
	SELECT cs.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,cs.MinPT,cs.MaxPT
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype AND prf.bettype = cs.bettype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers)
			AND ci.roleid = 2  
			AND ci.Enabled = 1
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType in (select sporttype from #SportType)			
			AND (
					ISNULL(bitmapOrder,0) < 5 --From VB onwards
					OR 
					CASE substring(bitmapHasSynced, 1+((bitmapOrder-1)/8), 1) & POWER(2, (bitmapOrder-1)%8) WHEN 0 THEN 0 ELSE 1 END = 1		 
				)
	
	INSERT INTO #MasterPT (CustID, recommend,mrecommend,srecommend,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT,IsAutoMasterPT,AutoMasterPT,IsAutoSuperPT,AutoSuperPT,MinPT,MaxPT)			
	SELECT cs.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,cs.MinPT,cs.MaxPT
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype AND prf.bettype = cs.bettype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers) 
			AND ci.roleid = 3  
			AND ci.Enabled = 1
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType in (select sporttype from #SportType)			
			AND (
					ISNULL(bitmapOrder,0) < 5 --From VB onwards
					OR 
					CASE substring(bitmapHasSynced, 1+((bitmapOrder-1)/8), 1) & POWER(2, (bitmapOrder-1)%8) WHEN 0 THEN 0 ELSE 1 END = 1		 
				)
	
	INSERT INTO #SuperPT (CustID, SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT,IsAutoMasterPT,AutoMasterPT,IsAutoSuperPT,AutoSuperPT,MinPT,MaxPT)			
	SELECT cs.CustID, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,cs.MinPT,cs.MaxPT
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype AND prf.bettype = cs.bettype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers)
			AND ci.roleid = 4  
			AND ci.Enabled = 1
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType in (select sporttype from #SportType)
			AND (
					ISNULL(bitmapOrder,0) < 5 --From VB onwards
					OR 
					CASE substring(bitmapHasSynced, 1+((bitmapOrder-1)/8), 1) & POWER(2, (bitmapOrder-1)%8) WHEN 0 THEN 0 ELSE 1 END = 1		 
				)
		
	CREATE CLUSTERED INDEX CIX_MemberPT ON #MemberPT(CustID, sporttype, bettype)
	CREATE CLUSTERED INDEX CIX_AgentPT ON #AgentPT(CustID, sporttype, bettype)
	CREATE CLUSTERED INDEX CIX_MasterPT ON #MasterPT(CustID, sporttype, bettype)
	CREATE CLUSTERED INDEX CIX_SuperPT ON #SuperPT(CustID, sporttype, bettype)	

	-- End DATA PREPARATION	

	-- Starting check PT Rule
	---- 1. S1 < 0 OR M1 < 0 OR A1 < 0  
	IF @RuleId IN (0,1)  
	BEGIN  
		----PRINT '1. S1 < 0 OR M1 < 0 OR A1 < 0 '  
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)   
		SELECT 1 AS RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,  
			 CASE 
				WHEN cs.SuperPT < 0 THEN cs.SuperPT
				WHEN cs.MasterPT < 0 THEN cs.MasterPT
				WHEN cs.AgentPT < 0 THEN cs.AgentPT
				ELSE 0  
			 END,  
			 0,   
			 cs.Islive  
		FROM #MemberPT cs 
		WHERE cs.SuperPT < 0 OR cs.MasterPT < 0 OR cs.AgentPT < 0
		
	END  

	----2. S4 > MaxPT OR M4 > MaxPT OR A4 > MaxPT  
	IF @RuleId IN (0,2)  
	BEGIN  
		----PRINT '2. S4 > 90 OR M4 > 90 OR A4 > 90 '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 2 AS RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,  
			 CASE 
				WHEN cs.SuperPT > ps.MaxPT THEN cs.SuperPT
				WHEN cs.MasterPT > ps.MaxPT THEN cs.MasterPT
				WHEN cs.AgentPT > ps.MaxPT THEN cs.AgentPT   
				ELSE ps.MaxPT   
			 END,  
			 ps.MaxPT,  
			 cs.Islive
		FROM #SuperPT cs 
			INNER JOIN dbo.ProductSettingDetail ps ON cs.SportType = ps.SportType AND cs.Bettype = ps.Bettype AND cs.IsLive = ps.IsLive AND ps.Settingtype = 1
		WHERE cs.SuperPT > ps.MaxPT OR cs.MasterPT > ps.MaxPT OR cs.AgentPT > ps.MaxPT
		
	END  

	----3. S4 < M4   

	IF @RuleId IN (0,3)  
	BEGIN   
		----PRINT '3. S4 < M4 '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 3 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId
			, cs.SuperPT
			, cs.MasterPT
			, cs.IsLive  
		FROM #SuperPT cs 
		WHERE cs.SuperPT < cs.MasterPT

	END  

	----4. S4 < A4  

	IF @RuleId IN (0,4)  
	BEGIN  
		----PRINT '4. S4 < A4 '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 4 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.SuperPT, cs.AgentPT, cs.IsLive  
		FROM #SuperPT cs
		WHERE cs.SuperPT < cs.AgentPT
	END  
	
	----5. S4 < N4   

	IF @RuleId IN (0,5)  
	BEGIN   
		----PRINT '5. S4 < N4 '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 5 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.SuperPT, cs.MinPT, cs.IsLive  
		FROM #SuperPT cs  
		WHERE cs.superPT < cs.MinPT

	END  
	

	----6. S4 < US3   
	
	IF @RuleId IN (0,6)  
	BEGIN   
		----PRINT '6. S4 < US3   '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 6 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.SuperPT , cs.AutoSuperPT, cs.IsLive  
		FROM #MasterPT cs 
			JOIN #SuperPT scs ON scs.CustID = cs.srecommend  AND scs.SportType = cs.SportType  
											AND scs.BetType = cs.BetType 
											AND scs.IsLive = cs.IsLive  
		WHERE scs.SuperPT < cs.AutoSuperPT
		
	END  
	
	----7. S4 < US1   

	IF @RuleId IN (0,7)  
	BEGIN   
		----PRINT '7. S4 < US1'
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 7 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.SuperPT, cs.AutoSuperPT, scs.IsLive
		FROM #MemberPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType  
											AND scs.BetType = cs.BetType 
											AND scs.IsLive = cs.IsLive 
		WHERE scs.SuperPT < cs.AutoSuperPT
		
	END  

	----8. S4 < S3 + M3   

	IF @RuleId IN (0,8)  
	BEGIN   
		----PRINT '8. S4 < S3 + M3   '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 8 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.SuperPT, cs.SuperPT + cs.MasterPT, scs.IsLive  
		FROM #MasterPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType	AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive 
		WHERE scs.SuperPT < cs.SuperPT + cs.MasterPT
		
	END  

	----9. S4 < S1 + M1 + A1   

	IF @RuleId IN (0,9)  
	BEGIN   
		----PRINT '9. S4 < S1 + M1 + A1   '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 9 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.SuperPT, cs.SuperPT + cs.MasterPT + cs.AgentPT, scs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND  scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive 
		WHERE scs.SuperPT < cs.SuperPT + cs.MasterPT + cs.AgentPT

	END  

	----10. N4 > S1 + M1 + A1   
	----PRINT '10. N4 > S1 + M1 + A1 '
	IF @RuleId IN (0,10)  
	BEGIN 
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 10 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MinPT, cs.SuperPT + cs.MasterPT + cs.AgentPT, scs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.MinPT > cs.SuperPT + cs.MasterPT + cs.AgentPT
		  
	END  


	-----------------------------------------------------------------------  
	----11. M4 < A4  

	IF @RuleId IN (0,11)  
	BEGIN   
		----PRINT '11. M4 < A4  '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 11 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.MasterPT, cs.AgentPT, cs.IsLive  
		FROM #SuperPT cs 
		WHERE cs.MasterPT < cs.AgentPT
		
	END  
	----12. M4 < M3   
	IF @RuleId IN (0,12)  
	BEGIN  
		----PRINT '12. M4 < M3'
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 12 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.MasterPT, scs.IsLive  
		FROM #MasterPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive   
		WHERE scs.MasterPT < cs.MasterPT
		 
	END  
	----13. M4 < N3   

	IF @RuleId IN (0,13)  
	BEGIN  
		----PRINT '13. M4 < N3'
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 13 as RuleId, scs.BetType, scs.SportType, scs.CustId, cs.CustId, scs.MasterPT , cs.MinPT, scs.IsLive  
		FROM #MasterPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive   
		WHERE scs.MasterPT < cs.MinPT


	END  
	----14. M4 < UM2   

	IF @RuleId IN (0,14)  
	BEGIN  
		----PRINT '14. M4 < UM2 '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 14 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.AutoMasterPT, scs.IsLive  
		FROM #AgentPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive   
		WHERE scs.MasterPT < cs.AutoMasterPT
		
	END  

	----15. M4 < UM1   

	IF @RuleId IN (0,15)  
	BEGIN  
		----PRINT '15. M4 < UM1   '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 15 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.AutoMasterPT, scs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND  scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.MasterPT < cs.AutoMasterPT
			
	END  

	----16. M4 < M1 + A1   
	
	IF @RuleId IN (0,16)  
	BEGIN  
		----PRINT '16. M4 < M1 + A1 '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 16 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT , cs.MasterPT + cs.AgentPT, scs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND  scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.MasterPT < cs.MasterPT + cs.AgentPT
	END  


	----17. M3 < N3   

	IF @RuleId IN (0,17)  
	BEGIN  
		----PRINT '17. M3 < N3   '
		
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 17 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.MasterPT, cs.MinPT, cs.IsLive  
		FROM #MasterPT cs
		WHERE cs.MasterPT < cs.MinPT
		
	END  

	--------------------------------------------------------------------------------------------  
	----18. M3 < M2 + A2   

	IF @RuleId IN (0,18)  
	BEGIN   
		----PRINT '18. M3 < M2 + A2   '
		
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 18 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.MasterPT + cs.AgentPT, cs.IsLive  
		FROM #AgentPT cs
			INNER JOIN #MasterPT scs ON cs.mrecommend = scs.Custid AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.MasterPT < cs.MasterPT + cs.AgentPT
		
	END  

	----19. M3 < M1 + A1   

	IF @RuleId IN (0,19)  
	BEGIN   
		----PRINT '19. M3 < M1 + A1   '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 19 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.MasterPT + cs.AgentPT, cs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #MasterPT scs ON scs.CustID = cs.mrecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.MasterPT < cs.MasterPT + cs.AgentPT
		
	END  

	 
	----20. N3 > M1 + A1   

	IF @RuleId IN (0,20)  
	BEGIN  
		----PRINT '20. N3 > M1 + A1   '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 20 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MinPT, cs.MasterPT + cs.AgentPT, cs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #MasterPT scs ON scs.CustID = cs.mrecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.MinPT > cs.MasterPT + cs.AgentPT
		
	END    


	----21. A4 < A2  

	IF @RuleId IN (0,21)  
	BEGIN   
		----PRINT '21. A4 < A2  '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLIve)  
		SELECT 21 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.AgentPT, cs.AgentPT, scs.IsLive  
		FROM #AgentPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.AgentPT < cs.AgentPT
		  
	END   


	----22. A4 < A1  

	IF @RuleId IN (0,22)  
	BEGIN  
		----PRINT '22. A4 < A1  '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 22 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.AgentPT, cs.AgentPT, scs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.AgentPT < cs.AgentPT
			
	END   

	----23. A2 < N2  

	IF @RuleId IN (0,23)  
	BEGIN   
		----PRINT '23. A2 < N2  '	
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 23 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.AgentPT, cs.MinPT, cs.IsLive
		FROM #AgentPT  cs
		WHERE cs.AgentPT < cs.MinPT
		  
	END   

	----24. N2 > A1  

	IF @RuleId IN (0,24)  
	BEGIN  
		----PRINT '24. N2 > A1  '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 24 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MinPT, cs.AgentPT, cs.IsLive   
		FROM #MemberPT cs
			INNER JOIN #AgentPT scs ON scs.CustID = cs.recommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE   scs.MinPT > cs.AgentPT

		  
	END  


	---------------------------------------------------  
	---- 25. L4 < S1 + M1 + A1   
	IF @RuleId IN (0,25)  
	BEGIN   
		----PRINT '25. L4 < S1 + M1 + A1   '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 25 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MaxPT, cs.SuperPT + cs.MasterPT + cs.AgentPT, cs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.MaxPT < cs.SuperPT + cs.MasterPT + cs.AgentPT

		  
	END  

	---- 26. L3 < M1 +A1  
	IF @RuleId IN (0,26)  
	BEGIN  
		----PRINT '26. L3 < M1 +A1  '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 26 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MaxPT, cs.MasterPT + cs.AgentPT, cs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #MasterPT scs ON scs.CustID = cs.mrecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE scs.MaxPT < cs.MasterPT + cs.AgentPT
		
	END    
	---- 27. L2 < A1   
	IF @RuleId IN (0,27)  
	BEGIN  
		----PRINT '27. L2 < A1   '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 27 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MaxPT, cs.AgentPT, cs.IsLive  
		FROM #MemberPT cs
			INNER JOIN #AgentPT scs	ON scs.CustID = cs.recommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
		WHERE  scs.MaxPT < cs.AgentPT

	END  


	---- 28. MIN(S4-M1-A1, (IS1?US1,US3)) > S1  
	IF @RuleId IN (0,28)  
	BEGIN   
		----PRINT '28. MIN(S4-M1-A1, (IS1?US1,US3)) > S1  '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 28 AS RuleId, cs.BetType, cs.SportType   
				,CASE WHEN scs.SuperPT - cs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoSuperPT = 1 THEN cs.AutoSuperPT ELSE mcs.AutoSuperPT END)     
				  THEN ( CASE WHEN cs.IsAutoSuperPT = 1   
					  THEN cs.CustId   
					  ELSE mcs.CustId   
					END)  
				  ELSE scs.CustId  
				 END   
				,cs.CustId      
				,CASE WHEN scs.SuperPT - cs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoSuperPT = 1 THEN cs.AutoSuperPT ELSE mcs.AutoSuperPT END)     
				  THEN ( CASE WHEN cs.IsAutoSuperPT = 1   
					  THEN cs.AutoSuperPT   
					  ELSE mcs.AutoSuperPT   
					END)  
				  ELSE scs.SuperPT - cs.MasterPT - cs.AgentPT
				 END   
				,cs.SuperPT  
				,cs.IsLive  
		FROM #MemberPT cs WITH (NOLOCK)  
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType  AND scs.bettype = cs.bettype  AND scs.IsLive = cs.IsLive  
			INNER JOIN #MasterPT mcs ON mcs.CustID = cs.mrecommend AND mcs.SportType = cs.SportType AND mcs.bettype = cs.bettype AND mcs.IsLive = cs.IsLive 							   
		
		WHERE (cs.IsAutoSuperPT = 1 OR mcs.IsAutoSuperPT = 1)  
			AND cs.SuperPT < CASE WHEN scs.SuperPT - cs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoSuperPT = 1 THEN cs.AutoSuperPT ELSE mcs.AutoSuperPT END)     
					THEN ( CASE WHEN cs.IsAutoSuperPT = 1   
						THEN cs.AutoSuperPT   
						ELSE mcs.AutoSuperPT   
					  END)  
					ELSE scs.SuperPT - cs.MasterPT - cs.AgentPT  
				   END   
				   
	END   

	
	---- 29. MIN (M4-A1, M3-A1,(IM1?UM1,UM2)) > M1 
	IF @RuleId IN (0,29)  
	BEGIN   
		----PRINT '29. MIN (M4-A1, M3-A1,(IM1?UM1,UM2)) > M1   '
		INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		SELECT 29 AS RuleId, cs.BetType, cs.SportType   
		,CASE WHEN scs.MasterPT > mcs.MasterPT   
		   THEN CASE WHEN mcs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			 THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			   THEN cs.CustId  
			   ELSE acs.CustId   
			   END  
				)  
			 ELSE mcs.CustId  
		   END  
		 ELSE   
		   CASE WHEN scs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			 THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			   THEN cs.CustId  
			   ELSE acs.CustId   
			  END  
			  )  
			 ELSE scs.CustId  
		   END  
		 END  
		,cs.CustId  
		,CASE WHEN scs.MasterPT > mcs.MasterPT   
		   THEN CASE WHEN mcs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			 THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			   THEN cs.AutoMasterPT  
			   ELSE acs.AutoMasterPT   
				END  
				)  
			 ELSE mcs.MasterPT - cs.AgentPT  
		   END  
		 ELSE   
		   CASE WHEN scs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			 THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			   THEN cs.AutoMasterPT  
			   ELSE acs.AutoMasterPT   
			  END  
			  )  
			 ELSE scs.MasterPT - cs.AgentPT  
		   END  
		 END  
		,cs.MasterPT  
		,cs.IsLive  
		FROM #MemberPT cs 
			INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.bettype = cs.bettype AND scs.IsLive = cs.IsLive
			INNER JOIN #MasterPT mcs ON mcs.CustId = cs.mrecommend AND mcs.SportType = cs.SportType AND mcs.bettype = cs.bettype AND mcs.IsLive = cs.IsLive
			INNER JOIN #AgentPT acs ON acs.CustId = cs.recommend  AND acs.SportType = cs.SportType AND acs.bettype = cs.bettype AND acs.IsLive = cs.IsLive	   		     
				   
		WHERE ( acs.IsAutoMasterPT = 1 OR cs.IsAutoMasterPT = 1 )  
			AND cs.MasterPT < CASE WHEN scs.MasterPT > mcs.MasterPT   
					 THEN CASE  WHEN mcs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
					   THEN (CASE WHEN cs.IsAutoMasterPT = 1   
						 THEN cs.AutoMasterPT  
						 ELSE acs.AutoMasterPT
						  END  
						  )  
					   ELSE mcs.MasterPT - cs.AgentPT  
					   END  
					ELSE   
					  CASE WHEN scs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
						THEN (CASE WHEN cs.IsAutoMasterPT = 1   
						  THEN cs.AutoMasterPT  
						  ELSE acs.AutoMasterPT   
						 END  
						 )  
						ELSE scs.MasterPT - cs.AgentPT  
						END  
					END  

	END   

	---- 33. PT setting of member exists in both Individual and group PT   
	IF @RuleId IN (0,33)  
	BEGIN   
		 ----PRINT ' 30. PT setting of member exists in both Individual and group PT'
		 INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		 SELECT DISTINCT 33,NULL,NULL,M.CustID,M.CustID,NULL,NULL,NULL
		 FROM #MemberPT M
		 WHERE EXISTS (SELECT 1 FROM dbo.CustPTSetting3rd_Member M1 WITH (NOLOCK) WHERE M1.CustID = M.CustID)
			   AND EXISTS (SELECT 1 FROM dbo.CustSettingMode3rd csm WITH (NOLOCK) WHERE csm.CustID = M.CustID AND csm.IsGrouped = 1)	
	END	
	
	---- 34. IsGrouped Flag = 0 but not exists in Individual PT table
	IF @RuleId IN (0,34)  
	BEGIN   
		 ----PRINT '31. IsGrouped Flag = 0 but not exists in Individual PT table'
		 INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		 SELECT DISTINCT 34,NULL,NULL,M.CustID,M.CustID,NULL,NULL,NULL
		 FROM #MemberPT M
		 WHERE EXISTS (SELECT 1 FROM dbo.CustSettingMode3rd csm WITH (NOLOCK) WHERE csm.CustID = M.CustID AND csm.IsGrouped = 0)	
			   AND NOT EXISTS (SELECT 1 FROM dbo.CustPTSetting3rd_Member M1 WITH (NOLOCK) WHERE M1.CustID = M.CustID)
			   
	END	 
	
	---- 35. IsGrouped Flag = 1 but not exists in Group PT table
	IF @RuleId IN (0,35)  
	BEGIN   
		 ----PRINT '32. IsGrouped Flag = 1 but not exists in Group PT table'
		 INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		 SELECT DISTINCT 35,NULL,NULL,M.CustID,M.CustID,NULL,NULL,NULL
		 FROM #MemberPT M
		 WHERE EXISTS (SELECT 1 FROM dbo.CustSettingMode3rd csm WITH (NOLOCK) WHERE csm.CustID = M.CustID AND csm.IsGrouped = 1)	
				AND NOT EXISTS (SELECT 1 FROM dbo.CustPTGroupSetting3rd_Member M1 WITH (NOLOCK) WHERE M1.AgentID = M.recommend)
			   
	END	 
		
	IF @isDummySuper = 1
	BEGIN
		---- 36. dummy super has s3<> 0
		IF @RuleId IN (0,36)
		BEGIN 	
			INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
			SELECT	36 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
					SuperPT,
					0, 
					0
			FROM #MasterPT cs
			WHERE SuperPT<>0 
				AND custid IN (SELECT custid FROM #DirectMaster)			
		END
		
		--37. dummy super has s1 <> 0
		IF @RuleId IN (0,37)
		BEGIN 	
			INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
			SELECT	37 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
					SuperPT,
					0, 
					0
			FROM #MemberPT cs
			WHERE SuperPT<>0 
				AND mrecommend IN (SELECT custid FROM #DirectMaster)			
		END
	END		
	
	---- 72. S4 = M4 = A4 = 0
	IF @RuleId IN (0,72)  
	BEGIN   
		 ----PRINT '72. S4 = M4 = A4 = 0'
		 INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
		 SELECT DISTINCT 72,bettype,sporttype,CustID,CustID,NULL,NULL,IsLive
		 FROM #SuperPT 
		 WHERE SuperPT = 0 AND MasterPT = 0 AND AgentPT = 0	   
	END	 
--SELECT * FROM #MasterPT where custid IN (119408,169526,3198807) 
--SELECT * FROM #supers wHERE custid IN (365484,4014144,3451110)

SELECT ca.username AS UsernameA, ca.roleid AS roleidA, cb.username AS UsernameB, cb.roleid AS roleidB, cs.* 
FROM #CheckPTResult_Credit cs
	INNER JOIN CustInfo ca WITH (NOLOCK) ON cs.custidA = ca.custid
	INNER JOIN CustInfo cb WITH (NOLOCK) ON cs.custidB = cb.custid	
WHERE ruleid NOT IN (36,37)
ORDER BY ruleid	

--DROP TABLE #CheckPTResult_Credit