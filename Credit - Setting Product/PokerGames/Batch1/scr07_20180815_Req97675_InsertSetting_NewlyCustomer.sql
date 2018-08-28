/*
	Created: Elodie
	Task: Copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20180815
*/ 
PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.site IN ('789y')
	AND ci.currency <> 20
	AND ci.custid NOT IN (16) -- dummy account
	AND ci.currency IN (16,64)

DECLARE @ProductID INT = 33, @currency INT

SELECT t.* 
INTO #SportBettypeFilter3
FROM ProductSettingDetail t WITH (NOLOCK)
WHERE t.SettingType = 3 AND t.ProductID = @ProductID

SELECT t.* 
INTO #SportBettypeFilter6
FROM ProductSettingDetail t WITH (NOLOCK)
WHERE t.SettingType = 6 AND t.ProductID = @ProductID

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT,
	Credit MONEY
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
	currency INT,
	Credit MONEY
)
	
INSERT INTO #MemberTemp (CustID, currency, Credit)
SELECT custid, currency, Credit
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid	
	
INSERT INTO #SMATemp (CustID, roleid, currency, Credit)
SELECT custid, roleid, currency, Credit
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 

----------------------------------------Comm Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustDiscount3rd_Agent (CustID, SportType, BetType, Discount)	        
SELECT ci.custid, sb.SportType, sb.BetType, 
	CASE	WHEN ci.roleid = 4 THEN 0.85
			ELSE 0 END 
FROM #SMATemp ci WITH(NOLOCK)
	CROSS APPLY #SportBettypeFilter3 sb 

--Member Level
INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
SELECT ci.custid, sb.SportType, sb.BetType, 0, 0, 0, 0.85
FROM #MemberTemp ci WITH(NOLOCK)
	CROSS APPLY #SportBettypeFilter3 sb
----------------------------------------WinLoss Limit Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustWinLossLimit_Agent (CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, sb.SportType, sb.BetType, 0, 
	CASE	WHEN FLOOR(ci.Credit * 0.1) < cs.MinLossLimit THEN cs.MinLossLimit
			WHEN FLOOR(ci.Credit * 0.1) > cs.DefaultLossLimit THEN cs.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END, 1
FROM #SMATemp ci WITH(NOLOCK)
	INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON ci.currency = cs.ExchangeId
	CROSS APPLY #SportBettypeFilter6 sb
WHERE cs.ProductId = @ProductID	
		 
--Member Level
INSERT INTO dbo.CustWinLossLimit_Member(CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, sb.SportType, sb.BetType, 0,
	CASE	WHEN FLOOR(ci.Credit * 0.1) < cs.MinLossLimit THEN cs.MinLossLimit
			WHEN FLOOR(ci.Credit * 0.1) > cs.DefaultLossLimit THEN cs.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END, 1
FROM #MemberTemp ci WITH(NOLOCK)
	INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON ci.currency = cs.ExchangeId
	CROSS APPLY #SportBettypeFilter6 sb
WHERE cs.ProductId = @ProductID	

/*******************************CUST PRODUCTSTATUS TABLE*******************************/	
DECLARE @xmlStrValue_0 XML, @xmlStrValue_1 XML, @Sporttype SMALLINT = 163

SET @xmlStrValue_0 =(
		SELECT (
				SELECT psp.bitmapOrder	AS '@b'
					, 0	AS '@s'
				FROM ProductStatusProfile psp WITH (NOLOCK)
				WHERE psp.Sporttype = @Sporttype AND Bettype BETWEEN 1401 AND 1404
				FOR XML PATH('r')
					, TYPE
				)
		FOR XML PATH('root')
			, TYPE
		)

SET @xmlStrValue_1 =(
		SELECT (
				SELECT psp.bitmapOrder	AS '@b'
					, 1	AS '@s'
				FROM ProductStatusProfile psp WITH (NOLOCK)
				WHERE psp.Sporttype = @Sporttype AND Bettype BETWEEN 1401 AND 1404
				FOR XML PATH('r')
					, TYPE
				)
		FOR XML PATH('root')
			, TYPE
		)

SELECT custid, roleid
INTO #DisableLine
FROM custInfo WITH (NOLOCK) 
WHERE username IN (	'AZ1','AZ12','AZ13','AZ15','AZ3','AZ4','AZ5','AZ6','AZ7','BC5','BC7','BC8','BC9','BCA','BK','BL','BM','BP','BX14','BX15','BX16','BX19',
					'BX21','BX3','BX32','BX37','BX38','BX41','BX43','BX45','BX48','BX54','BX55','BX60','BX63','BX64','BX75','BX76','BX79','BX81','BX84',
					'BX92','BX98','BY','CG1','CG13','CG15','CG26','CG27','CG33','CG34','CG43','CG44','CG46','CG48','CG60','DT1','DT10','DT11','DT12',
					'DT13','DT17','DT18','DT19','DT3','DT31','DT32','DT34','DT35','DT36','DT40','DT41','DT43','DT45','DT46','DT47','DT62','DT63','DT64',
					'DT65','DT66','DT68','DT69','DT70','DT71','DT72','DT77','DT78','DT79','DT8','DT80','DT81','DT82','DT83','DT84','DT85','DT87','DT88',
					'DT92','DT93','DT95','DT96','DT97','DT99','DTA11','DTA12','DTA13','DTA14','DTA15','DTA17','DTA18','DTA2','DTA21','DTA22','DTA23',
					'DTA25','DTA27','DTA28','DTA29','DTA3','DTA30','DTA31','DTA32','DTA33','DTA34','DTA35','DTA36','DTA37','DTA38','DTA4','DTA40','DTA41',
					'DTA42','DTA43','DTA44','DTA46','DTA47','DTA48','DTA49','DTA50','DTA51','DTA52','DTA53','DTA54','DTA55','DTA56','DTA57','DTA58','DTA59',
					'DTA60','DTA61','DTA62','DTA63','DTA64','DTA65','DTA66','DTA67','DTA68','DTA69','DTA7','DTA70','DTA71','DTA72','DTA73','DTA74','DTA75',
					'DTA76','DTA77','DTA78','DTA79','DTA8','DTA80','DTA81','DTA82','DTA83','DTA84','DTA85','DTA86','DTA87','DTA88','DTA89','DTA90','DTA91',
					'DTA92','DTA93','DTA94','DTA95','DTA96','DTA97','DTA98','DTA99','DTB01','DX13','DX15','DX16','DX18','DX2','DX20','DX21','DX22','DX23',
					'DX24','DX25','DX26','DX27','DX3','DX33','DX34','DX39','DX40','DX44','DX45','DX46','DX47','DX48','DX49','DX52','DX53','DX54','DX57',
					'DX58','DX60','DX7','DX8','DX9','EA','EB3','EG1','EH','EH1','EH2','EJ1','ET1','ET5','EW','HC','QC','QH','QM','QO','QR','qs','S01',
					'S04','S09','S17','S18','S19','SC','SD1','SD11','SD13','SD14','SD19','SD20','SD22','SD23','SD31','SD32','SD38','SD44','SD47','SD48',
					'SD53','SD55','SD56','SD57','SD61','SD68','SD70','SD71','SD72','SD9','SG','SH','SS4','SS83','SS87','SS89','SS9','SS90','SU5','SU7',
					'SU9','XJ','XK1','XK2','XS','XXA','XXB','AZ8','BD1','BD2','BD4','BN','BR','BX1','BX12','BX13','BX17','BX2','BX22','BX27','BX30','BX31',
					'BX33','BX35','BX39','BX42','BX44','BX49','BX5','BX50','BX51','BX52','BX53','BX56','BX57','BX58','BX6','BX62','BX7','BX77','BX82',
					'BX83','BX85','BX86','BX88','BX91','BX93','BX95','BX96','CG18','CG19','CG23','CG24','CG25','CG28','CG29','CG31','CG36','CG40','CG41',
					'CG5','CG50','CG52','CG55','CG56','CG57','CG58','CG59','DT14','DT15','DT20','DT21','DT23','DT24','DT25','DT26','DT27','DT28','DT29',
					'DT30','DT37','DT38','DT39','DT4','DT42','DT44','DT5','DT50','DT51','DT6','DT61','DT67','DT7','DT73','DT9','DT90','DT94','DT98','DTA1',
					'DTA10','DTA16','DTA19','DTA20','DTA24','DTA26','DTA39','DTA45','DTA6','DX10','DX12','DX14','DX19','DX28','DX29','DX30','DX31','DX35',
					'DX36','DX37','DX38','DX4','DX5','DX50','DX51','DX55','DX56','EB','EB2','EG3','EG5','EH3','EH9','EQ','ET3','QA','QI','QV','S02','S08',
					'S10','S12','S13','S15','S16','SD10','SD12','SD16','SD17','SD18','SD24','SD29','SD33','SD35','SD36','SD39','SD40','SD45','SD49','SD50',
					'SD51','SD52','SD54','SD59','SD60','SD63','SD65','SD66','SD67','SD69','SK8','SS01','SS1','SS2','SS3','SS81','SS82','SS84','SS85','SS86',
					'SS88','SU1','SU10','SU4','SU6','SU8','XH','XK','XK4','XK5','BC2','BX36','BX61','BX99','CG17','CG21','CG45','DX1','DX17','QK','QP','SD8',
					'SU2','AZ10','AZ11','AZ14','AZ2','AZ9','BC','BC1','BC3','BC6','BD','BD3','BD5','BE','BG','BH','BO','BX','BX10','BX11','BX18','BX20','BX23',
					'BX24','BX25','BX26','BX28','BX29','BX34','BX4','BX40','BX46','BX47','BX59','BX65','BX78','BX8','BX80','BX87','BX89','BX9','BX90','BX94',
					'BX97','BZ','CG16','CG2','CG20','CG22','CG3','CG30','CG32','CG35','CG37','CG38','CG39','CG4','CG42','CG47','CG49','CG51','CG53','CG54',
					'CG6','CG7','CG8','CG9','DT16','DT2','DT22','DT48','DT49','DT74','DT75','DT76','DT86','DT89','DT91','DTA5','DTA9','DX11','DX32','DX41',
					'DX42','DX43','DX59','DX6','EB1','EB5','EB6','EG2','EG6','EH7','EH8','EJ2','EK','EM','EN','EO','ET2','ET4','EX','QB','QL','QN','QT','QU',
					'S03','S06','S07','S20','S21','S22','SD15','SD2','SD21','SD25','SD26','SD27','SD28','SD3','SD30','SD34','SD37','SD41','SD42','SD43','SD46',
					'SD5','SD58','SD6','SD62','SD64','SD7','SS5','SS6','SS7','SS8','SU3','XK3','DTB02','DTB03','DTB04','DTB05','DTB06','DTB07','DTB08','DTB09',
					'DTB10','DTB11','DTB12','DTB13','DTB14','DTB15','DTB16','DTB17','DTB18','DTB19','DTB20','DTB21','DTB22','DTB23','DTB24','DTB25','DTB26',
					'DTB27','DTB28','DTB29','DTB30','DTB31','DTB32','DTB33','DTB34','DTB35','DTB36','DTB37','DTB38','DTB39','DTB40','DTB41','DTB42','DTB43',
					'DTB44','DTB45','DTB46','DTB48','DTB49','DTB50','DTB51','DTB47','DTB52','DTB53','DTB54','DTB55','DTB56','DTB57','DTB58','DTB59','DTB60',
					'DTB61','DTB62','DTB63','DTB64','DTB65','DTB66','DTB67','DTB68','DTB69','DTB70','DTB71','DTB72','DTB73','DTB74','DTB75','DTB76','DTB77',
					'DTB78','DTB79','DTB80','DTB81','DTB82','DTB83','DTB84','DTB85','DTB86','DTB87','DTB88','DTB89','DTB90','DTB91','DTB92','DTB93','DTB94',
					'DTB95','DTB96','DTB97','DTB98','DTB99','DTC1','DTC2','DTC3','DTC4','DTC5','DTC6','DTC7','DTC8','DTC9','DTC10','DTC11','DTC12','DTC13',
					'DTC14','DTC15','DTC16','DTC17','DTC18','DTC19','DTC20','DTC21','DTC22','DTC42','DTC37','DTC38','DTC39','DTC40','DTC41','DTC32','DTC33',
					'DTC34','DTC35','DTC36','DTC28','DTC29','DTC30','DTC31','DTC25','DTC26','DTC27','DTC24','DTC23','DTC43','DTC44','DTC45','DTC46','DTC47',
					'DTC48','DTC49','DTC50','DTC51','DTC52','DTC53','DTC54','DTC55','DTC56','DTC57','DTC58','DTC59','DTC60','DTC61','DTC62','DTC63','DTC64',
					'DTC65','DTC66','DTC67','DTC68','DTC69','DTC70','DTC71','DTC72','DTC73','DTC75','DTC76','DTC77','DTC78','DTC79','DTC80','DTC81','DTC82',
					'DTC83','DTC85','DTC86','DTC87','DTC88','DTC89','DTC90','DTC91','DTC92','DTC93','DTC95','DTC96','DTC97','DTC98','DTC99','DTC106','DTC107',
					'DTC108','DTC109','DTC110','DTC111','DTC112','DTC113','DTC115','DTC116','DTC117','DTC118','DTC119','DTC120','DTC121','DTC122','EZ01','EZ02',
					'EZ03','EZ05','EZ06','EZ07','EZ08','EZ09','EZ10','EZ11','EZ12','EZ13','EZ15','EZ16','EZ17','DTD01','DTD02','DTD03','DTD05','DTD06','DTD07',
					'DTD08','DTD09','DTD10','DTD11','DTD12','DTD13','DTD15','DTD16','DTD17','DTD18','DTD19','DTD20','DTD21','DTD22','DTD53','DTD55','DTD51',
					'DTD52','DTD38','DTD39','DTD50','DTD33','DTD35','DTD36','DTD37','DTD30','DTD31','DTD32','DTD27','DTD28','DTD29','DTD25','DTD26','DTD23',
					'DTD77','DTD73','DTD75','DTD76','DTD69','DTD70','DTD71','DTD72','DTD65','DTD66','DTD67','DTD68','DTD62','DTD63','DTD58','DTD59','DTD60',
					'DTD61','DTD57','DTD56','DTD78','DTD79','DTD80','DTD81','DTD82','DTD83','DTD85','DTD86','DTD87','DTD88','DTD89','DTD90','DTD91','DTD92',
					'DTD93','DTD95','DTD96','DTD97','DTD98','DTD99','DTD121','DTD117','DTD118','DTD119','DTD120','DTD115','DTD116','DTD109','DTD110','DTD111',
					'DTD112','DTD113','DTD108','DTD107','DTD105','DTD106','DTD102','DTD103','DTD101','DTD100','DTE19','DTE20','DTE21','DTE22','DTE13','DTE15',
					'DTE16','DTE17','DTE18','DTE10','DTE11','DTE12','DTE06','DTE07','DTE08','DTE09','DTE02','DTE03','DTE05','DTE01','DTE39','DTE40','DTE41',
					'DTE42','DTE34','DTE35','DTE36','DTE37','DTE38','DTE30','DTE31','DTE32','DTE33','DTE26','DTE27','DTE28','DTE29','DTE24','DTE25','DTE23',
					'DTE61','DTE62','DTE58','DTE59','DTE60','DTE54','DTE55','DTE56','DTE57','DTE51','DTE52','DTE53','DTE50','DTE46','DTE47','DTE48','DTE49',
					'DTE44','DTE45','DTE43','DTE83','DTE85','DTE79','DTE80','DTE81','DTE82','DTE75','DTE76','DTE77','DTE78','DTE70','DTE71','DTE72','DTE73',
					'DTE67','DTE68','DTE69','DTE65','DTE66','DTE63','EZ23','EZ25','EZ26','EZ27','EZ28','EZ20','EZ21','EZ22','EZ19','EZ18','DTF07','DTF08',
					'DTF01','DTF02','DTF03','DTF05','DTF06','DTE96','DTE97','DTE98','DTE99','DTE92','DTE93','DTE95','DTE87','DTE88','DTE89','DTE90','DTE91',
					'DTE86','DTF28','DTF29','DTF30','DTF18','DTF19','DTF20','DTF21','DTF22','DTF23','DTF25','DTF26','DTF27','DTF10','DTF11','DTF12','DTF13',
					'DTF15','DTF16','DTF17','DTF09','DTF46','DTF47','DTF48','DTF49','DTF50','DTF42','DTF43','DTF44','DTF45','DTF40','DTF41','DTF36','DTF37',
					'DTF38','DTF39','DTF32','DTF33','DTF34','DTF35','DTF31','DTF70','DTF61','DTF62','DTF63','DTF64','DTF65','DTF66','DTF67','DTF68','DTF69',
					'DTF53','DTF54','DTF55','DTF56','DTF57','DTF58','DTF59','DTF60','DTF52','DTF51','DTF83','DTF84','DTF85','DTF86','DTF87','DTF88','DTF89',
					'DTF90','DTF78','DTF79','DTF80','DTF81','DTF82','DTF72','DTF73','DTF74','DTF75','DTF76','DTF77','DTF71','DTF108','DTF109','DTF110','DTF100',
					'DTF101','DTF102','DTF103','DTF104','DTF105','DTF106','DTF107','DTF99','DTF92','DTF93','DTF94','DTF95','DTF96','DTF97','DTF98','DTF91',
					'DTF117','DTF118','DTF119','DTF120','DTF121','DTF122','DTF123','DTF124','DTF125','DTF126','DTF127','DTF128','DTF129','DTF130','DTF112',
					'DTF113','DTF114','DTF115','DTF116','DTF111','EZ29','EZ30','EZ31','EZ32','EZ33','EZ34','EZ35','EZ36','EZ37','EZ38')

SELECT custid, ci.roleid, ci.srecommend
INTO #CustList
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.srecommend IN (SELECT custid FROM #supers) AND custid > @MaxCustID

UPDATE cs
SET cs.bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),@xmlStrValue_0)))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID

--Should update disabled = 1 for newly member
UPDATE cs
SET bitmapIsDisabled = CASE WHEN ci.roleid BETWEEN 2 AND 4 THEN (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrValue_0)))
							ELSE (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrValue_1))) END
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
WHERE NOT EXISTS (SELECT 1 FROM #DisableLine WHERE custid = ci.srecommend)	

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #SportBettypeFilter3
DROP TABLE #SportBettypeFilter6	

PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 