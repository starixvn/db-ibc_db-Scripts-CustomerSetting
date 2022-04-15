/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220413
	Task: Reduce min bet for Leap Gaming Virtual Sports 3 - deposit RedmineID:#168395
	DB: DBCUST/CustDB
	
	P/s : Step 3 Delete redundant and copy new setting newly created customer Leap Gaming Virtual Sports 3 Deposit
*/
-- BEGIN STEP 3.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
(@maxcustID INT)
AS
BEGIN			
	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN

	DECLARE @batch int = 3000
	DECLARE @BitOrder INT 
	
	DECLARE @SportType SMALLINT = 231
	DECLARE @betType SMALLINT = 5301
	
	CREATE TABLE #supers (custid int)
	
	CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #SMATemp    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT,isfinished BIT DEFAULT(0))
	CREATE TABLE #MemberBatch (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,Currency INT)
	CREATE TABLE #SMABatch    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,Currency INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN('spondemo','Athena000','Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','Unobet','Bolanation')
	AND ci.currency in (12,3,6,20,96,2,13,15,4,45,46,51,61,97,121)  -- GBP,US$,EURO,UUS,USDT,RM,RMB,IN,TB,Won,BND,INH,INR,BDT,PKR	  

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #SMATemp(CustID,RoleID,mrecommend,Currency)
	SELECT custid, roleid,mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustID 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,mrecommend,Currency)
	SELECT custid, mrecommend,Currency
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustID	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	-- SMA LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.RoleID,DELETED.Currency INTO #SMABatch(CustID,RoleID,Currency)
		FROM #SMATemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------Betlimit Setting----------------------------------------------
		UPDATE cs 
		SET  cs.MinBet = CASE WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet  ELSE tmp.MinBet END
		FROM Dep_CustBetSetting_Agent cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #SMABatch t WITH(NOLOCK) ON cs.CustID = t.CustID AND cs.SportType = @SportType AND cs.BetType = @betType
			INNER JOIN Dep_ProductBetSetting tmp  WITH(NOLOCK) ON tmp.Currency = t.Currency AND tmp.SportType = @SportType AND tmp.BetType = @betType
			
		TRUNCATE TABLE #SMABatch
	END			
	
	--MEMBER LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.Currency INTO #MemberBatch(CustID,Currency)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		-------------------------------------Betlimit Setting----------------------------------------------
		-----
		UPDATE cs 
		SET  cs.MinBet = CASE WHEN (cs.MinBet = 0 AND (cs.MaxBet = 0 OR cs.MaxBet = 0.1)) THEN cs.MinBet  ELSE tmp.MinBet END
		FROM Dep_CustBetSetting_Member cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #MemberBatch t WITH(NOLOCK) ON cs.CustID = t.CustID AND cs.SportType = @SportType AND cs.BetType = @betType
			INNER JOIN Dep_ProductBetSetting tmp  WITH(NOLOCK) ON tmp.Currency = t.Currency AND tmp.SportType = @SportType AND tmp.BetType = @betType
				
		TRUNCATE TABLE #MemberBatch
	END 
	
	
	DROP TABLE #MemberTemp 
	DROP TABLE #SMATemp    
	DROP TABLE #MemberBatch
	DROP TABLE #SMABatch   
END		
GO
-- END STEP 3.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 3.2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
