/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20210917
	Task: Funky Game - initial settings for customers
	DB: DBCust/CustDB
*/

--BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@StakeLevelList VARCHAR(100)
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	
	INSERT INTO #tblCust(custid, roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND custid <= @maxcustid
		AND enabled = 1
		
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmpCust(custid)
		FROM #tblCust t
		WHERE roleid > 1 
		
		IF @@ROWCOUNT = 0
		BREAK;
		
		INSERT INTO CustStakeLevel_Agent(custid,SportType,BetType,StakeLevelList)
		SELECT custid, 224, 5500, @StakeLevelList
		FROM @tmpCust
		
		DELETE @tmpCust
	END
	
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmpCust(custid)
		FROM #tblCust t
		WHERE roleid = 1 
		
		IF @@ROWCOUNT = 0
		BREAK;
		
		INSERT INTO CustStakeLevel_Member(custid,SportType,BetType,StakeLevelList)
		SELECT custid, 224, 5500, @StakeLevelList
		FROM @tmpCust
		
		DELETE @tmpCust
	END
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

CREATE TABLE #supers (custid int, StakeLevelList VARCHAR(10),isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT, @StakeLevelList VARCHAR(10)

SELECT @max_custid = xxx

INSERT INTO #supers(custid,StakeLevelList)
SELECT ci.custid,CAST(l.StakeLevelID as VARCHAR(10))
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN StakeLevel l WITH(NOLOCK) ON ci.currency = l.ExchangeID AND l.GameTypeID = 5500
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.currency IN (13	,--	RMB
						6	,--	EURO
						5	,--	HK$
						67	,--	HKK
						47	,--	DDD
						15	,--	IN
						22	,--	IND
						33	,--	IDD
						34	,--	IDR
						45	,--	Won
						69	,--	MMK
						2	,--	RM
						43	,--	THB
						16	,--	Yen
						64	,--	UT
						3	,--	US$
						35	,--	$US
						72	--	YNG
						)
		
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
		,@StakeLevelList = StakeLevelList
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@StakeLevelList = @StakeLevelList
			,@target = @target
			
			
	waitfor delay '00:00:0.200'
END
DROP TABLE #supers
GO
	