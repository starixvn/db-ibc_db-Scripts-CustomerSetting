/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Insert PT and Betlimit for Sports Lottery - API Licensee for large line - Deposit  [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 3 Insert PT and Betlimit API Licensee Deposit for large line
*/
-- BEGIN STEP 3.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_08]
 	@CustIDs VARCHAR(MAX) 	= ''
 	,@RoleID INT
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
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
			    
	INSERT INTO #CustList(custid)	
	SELECT val
	FROM dbo.strSplit(@CustIDs,',')

	DECLARE @SportType SMALLINT = 169
	DECLARE @BitOrder INT 
	DECLARE @batch SMALLINT = 2500

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype

	DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT,
		fSportType	SMALLINT,
		fBettype	SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType, fSportType, fBettype) VALUES (169, 3611, 220, 1021)
	-- SMA LEVEL
	IF @RoleID  <> 1
	BEGIN
		WHILE(1 =1)
		BEGIN
			
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
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
			FROM #CustListTemp a WITH(NOLOCK)
				INNER JOIN Dep_CustPTSetting_Agent cs WITH (NOLOCK) ON cs.CustID = a.CustID
				INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType
			
			IF @RoleID = 2
			BEGIN
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
				FROM #CustListTemp a WITH(NOLOCK)
					INNER JOIN Dep_CustPTGroupSetting_Member cs WITH (NOLOCK) ON cs.AgentID = a.CustID
					INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType
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
			FROM #CustListTemp t WITH(NOLOCK)
				INNER JOIN Dep_CustBetSetting_Agent cs WITH (NOLOCK) ON cs.CustID = t.CustID
				INNER JOIN @SportBetType b ON b.fBetType = cs.BetType AND b.fSportType = cs.SportType

			TRUNCATE TABLE #CustListTemp
		END
	END	
	--MEMBER LEVEL
	IF @RoleID  = 1
	BEGIN
		WHILE(1 =1)
		BEGIN
			
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
			-------------------------------------PT Setting-----------------------------------------------
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
			FROM #CustListTemp a WITH(NOLOCK)
				INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
				INNER JOIN Dep_CustPTSetting_Member cs WITH (NOLOCK) ON cs.CustID = a.CustID
				INNER JOIN @SportBetType t ON t.fBetType = cs.BetType AND t.fSportType = cs.SportType
			WHERE m.IsGroupedPT=0

			INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
			SELECT t.CustID,1
			FROM #CustListTemp t WITH(NOLOCK) 
			WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
				AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
			-------------------------------------Betlimit Setting----------------------------------------------
				INSERT INTO Dep_CustBetSetting_Member(
				 CustID
				,SportType
				,BetType
				,MinBet
				,MaxBet
				,MaxPerMatch
			)
			SELECT t.CustID,b.SportType,b.BetType,cs.MinBet,cs.MaxBet,cs.MaxPerMatch
			FROM #CustListTemp t WITH(NOLOCK)
				INNER JOIN Dep_CustBetSetting_Member cs WITH (NOLOCK) ON cs.CustID = t.CustID
				INNER JOIN @SportBetType b ON b.fBetType = cs.BetType AND b.fSportType = cs.SportType
			
			TRUNCATE TABLE #CustListTemp
		END 	
	END
	--------------------------------------------Enable Status--------------------------------------------------

	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #CustList temp ON temp.CustID = c.custid

	WHILE (1 = 1) 
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
	FROM #CustList A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	DROP TABLE #CustList
	DROP TABLE #CustListTemp
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
END
GO
-- END STEP 3.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 3.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY ,RoleID INT)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)	
DECLARE @max_custid INT 	
SELECT @max_custid = xxx

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (3287311,1574102,13682916,1574008) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID)
SELECT CustID
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (3287311,1574102,13682916,1574008) AND ci.custid<=@max_custid 
	AND roleid = 1 
	AND ci.Enabled=1
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
INSERT INTO #tmpSMA(CustID,RoleID)
SELECT CustID,RoleID
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (3287311,1574102,13682916,1574008) 
	AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4)
	AND ci.Enabled=1
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

DECLARE @SMA_cnt INT
SET @SMA_cnt = (SELECT COUNT(*) FROM #tmpSMA )
DECLARE @msg_total nvarchar(200) = 'Total of SMA level: %d.'
RAISERROR (@msg_total, 0, 1, @SMA_cnt) WITH NOWAIT
-- Super / Master level
WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	
	UPDATE TOP (@batch) a
	SET a.isfinished = 1
	OUTPUT INSERTED.CustID,INSERTED.RoleID INTO #tmpSMATemp(CustID,RoleID)	
	FROM #tmpSMA a	
	WHERE isfinished = 0 AND RoleID <>  2
	
	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','
	FROM #tmpSMATemp	

	EXEC dbo.[Acc_Dep_DynamicCustSetting_08] @CustIDs = @CustIDs, @RoleID = 0,@target = 'REPLICATED' 	
	
	TRUNCATE TABLE #tmpSMATemp
	WAITFOR DELAY '00:00:00.280'			
END
-- Agent level
WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	
	UPDATE TOP (@batch) a
	SET a.isfinished = 1
	OUTPUT INSERTED.CustID,INSERTED.RoleID INTO #tmpSMATemp(CustID,RoleID)	
	FROM #tmpSMA a	
	WHERE isfinished = 0 AND RoleID =  2
	
	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','
	FROM #tmpSMATemp	

	EXEC dbo.[Acc_Dep_DynamicCustSetting_08] @CustIDs = @CustIDs, @RoleID=2,@target = 'REPLICATED' 	
	
	TRUNCATE TABLE #tmpSMATemp
	WAITFOR DELAY '00:00:00.280'			
END

DECLARE @Member_cnt INT
SET @Member_cnt = (SELECT COUNT(*) FROM #tmpCust )
DECLARE @msg_Member nvarchar(200) = 'Total of member level: %d.'
RAISERROR (@msg_Member, 0, 1, @Member_cnt) WITH NOWAIT
-- member level
WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	
	UPDATE TOP (@batch) a
	SET a.isfinished = 1
	OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
	FROM #tmpCust a	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','
	FROM #tmpCustTemp	

	EXEC dbo.[Acc_Dep_DynamicCustSetting_08] @CustIDs = @CustIDs, @RoleID = 1,@target = 'REPLICATED' 	
	
	TRUNCATE TABLE #tmpCustTemp
	WAITFOR DELAY '00:00:00.280'			
END		

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT a.CustID ,85 AS ProductSettingID
FROM #tmpSMA a
WHERE a.RoleID = 4 AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid = a.CustID AND ProductSettingID=85)
UNION ALL								
SELECT a.CustID ,86  AS ProductSettingID
FROM #tmpSMA a
WHERE a.RoleID = 4 AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid = a.CustID AND ProductSettingID=86)
UNION ALL								
SELECT a.CustID ,87  AS ProductSettingID
FROM #tmpSMA a
WHERE a.RoleID = 4 AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid = a.CustID AND ProductSettingID=87)	


DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
GO
-- END STEP 3.2: Run this SP at replicated DB: DB06, DBTP -----
-----------------------------------------------------------------------------------
-- BEGIN STEP 3.3: Run this SP at DBCust -----
-------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY ,RoleID INT)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)	
DECLARE @max_custid INT 	
SELECT @max_custid = xxx

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (3287311,1574102,13682916,1574008) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID)
SELECT CustID
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (3287311,1574102,13682916,1574008) AND ci.custid<=@max_custid 
	AND roleid = 1 
	AND ci.Enabled=1
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
INSERT INTO #tmpSMA(CustID,RoleID)
SELECT CustID,RoleID
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (3287311,1574102,13682916,1574008) 
	AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4)
	AND ci.Enabled=1
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

DECLARE @SMA_cnt INT
SET @SMA_cnt = (SELECT COUNT(*) FROM #tmpSMA )
DECLARE @msg_total nvarchar(200) = 'Total of SMA level: %d.'
RAISERROR (@msg_total, 0, 1, @SMA_cnt) WITH NOWAIT
-- Super / Master level
WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	
	UPDATE TOP (@batch) a
	SET a.isfinished = 1
	OUTPUT INSERTED.CustID,INSERTED.RoleID INTO #tmpSMATemp(CustID,RoleID)	
	FROM #tmpSMA a	
	WHERE isfinished = 0 AND RoleID <>  2
	
	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','
	FROM #tmpSMATemp	

	EXEC dbo.[Acc_Dep_DynamicCustSetting_08] @CustIDs = @CustIDs, @RoleID = 0,@target = 'DBCUST' 	
	
	TRUNCATE TABLE #tmpSMATemp
	WAITFOR DELAY '00:00:00.280'			
END
-- Agent level
WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	
	UPDATE TOP (@batch) a
	SET a.isfinished = 1
	OUTPUT INSERTED.CustID,INSERTED.RoleID INTO #tmpSMATemp(CustID,RoleID)	
	FROM #tmpSMA a	
	WHERE isfinished = 0 AND RoleID =  2
	
	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','
	FROM #tmpSMATemp	

	EXEC dbo.[Acc_Dep_DynamicCustSetting_08] @CustIDs = @CustIDs, @RoleID=2,@target = 'DBCUST' 	
	
	TRUNCATE TABLE #tmpSMATemp
	WAITFOR DELAY '00:00:00.280'			
END

DECLARE @Member_cnt INT
SET @Member_cnt = (SELECT COUNT(*) FROM #tmpCust )
DECLARE @msg_Member nvarchar(200) = 'Total of member level: %d.'
RAISERROR (@msg_Member, 0, 1, @Member_cnt) WITH NOWAIT
-- member level
WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	
	UPDATE TOP (@batch) a
	SET a.isfinished = 1
	OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
	FROM #tmpCust a	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','
	FROM #tmpCustTemp	

	EXEC dbo.[Acc_Dep_DynamicCustSetting_08] @CustIDs = @CustIDs, @RoleID = 1,@target = 'DBCUST' 	
	
	TRUNCATE TABLE #tmpCustTemp
	WAITFOR DELAY '00:00:00.280'			
END	
	
INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT a.CustID ,85 AS ProductSettingID
FROM #tmpSMA a
WHERE a.RoleID = 4 AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid = a.CustID AND ProductSettingID=85)
UNION ALL								
SELECT a.CustID ,86  AS ProductSettingID
FROM #tmpSMA a
WHERE a.RoleID = 4 AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid = a.CustID AND ProductSettingID=86)
UNION ALL								
SELECT a.CustID ,87  AS ProductSettingID
FROM #tmpSMA a
WHERE a.RoleID = 4 AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
								WHERE Custid = a.CustID AND ProductSettingID=87)	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp
PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
GO

-- END STEP 3.3: Run this SP at DBCust -----
-------------------------------------------------
