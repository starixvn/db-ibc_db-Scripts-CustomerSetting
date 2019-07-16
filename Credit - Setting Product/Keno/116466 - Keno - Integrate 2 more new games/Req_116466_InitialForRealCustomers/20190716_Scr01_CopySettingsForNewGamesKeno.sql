/*
	Created: Eden
	Date: 2019/07/16
	Task: copy settings for new games of Keno
	DB: DBCUST/CUSTDB
*/
				
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@max_custid	INT,
	@target VARCHAR(20)		
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
				
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
			
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY CLUSTERED, ID INT IDENTITY(1,1))		
	CREATE NONCLUSTERED INDEX inx_tmp ON #tblCust (ID)
	DECLARE @tmpGameType TABLE(fromGameTypeID INT, GameTypeID INT)
	
	INSERT INTO @tmpGameType(fromGameTypeID,GameTypeID)
	SELECT 15, 25
	UNION SELECT 15, 26
	
	INSERT INTO #tblCust(custid)
	SELECT custid
	FROM dbo.CustInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @max_custid
		AND Enabled = 1
	OPTION ( OPTIMIZE FOR UNKNOWN )
		
	DECLARE @Threshold INT = 5000,@fromID INT , @toID INT, @maxID INT
	
	SELECT @maxID = max(ID) FROM #tblCust
	SELECT @fromID = 0, @toID = @Threshold, @maxID = ISNULL(@maxID,0)	
	
	WHILE(1=1)
	BEGIN
		INSERT INTO [dbo].[CustGameType]
           ([CustID]
           ,[GameTypeID]
           ,[StakeLevelList]
           ,[MaxPerGameType]
           ,[MinBet]
           ,[MaxBet]
           ,[IsDisabled])
		SELECT cg.[CustID]
           ,s.[GameTypeID]
           ,''[StakeLevelList]
           ,[MaxPerGameType]
           ,[MinBet]
           ,[MaxBet]
           ,[IsDisabled]   
		FROM dbo.CustGameType cg WITH(NOLOCK)
			INNER JOIN #tblCust t ON cg.custid = t.custid			
			INNER JOIN @tmpGameType s ON cg.GameTypeID = s.fromGameTypeID
		WHERE ID BETWEEN @fromID AND @toID	

		SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold + 1

		IF @fromID > @maxID
			BREAK;			
			
		WAITFOR DELAY '00:00:00.200'
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,
		@max_custid INT	
		
CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx
						
INSERT INTO #Supers(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND ci.currency <> 20 -- Exclude UUS
	AND c.username NOT LIKE '3rdSuper%'
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

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
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 
			@max_custid=@max_custid,
			@target = 'REPLICATED' 	
							
END			
GO		

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
DECLARE @srecommend INT,
		@max_custid INT	
		
CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

SELECT @max_custid = xxx
						
INSERT INTO #Supers(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND ci.currency <> 20 -- Exclude UUS
	AND c.username NOT LIKE '3rdSuper%'
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

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
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 
			@max_custid=@max_custid,
			@target = 'DBCUST' 	
					
END			
GO		
-- END STEP 3: RUN THIS SCRIPT AT DBCUST SERVER  -----
-----------------------------------------------------------------------------------	
	
	
	