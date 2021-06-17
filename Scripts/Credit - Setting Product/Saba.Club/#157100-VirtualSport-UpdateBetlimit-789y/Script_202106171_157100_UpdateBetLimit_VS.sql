/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20210617
	Task:  for 789y, update setting for Virtual Sports (Inspired VS), Virtual Sports 2 (Betradar VS), Virtual Sports 3 (LeapGaming VS):
		1. If MaxperMatch > 10k --> adjust MaxPerMatch to 10k
		2. If Maxbet > 10k --> adjust Maxbet to 10k 
	RedmineID :[#147941]
	DB: DBCust/CustDB
*/

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
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN

	CREATE TABLE #SMATemp
	(
		CustID INT
	)
	CREATE TABLE #SMATempUpdate
	(
		CustID INT
	)

	CREATE TABLE #Membertemp
	(
		CustID INT
	)
	CREATE TABLE #MembertempUpdate
	(
		CustID INT
	)

	INSERT INTO #SMATemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

	INSERT INTO #Membertemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1 AND Enabled = 1 AND custid <= @maxcustid

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #SMATempUpdate

		DELETE TOP (700) #SMATemp 
		OUTPUT DELETED.CustID
		INTO #SMATempUpdate(CustID)

		IF @@ROWCOUNT=0
			BREAK

		--Agent Level      
		UPDATE bt
		SET bt.MaxPerMatch = CASE WHEN bt.MaxPerMatch > 10000 THEN 10000 ELSE bt.MaxPerMatch END,
			bt.MaxBet = CASE WHEN bt.MaxBet > 10000 THEN 10000 ELSE bt.MaxBet END,
			bt.MinBet = CASE WHEN bt.MinBet > 10000 THEN 10000 ELSE bt.MinBet END
		FROM CustBetSetting3rd_Agent bt WITH(ROWLOCK) 
			INNER JOIN  #SMATempUpdate ci WITH(NOLOCK) ON bt.CustID = ci.CustID
		WHERE bt.sporttype IN(180,181,182,183,184,185,186,190,191,192,193,199,231)
			AND (bt.MaxPerMatch > 10000 OR BT.MaxBet > 10000 OR bt.MinBet > 10000)
	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #MembertempUpdate

		DELETE TOP (700) #Membertemp 
		OUTPUT DELETED.CustID
		INTO #MembertempUpdate(CustID)

		IF @@ROWCOUNT=0
			BREAK

		--Member Level      
		UPDATE bt
		SET bt.MaxPerMatch = CASE WHEN bt.MaxPerMatch > 10000 THEN 10000 ELSE bt.MaxPerMatch END,
			bt.MaxBet = CASE WHEN bt.MaxBet > 10000 THEN 10000 ELSE bt.MaxBet END,
			bt.MinBet = CASE WHEN bt.MinBet > 10000 THEN 10000 ELSE bt.MinBet END
		FROM CustBetSetting3rd_Member bt WITH(ROWLOCK) 
			INNER JOIN #MembertempUpdate ci WITH(NOLOCK) ON bt.CustID = ci.CustID
		WHERE bt.sporttype IN(180,181,182,183,184,185,186,190,191,192,193,199,231)
			AND (bt.MaxPerMatch > 10000 OR BT.MaxBet > 10000 OR bt.MinBet > 10000)
	END

	DROP TABLE #SMATemp
	DROP TABLE #SMATempUpdate
	DROP TABLE #MembertempUpdate
	DROP TABLE #Membertemp
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
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND ci.site IN ('789y')

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
			
			
	waitfor delay '00:00:0.200'
END
DROP TABLE #supers
GO