/*
	Created: Elodie	
	Task: Initialize Product Status of Lottery for Credit customers
	DB: DBCUST/CustDB
	Date: 20170801
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@Custid INT
	,@maxcustid INT
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
	DECLARE @BitmapOrder TINYINT = 11

	IF @Custid IN (324561, 395075, 506057, 674248, 796555, 993226, 1016771, 1036451, 1127269, 1156957, 1164457, 2042873, 2453866, 5005322, 17721601)
	BEGIN	
		SELECT custid
		INTO #IgnoredCust
		FROM dbo.custInfo WITH (NOLOCK)
		WHERE (mrecommend IN (40958, 45638, 60349, 63971, 167860, 244268, 272369, 620479, 771534, 832960, 852273, 861558, 891798, 913666, 916007, 929428, 971014, 979669, 981513, 997587, 2006349, 2087760)
				AND roleid BETWEEN 1 AND 3)
			OR (recommend IN (8346,104769) AND roleid BETWEEN 1 AND 2)

		SELECT custid, ci.roleid
		INTO #CustListDirect
		FROM dbo.custInfo ci WITH (NOLOCK)
		WHERE ci.srecommend = @Custid AND ci.custid <= @maxcustid
			AND NOT EXISTS (SELECT 1 FROM #IgnoredCust WHERE custid = ci.custid)

		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustListDirect ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	END
	ELSE
	BEGIN
		SELECT custid, ci.roleid
		INTO #CustList
		FROM dbo.custInfo ci WITH (NOLOCK)
		WHERE ci.srecommend = @Custid AND ci.custid <= @maxcustid
	
		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
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

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

SELECT custid, roleid
INTO #DisableLine
FROM custInfo WITH (NOLOCK) 
WHERE username IN (	'MMMRM','SBKHK','SBKRMB','SBKTB','MMPRM','SMM','SBKH','SBKT','SMH','SMMH','SMAH','SMAT','SMBT','SMBH','SMCH','SMK','M7RM','M7ARM','M7RMB','M7ARMB','M7BRMB',
					'M7BRM','S7RMB','M7ZRMB','M7CRM','HK7','MQRM','MQARM','MQRMB','MQR','SQHH','SDRM','SDRMB','SDH','SDHA','S188R','S188RM','S188AR','S188BH','S188HK','S188HL',
					'SV','S188M','M63H','M63IRMB','M63IHK','S63H','S63K','S63M','S70RMB','S70M','MK1','MK2','MK3','MK5','MK6','MK4C','TH7','MK8','MK9','MK10','MK11C','CKT',
					'CKT1','CKT2','MKM','MK12','TH88','MK17','CK18','MKTB','MK13','MKM1','MK19','MK20','MK21','MK16','MK15','TH25','MK22','TH26','MK23','JC2','JC8','MKI',
					'JC9','MK27','THM','JCM','JC10','TH89','MK31','MKM2','JC5','GAX','MK32','JC83','AK1','AKM1','MK33','MK35','MK36','TH3','M85TB','M85ATB','M85BTB','M85CTB',
					'M85DTB','S85BR','S85H','S85T','S85GTH','KJH','KJHB','KJM','KJI','KJD','KJT','KJMB','KJE','KJB','KJC','KJF','KJMC','KJMA','KJG','KJMD','KJL','KJO','KJME',
					'KJMF','KJMG','KJA','SZ','SBMW','YKM','CYKM','M822M','S822R','GEH','GFH','S822M','S822MA','GFJ','S822D','PPH','PPM','S27RMB','S27A','SADA','S9M','S9H',
					'XKS','POB','POM','POH','POJ','VAG','PYM','PYC','AC1','AC2','ACK','AC3','AC4','AC7','AC8','AC9','AC11','AC12','AC14','ACK2','AC15','AC16','AC17','AC18',
					'AC19','PPS','PPJ','PPN','PPQ','PPZ','PPP','PPA','PPT','PPU','TD1','TD2','TD3','TD4','TD5','TD6','YT1','TDA','TDB','YT2','TDC','TDD','YT3','DS1','DS2',
					'DS3','DS5','DS6','DS7','DS8','DS9','DS10','DS11','DS12','DS13','DS15','DS16','DS17','DS18','DS19','DS20','DS27','DS21','KDS','DS22','DS23','DS25','RC')

SELECT custid
INTO #EnableSuperOnly
FROM custInfo WITH (NOLOCK) 
WHERE username IN ('SCHK','SCM','SCAI','SCI','SCDH','SCDK','TP','TH','TY','TF','TC','TD','TZ','EEM','EEH','EED','EEK')

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
		AND ci.custid <= @max_custid
		AND ci.site IN ('755555', 'Indo', 'KORIBC', '733333', '222223', '222225', '222227')		
		AND (EXISTS (SELECT 1 FROM #DisableLine WHERE custid = ci.custid) OR EXISTS (SELECT 1 FROM #EnableSuperOnly WHERE custid = ci.custid))


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
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.280'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

SELECT custid, roleid
INTO #DisableLine
FROM custInfo WITH (NOLOCK) 
WHERE username IN (	'MMMRM','SBKHK','SBKRMB','SBKTB','MMPRM','SMM','SBKH','SBKT','SMH','SMMH','SMAH','SMAT','SMBT','SMBH','SMCH','SMK','M7RM','M7ARM','M7RMB','M7ARMB','M7BRMB',
					'M7BRM','S7RMB','M7ZRMB','M7CRM','HK7','MQRM','MQARM','MQRMB','MQR','SQHH','SDRM','SDRMB','SDH','SDHA','S188R','S188RM','S188AR','S188BH','S188HK','S188HL',
					'SV','S188M','M63H','M63IRMB','M63IHK','S63H','S63K','S63M','S70RMB','S70M','MK1','MK2','MK3','MK5','MK6','MK4C','TH7','MK8','MK9','MK10','MK11C','CKT',
					'CKT1','CKT2','MKM','MK12','TH88','MK17','CK18','MKTB','MK13','MKM1','MK19','MK20','MK21','MK16','MK15','TH25','MK22','TH26','MK23','JC2','JC8','MKI',
					'JC9','MK27','THM','JCM','JC10','TH89','MK31','MKM2','JC5','GAX','MK32','JC83','AK1','AKM1','MK33','MK35','MK36','TH3','M85TB','M85ATB','M85BTB','M85CTB',
					'M85DTB','S85BR','S85H','S85T','S85GTH','KJH','KJHB','KJM','KJI','KJD','KJT','KJMB','KJE','KJB','KJC','KJF','KJMC','KJMA','KJG','KJMD','KJL','KJO','KJME',
					'KJMF','KJMG','KJA','SZ','SBMW','YKM','CYKM','M822M','S822R','GEH','GFH','S822M','S822MA','GFJ','S822D','PPH','PPM','S27RMB','S27A','SADA','S9M','S9H',
					'XKS','POB','POM','POH','POJ','VAG','PYM','PYC','AC1','AC2','ACK','AC3','AC4','AC7','AC8','AC9','AC11','AC12','AC14','ACK2','AC15','AC16','AC17','AC18',
					'AC19','PPS','PPJ','PPN','PPQ','PPZ','PPP','PPA','PPT','PPU','TD1','TD2','TD3','TD4','TD5','TD6','YT1','TDA','TDB','YT2','TDC','TDD','YT3','DS1','DS2',
					'DS3','DS5','DS6','DS7','DS8','DS9','DS10','DS11','DS12','DS13','DS15','DS16','DS17','DS18','DS19','DS20','DS27','DS21','KDS','DS22','DS23','DS25','RC')

SELECT custid
INTO #EnableSuperOnly
FROM custInfo WITH (NOLOCK) 
WHERE username IN ('SCHK','SCM','SCAI','SCI','SCDH','SCDK','TP','TH','TY','TF','TC','TD','TZ','EEM','EEH','EED','EEK')

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
		AND ci.custid <= @max_custid
		AND ci.site IN ('755555', 'Indo', 'KORIBC', '733333', '222223', '222225', '222227')		
		AND (EXISTS (SELECT 1 FROM #DisableLine WHERE custid = ci.custid) OR EXISTS (SELECT 1 FROM #EnableSuperOnly WHERE custid = ci.custid))
							
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
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.280'
END

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 