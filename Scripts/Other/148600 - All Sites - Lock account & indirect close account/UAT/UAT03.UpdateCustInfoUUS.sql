/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210519@Tina
	Task: Initialize Product Status for UUS Credit customers [RedmineID: 148600]
	DB: DBCUST/CustDB And all subscriber of CustDB_CustomerInfo Publication
*/
ALTER PROCEDURE [dbo].[Acc_ExecRep_Cust_09]
	 @srecommend INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   )
		RETURN
				
	/*******************************CUST PRODUCT STATUS TABLE*******************************/	

	CREATE TABLE #CustTemp
	(
		CustID INT,
		reject BIT NULL,
		closed BIT NULL 
	)

	CREATE TABLE #Cust_batch
	(
		CustID INT PRIMARY KEY CLUSTERED
	)
	
	INSERT INTO #CustTemp (CustID, reject, closed)
	SELECT custid, reject, closed
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend

	--Backup data before updating
	 IF @@servername = 'DBCUST'
	 BEGIN
		INSERT INTO Cust_BackupStatus(CustID, reject, closed)
		SELECT CustID, reject, closed
		FROM #CustTemp
	 END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (3000) #CustTemp OUTPUT DELETED.CustID INTO #Cust_batch(CustID)

		IF @@ROWCOUNT=0
			BREAK

		UPDATE ci
		SET ci.closed = 1, ci.reject = 1
		FROM [dbo].[custInfo] ci WITH(ROWLOCK)
			INNER JOIN #Cust_batch cb ON cb.CustID = ci.custid

		TRUNCATE TABLE #Cust_batch

	END

	DROP TABLE #Cust_batch
	DROP TABLE #CustTemp
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
	INNER JOIN CustProductStatus cps WITH (NOLOCK) ON cps.CustID = ci.custid
WHERE ci.roleid = 4  
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	--AND ci.custid IN (24975141,24975151,24975155,24975159,24975163, 24975179,24957464,24975126,24975127,24975129,24975132,24975133,24975135,24975142,24975143,24975145,24975119) --run on SIT
	AND ci.currency = 20 --run on UAT
	--AND ci.custid IN (52786885,52786933,52786934,52786948,52786949,52786954,52786956,52786961,38268801,47447605,46337216,45080424,52786964,34027396) --run on UAT round 1
	AND ci.custid = 25659077 --run on UAT round 2

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

	EXEC dbo.Acc_ExecRep_Cust_09 @srecommend = @srecommend
			,@target = @target
			
			
	waitfor delay '00:00:00.100'
END
DROP TABLE #supers
GO
