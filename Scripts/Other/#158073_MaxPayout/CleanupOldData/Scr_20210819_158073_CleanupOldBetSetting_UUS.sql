/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210819
	Task: Cleanup betsetting of old structure tables - UUS [Redmine: #154048]   
	DB: DBCUST/CUSTDB and all subscribers of CustDB_CustSetting publication
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	 @srecommend INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN

	CREATE TABLE #Custinfo(CustID INT)
	CREATE TABLE #Custinfo_TmpBatch(CustID INT)

	INSERT INTO #Custinfo (custid)
	SELECT custid
	FROM custInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
		AND Enabled = 1

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #Custinfo_TmpBatch

		DELETE TOP (100) a
		OUTPUT deleted.custid
		INTO #Custinfo_TmpBatch(custid)
		FROM #Custinfo a

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c
		SET c.minbet = 0,
			c.maxbet = 0
		FROM custSetting c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Custinfo_TmpBatch t ON c.custid = t.CustID

		UPDATE c
		SET c.minbet = 0,
			c.maxbet = 0
		FROM custSetting3rd c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Custinfo_TmpBatch t ON c.custid = t.CustID

		UPDATE c
		SET maxpermatch		= 0,
			MaxPerMatch1MP	= 0,
			maxpermatch2	= 0,
			maxpermatch3	= 0,
			maxpermatch5	= 0,
			maxpermatch8	= 0,
			maxpermatch10	= 0,
			maxpermatch11	= 0,
			maxpermatch99	= 0,
			MaxPerMatch99MP	= 0,
			maxpermatch161	= 0,
			maxpermatch164	= 0,
			maxperball161	= 0
		FROM custInfo c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Custinfo_TmpBatch t ON c.custid = t.CustID
		WHERE  NOT (maxpermatch		= 0
					AND MaxPerMatch1MP	= 0
					AND maxpermatch2	= 0
					AND maxpermatch3	= 0
					AND maxpermatch5	= 0
					AND maxpermatch8	= 0
					AND maxpermatch10	= 0
					AND maxpermatch11	= 0
					AND maxpermatch99	= 0
					AND MaxPerMatch99MP	= 0
					AND maxpermatch161	= 0
					AND maxpermatch164	= 0
					AND maxperball161	= 0
					)
	END

	DROP TABLE #Custinfo
	DROP TABLE #Custinfo_TmpBatch
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

DECLARE @srecommend INT

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
	AND c.Enabled = 1
	AND ci.currency = 20

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
			,@target = @target	
			
	WAITFOR DELAY '00:00:0.020'
END
DROP TABLE #supers
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------