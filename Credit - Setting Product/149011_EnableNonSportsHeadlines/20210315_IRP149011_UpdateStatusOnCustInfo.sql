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
	
	INSERT INTO #tblCust(custid, roleid, srecommend, mrecommend, recommend, isUpdateNG, isUpdateCasino)
	SELECT c.custid, c.roleid, c.srecommend, c.mrecommend, c.recommend, 
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
		
	UPDATE ci
	SET maxpermatch161 = CASE WHEN roleid <> 4 AND isUpdateNG = 1 AND maxpermatch161 <> 0.1 THEN @MPM ELSE maxpermatch161 END,
		maxperball161 = CASE WHEN roleid <> 4 AND isUpdateNG = 1 AND maxperball161 <> 0.1 THEN @MPB ELSE maxperball161 END,
		maxpermatch164 = CASE WHEN roleid <> 4 AND isUpdateNG = 1 AND maxpermatch164 <> 0.1 THEN @MPM ELSE maxpermatch164 END,
		DisableNumber = CASE WHEN isUpdateNG = 1 THEN 0 ELSE DisableNumber END,
		DisableCasino = CASE WHEN isUpdateCasino = 1 THEN 0 ELSE DisableCasino END
	FROM custinfo ci WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t ON ci.custid = t.custid
	WHERE (isUpdateCasino = 1 OR isUpdateNG = 1)
	
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
	  
	  