/*
	Created: 20180319@Johnson
	Task: Initial bet Settings for new sports of BetRadar for licensees
	Redmine: https://nexdev.net/issues/91273
	DB: DBCUST/CUSTDB
*/ 
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT
	, @max_custid INT 
	, @target VARCHAR(20) 
AS
BEGIN	
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at DBCUST only
	
	IF (dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 			
	   )
	RETURN	
			
	CREATE TABLE #tblCust (custid INT PRIMARY KEY,roleid TINYINT, ID INT IDENTITY(1,1))
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)
	DECLARE @sport TABLE(sporttype SMALLINT, bettype SMALLINT, fromSportType SMALLINT, fromBettype SMALLINT)

	CREATE NONCLUSTERED INDEX inx_tmp ON #tblCust (ID)

	INSERT INTO @sport
	SELECT 192 as sporttype, 2701 as bettype, 191 FromSport, 2701 FromBettype
	UNION SELECT 193, 2801, 190, 2701

	INSERT INTO #tblCust (custid,roleid)			
	SELECT custid,roleid
	FROM dbo.Customer WITH(NOLOCK)
	WHERE srecommend =@srecommend
		AND mrecommend NOT IN (SELECT custid FROM dbo.Customer WITH(NOLOCK)
							   WHERE srecommend=@srecommend and username like '%Acc%' and roleid=3)
		AND custid <= @max_custid
	
	DELETE #tblCust
	OUTPUT DELETED.custID
	INTO @tmpCust
	WHERE roleid > 1
	
	INSERT INTO dbo.Dep_CustBetSetting_Agent(
					CustID
					,SportType
					,BetType
					,MinBet
					,MaxBet
					,MaxPerMatch)
	SELECT	cb.custid
			,s.sporttype
			,s.bettype
			,cb.minbet
			,cb.maxbet
			,cb.maxpermatch
	FROM dbo.Dep_CustBetSetting_Agent cb WITH(NOLOCK)
		INNER JOIN @tmpCust t ON cb.custid = t.custid
		INNER JOIN @sport s ON cb.sporttype = s.FromSporttype AND cb.BetType = s.FromBettype
	
	DECLARE @Threshold INT = 20000,@fromID INT , @toID INT, @maxID INT
	
	SELECT @maxID = max(ID) FROM #tblCust
	SELECT @fromID = 0, @toID = @Threshold	
		
	WHILE(1=1)
	BEGIN		
		INSERT INTO dbo.Dep_CustBetSetting_Member(
					CustID
					,SportType
					,BetType
					,MinBet
					,MaxBet
					,MaxPerMatch)
		SELECT	cb.custid
				,s.sporttype
				,s.bettype
				,cb.minbet
				,cb.maxbet
				,cb.maxpermatch
		FROM dbo.Dep_CustBetSetting_Member cb WITH(NOLOCK)
			INNER JOIN #tblCust t ON cb.custid = t.custid			
			INNER JOIN @sport s ON cb.sporttype = s.FromSporttype AND cb.BetType = s.FromBettype
		WHERE ID BETWEEN @fromID AND @toID		
		
		SELECT @fromID = @toID + 1,
			@toID = @toID + @Threshold + 1

		IF @fromID > @maxID
			BREAK;			
			
		WAITFOR DELAY '00:00:00.200'	
	END
	
	DROP TABLE #tblCust		
END	
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
SELECT custid
FROM  Dep_CustSuper with(nolock) 
WHERE custid <= @max_custid
	
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
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
			@srecommend = @srecommend, 
			@max_custid=@max_custid,
			@target = 'REPLICATED' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO		

---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @max_custid INT, @srecommend INT
SELECT  @max_custid= xxx ---input maxcustid

INSERT INTO #supers(custid)
SELECT custid
FROM  Dep_CustSuper with(nolock) 
WHERE custid <= @max_custid
	
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
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] 
			@srecommend = @srecommend, 
			@max_custid=@max_custid,
			@target = 'DBCUST' 	
				
	--WAITFOR DELAY '00:00:00.280'			
END			
GO		

-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------


















