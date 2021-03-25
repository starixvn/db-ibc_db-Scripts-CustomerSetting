/*
	Created: 20210309@Johnson
	Task:  update bet settings, winlimit non-sports for the list of headlines
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@srecommend INT, 	
	@MPB MONEY,
	@MPM 	MONEY,	
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT,
							maxpermatch161 MONEY, MaxPerBall161 MONEY,maxpermatch164 MONEY,
							s_maxpermatch161 MONEY, s_MaxPerBall161 MONEY,s_maxpermatch164 MONEY,
							m_maxpermatch161 MONEY, m_MaxPerBall161 MONEY,m_maxpermatch164 MONEY,
							a_maxpermatch161 MONEY, a_MaxPerBall161 MONEY,a_maxpermatch164 MONEY,
							isUpdateNG BIT, isUpdateCasino BIT)
	
	CREATE TABLE #tblCustBitmap (custid INT, bitmapOrder TINYINT PRIMARY KEY(custid,bitmapOrder))
	CREATE TABLE #tblCustSetting3rd (custid INT, sporttype INT, maxbet MONEY PRIMARY KEY(custid,sporttype))
	
	INSERT INTO #tblCust(custid, roleid, srecommend, mrecommend, recommend,
						maxpermatch161 , MaxPerBall161, maxpermatch164,
						s_maxpermatch161, s_MaxPerBall161 ,s_maxpermatch164,
						m_maxpermatch161, m_MaxPerBall161 ,m_maxpermatch164,
						a_maxpermatch161, a_MaxPerBall161 ,a_maxpermatch164, isUpdateNG, isUpdateCasino)
	SELECT c.custid, c.roleid, c.srecommend, c.mrecommend, c.recommend, 
		c.maxpermatch161 , c.MaxPerBall161, c.maxpermatch164,
		s.maxpermatch161, s.MaxPerBall161 ,s.maxpermatch164,
		m.maxpermatch161, m.MaxPerBall161 ,m.maxpermatch164,
		a.maxpermatch161, a.MaxPerBall161 ,a.maxpermatch164,
		CASE WHEN c.roleid = 1 AND s.DisableNumber = 0 AND m.DisableNumber = 0 AND a.DisableNumber = 0 THEN 0
			WHEN c.DisableNumber = 1 THEN 1 ELSE 0 END as isUpdateNG,
		CASE WHEN c.roleid = 1 AND s.DisableCasino = 0 AND m.DisableCasino = 0 AND a.DisableCasino = 0 THEN 0
			WHEN c.DisableCasino = 1 THEN 1 ELSE 0 END as isUpdateCasino	
	FROM custinfo c WITH(NOLOCK)
		LEFT JOIN custinfo s WITH(NOLOCK) ON c.srecommend = s.custid
		LEFT JOIN custinfo m WITH(NOLOCK) ON c.mrecommend = m.custid
		LEFT JOIN custinfo a WITH(NOLOCK) ON c.recommend = a.custid
	WHERE c.srecommend = @srecommend		
		AND c.enabled = 1
	
	IF dbo.f_CheckRepTable('CustSetting3rd') = 0 
	BEGIN
		DECLARE @query varchar(max) 

		select @query = 'SELECT *
		FROM OPENQUERY(DBCUST,''SELECT custid, sporttype, maxbet 
								FROM custdb.dbo.custsetting3rd with (nolock) 
								WHERE custid in (select custid 
												from custdb.dbo.customer with (nolock) 
												where srecommend = '+cast(@srecommend AS VARCHAR(20))+')
								AND sporttype IN (161,164) 
								AND bettype IN (81,8101)'')'

		INSERT #tblCustSetting3rd
		exec (@query)
	END
	ELSE 
	BEGIN
		INSERT #tblCustSetting3rd
		SELECT custid, sporttype, maxbet 
		FROM dbo.custsetting3rd WITH (NOLOCK) 
		WHERE custid IN (SELECT custid 
						FROM customer ci WITH(NOLOCK)
						WHERE ci.srecommend = @srecommend
						)
		AND sporttype IN (161,164) 
		AND bettype IN (81,8101)
	END	
	
	;WITH tmp AS 
	(SELECT custid, 
		MAX(CASE WHEN sporttype = 161 THEN maxbet ELSE 0 END) as Maxbet161,
		MAX(CASE WHEN sporttype = 164 THEN maxbet ELSE 0 END) as Maxbet164
	FROM #tblCustSetting3rd cs
	GROUP BY custid)
	UPDATE ci
	SET maxpermatch161 = CASE WHEN t.roleid <> 4 AND isUpdateNG = 1 THEN 
								CASE WHEN cs.Maxbet161 < 1 OR t.maxpermatch161 <1 OR t.maxperball161 < 1 THEN ci.maxpermatch161
									WHEN t.roleid = 1 AND (acs.Maxbet161 < 1 OR t.a_maxpermatch161 <1 OR t.a_maxperball161 < 1) THEN t.a_maxpermatch161
									WHEN t.roleid IN (1,2) AND (mcs.Maxbet161 < 1 OR t.m_maxpermatch161 <1 OR t.m_maxperball161 < 1) THEN t.m_maxpermatch161
									WHEN (scs.Maxbet161 < 1 OR t.s_maxpermatch161 <1 OR t.s_maxperball161 < 1) THEN t.s_maxpermatch161
									ELSE @MPM END
							ELSE ci.maxpermatch161 END,
		maxperball161 = CASE WHEN t.roleid <> 4 AND isUpdateNG = 1 THEN 
								CASE WHEN cs.Maxbet161 < 1 OR t.maxpermatch161 <1 OR t.maxperball161 < 1 THEN ci.maxpermatch161
									WHEN t.roleid = 1 AND (acs.Maxbet161 < 1 OR t.a_maxpermatch161 <1 OR t.a_maxperball161 < 1) THEN t.a_maxpermatch161
									WHEN t.roleid IN (1,2) AND (mcs.Maxbet161 < 1 OR t.m_maxpermatch161 <1 OR t.m_maxperball161 < 1) THEN t.m_maxpermatch161
									WHEN (scs.Maxbet161 < 1 OR t.s_maxpermatch161 <1 OR t.s_maxperball161 < 1) THEN t.s_maxpermatch161
									ELSE @MPB END
							ELSE ci.maxperball161 END,
		maxpermatch164 = CASE WHEN t.roleid <> 4 AND isUpdateNG = 1 THEN 
								CASE WHEN t.roleid <> 4 AND isUpdateNG = 1 THEN 
								CASE WHEN cs.Maxbet164 < 1 OR t.maxpermatch164 <1 THEN ci.maxpermatch164
									WHEN t.roleid = 1 AND (acs.Maxbet164 < 1 OR t.a_maxpermatch164 <1) THEN t.a_maxpermatch164
									WHEN t.roleid IN (1,2) AND (mcs.Maxbet161 < 1 OR t.m_maxpermatch164 < 1) THEN t.m_maxpermatch164
									WHEN (scs.Maxbet161 < 1 OR t.s_maxpermatch164 < 1) THEN t.s_maxpermatch164
									ELSE @MPM END
							ELSE ci.maxpermatch164 END,
		DisableNumber = CASE WHEN isUpdateNG = 1 THEN 0 ELSE DisableNumber END,
		DisableCasino = CASE WHEN isUpdateCasino = 1 THEN 0 ELSE DisableCasino END
	FROM custinfo ci WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t ON ci.custid = t.custid
		INNER JOIN tmp as cs ON t.custid = cs.custid
		INNER JOIN tmp as scs ON t.srecommend = scs.custid
		LEFT JOIN tmp as mcs ON t.mrecommend = mcs.custid
		LEFT JOIN tmp as acs ON t.recommend = acs.custid
	WHERE (isUpdateCasino = 1 OR isUpdateNG = 1)
	
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
		AND sporttype <> 242--IBCBet Live Casino
		)
		OR (ProductID = 44--RnG Lottery
		AND SettingStatus = 0
		AND settingType  = 13--status
		)		
	UNION SELECT 180--vs
	UNION SELECT 212--Macau Games
	UNION SELECT 219--Fishing World
	UNION SELECT 245--Virtual Games
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,		
		stt.bitmapOrder,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, bitmapOrder)) as isDisabled
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
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@MPM MONEY,
		@MPB MONEY,				
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
DECLARE @tmpBetSetting TABLE(currency INT, MaxBet MONEY, MPM MONEY, MPB MONEY, MaxLoss MONEY)

INSERT INTO @tmpBetSetting(currency,MaxBet,MPM,MPB,MaxLoss)
SELECT 2, 50, 500, 100, 1500 --RM
UNION SELECT 5, 90, 900,180,2700 --HK$
UNION SELECT 13, 90, 900,180,2700 --RMB
UNION SELECT 33, 180,1800,360,5400 --IDD
UNION SELECT 43, 500, 5000,1000,15000 --THB
UNION SELECT 67, 50, 500, 100, 1500 --HKK

INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM vw_CustAccount ca WITH(NOLOCK)
	INNER JOIN vw_customer ci WITH(NOLOCK) ON ca.custid = ci.custid
	INNER JOIN custinfo c WITH(NOLOCK) ON ca.custid = c.custid
WHERE ca.groupid in (
	SELECT 	groupID 
	FROM vw_custAccount WITH(NOLOCK)
	WHERE custid IN (SELECT custid 
					FROM custinfo WITH (NOLOCK) 
					WHERE username IN ('CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'))
		   )
	AND ci.roleid = 4
	AND c.enabled = 1
	AND site NOT IN ('789y','IBCIndo','76666b')
	AND ci.currency IN (SELECT currency FROM @tmpBetSetting)
	
SELECT @super_cnt = @@ROWCOUNT

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@currency = currency
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @MPB = MPB,
		@MPM = MPM
	FROM @tmpBetSetting
	WHERE currency =@currency
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@srecommend = @srecommend, 
			@MPB = @MPB,
			@MPM = @MPM,						
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END		
GO	
-- END STEP 2: Run this SP at replicated DB -----
-----------------------------------------------------------------------------------



---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CustDB -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@MPM MONEY,
		@MPB MONEY,				
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
DECLARE @tmpBetSetting TABLE(currency INT, MaxBet MONEY, MPM MONEY, MPB MONEY, MaxLoss MONEY)

INSERT INTO @tmpBetSetting(currency,MaxBet,MPM,MPB,MaxLoss)
SELECT 2, 50, 500, 100, 1500 --RM
UNION SELECT 5, 90, 900,180,2700 --HK$
UNION SELECT 13, 90, 900,180,2700 --RMB
UNION SELECT 33, 180,1800,360,5400 --IDD
UNION SELECT 43, 500, 5000,1000,15000 --THB
UNION SELECT 67, 50, 500, 100, 1500 --HKK

INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM vw_CustAccount ca WITH(NOLOCK)
	INNER JOIN vw_customer ci WITH(NOLOCK) ON ca.custid = ci.custid
	INNER JOIN custinfo c WITH(NOLOCK) ON ca.custid = c.custid
WHERE ca.groupid in (
	SELECT 	groupID 
	FROM vw_custAccount WITH(NOLOCK)
	WHERE custid IN (SELECT custid 
					FROM custinfo WITH (NOLOCK) 
					WHERE username IN ('CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'))
		   )
	AND ci.roleid = 4
	AND c.enabled = 1
	AND site NOT IN ('789y','IBCIndo','76666b')
	AND ci.currency IN (SELECT currency FROM @tmpBetSetting)
	
SELECT @super_cnt = @@ROWCOUNT

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@currency = currency
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @MPB = MPB,
		@MPM = MPM
	FROM @tmpBetSetting
	WHERE currency =@currency
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
			@srecommend = @srecommend, 
			@MPB = @MPB,
			@MPM = @MPM,						
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END		
GO	
-- END STEP 3: Run this SP at DBCUST/CustDB DB -----
-----------------------------------------------------------------------------------
	  	  
	  