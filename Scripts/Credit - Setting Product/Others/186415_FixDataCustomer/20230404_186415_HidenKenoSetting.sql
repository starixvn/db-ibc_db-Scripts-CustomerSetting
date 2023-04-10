/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Non Offer - Update value hideKeno=0  Status [#RM:174744]
	DB: DBCUST/CustDB 
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@Custid INT
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
		)
	RETURN
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
	
	INSERT INTO #CustList(CustID)
	SELECT custid
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE ci.srecommend = @Custid
		AND ci.Enabled = 1
		AND ci.HideKeno = 1
		AND ci.custid <= @maxcustid
	
	DECLARE @batch int = 3000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustList WHERE isfinished = 0)
	BEGIN
		UPDATE TOP (@batch) #CustList 
		SET isfinished = 1
		OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
		WHERE isfinished = 0

		IF @@ROWCOUNT=0
			BREAK		
		
		--update disabled=0 miss update hideKeno=0 
		UPDATE g 
		SET HideKeno = 0
		FROM dbo.CustInfo g WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #CustListTemp b ON g.CustID = b.CustID 
		
		TRUNCATE TABLE #CustListTemp
	END
		
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

DECLARE @srecommend INT , @max_custid INT
SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH(NOLOCK) 
	INNER JOIN custinfo c WITH(NOLOCK) ON ci.custid = c.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site	
	LEFT JOIN custAccount ca WITH(NOLOCK) ON ca.custid = ci.custid
WHERE ISNULL(ca.groupid,0) NOT IN (
	SELECT 	groupID 
	FROM custAccount WITH(NOLOCK)
	WHERE custid IN (SELECT custid 
					FROM custinfo WITH (NOLOCK) 
					WHERE username IN ('SDRMB', '266HK', 'M863HK', 'SBSR', 'YKH', 'S188RM', 'PYY', 'POT', 'SF8', 'S80R',
									--list 20 previous headlines
									'CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'
								))
		   )
	AND ci.roleid = 4
	AND s.isLicensee = 0
	AND ci.custid <= @max_custid
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT DISTINCT srecommend 
						FROM customer WITH(NOLOCK)
						WHERE username IN (SELECT username 
											FROM PhoneBettingCustomerList WITH(NOLOCK)
										)
						)
	AND NOT EXISTS (SELECT 1 FROM CustSuper s WITH(NOLOCK) WHERE ci.custid = s.custid AND isInternal = 1)					
	AND c.enabled = 1
	AND ci.site NOT IN ('789y')
	AND ci.currency IN (2,3,5,6,9,12,13,15,16,22,33,34,42,43,45,47,53,64,67,69)
	AND ci.custid NOT IN (SELECT custid FROM Acc_CustDirect WITH(NOLOCK) WHERE roleid = 4) --super not dummy account
	AND ci.username not like '3rdSuper%'  

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

	EXEC dbo.Acc_DynamicCustomerInfo_09 @custid = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
			
	WAITFOR DELAY '00:00:0.100'
END
	DROP TABLE #supers
GO