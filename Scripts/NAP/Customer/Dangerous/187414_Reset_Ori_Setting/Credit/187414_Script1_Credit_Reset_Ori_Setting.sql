/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created by: Helios
    Date: 2023/04/25
    Task: Nap - Script Update change DangerLevel of Type Original and ABI [redmine : #187414]
    DB: DBCUST/CustDB 

    Revisions:  Initial Script: Copy Ori50 qua ABI50, reset all Ori setting
*/

ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
		 @Custid			VARCHAR (MAX)
		,@target			VARCHAR(20)
		
AS

BEGIN
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

---------------------------------Check Replicate---------------------------------
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 )
	   RETURN

	UPDATE c
		SET 
		c.danger2 = CASE WHEN c.danger = 50 AND c.danger2 = 0 THEN 50 ELSE c.danger2 END,
		c.danger = 0
		FROM custInfo c WITH(ROWLOCK, UPDLOCK)
		WHERE c.custid IN (SELECT s.value FROM STRING_SPLIT(@Custid , ',') s)
END
GO
 --END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------

-----------------------------------------------------
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
	DECLARE @max_custid			INT
		,	@target				VARCHAR(20) 
		,	@batch				INT = 3000
		,	@AffectedList		VARCHAR(MAX)

	SELECT @max_custid = xxx

	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

	CREATE TABLE #supers (custid INT PRIMARY KEY CLUSTERED )
	CREATE TABLE #CustList (custid INT PRIMARY KEY CLUSTERED )
	CREATE TABLE #AffectedCust (custid INT PRIMARY KEY CLUSTERED )

	-- Collect Super
	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) 
				ON ci.site = s.site
	WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid

	-- Collect Downline to Update
	INSERT INTO #CustList (custid)
	SELECT c.custid
	FROM Custinfo c WITH (NOLOCK)
		INNER JOIN #supers s 
				ON c.srecommend = s.custid
	WHERE c.Enabled = 1
	AND c.danger IN (1,2,3,11,12,13,50)
	AND c.custid <= @max_custid

			
	-- For deployer info
	DECLARE @smap_cnt INT
	DECLARE @msg_total NVARCHAR(200) = 'Total of Affect Cust: %d.'
	
	SET @smap_cnt = (SELECT COUNT(1) FROM #CustList )
	RAISERROR (@msg_total, 0, 1, @smap_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		
		TRUNCATE TABLE #AffectedCust

		DELETE TOP (@batch) s 
		OUTPUT DELETED.custid
			INTO #AffectedCust (custid)
		FROM #CustList s
				
		IF @@ROWCOUNT = 0 
			BREAK ;

		SET @AffectedList = STUFF ((	SELECT ',' + CAST(custid AS VARCHAR(20))
												FROM #AffectedCust
												FOR XML PATH('')), 1, 1, '')

		EXEC dbo.Acc_CustomerInfo_Execrep_09 @custid = @AffectedList
				,@target = @target
				
		WAITFOR DELAY  '00:00:0.050'	
		
		SET @msg_total = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total, 0, 1) WITH NOWAIT
	END
	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	GO
