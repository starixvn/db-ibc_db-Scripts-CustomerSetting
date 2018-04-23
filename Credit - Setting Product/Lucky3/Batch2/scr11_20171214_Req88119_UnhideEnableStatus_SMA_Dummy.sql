/*
	Created: Elodie	
	Task: Initialize Product Status of Lucky3 for Credit customers
	DB: DBCUST/CustDB
	Date: 20171214
*/ 
PRINT N'Step 14: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('733333'), ('222223'), ('222225'), ('222227'), ('033333'), ('JPNIBC'), ('611111'), ('722222'), ('766666'), ('7aa666'), ('BEST-ODDS'), ('XYZbet'), ('755555'), ('789y')        

CREATE TABLE #DummySupers (custid int)

INSERT INTO #DummySupers(custid)
SELECT ci.custid
FROM dbo.Customer ci WITH(NOLOCK)
WHERE ci.custid IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42,21278849,21278858) -- dummy account	

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT
)
	
CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid TINYINT,currency INT)
CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid TINYINT,currency INT)
CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid TINYINT,currency INT)			
--- get direct master
INSERT INTO #DirectMaster (CustID,roleid,currency)
SELECT ci.custid, ci.roleid,c.currency
FROM Customer ci with(nolock)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND ci.roleid=3 AND ci.srecommend IN (SELECT custid FROM #DummySupers)
	AND c.Enabled=1
		
--- get direct agent
INSERT INTO #DirectAgent (CustID,mrecommend,roleid,currency)
SELECT ci.custid, ci.mrecommend,ci.roleid,c.currency
FROM Customer ci WITH(NOLOCK)
INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
	AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	and ci.roleid = 2 AND ci.srecommend IN (SELECT custid FROM #DummySupers)
	AND c.Enabled=1

INSERT INTO #DirectMember(CustID,recommend,mrecommend,roleid,currency)
SELECT c.custid, c.recommend,c.mrecommend,c.roleid,c.currency
FROM Customer c WITH(NOLOCK)
INNER JOIN Customer ca (nolock) on c.recommend=ca.custid 
INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
WHERE EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ca.site)
	AND EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
	AND c.roleid=1 AND ci.srecommend IN (SELECT custid FROM #DummySupers)
	AND ci.Enabled=1

----------- For SMA  -----------
INSERT INTO #SMATemp (CustID,RoleID)
SELECT custid, 4 -- Super
FROM #DummySupers
UNION ALL
-----------------------Master--------------------------------------
SELECT d.CustID, 3 -- Direct Master 
FROM #DirectMaster d	
UNION 
SELECT DISTINCT d.mrecommend, 3 -- Master of direct agent
FROM #DirectAgent d
UNION 
SELECT DISTINCT d.mrecommend, 3 -- Master of direct member
FROM #DirectMember D 	
UNION 
-----------------------Agent--------------------------------------
SELECT ci.CustID,2 -- Agent of direct master
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN #DirectMaster D ON ci.mrecommend = d.CustID 
WHERE ci.roleid = 2 AND ci.Enabled=1 
UNION
SELECT DISTINCT d.recommend, 2 -- agent of direct member
FROM #DirectMember D 	
UNION 
SELECT d.CustID, 2 -- Direct Agent
FROM #DirectAgent D
UNION ALL
--dummy account don't have member enabled
SELECT ci.custid, ci.roleid
FROM Custinfo ci WITH (NOLOCK)
WHERE username IN ('WSNT','midrup','MLOTTO','MSSD')

/*******************************CUST PRODUCT STATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 9
	
SELECT custid, roleid
INTO #DisabledList
FROM dbo.custInfo WITH (NOLOCK)
WHERE username IN (	--Sheet 1: MBC Disable
				'266HK','MMMRM','SBKHK','SBKRMB','SBKTB','MMPRM','SMM','SMSM','SBKH','MMSD','SBKT','SMH','SMMH','SBK','SMAH','SMMS','SMAT',
				'SMR','MMRMB','SMMR','SMBT','SMBH','SSMS','SMCH','SMMP','SMK','M8HK','M8RMB','M7RM','M7ARM','M7SD','M7RMB','M7ARMB','M7BRMB',
				'M7BRM','S7RMB','M7ZRMB','M7CRM','M926R','HK7','M789H','M57HK','S57R','S57H','M863HK','S863R','KM','KH','KR','KS','KT','KRC',
				'KSD','KMM','KRR','KMA','KHH','KHK','KAR','KBR','KCR','KAM','KMAM','KMBM','KHAH','KHBH','KAT','KHCH','KDR','KER','KHT','KHDH',
				'MQRM','MQARM','MQRMB','MQR','SQHH','MMYTB','SVM','SVR','SVS','SVH','SVUS','SVP','SVE','SVA','SVV','S80R','S80U','S80H','M50RM',
				'S50RMB','S50R','SDRM','SDSD','SDRMB','SDARM','SDR','SDH','SDHK','SDHA','SDEU','SDBP','S188R','S188RM','S188ARM','M188SD',
				'S188AR','S188H','S188AH','S188BH','S188US','S188HK','S188HL','SV','S188M','1188MR','S188HJ','M63H','M63IRMB','M63IHK','S63H',
				'S63K','S63M','S90R','M90RM','S90AR','S90RM','S90H','S90C','M79BR','M79CR','79AH','79AR','SBSR','SBH','SBSU','SBS','SBM','SBU',
				'SBHA','SBHB','SBHC','SBC','SBHD','MYM','SSF','SBHE','SBHF','SBHG','SBHJ','SBTB','SSG','M606HK','S59BR','S989R','S989M','S989H',
				'SORM','MK1','MK2','MK3','MK5','MK6','MK4C','TH7','MK8','MK9','MK10','MK11C','CKT','CKT1','CKT2','MKM','MK12','TH88','MKS','MK17',
				'CK18','MKTB','MK13','CKU','MKM1','MK19','MK20','MK21','MK16','MK15','TH25','MK22','MK30','TH26','MK23','JC1','JC7','JC2','JC8',
				'MKI','JC6','JC81','JC3','JC9','MK27','TH28','TH29','THM','JCM','JC10','TH89','MK31','MKM2','JC5','JC82','MKS1','JCH','GAX','MK32',
				'JC83','MKH','AK1','AKM1','MK33','MK35','MKHA','MK36','CKV','TH3','MKD','MKE','M113H','M85TB','M85ATB','S85RMB','M85BTB','S85RM',
				'M85CTB','M85DTB','S85R','S85AR','S85BR','S85RR','S85H','S85S','S85M','S85T','S85GTH','S85A','WWR','WKR','FBR','FBM','SFB','FBH',
				'FBB','KJH','KJHB','KJM','KJI','KJD','KJT','KJMB','KJK','KJE','KJB','KJC','KJF','KJMC','KJMA','KJG','KJMD','KJL','KJO','KJME',
				'KJMF','KJMG','KJA','MR','MRU','MK','MCR','SZ','MA','SBMW','YKH','YKR','YKM','CYKM','M822M','S822R','GEH','GFH','S822M',
				'S822MA','GFJ','S822D','M81ARMB','S81R','S81RA','S81RB','SBRR','PPH','PPM','SF8','POR','POT','U311','POK','POY','POB',
				'POW','KTV','KTW','POG','POM','POH','POJ','POZ','POA','PON','PVV','POQ','VVG','SVVG','VAG','JTRIHK','JTRIEU','JTRIUSD',
				'JTRIGBP','Pyy','PYH','PYT','PYU','PYM','PYG','PYR','PYA','PYB','PYC','PYD','PYE','TP','TH','TR','TY','TF','TC','TD','TE',
				'TZ','AC1','AC2','ACK','ACH','ACH1','ACH2','ACH3','AC3','AC4','ACH4','ACH5','ACH6','AC7','AC8','AC9','AC11','ACH7','AC12',
				'AC14','ACM1','ACM2','ACM3','ACM4','ACM5','ACK2','ACK3','ACK4','ACK5','AC15','AC16','AC17','AC18','AC19','AC20','ACK6','ACK7',
				'ACK8','KKT','KKM','KKH','KKMA','KKS','KKB','KKC','KKD','KKE','KKJ','KKN','KKU','KKU1','KKV','KKP','KKQ','KKX','KKY','KKZ',
				'KKA','KKW','KKF','KKO','KKG','KKK','KKL','KKI','KKR','KAA','K1K','KAB','KGK','KGL','KGM','KGN','KGO','KGP','KAC','K2K','KGD',
				'SRS','KAD','KGA','KGB','KAE','KAF','KBA','KBB','KBC','KGE','KBD','KBE','KAG','KAH','KAJ','KAK','KBF','KAO','KBT','KCT','KDT',
				'KET','KBG','KBH','KBJ','KND','KBK','KBU','KBL','KBV','KBW','KNE','KFT','KFU','KAI','KAL','KAN','KAP','KAS','KAU','KLT','KBP',
				'K3K','KGT','KLT','KiT','VVA','VVB','XKM','XKH','A68M','A68H','S68H','S68AH','S68M','S68BH','S68CH','WPR','LLKH','SMTG','D77',
				'D78','D79','D80','D81','D82','D83','D85','D99','D66','DRM','DADR','DRN','DRP','DTH1','BB1','DMB','D96','BB9','DRQ','BB19',
				'BB5','BB3','BB2','TS1','TS2','TS3','TS4','TS5','TS6','TSi','TMK1','TF1','YT1','YT2','YT3','TD1','TD2','TD3','TD4','TD5',
				'TD6','TDA','TDB','TDC','TDD','RS','RT','S42CH','DS1','DS2','DS3','DS5','DS6','DS7','DS8','DS9','DS10','DS11','DS12','DS13',
				'DS15','DS16','DS17','DS18','DS19','DS20','DS27','DS21','KDS','DS22','DS23','DS25','DS26','DS30','DS31','DS32','DS33','RC',
				'VBH','VBR','CLM','147HKD','147RMB','JER','JES','JEY','JEH1','82H','HER1','M553R','M553AR','M553BR','M553H','M553AH','M553BH',
				'M553CH','M553M','M553DH','S553H','S553M','S668M','S668H',
				--Sheet 2: MBC Enable Super Level Only
				'SCHK','SCM','SCS','SCSM','SCH','SCAH','SCAI','SCI','SCBH','SCHI','SCDH','SCDK','HIS','HIH','HIU','HAH',
				'HIM','HIK','HIW','HIT','HIF','HIJ','HIC','8000HK','8000AHK','S8T','S8R','S8U','S8KT','S8H','S8AR',
				'S8AH','S8BR','S8BH','S8CR',
				--Sheet 3: 789Y Disable
				'SDD','SY1B','SDDTB','SDDT','SDT','SDE','SDU','SDM','SDY','SDV','SDW','SDX','SDZ','SDK','SDL','SDJ','SDO','SDP','SDB',
				'SDC','SDF','SDG','SDI','SDN','SDY1','SYA','SYB','SYC','SYD','SYE','SYF','SYG','SYH','SYJ','SYK','SYL','SYN','SYO',
				'SYP','SYQ','SYS','SYU','SYV','SYW','SYY','SDA','SYZ','SDY2','SQY','SYZ1','SDY3','SDY5','SDQ','SDS','SDY6','SYC2',
				'SDY7','SDN1','SDN2','SDY8','UZA','SYC3','SDN3','SDY9','SQA','YDH','SDY11','SDY12','SYX','SCC','VIP','SKKS','SKS',
				'SKT','VID','SKD','SKV','SKX','SKF','SKG','SKY','SKZ','SKI','SKJ','SKB','SKQ','SKK','VIU','skn','skp','SKAC','SKAD',
				'SKAE','SKAF','SKAG','SKAH','SKAI','SKAJ','SKKA','QHN','QVN','SKAN','SHB','SKAO','SKAP','SHD','SKAR','SKAS','SKAT',
				'skau','skav','skaw','skax','skay','skba','skbb','SKBF','skbg','SKBI','SKBL','SKBM','skbn','skbp','SKBR','SKBT',
				'SKTB','SKTA','sktc','SKBQ','SKBV','SKBW','SKBX','skby','skbz','SKCA','skcb','SKCC','SKCD','SKCE','SKCF','SKCG',
				'SKCI','SKCH','SKCJ','SKCK','M11HK','M11RMB','SPUS','M11AHK','M11SD','JWL','JWU','JWA','JWK','ABS','ABB','ABW',
				'BBA','BBD','BBE','BBF','BV12','BV16','BV19','BV27','BV28','BV36','BV38','BV42','BV44','BV48','BV49','BV51',
				'BV52','BV53','BV55','BV57','BV59','BV60','BV62','BV65','BV66','BV67','BV68','BV69','BV70','BV73','BV75','BV76',
				'BV77','BV79','BV8','BV80','BV81','BV82','BV84','BV85','BV87','BV88','BV89','BV9','BV90','BV91','BV92','BV93',
				'BV94','BV98','BV99','CAT10','CAT11','CAT12','CAT14','CAT5','CP1','CP10','CP4','CP8','EL','EP','FC10','FC13',
				'FC16','FC18','FC24','FC3','FC8','KP90','KP91','KP92','KP94','KP96','KP97','KX2','KX9','KY18','KY26','KY34',
				'KY51','KY58','KY68','KY71','KY78','KY81','KY82','KY9','KY96','NC11','NC15','NC18','NC2','NC20','NC21','NC22',
				'NC23','NC25','NC26','NC3','NC30','NC36','NC37','NC38','NC39','NC45','NC48','NC49','NC50','NC51','NC52','NC53',
				'NC54','NC55','NC57','NC58','NC59','NC62','NC65','NC67','NC70','NC72','NC73','NC74','NC78','NC80','NC82','NC83',
				'NC84','NC89','ND03','ND06','ND07','ND09','ND10','ND11','ND15','ND20','ND21','ND23','ND25','ND26','ND28','ND29',
				'ND30','ND31','ND32','ND33','ND35','ND36','ND37','ND38','ND39','ND40','ND41','ND42','ND43','ND45','ND46','ND47',
				'ND48','ND49','ND50','ND51','ND52','ND53','ND55','ND56','ND57','ND58','ND59','ND60','ND61','ND62','ND63','ND65',
				'ND66','ND67','NE1','NE10','NE11','NE12','NE13','NE15','NE16','NE17','NE18','NE19','NE20','NE21','NE22','NE3',
				'NE5','NE6','NE7','NE8','NE9','NW13','NW20','NW21','NW22','NW24','NW25','NW33','NW34','NW35','NW39','NW45','NW51',
				'NW62','NW7','NW72','NW73','NW79','NW80','NW83','OP22','OP23','OP24','OP25','OP26','OP27','OP28','OP29','PS11',
				'PS13','PS16','PS19','PS26','PS27','PS30','PS5','PS8','PS9','Q15','Q18','Q19','Q3','Q7','RRL11','RRL12','RRL15',
				'RRL16','RRL2','RRL20','RRL21','RRL24','RRL3','RRL6','RRL9','TY05','TY09','TY16','TY22','TY28','TY33','TY41',
				'TY50','TY55','TY56','TY67','TY68','TY81','TY83','TY85','TY86','TY87','TY94','TY95','XQ','XX','ZA13','ZA15',
				'ZA17','ZA19','ZA2','ZA22','ZA33','ZA38','ZA41','ZA42','ZA46','ZA47','ZA57','ZA59','ZA60','ZA65','ZA67','ZA72',
				'ZA74','ZA76','ZA78','ZA84','ZA88','ZA89','ZA9','ZA91','ZA94','ZA95','ZA97','ZA98','ZA99','ZX1','ZX11','ZX12',
				'ZX13','ZX15','ZX16','ZX17','ZX2','ZX20','ZX21','ZX23','ZX24','ZX25','ZX27','ZX28','ZX3','ZX32','ZX33','ZX38',
				'ZX4','ZX41','ZX42','ZX43','ZX44','ZX45','ZX46','ZX47','ZX48','ZX49','ZX5','ZX50','ZX6','ZX7','ZX8','ZX9','BV1',
				'BV11','BV15','BV22','BV26','BV29','BV39','BV41','BV46','BV47','BV6','BV61','BV64','BV72','BV78','BV86','BV95',
				'CAT3','CP7','ES','FC21','FC25','FC29','KP93','KX5','KY19','KY35','KY73','NC12','NC28','NC29','NC32','NC33',
				'NC34','NC42','NC43','NC44','NC61','NC64','NC76','NC77','NC79','NC87','ND01','ND02','ND12','ND13','ND17','ND18',
				'ND19','ND22','ND27','NE2','NW2','NW37','NW38','NW43','NW44','NW48','NW49','NW54','NW58','NW84','PS18','PS21',
				'PS7','QE','RRL8','TY15','TY19','TY36','TY61','TY89','TY97','XXQ','xxt','XZ','ZA1','ZA20','ZX10','ZX14','ZX26',
				'ZX30','ZX31','ZX39','BV18','BV32','BV74','CAT6','EA5','EAJ','FC1','FC22','FC23','KP102','KP24','KP26','KP3',
				'KP37','KP38','kp44','KP48','KP49','KP54','KP67','KP69','KP74','KP76','KX3','KX8','KY16','KY24','KY36','KY41',
				'KY72','KY8','KY98','NC17','NC27','NW11','NW12','NW19','NW23','NW50','NW67','NW82','OP10','OP12','OP16','OP20',
				'OP3','OP31','OP34','OP4','OP42','OP50','OP64','OP70','OP8','PS1','PS12','QF','RRL27','RRL30','SSB','TY03','TY12',
				'TY14','TY34','TY52','TY57','TY70','TY74','TY75','TY77','TY82','TY96','ZA26','ZA3','ZA58','BV10','BV13','BV14',
				'BV17','BV2','BV20','BV21','BV23','BV24','BV25','BV3','BV30','BV31','BV33','BV34','BV35','BV37','BV4','BV40',
				'BV43','BV45','BV5','BV50','BV54','BV56','BV58','BV63','BV7','BV71','BV83','BV96','BV97','CAT1','CAT15','CAT16',
				'CAT2','CAT4','CAT7','CAT8','CAT9','CP2','CP3','CP5','CP6','CP9','EA1','EA2','EA3','EA4','EA6','EA7','EA8','EA9',
				'EAA','EAB','EAC','EAD','EAE','EAF','EAG','EAH','EAI','EAK','EBA','EBB','EBC','EBD','EBE','EBF','EBG','EBH','EBI',
				'EBJ','EBK','EBL','EBM','EC','EEA','EF','EG','EI','EJ','EJA','ER','ET10','ET6','ET7','ET8','ET9','EU','EV','EY',
				'FC11','FC12','FC14','FC15','FC17','FC19','FC2','FC20','FC26','FC27','FC28','FC30','FC4','FC5','FC6','FC7','FC9',
				'KP1','KP101','KP2','KP21','KP22','KP23','KP25','KP27','KP28','KP29','KP30','KP31','KP32','KP33','KP34','KP35',
				'KP36','KP39','KP4','KP40','KP41','KP42','kp43','kp45','kp46','KP47','KP5','KP50','KP51','KP52','KP53','KP6',
				'KP68','KP7','KP70','KP71','KP72','KP73','KP75','KP78','KP79','KP8','KP81','KP82','KP83','KP84','KP9','KP95',
				'KPA','KPB','KPC','KPD','KPE','KPF','KPG','KPH','KPI','KPJ','KX1','KX10','KX4','KX6','KX7','KY1','KY10','KY11',
				'KY12','KY13','KY14','KY15','KY17','KY2','KY20','KY21','KY22','KY23','KY25','KY27','KY28','KY29','KY3','KY30',
				'KY31','KY32','KY33','KY37','KY38','KY39','KY4','KY40','KY42','KY43','KY44','KY45','KY46','KY47','KY5','KY50',
				'KY52','KY53','KY54','KY55','KY56','KY57','KY59','KY6','KY60','KY61','KY62','KY63','KY64','KY65','KY66','KY67',
				'KY69','KY7','KY70','KY74','KY75','KY76','KY77','KY79','KY80','KY83','KY84','KY85','KY86','KY87','KY88','KY89',
				'KY90','KY91','KY92','KY93','KY94','KY95','KY97','KY99','NC1','NC10','NC13','NC14','NC16','NC19','NC24','NC31',
				'NC35','NC4','NC40','NC41','NC46','NC47','NC5','NC56','NC6','NC60','NC63','NC66','NC68','NC69','NC7','NC71',
				'NC75','NC8','NC81','NC85','NC86','NC88','NC9','NC90','ND05','ND08','ND16','NW1','NW10','NW14','NW15','NW16',
				'NW17','NW18','NW26','NW27','NW28','NW29','NW3','NW30','NW31','NW32','NW36','NW4','NW40','NW41','NW42','NW46',
				'NW47','NW5','NW52','NW53','NW55','NW56','NW57','NW59','NW6','NW60','NW61','NW63','NW64','NW65','NW66','NW68',
				'NW69','NW70','NW71','NW74','NW75','NW76','NW77','NW78','NW8','NW81','NW85','NW86','NW87','NW88','NW89','NW9',
				'NW90','OP1','OP11','OP13','OP14','OP15','OP17','OP18','OP19','OP2','OP21','OP30','OP32','OP33','OP35','OP36',
				'OP37','OP38','OP39','OP40','OP41','OP43','OP44','OP45','OP46','OP47','OP48','OP49','OP5','OP6','OP60','OP61',
				'OP62','OP63','OP65','OP66','OP67','OP68','OP69','OP7','OP71','OP72','OP73','OP74','OP75','OP76','OP77','OP78',
				'OP79','OP9','PS10','PS14','PS15','PS17','PS2','PS20','PS22','PS23','PS24','PS25','PS28','PS29','PS3','PS4',
				'PS6','Q1','Q10','Q11','Q12','Q13','Q14','Q16','Q17','Q2','Q20','Q4','Q5','Q6','Q8','Q9','QD','QG','QJ','RRL1',
				'RRL10','RRL13','RRL14','RRL17','RRL18','RRL19','RRL22','RRL23','RRL25','RRL26','RRL28','RRL29','RRL4','RRL5',
				'RRL7','SSA','SSC','SSE','TY01','TY02','TY04','TY06','TY07','TY08','TY10','TY11','TY13','TY17','TY18','TY20',
				'TY21','TY23','TY24','TY25','TY26','TY27','TY29','TY30','TY31','TY32','TY35','TY37','TY38','TY39','TY40','TY42',
				'TY43','TY44','TY45','TY46','TY47','TY48','TY49','TY51','TY53','TY54','TY58','TY59','TY60','TY62','TY63','TY64',
				'TY65','TY66','TY69','TY71','TY72','TY73','TY76','TY78','TY79','TY80','TY84','TY88','TY90','TY91','TY92','TY93',
				'TY98','TY99','XA','XB','XC','XD','XG','XM','XN','XO','XP','XR','XXD','XXE','XXG','XXH','XXJ','XXK','XXO','XXP',
				'XXR','XXS','XY','ZA10','ZA11','ZA12','ZA14','ZA16','ZA18','ZA21','ZA23','ZA24','ZA25','ZA27','ZA28','ZA29','ZA30',
				'ZA31','ZA32','ZA34','ZA35','ZA36','ZA37','ZA39','ZA4','ZA40','ZA43','ZA44','ZA45','ZA48','ZA49','ZA5','ZA50','ZA51',
				'ZA52','ZA53','ZA54','ZA55','ZA56','ZA6','ZA61','ZA62','ZA63','ZA64','ZA66','ZA68','ZA69','ZA7','ZA70','ZA71','ZA73',
				'ZA75','ZA77','ZA79','ZA8','ZA80','ZA81','ZA82','ZA83','ZA85','ZA86','ZA87','ZA90','ZA92','ZA93','ZA96','ZX18','ZX19',
				'ZX22','ZX29','ZX34','ZX35','ZX36','ZX37','ZX40','KP90','KP91','KP92','KP94','KP96','KP97','OP22','OP23','OP24','OP25',
				'OP26','OP27','OP28','OP29','KP93','KP102','KP24','KP26','KP3','KP37','KP38','kp44','KP48','KP49','KP54','KP67','KP69',
				'KP74','KP76','OP10','OP12','OP16','OP20','OP3','OP31','OP34','OP4','OP42','OP50','OP64','OP70','OP8','KP1','KP101','KP2',
				'KP21','KP22','KP23','KP25','KP27','KP28','KP29','KP30','KP31','KP32','KP33','KP34','KP35','KP36','KP39','KP4','KP40',
				'KP41','KP42','kp43','kp45','kp46','KP47','KP5','KP50','KP51','KP52','KP53','KP6','KP68','KP7','KP70','KP71','KP72',
				'KP73','KP75','KP78','KP79','KP8','KP81','KP82','KP83','KP84','KP9','KP95','KPA','KPB','KPC','KPD','KPE','KPF','KPG',
				'KPH','KPI','KPJ','OP1','OP11','OP13','OP14','OP15','OP17','OP18','OP19','OP2','OP21','OP30','OP32','OP33','OP35',
				'OP36','OP37','OP38','OP39','OP40','OP41','OP43','OP44','OP45','OP46','OP47','OP48','OP49','OP5','OP6','OP60','OP61',
				'OP62','OP63','OP65','OP66','OP67','OP68','OP69','OP7','OP71','OP72','OP73','OP74','OP75','OP76','OP77','OP78','OP79',
				'OP9','TY24','TY25','TY43','XT','XTA','XTB','XTC','XTD','XTE','XTF','AZ4','AZ5','AZ6','AZ7','BC5','BC7','BC8','BC9',
				'BD4','BP','BX12','BX14','BX15','BX19','BX22','BX27','BX28','BX3','BX30','BX31','BX33','BX45','BX48','BX51','BX55',
				'BX56','BX57','BX6','BX60','BX64','BX7','BX77','BX79','BX84','BX85','BX91','BX95','BX98','BX99','BY','CG1','CG13',
				'CG27','CG34','CG43','CG44','CG46','CG60','DT10','DT11','DT12','DT13','DT15','DT20','DT24','DT25','DT26','DT31',
				'DT34','DT36','DT37','DT42','DT43','DT44','DT5','DT50','DT51','DT6','DT62','DT64','DT65','DT66','DT67','DT7','DT72',
				'DT76','DT78','DT80','DT83','DT88','DT90','DT92','DT93','DT95','DT97','DTA12','DTA17','DTA18','DTA19','DTA21','DTA23',
				'DTA26','DTA3','DTA37','DTA39','DTA41','DTA42','DTA43','DTA45','DTA47','DTA48','DTA49','DTA50','DTA63','DTA64','DTA66',
				'DTA68','DTA71','DTA75','DTA79','DTA80','DTA83','DTA85','DTA88','DTA9','DTA90','DTA99','DTB02','DTB08','DTB09','DTB10',
				'DTB11','DTB15','DTB17','DTB26','DTB27','DTB29','DTB30','DTB31','DTB32','DTB41','DTB45','DTB46','DTB50','DTB55','DTB58',
				'DTB65','DTB67','DTB69','DTB71','DTB72','DTB73','DTB74','DTB75','DTB77','DTB79','DTB80','DTB83','DTB85','DTB87','DTB92',
				'DTB93','DTC107','DTC108','DTC109','DTC11','DTC111','DTC112','DTC115','DTC117','DTC118','DTC119','DTC121','DTC13','DTC14',
				'DTC17','DTC18','DTC2','DTC21','DTC25','DTC27','DTC30','DTC34','DTC36','DTC37','DTC39','DTC40','DTC43','DTC45','DTC49',
				'DTC50','DTC52','DTC54','DTC55','DTC58','DTC63','DTC64','DTC65','DTC66','DTC70','DTC71','DTC72','DTC77','DTC78','DTC79',
				'DTC8','DTC80','DTC81','DTC82','DTC85','DTC86','DTC89','DTC90','DTC96','DTD01','DTD02','DTD06','DTD07','DTD09','DTD100',
				'DTD102','DTD103','DTD105','DTD106','DTD107','DTD109','DTD11','DTD110','DTD111','DTD112','DTD113','DTD115','DTD117','DTD118',
				'DTD119','DTD12','DTD120','DTD13','DTD15','DTD16','DTD21','DTD22','DTD23','DTD25','DTD26','DTD27','DTD28','DTD30','DTD31',
				'DTD36','DTD38','DTD39','DTD50','DTD52','DTD55','DTD57','DTD58','DTD59','DTD61','DTD65','DTD66','DTD68','DTD69','DTD71',
				'DTD72','DTD73','DTD75','DTD76','DTD77','DTD78','DTD79','DTD80','DTD81','DTD82','DTD83','DTD85','DTD86','DTD87','DTD88',
				'DTD89','DTD90','DTD92','DTD93','DTD95','DTD96','DTD97','DTD98','DTD99','DTE01','DTE02','DTE03','DTE05','DTE06','DTE07',
				'DTE08','DTE09','DTE11','DTE16','DTE18','DTE19','DTE20','DTE21','DTE22','DTE23','DTE25','DTE26','DTE27','DTE28','DTE30',
				'DTE31','DTE32','DTE33','DTE34','DTE35','DTE36','DTE37','DTE38','DTE40','DTE41','DTE42','DTE48','DTE51','DTE53','DTE54',
				'DTE55','DTE56','DTE57','DTE58','DTE59','DTE60','DTE61','DTE62','DTE63','DTE66','DTE67','DTE69','DTE72','DTE73','DTE75',
				'DTE76','DTE77','DTE78','DTE79','DTE80','DTE81','DTE82','DTE85','DTE86','DTE87','DTE88','DTE89','DTE90','DTE91','DTE92',
				'DTE93','DTE96','DTE97','DTE98','DTE99','DTF01','DTF02','DTF03','DTF05','DTF07','DTF08','DTF09','DTF10','DTF11','DTF12',
				'DTF13','DTF15','DTF16','DTF17','DTF18','DTF19','DTF20','DTF21','DTF22','DTF23','DTF25','DTF26','DTF27','DTF28','DTF29',
				'DTF30','DX15','DX17','DX18','DX19','DX22','DX25','DX3','DX44','DX47','DX48','DX54','DX58','DX8','EB3','EH','EH1','EH2',
				'EJ1','ET1','ET5','EW','EZ01','EZ02','EZ03','EZ05','EZ06','EZ07','EZ08','EZ09','EZ10','EZ11','EZ12','EZ13','EZ15','EZ16',
				'EZ17','EZ19','EZ20','EZ21','EZ22','EZ23','EZ25','EZ26','EZ27','EZ28','HC','QM','QO','qs','S01','S09','S17','SC','SD1',
				'SD13','SD23','SD31','SD32','SD38','SD44','SD57','SD67','SD68','SD70','SG','SH','SS4','SS89','SS9','SS90','SU7','SU9',
				'XJ','XK2','XS','XTA','XTB','XTE','XTF','XXA','XXB','AZ1','AZ12','AZ13','AZ15','BCA','BD1','BK','BR','BX1','BX10','BX13',
				'BX16','BX17','BX21','BX26','BX35','BX37','BX41','BX42','BX49','BX5','BX52','BX53','BX54','BX58','BX62','BX82','BX86',
				'BX88','BX96','CG15','CG16','CG18','CG19','CG23','CG24','CG29','CG31','CG36','CG41','CG5','CG50','CG52','CG57','CG58',
				'CG59','DT1','DT21','DT23','DT29','DT35','DT38','DT4','DT40','DT41','DT45','DT61','DT68','DT70','DT87','DT94','DT98',
				'DTA10','DTA11','DTA13','DTA14','DTA15','DTA22','DTA31','DTA44','DTA46','DTA6','DTA62','DTA69','DTA70','DTA74','DTA76',
				'DTA77','DTA87','DTA91','DTB04','DTB18','DTB19','DTB20','DTB21','DTB22','DTB33','DTB34','DTB35','DTB39','DTB43','DTB44',
				'DTB47','DTB48','DTB56','DTB57','DTB60','DTB63','DTB66','DTB70','DTB81','DTB84','DTB90','DTB96','DTB98','DTB99','DTC1',
				'DTC106','DTC110','DTC12','DTC15','DTC19','DTC20','DTC22','DTC23','DTC29','DTC3','DTC4','DTC41','DTC47','DTC53','DTC56',
				'DTC59','DTC6','DTC67','DTC68','DTC7','DTC83','DTC88','DTC9','DTC91','DTC92','DTC95','DTC98','DTC99','DTD05','DTD08',
				'DTD10','DTD101','DTD108','DTD17','DTD19','DTD20','DTD32','DTD33','DTD35','DTD37','DTD60','DTD62','DTD91','DTE10','DTE17',
				'DTE24','DTE39','DTE43','DTE44','DTE45','DTE50','DTE52','DTE68','DTE70','DTE71','DTE83','DTF06','DX10','DX12','DX13','DX14',
				'DX2','DX21','DX26','DX29','DX30','DX31','DX33','DX34','DX35','DX36','DX37','DX38','DX39','DX4','DX49','DX5','DX50','DX51',
				'DX53','DX55','DX56','DX6','EA','EB','EB2','EG3','EG5','EH3','EH9','EQ','ET3','EZ18','QA','QI','QR','QV','S02','S04','S10',
				'S12','S13','S15','S16','S18','S19','SD10','SD11','SD12','SD14','SD16','SD17','SD18','SD22','SD24','SD35','SD36','SD39',
				'SD40','SD45','SD48','SD49','SD51','SD52','SD53','SD54','SD56','SD59','SD60','SD61','SD63','SD65','SD66','SD69','SD9',
				'SK8','SS01','SS1','SS2','SS3','SS81','SS82','SS84','SS85','SS86','SS88','SU1','SU10','SU4','SU5','SU8','XH','XK','XK4',
				'XK5','BX93','CG56','DT82','DTA30','DTA81','DTB12','DTC38','DTC42','DTC93','DTD116','DTD121','DTE29','AZ10','AZ11','AZ14',
				'AZ2','AZ3','AZ8','AZ9','BC','BC1','BC2','BC3','BC6','BD','BD2','BD3','BD5','BE','BG','BH','BL','BM','BN','BO','BX','BX11',
				'BX18','BX2','BX20','BX23','BX24','BX25','BX29','BX32','BX34','BX36','BX38','BX39','BX4','BX40','BX43','BX44','BX46',
				'BX47','BX50','BX59','BX61','BX63','BX65','BX75','BX76','BX78','BX8','BX80','BX81','BX83','BX87','BX89','BX9','BX90',
				'BX92','BX94','BX97','BZ','CG17','CG2','CG20','CG21','CG22','CG25','CG26','CG28','CG3','CG30','CG32','CG33','CG35',
				'CG37','CG38','CG39','CG4','CG40','CG42','CG45','CG47','CG48','CG49','CG51','CG53','CG54','CG55','CG6','CG7','CG8',
				'CG9','DT14','DT16','DT17','DT18','DT19','DT2','DT22','DT27','DT28','DT3','DT30','DT32','DT39','DT46','DT47','DT48',
				'DT49','DT63','DT69','DT71','DT73','DT74','DT75','DT77','DT79','DT8','DT81','DT84','DT85','DT86','DT89','DT9','DT91',
				'DT96','DT99','DTA1','DTA16','DTA2','DTA20','DTA24','DTA25','DTA27','DTA28','DTA29','DTA32','DTA33','DTA34','DTA35',
				'DTA36','DTA38','DTA4','DTA40','DTA5','DTA51','DTA52','DTA53','DTA54','DTA55','DTA56','DTA57','DTA58','DTA59','DTA60',
				'DTA61','DTA65','DTA67','DTA7','DTA72','DTA73','DTA78','DTA8','DTA82','DTA84','DTA86','DTA89','DTA92','DTA93','DTA94',
				'DTA95','DTA96','DTA97','DTA98','DTB01','DTB03','DTB05','DTB06','DTB07','DTB13','DTB14','DTB16','DTB23','DTB24','DTB25',
				'DTB28','DTB36','DTB37','DTB38','DTB40','DTB42','DTB49','DTB51','DTB52','DTB53','DTB54','DTB59','DTB61','DTB62','DTB64',
				'DTB68','DTB76','DTB78','DTB82','DTB86','DTB88','DTB89','DTB91','DTB94','DTB95','DTB97','DTC10','DTC113','DTC116','DTC120',
				'DTC122','DTC16','DTC24','DTC26','DTC28','DTC31','DTC32','DTC33','DTC35','DTC44','DTC46','DTC48','DTC5','DTC51','DTC57',
				'DTC60','DTC61','DTC62','DTC69','DTC73','DTC75','DTC76','DTC87','DTC97','DTD03','DTD18','DTD29','DTD51','DTD53','DTD56',
				'DTD63','DTD67','DTD70','DTE12','DTE13','DTE15','DTE46','DTE47','DTE49','DTE65','DTE95','DX1','DX11','DX16','DX20','DX23',
				'DX24','DX27','DX28','DX32','DX40','DX41','DX42','DX43','DX45','DX46','DX52','DX57','DX59','DX60','DX7','DX9','EB1','EB5',
				'EB6','EG1','EG2','EG6','EH7','EH8','EJ2','EK','EM','EN','EO','ET2','ET4','EX','QB','QC','QH','QK','QL','QN','QP','QT','QU',
				'S03','S06','S07','S08','S20','S21','S22','SD15','SD19','SD2','SD20','SD21','SD25','SD26','SD27','SD28','SD29','SD3','SD30',
				'SD33','SD34','SD37','SD41','SD42','SD43','SD46','SD47','SD5','SD50','SD55','SD58','SD6','SD62','SD64','SD7','SD71','SD72',
				'SD8','SS5','SS6','SS7','SS8','SS83','SS87','SU2','SU3','SU6','XK1','XK3','PZZ')
	AND roleid <> 4

--SMA level
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cs.CustID = c.CustID
WHERE NOT EXISTS (SELECT 1 FROM #DisabledList WHERE custid = c.mrecommend AND roleid = 3)
	AND NOT EXISTS (SELECT 1 FROM #DisabledList WHERE custid = c.recommend AND roleid = 2)
	AND NOT EXISTS (SELECT 1 FROM #DisabledList WHERE custid = c.custid AND roleid = 1)

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cs.CustID = c.CustID
	INNER JOIN #DisabledList d WITH(NOLOCK) ON c.mrecommend = d.CustID
WHERE d.roleid = 3

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cs.CustID = c.CustID
	INNER JOIN #DisabledList d WITH(NOLOCK) ON c.recommend = d.CustID
WHERE d.roleid = 2

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cs.CustID = c.CustID
	INNER JOIN #DisabledList d WITH(NOLOCK) ON c.custid = d.CustID
WHERE d.roleid = 1	

PRINT N'Step 14: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 