/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211025@Johnson
	Task: Delete existing settings for new games keno for UUS currency
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]	
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY)
	DECLARE @tmp TABLE (custid INT PRIMARY KEY)

	INSERT INTO #tblCust(custid)
	SELECT DISTINCT ci.custid
	FROM CustGameType cs WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE cs.GameTypeID IN (30,31)
		AND ci.currency <> 20
	
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmp(custid)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		DELETE CustGameType WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmp)
			AND GameTypeID IN (30,31)
			
		DELETE @tmp
		
		WAITFOR DELAY '0:0:0.1'
	END	   
	
	DROP TABLE #tblCust
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------



-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

	EXEC dbo.Acc_CustSetting3rd_19 @target = @target	
			
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------

	