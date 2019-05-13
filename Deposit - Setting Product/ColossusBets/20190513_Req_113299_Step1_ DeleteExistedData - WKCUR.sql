/*
	Created: Winnie
	Date: 2019-05-13
	Task: Delete existing colossus settings for WKCUR RedmineID: #113299
	DB: DBCUST/CustDB
*/ 

ALTER PROCEDURE [dbo].Acc_CustSetting3rd_19
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('Dep_AgentCommRate') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustCommRate') = 0 RETURN	
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN		
	
	CREATE TABLE #tempAgent (CustID INT PRIMARY KEY)	
	CREATE TABLE #tempMem   (CustID INT PRIMARY KEY)
	DECLARE @Sporttype SMALLINT

	SELECT 	@Sporttype = 204

	INSERT INTO #tempAgent(CustID)
	SELECT DISTINCT c.CustID 
	FROM dbo.Dep_AgentCommRate cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE c.roleid IN(2,3,4) AND SportType = @Sporttype 
		AND srecommend IN (	SELECT custid 
							FROM dbo.Dep_CustSuper cs WITH(NOLOCK)							
							WHERE cs.site ='WKCUR'  AND cs.currency IN (4,13,20,51))

	INSERT INTO #tempMem(CustID)
	SELECT DISTINCT c.CustID 
	FROM dbo.Dep_CustCommRate cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE c.roleid =1 AND SportType = @Sporttype 
		AND srecommend IN (	SELECT custid 
							FROM dbo.Dep_CustSuper cs WITH(NOLOCK)							
							WHERE cs.site ='WKCUR'  AND cs.currency IN (4,13,20,51))

	DELETE cg
	FROM dbo.Dep_AgentCommRate cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN #tempAgent c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE SportType = @Sporttype 
						
	DELETE cg
	FROM dbo.Dep_CustCommRate cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #tempMem c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE SportType = @Sporttype 
	
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_CustSetting3rd_19 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_CustSetting3rd_19 @target = 'DBCUST'




