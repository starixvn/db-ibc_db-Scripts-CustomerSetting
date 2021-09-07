/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210907@Johnson
	Task: copy danger setting for Esports from Other Sports
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@srecommend INT, 
	@max_custid	INT,
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY)
	DECLARE @tmp TABLE (custid INT PRIMARY KEY)
	
	INSERT INTO #tblCust(custid)
	SELECT custid
	FROM custInfo ci WITH(NOLOCK) 
	WHERE srecommend = @srecommend
		AND custid <= @max_custid
		AND Danger3 IN (8, 9, 16, 17, 21)
		AND ISNULL(Danger5,0) <> Danger3
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmp(custid)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE custInfo WITH(ROWLOCK)
		SET danger5 = Danger3
		WHERE custid IN (SELECT custid FROM @tmp)
			AND Danger3 IN (8, 9, 16, 17, 21)
			AND ISNULL(danger5,0) <> danger3
		
		DELETE @tmp
		
		WAITFOR DELAY '0:0:0.1'
	END
		
	DROP TABLE #tblCust	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @Custid INT, @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND Enabled = 1
		
-- For deployer info
DECLARE @Cust_CNT INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order: %d'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @Cust_CNT = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @Cust_CNT ) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@Custid = custid
	WHERE isfinished = 0
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @Custid) WITH NOWAIT

	EXEC dbo.Acc_CustomerInfo_Execrep_09 @srecommend = @Custid
			,@max_custid = @max_custid
			,@target = @target	
			
	WAITFOR DELAY '00:00:0.100'
END

--Drop all temp tables
DROP TABLE #supers
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
