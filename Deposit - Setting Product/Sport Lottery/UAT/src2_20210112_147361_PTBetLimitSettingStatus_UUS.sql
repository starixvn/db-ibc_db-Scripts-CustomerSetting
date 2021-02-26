/*
	Created: Winfred
	Date: 20200828
	Task: Insert PT and Betlimit for Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 2 Insert PT and Betlimit for Sports Lottery UUS
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 

		OR dbo.f_CheckRepTable('Dep_StakeLevel') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN

	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY,RoleID INT)

	DECLARE @SportType SMALLINT = 169
	DECLARE @BitOrder INT

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
		AND custid<=@max_custid 

	INSERT INTO #tmpCust(CustID)
	SELECT CustID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT,
		fSportType	SMALLINT,
		fBettype	SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType, fSportType, fBettype) VALUES (169, 3611, 220, 1021)

	-------------------------------------PT Setting-----------------------------------------------
	--Agent Level
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			a.CustID
		   ,t.SportType
		   ,t.BetType
		   ,cs.IsLive
		   ,cs.SuperPT
		   ,cs.MasterPT
		   ,cs.AgentPT
	FROM #tmpSMA a WITH(NOLOCK)
		INNER JOIN Dep_CustPTSetting_Agent cs WITH (NOLOCK) ON cs.CustID = a.CustID
		INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType

	INSERT INTO dbo.Dep_CustPTGroupSetting_Member
		(	AgentID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			a.CustID
		   ,t.SportType
		   ,t.BetType
		   ,cs.IsLive
		   ,cs.SuperPT
		   ,cs.MasterPT
		   ,cs.AgentPT
	FROM #tmpSMA a WITH(NOLOCK)
		INNER JOIN Dep_CustPTGroupSetting_Member cs WITH (NOLOCK) ON cs.AgentID = a.CustID
		INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType
	WHERE a.RoleID=2
	--Member Level
	INSERT INTO dbo.Dep_CustPTSetting_Member
		(	CustID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			a.CustID
		   ,t.SportType
		   ,t.BetType
		   ,cs.IsLive
		   ,cs.SuperPT
		   ,cs.MasterPT
		   ,cs.AgentPT
	FROM #tmpCust a WITH(NOLOCK)
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
		INNER JOIN Dep_CustPTSetting_Member cs WITH (NOLOCK) ON cs.CustID = a.CustID
		INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType
	WHERE m.IsGroupedPT=0

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT t.CustID,1
	FROM #tmpCust t WITH(NOLOCK) 
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
							WHERE Custid=@srecommend AND ProductSettingID=86)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,86
	END

	-------------------------------------Betlimit Setting----------------------------------------------
	INSERT INTO Dep_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,cs.MinBet,cs.MaxBet,cs.MaxPerMatch
	FROM #tmpSMA t WITH(NOLOCK)
		INNER JOIN Dep_CustBetSetting_Agent cs WITH (NOLOCK) ON cs.CustID = t.CustID
		INNER JOIN @SportBetType b ON b.fBetType = cs.BetType AND b.fSportType = cs.SportType

	INSERT INTO Dep_CustBetSetting_Member(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT t.CustID,b.SportType,b.BetType,cs.MinBet,cs.MaxBet,cs.MaxPerMatch
	FROM #tmpCust t WITH(NOLOCK)
		INNER JOIN Dep_CustBetSetting_Member cs WITH (NOLOCK) ON cs.CustID = t.CustID
		INNER JOIN @SportBetType b ON b.fBetType = cs.BetType AND b.fSportType = cs.SportType

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=87)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,87
	END

	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #tmpSMA SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #tmpCust M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #tmpSMA temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #tmpCust temp ON temp.CustID = c.custid

	DECLARE @batch int = 3000
	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID,deleted.bitmapIsHidden,deleted.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid=@srecommend AND ProductSettingID=85)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,85
	END

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('spondemo','Athena000')
	AND ci.currency in (72,20)
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

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
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @max_custid=@max_custid,@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO

-- END STEP 2: Run this SP at replicated DB: DB06, DBTP -----
-----------------------------------------------------------------------------------
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = 48088928

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.CustID = 48088896
	AND ci.Enabled=1
	AND cs.site IN('spondemo','Athena000')
	AND ci.currency in (72,20)
ORDER BY ci.custid 


DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

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
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend,@max_custid=@max_custid,@target = 'DBCUST'
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO		


-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------
