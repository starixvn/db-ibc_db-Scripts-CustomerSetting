/*
	Created: 20171206@Vicky
	Task: Adjust MinBet/MaxBet/MaxPerMatch/MaxPerBall for Sportbook,NumberGame,VirtualSport
	DB: DBCUST/CustDB
*/

-----------------------------Change SP Acc_CustomerInfo_Execrep_09 to update Customer INFO---------------------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST')  RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN

	CREATE TABLE #Selected (custid INTEGER PRIMARY KEY)
	CREATE TABLE #Batch    (custid INTEGER PRIMARY KEY)

	DECLARE @MinBet MONEY 		= 1
	DECLARE @MaxBet MONEY 		= 10
	DECLARE @MaxPerMatch MONEY 	= 100
	DECLARE @MaxPerBall MONEY 	= 100
	
	INSERT #Selected (custid)
	SELECT custid
	FROM dbo.custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND custid <= @maxcustid

	WHILE 1 = 1
	BEGIN
		DELETE TOP (5000) #Selected
		OUTPUT DELETED.custid INTO #Batch

		IF @@ROWCOUNT = 0 BREAK
		
		--update maxpermax/MaxPerBall for sportbook/numbergame
		UPDATE custinfo WITH (ROWLOCK, UPDLOCK)
		SET 	
			MaxPerMatch		= @MaxPerMatch,
			MaxPerMatch2	= @MaxPerMatch,
			MaxPerMatch3	= @MaxPerMatch,
			MaxPerMatch5	= @MaxPerMatch,
			MaxPerMatch8	= @MaxPerMatch,
			MaxPerMatch10	= @MaxPerMatch,
			MaxPerMatch11	= @MaxPerMatch,
			MaxPerMatch99	= @MaxPerMatch,
			MaxPerMatch99MP	= @MaxPerMatch,
			MaxPerMatch1MP	= @MaxPerMatch,
			MaxPerMatch154	= @MaxPerMatch,
			MaxPerMatch161	= @MaxPerMatch,
			MaxPerBall161 	= @MaxPerBall
		WHERE custid IN (SELECT b.custid FROM #Batch AS b)
		
		TRUNCATE TABLE #Batch
		
		WAITFOR DELAY '00:00:00.100'
	END 
END
GO


-----------------------------Change SP Acc_DynamicCustSetting3rd_09 to update Customer BETSETTING---------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST')  RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustSetting') 			= 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSetting3rd') 		= 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') 	= 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_member') = 0 RETURN
	
	CREATE TABLE #Selected (custid INTEGER PRIMARY KEY, roleid TINYINT)
	CREATE TABLE #Batch    (custid INTEGER PRIMARY KEY, roleid TINYINT)

	DECLARE @MinBet MONEY 		= 1
	DECLARE @MaxBet MONEY 		= 10
	DECLARE @MaxPerMatch MONEY 	= 100
	DECLARE @MaxPerBall MONEY 	= 100
	
	INSERT #Selected (custid)
	SELECT custid
	FROM dbo.custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND custid <= @maxcustid

	WHILE 1 = 1
	BEGIN
		DELETE TOP (5000) #Selected
		OUTPUT DELETED.custid INTO #Batch

		IF @@ROWCOUNT = 0 BREAK
			
		---------update minbet/maxbet------------
		--for sportbook
		UPDATE dc SET minbet=@MinBet, maxbet=@MaxBet 
		FROM Dep_CustSetting  dc WITH (ROWLOCK, UPDLOCK)
		WHERE custid IN (SELECT b.custid FROM #Batch AS b) 
			
		--for number game
		UPDATE dc SET minbet=@MinBet, maxbet=@MaxBet 
		FROM Dep_CustSetting3rd  dc WITH (ROWLOCK, UPDLOCK)
		WHERE custid IN (SELECT b.custid FROM #Batch AS b)
		      AND sporttype = 161
			
		--update virtual sport of SMA
		UPDATE dca SET MinBet=@MinBet, MaxBet=@MaxBet, MaxPerMatch=@MaxPerMatch
		FROM Dep_CustBetSetting_Agent dca WITH (ROWLOCK, UPDLOCK)
		WHERE custid IN (SELECT b.custid FROM #Batch AS b WHERE roleid <> 1)
		      AND sporttype IN (180,181,182,183,184,185,186,190,191,199)
			
		--update virtual sport of Member
		UPDATE dcm SET MinBet=@MinBet, MaxBet=@MaxBet, MaxPerMatch=@MaxPerMatch 
		FROM Dep_CustBetSetting_member dcm WITH (ROWLOCK, UPDLOCK)
		WHERE custid IN (SELECT b.custid FROM #Batch AS b WHERE roleid = 1)
		      AND sporttype IN (180,181,182,183,184,185,186,190,191,199)
			
		WAITFOR DELAY '00:00:00.100'
		
		TRUNCATE TABLE #Batch
	END 
END
GO
-- END STEP 1: DEPLOY TWO SP above on @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid INTEGER PRIMARY KEY, isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT
DECLARE @var_super_total INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT DISTINCT srecommend 
FROM customer c INNER JOIN [site] s ON c.[site] = s.[site]
WHERE 	s.isActive = 1 
	AND isDeposit  = 1 
	AND s.[site] NOT IN ('BBin','BBin2') 
	AND c.currency = 20
	AND c.custid <= @max_custid

	
SET @var_super_total = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @var_super_total) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1, @srecommend = custid
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustomerInfo_Execrep_09
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
	EXEC dbo.Acc_DynamicCustSetting3rd_09 
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
	waitfor delay '00:00:0.100'
END
GO


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------

CREATE TABLE #supers (custid INTEGER PRIMARY KEY, isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT
DECLARE @var_super_total INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT DISTINCT srecommend 
FROM customer c INNER JOIN [site] s ON c.[site] = s.[site]
WHERE   s.isActive = 1 
    AND isDeposit  = 1 
    AND s.[site] NOT IN ('BBin','BBin2') 
    AND c.currency = 20
    AND c.custid <= @max_custid

    
SET @var_super_total = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @var_super_total) WITH NOWAIT

WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) #Supers
    SET isfinished = 1, @srecommend = custid
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @index = @index + 1
    RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustomerInfo_Execrep_09
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
	EXEC dbo.Acc_DynamicCustSetting3rd_09 
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
	waitfor delay '00:00:0.100'
END
GO

