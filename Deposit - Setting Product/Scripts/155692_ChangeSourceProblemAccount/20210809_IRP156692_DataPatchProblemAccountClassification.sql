/*
	Created: 20210809@Johnson
	Task: update last ModifiedDate for ProblemAccountClassification
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
 	@target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustCategoryHistory') = 0	
		OR dbo.f_CheckRepTable('ProblemAccountClassification') = 0		 		 		
		)
	RETURN
	
	;WITH T AS (
		SELECT custid, MAX(CreatedDate) maxdate 
		FROM Dep_CustCategoryHistory d WITH(NOLOCK) 
		GROUP BY custid 
	)
	UPDATE p
	SET p.ModifiedDate = maxdate
	FROM ProblemAccountClassification p WITH(ROWLOCK)
		INNER JOIN T on p.custid = t.custid
	WHERE ModifiedDate <> maxdate
	
END	
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_CustSetting_19 @target = 'REPLICATED'
--END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_CustSetting_19 @target = 'DBCUST'
--END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
