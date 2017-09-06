/*
	Created: Elodie	
	Task: Initialize Product Status of Lottery for Credit customers
	DB: DBCUST/CustDB
	Date: 20170801
*/ 
PRINT N'Step 14: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

CREATE TABLE #OfferedSite (site VARCHAR(10))
INSERT INTO #OfferedSite (site)
VALUES  ('033333'), ('611111'), ('722222'), ('766666'), ('789y'), ('7aa666'), ('BEST-ODDS'), ('JPNIBC'), ('XYZBET')	          

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
DECLARE @BitmapOrder TINYINT = 11
	
SELECT custid 
INTO #DisabledList
FROM dbo.custInfo WITH (NOLOCK)
WHERE username IN (	--Sheet 1: MBC Disable
					'266HK','SMSM','MMSD','SBK','SMMS','SMR','MMRMB','SMMR','SSMS','SMMP','CHITB','M8HK','M8RMB','M7SD','M926R','M58SD','M96RM','S96h','M863HK','S863R',
					'S80R','S80U','S80H','M51SD','TAS51S','M51RMB','S51SM','S51R','M51H','S51H','S51AH','S51BH','S51CH','S51DH','S51EH','S51HA','SPA3M','S50R','S3AAR',
					'S3AK','S3AG','SDSD','SDARM','SDR','SDHK','SDEU','SDBP','S188ARM','M188SD','S188H','S188AH','S188US','1188MR','3KHK','SEM','MSFR','M606HK','M818H',
					'M818R','M818RA','M818BH','SORM','MKS','CKU','MK30','JC1','JC7','JC6','JC81','JC3','TH28','TH29','JC82','MKS1','JCH','MKH','MKHA','CKV','MKD','M113H',
					'S85RMB','S85RM','S85R','S85AR','S85RR','S85S','S85M','S85A','STPH','SRRH','SRR','SRRR','SRUS','SRUN','SRMB','BBBU','SBBR','KJK','MR','MRU','MK','AHW',
					'MA','YKH','YKR','M81ARMB','S81R','S81RA','S81RB','MLLRMB','S95H','SSN','SBTR','SBTY','S27HK','S27H','S27TK','MPKS','WVW','POR','POT','U311','POK','POY',
					'POW','KTV','KTW','POG','POZ','POA','PON','VVG','SVVG','Pyy','PYH','PYT','PYU','PYG','PYR','PYA','PYB','PYD','TR','ACH','ACH1','ACH2','ACH3','ACH4',
					'ACH5','ACH6','ACH7','ACM1','ACM2','ACM3','ACM4','ACM5','ACK3','ACK4','ACK5','ACK6','ACK7','ACK8','VKS','LLKH','SMTG','TF1','DKS','JER','JES','JEY',
					'JEH1','WKM','MSWEU','M3BP','HER1',
					--Sheet 2: MBC Enable Super Level Only
					'SCS','SCSM','SCH','SCAH','SCBH','SCHI','SBRR','WPR',
					--Sheet 3: 789Y Disable
					'SDD','SY1B','SDDTB','SDDT','SDT','SDE','SDU','SDM','SDY','SDV','SDW','SDX','SDZ','SDK','SDL','SDJ','SDO','SDP','SDB','SDC','SDF','SDG','SDI','SDN',
					'SDY1','SYA','SYB','SYC','SYD','SYE','SYF','SYG','SYH','SYJ','SYK','SYL','SYN','SYO','SYP','SYQ','SYS','SYU','SYV','SYW','SYY','SDA','SYZ','SDY2',
					'SQY','SYZ1','SDY3','SDY5','SDQ','SDS','SDY6','SYC2','SDY7','SDN1','SDN2','SDY8','UZA','SYC3','SDN3','SDY9','SQA','YDH','SDY11','SDY12','SYX','SCC',
					'VIP','SKKS','SKS','SKT','VID','SKD','SKV','KKKUSD','SKX','SKF','SKG','SKY','SKZ','SKI','SKJ','SKB','SKQ','SKK','VIU','skn','skp','SKAC','SKAD','SKAE',
					'SKAF','SKAG','SKAH','SKAI','SKAJ','SKKA','QHN','QVN','SKAN','SHB','SKAO','SKAP','SHD','SKAR','SKAS','SKAT','skau','skav','skaw','skax','skay','skba',
					'skbb','SKBF','skbg','SKBI','SKBL','SKBM','skbn','skbp','SKBR','SKBT','SKTB','SKTA','sktc','SKBQ','SKBV','SKBW','SKBX','skby','skbz','SKCA','skcb',
					'SKCC','SKCD','Keonprovision','SKCE','SKCF','SKCG','SKCI','SKCH','SKCJ','SKCK','ABS','ABB','ABW','BBA','BBD','BBE','BBF','PZZ')
	AND roleid <> 4

--SMA level
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID
WHERE NOT EXISTS (SELECT 1 FROM #DisabledList WHERE custid = ci.CustID)

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMATemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	INNER JOIN #DisabledList d WITH(NOLOCK) ON cs.CustID = d.CustID

PRINT N'Step 14: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 