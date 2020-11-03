/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Tina@20201103
	Task: Store Sitename at Member level - https://nexdev.net/issues/144323
	DB: DBCUST/CustDB
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustomerInfo_09]
	@custid INT,
	@site varchar(10),
	@target VARCHAR(20)
AS
BEGIN
-- BEGIN STEP 1: DEPLOY THESE SP @ DBCUST.CustDB -----
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('customer') = 0 RETURN

	UPDATE ci
	SET	ci.[site] = @site
	FROM Customer ci WITH(ROWLOCK,UPDLOCK)
	WHERE ci.custid = @custid
	
	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #Member (CustID INT, [site] VARCHAR(10), IsFinished BIT DEFAULT 0)
DECLARE @custid INT, @site VARCHAR(10)

-- list of member
INSERT INTO #Member(CustID, [site])
SELECT ci.custid, ca.[site]
FROM customer ci WITH (NOLOCK) 
	INNER JOIN Customer ca WITH (NOLOCK) ON ci.recommend = ca.custid
	LEFT JOIN [Site] S WITH (NOLOCK) ON ci.[site] = S.[site]
WHERE ci.roleid = 1  
	AND ci.srecommend IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)) -- Get Deposit member 
	AND (S.isDeposit = 1 OR S.isLicensee = 1)
	AND (ci.[site] <> '' OR ci.[site] IS NULL) --only update for member who does not have site

-- For deployer info
DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #Member )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected custid: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT
		
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Member
	SET isfinished = 1
		,@custid = custid	
		,@site = [site]
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
			
	EXEC [dbo].[Acc_DynamicCustomerInfo_09] @custid = @custid
			, @site = @site
			, @target = 'REPLICATED'
			
	WAITFOR DELAY '00:00:0.100'
	
END

GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #Member (CustID INT, [site] VARCHAR(10), IsFinished BIT DEFAULT 0)
DECLARE @custid INT, @site VARCHAR(10)

-- list of member
INSERT INTO #Member(CustID, [site])
SELECT ci.custid, ca.[site]
FROM customer ci WITH (NOLOCK) 
	INNER JOIN Customer ca WITH (NOLOCK) ON ci.recommend = ca.custid
	LEFT JOIN [Site] S WITH (NOLOCK) ON ci.[site] = S.[site]
WHERE ci.roleid = 1  
	AND ci.srecommend IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)) -- Get Deposit member 
	AND (S.isDeposit = 1 OR S.isLicensee = 1)
	AND (ci.[site] <> '' OR ci.[site] IS NULL) --only update for member who does not have site

-- For deployer info
DECLARE @totalCust_cnt INT, @index INT = 0
SET @totalCust_cnt = (SELECT COUNT(1) FROM #Member )
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of affected custid: %d.'
RAISERROR (@msg_total, 0, 1, @totalCust_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Member
	SET isfinished = 1
		,@custid = custid	
		,@site = [site]
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
			
	EXEC [dbo].[Acc_DynamicCustomerInfo_09] @custid = @custid
			, @site = @site
			, @target = 'DBCUST'
			
	WAITFOR DELAY '00:00:0.100'
	
END

GO