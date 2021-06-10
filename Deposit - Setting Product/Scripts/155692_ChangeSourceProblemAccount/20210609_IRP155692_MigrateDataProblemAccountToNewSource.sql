/*
	Created: 20210609@Johnson
	Task: Migrate problem account for table ProblemAccountClassification
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
	
	IF (dbo.f_CheckRepTable('ProblemAccount') = 0
		OR dbo.f_CheckRepTable('ProblemAccountClassification') = 0		 		 
		OR dbo.f_CheckRepTable('CustInfo') = 0
		)
	RETURN
		
	--Import from ProblemAccount table 
	--86088 rows affects
	INSERT INTO ProblemAccountClassification(custid,IsReviewed,ModifiedDate)
	SELECT p.custid, 0, p.CreatedDate
	FROM ProblemAccount p WITH (NOLOCK)
		INNER JOIN custinfo ci WITH (NOLOCK) on p.CustId = ci.custid	
	WHERE enabled = 1
		AND srecommend IN (SELECT custid FROM dep_custsuper WITH(NOLOCK))	
		AND CustomerClass BETWEEN 8 AND 13
		AND NOT EXISTS (SELECT 1 FROM ProblemAccountClassification pc WITH(NOLOCK) WHERE pc.custid = ci.custid)

	--import PA from CTS & RobotUsers which not have in ProblemAccount table
	--will get lastest when release
	DECLARE @string VARCHAR(MAX)

	--23353 rows affects
	SELECT @string = 
			--list custids PA not robot users
			'146859&2020-10-21 00:49:57,
			430590&2020-11-05 07:14:47,
			50877457&2021-05-18 14:24:00,
			50877937&2021-05-18 15:29:00'

	SELECT REPLACE (REPLACE(REPLACE(val,char(9),''),char(13),''),char(10),'') custid
	INTO #tmpCust
	FROM dbo.f_SplitString(@string, ',')
	OPTION (MAXRECURSION 0)	

	;WITH t AS (
		SELECT (SELECT val FROM dbo.strSplit(custid,'&') where rank = 1) as custid,
				(SELECT val FROM dbo.strSplit(custid,'&') where rank = 2) as markdate				
		FROM #tmpCust
	)
	INSERT INTO ProblemAccountClassification(custid,IsReviewed,ModifiedDate)
	SELECT t.custid, 0, Markdate
	FROM t
		INNER JOIN custinfo ci WITH(NOLOCK) ON t.custid = ci.custid
	WHERE NOT EXISTS (SELECT 1 FROM ProblemAccountClassification pc WITH(NOLOCK) WHERE pc.custid = t.custid)
		AND ci.customerClass BETWEEN 8 AND 13
		AND ci.srecommend IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
	DROP TABLE #tmpCust
END
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_CustSetting_19 @target = 'REPLICATED'

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------	
	

---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB SERVER -----
--------------------------------------------------------------------------------------
EXEC Acc_CustSetting_19 @target = 'DBCUST'


-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB SERVER -----
--------------------------------------------------------------------------------------


		

	
