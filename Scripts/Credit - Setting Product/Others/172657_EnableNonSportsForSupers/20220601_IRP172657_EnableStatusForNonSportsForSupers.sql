/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20220601@Johnson
	Task:  Enable product status for non-sports for supers
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@srecommend INT, 		
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT,
							isUpdateNG BIT)
	
	CREATE TABLE #tblCustBitmap (custid INT, bitmapOrder TINYINT PRIMARY KEY(custid,bitmapOrder))
	
	INSERT INTO #tblCust(custid, roleid, srecommend, mrecommend, recommend, isUpdateNG)
	SELECT c.custid, c.roleid, c.srecommend, c.mrecommend, c.recommend,
		CASE WHEN c.roleid = 1 AND s.DisableNumber = 0 AND m.DisableNumber = 0 AND a.DisableNumber = 0 THEN 0
			WHEN c.DisableNumber = 1 THEN 1 ELSE 0 END as isUpdateNG		
	FROM custinfo c WITH(NOLOCK)
		LEFT JOIN custinfo s WITH(NOLOCK) ON c.srecommend = s.custid
		LEFT JOIN custinfo m WITH(NOLOCK) ON c.mrecommend = m.custid
		LEFT JOIN custinfo a WITH(NOLOCK) ON c.recommend = a.custid
	WHERE c.srecommend = @srecommend		
		AND c.enabled = 1
	
	UPDATE ci
	SET DisableNumber = 0 
	FROM custinfo ci WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM #tblCust)
			
	--update status for DCS products	
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN--return at dbtrans
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
	
	DECLARE @tmpSports TABLE (sporttype INT)
	
	INSERT INTO @tmpSports(sporttype)
	SELECT sporttype
	FROM ProductSettingDetail WITH(NOLOCK)
	WHERE (ProductID = 41--live casino
		AND SettingStatus = 0
		AND settingType  = 13--status		
		)
		OR (ProductID = 44--RnG Lottery
		AND SettingStatus = 0
		AND settingType  = 13--status
		)	
		OR (ProductID = 64--Virtual Games
		AND SettingStatus = 0
		AND settingType  = 13--status
		)		
	UNION SELECT 208--saba casino
	UNION SELECT 180--vs
	UNION SELECT 212--Macau Games
	UNION SELECT 219--Fishing World	
	UNION SELECT 171--VGaming
	UNION SELECT 175--Bitcoin
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,		
		stt.bitmapOrder,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, bitmapOrder)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, bitmapOrder)) as IsHidden
	FROM #tblCust t
		CROSS APPLY ProductStatusProfile stt WITH(NOLOCK)
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
		WHERE stt.Sporttype IN (SELECT sporttype FROM @tmpSports)
	)
	INSERT INTO #tblCustBitmap(custid,bitmapOrder)
	SELECT custid, bitmapOrder
	FROM stt
	WHERE 1 = CASE WHEN roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
					WHEN isDisabled = 1 THEN 1 ELSE 0 END
		AND IsHidden = 0			
	
	;WITH tmp AS(
	SELECT custid,( SELECT (SELECT t2.bitmapOrder as '@b', 0 as '@s' 
					FROM #tblCustBitmap t2 
					WHERE t2.custid = t.custid
					FOR XML PATH('r'),TYPE) 
					FOR XML PATH ('root'),TYPE
				) as xmlStrDisabled
	FROM #tblCustBitmap t
	GROUP BY custid
	)
	UPDATE cs
	SET bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (bitmapIsDisabled, CONVERT(VARCHAR(MAX),tmp.xmlStrDisabled)))	
	FROM  CustProductStatus cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN tmp ON cs.custid = tmp.custid 
	
	DROP TABLE #tblCust
	DROP TABLE #tblCustBitmap
END	

GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @srecommend INT,
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
DECLARE @tmpBetSetting TABLE(currency INT, MaxBet MONEY, MPM MONEY, MPB MONEY, MaxLoss MONEY)

INSERT INTO @tmpBetSetting(currency,MaxBet,MPM,MPB,MaxLoss)
SELECT 53, 90, 900,180,2700 --SEK
UNION SELECT 5, 90, 900,180,2700 --HK$
UNION SELECT 13, 90, 900,180,2700 --RMB
UNION SELECT 15, 180,1800,360,5400 --IN
UNION SELECT 33, 180,1800,360,5400 --IDD
UNION SELECT 47, 180,1800,360,5400 --DDD 
UNION SELECT 22, 180,1800,360,5400 --IND
UNION SELECT 34, 180,1800,360,5400 --IDR
UNION SELECT 43, 500, 5000,1000,15000 --THB
UNION SELECT 42, 500, 5000,1000,15000 --PE
UNION SELECT 45, 10000, 100000,20000,300000 --WON
--UNION SELECT 1, 10, 100, 20, 300 --SD$
UNION SELECT 6, 10, 100, 20, 500 --Euro
--UNION SELECT 70, 10, 100, 20, 300 --MKK
UNION SELECT 12, 10, 100, 20, 500 --GBP
UNION SELECT 3, 10, 100, 20, 500 --US$
UNION SELECT 16, 10, 100, 20, 500 --YEN
UNION SELECT 64, 10, 100, 20, 500 --UT
UNION SELECT 9, 10, 100, 20, 500 --AUD
UNION SELECT 69, 10, 100, 20, 500 --MMK
UNION SELECT 67, 50, 500, 100, 1500 --HKK
UNION SELECT 2, 50, 500, 100, 1500 --RM

IF  @@servername NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
BEGIN
	INSERT INTO #Supers(custid,currency)
	SELECT ci.custid , ci.currency
	FROM customer ci WITH(NOLOCK) 
		INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site	
		LEFT JOIN DBCUST.CUSTDB.dbo.custAccount ca WITH(NOLOCK) ON ca.custid = ci.custid
	WHERE ISNULL(ca.groupid,0) NOT IN (
		SELECT 	groupID 
		FROM DBCUST.CUSTDB.dbo.custAccount WITH(NOLOCK)
		WHERE custid IN (SELECT custid 
						FROM custinfo WITH (NOLOCK) 
						WHERE username IN ('SDRMB', '266HK', 'M863HK', 'SBSR', 'YKH', 'S188RM', 'PYY', 'POT', 'SF8', 'S80R',
										--list 20 previous headlines
										'CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'
										))
			   )
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.custid NOT IN (SELECT DISTINCT srecommend 
						FROM customer WITH(NOLOCK)
						WHERE username IN (SELECT username 
											FROM DBCUST.CUSTDB.dbo.PhoneBettingCustomerList WITH(NOLOCK)
										)
						)
		AND NOT EXISTS (SELECT 1 FROM DBCUST.CUSTDB.dbo.CustSuper s WITH(NOLOCK) WHERE ci.custid = s.custid AND isInternal = 1)						   
		AND ci.roleid = 4
		AND s.isLicensee = 0
		AND c.enabled = 1
		AND ci.site NOT IN ('789y')
		AND ci.currency IN (SELECT currency FROM @tmpBetSetting)
		AND ci.custid NOT IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK) WHERE roleid = 4) --super not dummy account
		AND ci.username not like '3rdSuper%'   
END
ELSE
BEGIN
	INSERT INTO #Supers(custid,currency)
	SELECT ci.custid , ci.currency
	FROM customer ci WITH(NOLOCK) 
		INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site	
		LEFT JOIN custAccount ca WITH(NOLOCK) ON ca.custid = ci.custid
	WHERE ISNULL(ca.groupid,0) NOT IN (
		SELECT 	groupID 
		FROM custAccount WITH(NOLOCK)
		WHERE custid IN (SELECT custid 
						FROM custinfo WITH (NOLOCK) 
						WHERE username IN ('SDRMB', '266HK', 'M863HK', 'SBSR', 'YKH', 'S188RM', 'PYY', 'POT', 'SF8', 'S80R',
										--list 20 previous headlines
										'CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'
										))
			   )
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.custid NOT IN (SELECT DISTINCT srecommend 
						FROM customer WITH(NOLOCK)
						WHERE username IN (SELECT username 
											FROM PhoneBettingCustomerList WITH(NOLOCK)
										)
						)
		AND NOT EXISTS (SELECT 1 FROM CustSuper s WITH(NOLOCK) WHERE ci.custid = s.custid AND isInternal = 1)						   
		AND ci.roleid = 4
		AND s.isLicensee = 0
		AND c.enabled = 1
		AND ci.site NOT IN ('789y')
		AND ci.currency IN (SELECT currency FROM @tmpBetSetting)
		AND ci.custid NOT IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK) WHERE roleid = 4) --super not dummy account
		AND ci.username not like '3rdSuper%'   
END
		
SELECT @super_cnt = @@ROWCOUNT

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1		
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
		
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@srecommend = @srecommend,			
			@target = @target	
				
	WAITFOR DELAY '00:00:00.280'			
END		
GO	
-- END STEP 2: Run this SP at replicated DB & DBCUST -----
-----------------------------------------------------------------------------------
	  
	  