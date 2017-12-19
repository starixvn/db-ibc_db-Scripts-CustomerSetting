/*
	Created: Elodie	
	Task: Initialize Product Status of Lucky3 for Credit customers
	DB: DBCUST/CustDB
	Date: 20171214
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
	DECLARE @BitmapOrder TINYINT = 9

	IF @Custid IN (324561, 395075, 506057, 674248, 796555, 993226, 1016771, 1036451, 1127269, 1156957, 1164457, 2042873, 2453866, 5005322, 17721601)
	BEGIN	
		SELECT custid
		INTO #SMABatch1
		FROM dbo.custInfo WITH (NOLOCK)
		WHERE (mrecommend IN (40958, 45638, 60349, 63971, 167860, 244268, 272369, 620479, 771534, 832960, 852273, 861558, 891798, 913666, 916007, 929428, 971014, 979669, 981513, 997587, 2006349, 2087760)
				AND roleid BETWEEN 2 AND 3)
			OR (recommend IN (8346,104769) AND roleid = 2)

		SELECT ci.custid, ci.roleid
		INTO #CustListDirect
		FROM dbo.custInfo ci WITH (NOLOCK)
			INNER JOIN #SMABatch1 s ON s.custid = ci.custid
		WHERE ci.srecommend = @Custid

		IF @Custid IN (2042873,17721601)
		BEGIN
			UPDATE cs
			SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
				bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
			FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
				INNER JOIN #CustListDirect ci WITH(NOLOCK) ON cs.CustID = ci.CustID
		END
		ELSE
		BEGIN
			UPDATE cs
			SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
				bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0))
			FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
				INNER JOIN #CustListDirect ci WITH(NOLOCK) ON cs.CustID = ci.CustID
		END
	END
	ELSE
	BEGIN
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
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

--SELECT custid, roleid
--INTO #DisableLine
--FROM custInfo WITH (NOLOCK) 
--WHERE username IN (	'MMMRM','SBKHK','SBKRMB','SBKTB','MMPRM','SMM','SBKH','SBKT','SMH','SMMH','SMAH','SMAT','SMBT','SMBH','SMCH','SMK','M7RM','M7ARM','M7RMB','M7ARMB','M7BRMB',
--					'M7BRM','S7RMB','M7ZRMB','M7CRM','HK7','MQRM','MQARM','MQRMB','MQR','SQHH','SDRM','SDRMB','SDH','SDHA','S188R','S188RM','S188AR','S188BH','S188HK','S188HL',
--					'SV','S188M','M63H','M63IRMB','M63IHK','S63H','S63K','S63M','S70RMB','S70M','MK1','MK2','MK3','MK5','MK6','MK4C','TH7','MK8','MK9','MK10','MK11C','CKT',
--					'CKT1','CKT2','MKM','MK12','TH88','MK17','CK18','MKTB','MK13','MKM1','MK19','MK20','MK21','MK16','MK15','TH25','MK22','TH26','MK23','JC2','JC8','MKI',
--					'JC9','MK27','THM','JCM','JC10','TH89','MK31','MKM2','JC5','GAX','MK32','JC83','AK1','AKM1','MK33','MK35','MK36','TH3','M85TB','M85ATB','M85BTB','M85CTB',
--					'M85DTB','S85BR','S85H','S85T','S85GTH','KJH','KJHB','KJM','KJI','KJD','KJT','KJMB','KJE','KJB','KJC','KJF','KJMC','KJMA','KJG','KJMD','KJL','KJO','KJME',
--					'KJMF','KJMG','KJA','SZ','SBMW','YKM','CYKM','M822M','S822R','GEH','GFH','S822M','S822MA','GFJ','S822D','PPH','PPM','S27RMB','S27A','SADA','S9M','S9H',
--					'XKS','POB','POM','POH','POJ','VAG','PYM','PYC','AC1','AC2','ACK','AC3','AC4','AC7','AC8','AC9','AC11','AC12','AC14','ACK2','AC15','AC16','AC17','AC18',
--					'AC19','PPS','PPJ','PPN','PPQ','PPZ','PPP','PPA','PPT','PPU','TD1','TD2','TD3','TD4','TD5','TD6','YT1','TDA','TDB','YT2','TDC','TDD','YT3','DS1','DS2',
--					'DS3','DS5','DS6','DS7','DS8','DS9','DS10','DS11','DS12','DS13','DS15','DS16','DS17','DS18','DS19','DS20','DS27','DS21','KDS','DS22','DS23','DS25','RC')

--SELECT custid
--INTO #EnableSuperOnly
--FROM custInfo WITH (NOLOCK) 
--WHERE username IN ('SCHK','SCM','SCAI','SCI','SCDH','SCDK','TP','TH','TY','TF','TC','TD','TZ','EEM','EEH','EED','EEK')

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
	AND ci.site IN ('755555', '789y')
	AND ci.currency <> 20
	AND ci.custid NOT IN (2,3,4,13,16,17,35,21278849,21278858) -- dummy account		

--INSERT INTO #supers(custid)
--SELECT custid
--FROM Custinfo ci WITH (NOLOCK)
--WHERE custid IN (324561, 395075, 506057, 674248, 796555, 993226, 1016771, 1036451, 1127269, 1156957, 1164457, 2042873, 2453866, 5005322, 17721601) --super of cross site batch 1

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

--SELECT custid, roleid
--INTO #DisableLine
--FROM custInfo WITH (NOLOCK) 
--WHERE username IN (	'MMMRM','SBKHK','SBKRMB','SBKTB','MMPRM','SMM','SBKH','SBKT','SMH','SMMH','SMAH','SMAT','SMBT','SMBH','SMCH','SMK','M7RM','M7ARM','M7RMB','M7ARMB','M7BRMB',
--					'M7BRM','S7RMB','M7ZRMB','M7CRM','HK7','MQRM','MQARM','MQRMB','MQR','SQHH','SDRM','SDRMB','SDH','SDHA','S188R','S188RM','S188AR','S188BH','S188HK','S188HL',
--					'SV','S188M','M63H','M63IRMB','M63IHK','S63H','S63K','S63M','S70RMB','S70M','MK1','MK2','MK3','MK5','MK6','MK4C','TH7','MK8','MK9','MK10','MK11C','CKT',
--					'CKT1','CKT2','MKM','MK12','TH88','MK17','CK18','MKTB','MK13','MKM1','MK19','MK20','MK21','MK16','MK15','TH25','MK22','TH26','MK23','JC2','JC8','MKI',
--					'JC9','MK27','THM','JCM','JC10','TH89','MK31','MKM2','JC5','GAX','MK32','JC83','AK1','AKM1','MK33','MK35','MK36','TH3','M85TB','M85ATB','M85BTB','M85CTB',
--					'M85DTB','S85BR','S85H','S85T','S85GTH','KJH','KJHB','KJM','KJI','KJD','KJT','KJMB','KJE','KJB','KJC','KJF','KJMC','KJMA','KJG','KJMD','KJL','KJO','KJME',
--					'KJMF','KJMG','KJA','SZ','SBMW','YKM','CYKM','M822M','S822R','GEH','GFH','S822M','S822MA','GFJ','S822D','PPH','PPM','S27RMB','S27A','SADA','S9M','S9H',
--					'XKS','POB','POM','POH','POJ','VAG','PYM','PYC','AC1','AC2','ACK','AC3','AC4','AC7','AC8','AC9','AC11','AC12','AC14','ACK2','AC15','AC16','AC17','AC18',
--					'AC19','PPS','PPJ','PPN','PPQ','PPZ','PPP','PPA','PPT','PPU','TD1','TD2','TD3','TD4','TD5','TD6','YT1','TDA','TDB','YT2','TDC','TDD','YT3','DS1','DS2',
--					'DS3','DS5','DS6','DS7','DS8','DS9','DS10','DS11','DS12','DS13','DS15','DS16','DS17','DS18','DS19','DS20','DS27','DS21','KDS','DS22','DS23','DS25','RC')

--SELECT custid
--INTO #EnableSuperOnly
--FROM custInfo WITH (NOLOCK) 
--WHERE username IN ('SCHK','SCM','SCAI','SCI','SCDH','SCDK','TP','TH','TY','TF','TC','TD','TZ','EEM','EEH','EED','EEK')

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
	AND ci.site IN ('755555', '789y')
	AND ci.currency <> 20
	AND ci.custid NOT IN (2,3,4,13,16,17,35,21278849,21278858) -- dummy account			

--INSERT INTO #supers(custid)
--SELECT custid
--FROM Custinfo ci WITH (NOLOCK)
--WHERE custid IN (324561, 395075, 506057, 674248, 796555, 993226, 1016771, 1036451, 1127269, 1156957, 1164457, 2042873, 2453866, 5005322, 17721601) --super of cross site batch 1
							
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