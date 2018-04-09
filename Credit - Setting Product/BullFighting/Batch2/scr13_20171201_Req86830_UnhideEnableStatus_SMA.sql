/*
	Created: Elodie	
	Task: Initialize Product Status of BullFighting for Credit customers
	DB: DBCUST/CustDB
	Date: 20171201
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@Custid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   AND dbo.f_CheckRepTable('ProductStatusProfile') = 1
	   )
		RETURN
				
	/*******************************CUST PRODUCT STATUS TABLE*******************************/	
	DECLARE @BitmapOrder TINYINT = 12

	
	SELECT custid, ci.roleid
	INTO #CustList
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @Custid AND roleid BETWEEN 2 AND 4
		
	IF EXISTS (	SELECT cu.custid 
				FROM custaccount cu WITH(NOLOCK)
				WHERE groupid = 515 AND cu.custid = @Custid) --line THAUS
		OR EXISTS (	SELECT 1
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
							AND roleid = 4 AND custid = @Custid)
	BEGIN
		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	END
	ELSE
	BEGIN
		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0))
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

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
	AND ci.site IN ('733333', '222223', '222225', '222227', '033333', 'JPNIBC', '611111', '722222', '766666', '7aa666', 'BEST-ODDS', 'XYZbet', '755555', '789y')
	AND ci.currency <> 20
	AND ci.custid NOT IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42,21278849,21278858) -- dummy account		

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @srecommend
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.100'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

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
	AND ci.site IN ('733333', '222223', '222225', '222227', '033333', 'JPNIBC', '611111', '722222', '766666', '7aa666', 'BEST-ODDS', 'XYZbet', '755555', '789y')
	AND ci.currency <> 20
	AND ci.custid NOT IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42,21278849,21278858) -- dummy account	

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @srecommend
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 