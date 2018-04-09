/*
	Created: Elodie	
	Task: Initialize Product Status of BullFighting for Credit customers
	DB: DBCUST/CustDB
	Date: 20171201
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
DECLARE @BitmapOrder TINYINT = 12
	
SELECT custid, roleid
INTO #DisabledList
FROM dbo.custInfo WITH (NOLOCK)
WHERE username IN (	--Sheet 1: MBC Disable
					'266HK','MMMRM','SBKHK','SBKRMB','SBKTB','MMPRM','SMM','SMSM','SBKH','MMSD','SBKT','SMH','SMMH','SBK','SMAH',
					'SMMS','SMAT','SMR','MMRMB','SMMR','SMBT','SMBH','SSMS','SMCH','SMMP','SMK','M8HK','M8RMB','M7RM','M7ARM',
					'M7SD','M7RMB','M7ARMB','M7BRMB','M7BRM','S7RMB','M7ZRMB','M7CRM','M926R','HK7','M789H','M57HK','S57R','S57H',
					'M863HK','S863R','KM','KH','KR','KS','KT','KRC','KSD','KMM','KRR','KMA','KHH','KHK','KAR','KBR','KCR','KAM',
					'KMAM','KMBM','KHAH','KHBH','KAT','KHCH','KDR','KER','KHT','KHDH','MQRM','MQARM','MQRMB','MQR','SQHH','MMYTB',
					'SVM','SVR','SVS','SVH','SVUS','SVP','SVE','SVA','SVV','S80R','S80U','S80H','M47RMB','S47SD','S47RM','M47R',
					'S47R','S47U','S47IR','S47DR','S47H','S47M','M50RM','S50RMB','S50R','SDRM','SDSD','SDRMB','SDARM','SDR','SDH',
					'SDHK','SDHA','SDEU','SDBP','S188R','S188RM','S188ARM','M188SD','S188AR','S188H','S188AH','S188BH','S188US',
					'S188HK','S188HL','SV','S188M','1188MR','S188HJ','M63H','M63IRMB','M63IHK','S63H','S63K','S63M','S90R','M90RM',
					'S90AR','S90RM','S90H','S90C','M79BR','M79CR','79AH','79AR','SBSR','SBH','SBSU','SBS','SBM','SBU','SBHA','SBHB',
					'SBHC','SBC','SBHD','MYM','SSF','SBHE','SBHF','SBHG','SBHJ','SBTB','SSG','M606HK','S59BR','S989R','S989M','S989H',
					'SORM','MK1','MK2','MK3','MK5','MK6','MK4C','TH7','MK8','MK9','MK10','MK11C','CKT','CKT1','CKT2','MKM','MK12','TH88',
					'MKS','MK17','CK18','MKTB','MK13','CKU','MKM1','MK19','MK20','MK21','MK16','MK15','TH25','MK22','MK30','TH26','MK23',
					'JC1','JC7','JC2','JC8','MKI','JC6','JC81','JC3','JC9','MK27','TH28','TH29','THM','JCM','JC10','TH89','MK31','MKM2',
					'JC5','JC82','MKS1','JCH','GAX','MK32','JC83','MKH','AK1','AKM1','MK33','MK35','MKHA','MK36','CKV','TH3','MKD','MKE',
					'M113H','M85TB','M85ATB','S85RMB','M85BTB','S85RM','M85CTB','M85DTB','S85R','S85AR','S85BR','S85RR','S85H','S85S',
					'S85M','S85T','S85GTH','S85A','WWR','WKR','FBR','FBM','SFB','FBH','FBB','KJH','KJHB','KJM','KJI','KJD','KJT','KJMB',
					'KJK','KJE','KJB','KJC','KJF','KJMC','KJMA','KJG','KJMD','KJL','KJO','KJME','KJMF','KJMG','KJA','MR','MRU','MK','MCR',
					'SZ','MA','SBMW','YKH','YKR','YKM','CYKM','M822M','S822R','GEH','GFH','S822M','S822MA','GFJ','S822D','M81ARMB','S81R',
					'S81RA','S81RB','SBRR','PPH','PPM','SF8','POR','POT','U311','POK','POY','POB','POW','KTV','KTW','POG','POM','POH','POJ',
					'POZ','POA','PON','PVV','POQ','VVG','SVVG','VAG','JTRIHK','JTRIEU','JTRIUSD','JTRIGBP','Pyy','PYH','PYT','PYU','PYM',
					'PYG','PYR','PYA','PYB','PYC','PYD','PYE','AC1','AC2','ACK','ACH','ACH1','ACH2','ACH3','AC3','AC4','ACH4','ACH5','ACH6',
					'AC7','AC8','AC9','AC11','ACH7','AC12','AC14','ACM1','ACM2','ACM3','ACM4','ACM5','ACK2','ACK3','ACK4','ACK5','AC15',
					'AC16','AC17','AC18','AC19','ACK6','ACK7','ACK8','AC20','XKM','XKH','A68M','A68H','S68H','S68AH','S68M','S68BH',
					'S68CH','WPR','LLKH','SMTG','D77','D78','D79','D80','D81','D82','D83','D85','D99','D66','DRM','DADR','DRN','DRP',
					'DTH1','BB1','DMB','D96','BB9','DRQ','BB19','BB3','BB2','BB5','TF1','YT1','YT2','YT3','TD1','TD2','TD3','TD4','TD5',
					'TD6','TDA','TDB','TDC','TDD','RS','RT','S42CH','DS1','DS2','DS3','DS5','DS6','DS7','DS8','DS9','DS10','DS11','DS12',
					'DS13','DS15','DS16','DS17','DS18','DS19','DS20','DS27','DS21','KDS','DS22','DS23','DS25','DS26','DS30','DS31','DS32',
					'DS33','RC','VBH','VBR','CLM','147HKD','147RMB','JER','JES','JEY','JEH1','82H','HER1','M553R','M553AR','M553BR','M553H',
					'M553AH','M553BH','M553CH','M553M','M553DH','S553H','S553M','S668M','S668H',
					--Sheet 2: MBC Enable Super Level Only
					'SCHK','SCM','SCS','SCSM','SCH','SCAH','SCAI','SCI','SCBH','SCHI','SCDH','SCDK','HIS','HIH','HIU','HAH','HIM','HIK','HIW',
					'HIT','HIF','HIJ','HIC','S8T','S8R','S8U','S8KT','S8H','S8AR','S8AH','S8BR','S8BH','S8CR',
					--Sheet 3: 789Y Disable
					'SDD','SY1B','SDDTB','SDDT','SDT','SDE','SDU','SDM','SDY','SDV','SDW','SDX','SDZ','SDK','SDL','SDJ','SDO','SDP',
					'SDB','SDC','SDF','SDG','SDI','SDN','SDY1','SYA','SYB','SYC','SYD','SYE','SYF','SYG','SYH','SYJ','SYK','SYL',
					'SYN','SYO','SYP','SYQ','SYS','SYU','SYV','SYW','SYY','SDA','SYZ','SDY2','SQY','SYZ1','SDY3','SDY5','SDQ','SDS',
					'SDY6','SYC2','SDY7','SDN1','SDN2','SDY8','UZA','SYC3','SDN3','SDY9','SQA','YDH','SDY11','SDY12','SYX','SCC',
					'VIP','SKKS','SKS','SKT','VID','SKD','SKV','SKX','SKF','SKG','SKY','SKZ','SKI','SKJ','SKB','SKQ','SKK','VIU',
					'skn','skp','SKAC','SKAD','SKAE','SKAF','SKAG','SKAH','SKAI','SKAJ','SKKA','QHN','QVN','SKAN','SHB','SKAO',
					'SKAP','SHD','SKAR','SKAS','SKAT','skau','skav','skaw','skax','skay','skba','skbb','SKBF','skbg','SKBI',
					'SKBL','SKBM','skbn','skbp','SKBR','SKBT','SKTB','SKTA','sktc','SKBQ','SKBV','SKBW','SKBX','skby','skbz',
					'SKCA','skcb','SKCC','SKCD','SKCE','SKCF','SKCG','SKCI','SKCH','SKCJ','SKCK','M11HK','M11RMB','SPUS',
					'M11AHK','M11SD','JWL','JWU','JWA','JWK','ABS','ABB','ABW','BBA','BBD','BBE','BBF','PZZ')
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