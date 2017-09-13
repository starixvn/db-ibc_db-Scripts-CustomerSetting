/*
	Created: Johnson
	Date: 2017-09-07
	Task: delete old virtual sports setting for deposit customers
	DB: DBCust/CustDB
*/


--step 1: Deploy this sp on DBCUST/CustDB
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT		
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DB230\SQLSERVER2008R2') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DB230\SQLSERVER2008R2') RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSetting3rd') = 0 RETURN
	
	CREATE TABLE #tmpCust (custid INT)
	DECLARE @temp TABLE (custid INT)	
	DECLARE @cnt INT, @rowcount INT 
	
	SELECT @cnt = 500
	
	INSERT INTO #tmpCust(custid)
	SELECT custid
	FROM dbo.CustInfo WITH(NOLOCK)
	WHERE srecommend = @srecommend
	
	WHILE (1=1)
	BEGIN
		DELETE TOP (@cnt) t
		OUTPUT deleted.custid
		INTO @temp
		FROM #tmpCust t
		
		SELECT @rowcount = @@ROWCOUNT
				
		DELETE cs
		FROM dbo.Dep_CustSetting3rd cs WITH(UPDLOCK,ROWLOCK)			
		WHERE custid IN (SELECT custid FROM @temp)
			AND cs.sporttype BETWEEN 180 AND 186
		
		IF @rowcount < @cnt BREAK;
		
		DELETE @temp
	END	
	
	DROP TABLE #tmpCust	
	
END
--- END STEP 1:DEPLOY THIS SP @DBCUST.CustDB --------	
-------------------------------------------------------------------------------------


---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (052/053/054/06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend INT

--supers list
INSERT INTO #supers(custid)
SELECT custid
FROM dbo.Dep_CustSuper WITH(NOLOCK)


WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid					
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend			
			,@target = 'REPLICATED'			
	
	WAITFOR DELAY '00:00:0.280'
END			
GO		
 
 -- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (052/053/054/06/DBTP) -----
-----------------------------------------------------------------------------------
 
 
 
---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend INT

--supers list
INSERT INTO #supers(custid)
SELECT custid
FROM dbo.Dep_CustSuper WITH(NOLOCK)


WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid					
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend			
			,@target = 'DBCUST'			
	
	WAITFOR DELAY '00:00:0.280'
END			
GO		
 
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------
 
 