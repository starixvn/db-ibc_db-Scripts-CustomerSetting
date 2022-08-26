/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220729@Johnson
	Task: Update New customer class [redmine:#175975]
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@srecommend INT, 
	@max_custid	INT,
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY)
	DECLARE @tmp TABLE (custid INT PRIMARY KEY)
	DECLARE @tmpCC TABLE (OldCustomerClass SMALLINT, NewCustomerClass SMALLINT)
	
	INSERT INTO @tmpCC(OldCustomerClass, NewCustomerClass)	
	SELECT 	1	,	201
	UNION SELECT 	111	,	2101
	UNION SELECT 	112	,	2201
	UNION SELECT 	113	,	2001
	UNION SELECT 	2	,	202
	UNION SELECT 	121	,	2102
	UNION SELECT 	122	,	2202
	UNION SELECT 	123	,	2002
	UNION SELECT 	3	,	200
	UNION SELECT 	31	,	2100
	UNION SELECT 	32	,	2200
	UNION SELECT 	33	,	2000
	UNION SELECT 	43	,	2500
	UNION SELECT 	45	,	2503
	UNION SELECT 	46	,	2504
	UNION SELECT 	47	,	2505
	UNION SELECT 	5	,	203
	UNION SELECT 	51	,	2103
	UNION SELECT 	52	,	2203
	UNION SELECT 	53	,	2003
	UNION SELECT 	57	,	2303
	UNION SELECT 	58	,	2403
	UNION SELECT 	6	,	204
	UNION SELECT 	61	,	2104
	UNION SELECT 	62	,	2204
	UNION SELECT 	63	,	2004
	UNION SELECT 	67	,	2304
	UNION SELECT 	68	,	2404
	UNION SELECT 	7	,	205
	UNION SELECT 	71	,	2105
	UNION SELECT 	72	,	2205
	UNION SELECT 	73	,	2005
	UNION SELECT 	77	,	2305
	UNION SELECT 	78	,	2405
	UNION SELECT 	8	,	301
	UNION SELECT 	86	,	3001
	UNION SELECT 	9	,	302
	UNION SELECT 	96	,	3002
	UNION SELECT 	9	,	302
	UNION SELECT 	96	,	3002
	UNION SELECT 	10	,	303
	UNION SELECT 	106	,	3003
	UNION SELECT 	10	,	303
	UNION SELECT 	106	,	3003
	UNION SELECT 	10	,	303
	UNION SELECT 	106	,	3003
	UNION SELECT 	12	,	304
	UNION SELECT 	126	,	3004
	UNION SELECT 	131	,	300
	UNION SELECT 	132	,	3000
	UNION SELECT 	14	,	401
	UNION SELECT 	99	,	400
	UNION SELECT 	101	,	4000
	UNION SELECT 	100	,	999
	UNION SELECT 	1001	,	901
	UNION SELECT 	1002	,	902


	INSERT INTO #tblCust(custid)
	SELECT custid
	FROM custInfo ci WITH(NOLOCK) 
	WHERE srecommend = @srecommend
		AND custid <= @max_custid
		
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmp(custid)		
		FROM #tblCust t
				
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE custInfo WITH(ROWLOCK)
		SET CustomerClass = ISNULL((SELECT NewCustomerClass FROM @tmpCC WHERE OldCustomerClass = CustomerClass), CustomerClass)
		WHERE custid IN (SELECT custid FROM @tmp)			
			
		DELETE @tmp
		
		--WAITFOR DELAY '0:0:0.1'
	END	
	
	DROP TABLE #tblCust
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------



-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
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
			
	--WAITFOR DELAY '00:00:0.100'
END

--Drop all temp tables
DROP TABLE #supers
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------

		