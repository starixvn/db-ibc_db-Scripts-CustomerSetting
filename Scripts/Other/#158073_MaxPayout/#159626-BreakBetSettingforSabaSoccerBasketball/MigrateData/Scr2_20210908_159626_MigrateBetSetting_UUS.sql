/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210908 
	Task: Initial data for Saba Soccer and Saba Basketball - UUS [Redmine: #159626]
	Notes:Get MaxcustID to insert setting for UUS after released  
	DB: DBCUST/CUSTDB and all subscribers of CustDB_CustSetting publication
*/

-- STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	 @srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting_Member') = 0 RETURN

	CREATE TABLE #SMAs(CustID INT)
	CREATE TABLE #Members(CustID INT)
	CREATE TABLE #CustTempBatch(CustID INT)

	INSERT INTO #SMAs (custid)
	SELECT custid
	FROM custInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND roleid IN(2,3,4)
		AND Enabled = 1
		AND custid <= @maxcustid

	INSERT INTO #Members (custid)
	SELECT custid
	FROM custInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND roleid = 1
		AND Enabled = 1
		AND custid <= @maxcustid

	------------------------------------------Initial DATA---------------------------------------------------------------
	INSERT INTO CustBetSetting_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
	SELECT t.custid
		,sporttype = CASE WHEN mm.sporttype = 1 THEN 9901 ELSE 9902 END
		,mm.bettype,mm.minbet,mm.maxbet,mm.MaxPerMatch,mm.MaxPayoutPerMatch
	FROM #SMAs t
		INNER JOIN CustBetSetting_Agent mm WITH(NOLOCK) ON mm.custid = t.CustID
	WHERE mm.SportType IN(1,2) AND mm.BetType = 1

	INSERT INTO CustBetSetting_Member(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPayoutPerMatch)
	SELECT t.custid
		,sporttype = CASE WHEN mm.sporttype = 1 THEN 9901 ELSE 9902 END
		,mm.bettype,mm.minbet,mm.maxbet,mm.MaxPerMatch,mm.MaxPayoutPerMatch
	FROM #Members t
		INNER JOIN CustBetSetting_Member mm WITH(NOLOCK) ON mm.custid = t.CustID
	WHERE mm.SportType IN(1,2) AND mm.BetType = 1

	--Update MaxPayoutPerMatch for soccer parrlay and mix sports parlay
	WHILE 1= 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch
		DELETE TOP(2500) t
		OUTPUT deleted.CustID INTO #CustTempBatch(CustID)
		FROM #SMAs t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MaxPayoutPerMatch = CASE WHEN b.MaxPerMatch >= 1 THEN b.MaxPerMatch * 10 ELSE b.MaxPerMatch END
		FROM CustBetSetting_Agent b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON b.CustID = t.CustID
		WHERE b.SportType IN(1,99) AND b.BetType = 9
	END

	WHILE 1= 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch
		DELETE TOP(2500) t
		OUTPUT deleted.CustID INTO #CustTempBatch(CustID)
		FROM #Members t

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE b
		SET b.MaxPayoutPerMatch = CASE WHEN b.MaxPerMatch >= 1 THEN b.MaxPerMatch * 10 ELSE b.MaxPerMatch END
		FROM CustBetSetting_Member b WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON b.CustID = t.CustID
		WHERE b.SportType IN(1,99) AND b.BetType = 9
	END

	DROP TABLE #Members
	DROP TABLE #SMAs
	DROP TABLE #CustTempBatch
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo c WITH (NOLOCK) ON ci.custid = c.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND c.Enabled = 1
	AND ci.currency = 20 --UUS

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

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
			
	WAITFOR DELAY '00:00:0.020'
END
DROP TABLE #supers
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------