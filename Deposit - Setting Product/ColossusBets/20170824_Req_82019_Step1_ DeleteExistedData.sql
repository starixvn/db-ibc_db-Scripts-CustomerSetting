/*
	Created: Winnie
	Date: 2017-08-24
	Task: Delete existing colossus settings for Leon& Sungame
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

	INSERT INTO #tempAgent(CustID)
	SELECT DISTINCT c.CustID 
	FROM Dep_AgentCommRate cg WITH(UPDLOCK,ROWLOCK)		
	INNER JOIN custInfo c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE c.roleid IN(2,3,4) AND SportType = 204 AND srecommend IN (SELECT custid FROM Dep_CustSuper cs WITH(NOLOCK)							
															WHERE cs.site IN  ('Leon','Sungame'))

	INSERT INTO #tempMem(CustID)
	SELECT DISTINCT c.CustID 
	FROM Dep_CustCommRate cg WITH(UPDLOCK,ROWLOCK)		
	INNER JOIN custInfo c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE c.roleid =1 AND SportType = 204 AND srecommend IN (SELECT custid FROM Dep_CustSuper cs WITH(NOLOCK)							
															WHERE cs.site IN  ('Leon','Sungame'))

	DELETE cg
	FROM Dep_AgentCommRate cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN #tempAgent c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE SportType = 204 
						
	DELETE cg
	FROM Dep_CustCommRate cg WITH(UPDLOCK,ROWLOCK)		
	INNER JOIN #tempMem c WITH(NOLOCK) ON cg.CustID=c.custid	
	WHERE SportType = 204 
	
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




