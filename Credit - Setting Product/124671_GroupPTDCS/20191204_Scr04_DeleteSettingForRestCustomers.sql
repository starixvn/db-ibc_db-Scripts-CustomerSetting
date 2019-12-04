/*
	Created: Johnson
	Date: 2019-12-04
	Task: delete settings for customers have grouped settings
	Original sp: DBA_CustSetting_GroupedPTSettingMaintenance
	DB: DBCUST/CUSTDB
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@AgentID INT		
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN		
	IF dbo.f_CheckRepTable('CustSettingMode3rd') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	
	SELECT ci.custid 
	INTO #tmpCust
	FROM custinfo ci (NOLOCK)
		INNER JOIN CustSettingMode3rd cs WITH(NOLOCK) ON ci.custid = cs.custid
	WHERE ci.recommend = @AgentID
		AND roleid = 1
		AND IsGrouped = 1
	
	DELETE CustPTSetting3rd_Member WITH(UPDLOCK,ROWLOCK)
	WHERE custid IN (SELECT custid FROM #tmpCust)
	
	DROP TABLE #tmpCust
END	
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

CREATE TABLE #AgentList (custid INT, isfinished BIT DEFAULT(0))

DECLARE @AgentID INT

INSERT INTO #AgentList(custid)
SELECT 	1 --list rest agents
	
-- For deployer info
DECLARE @agent_cnt INT, @index INT = 0

SET @agent_cnt = (SELECT COUNT(*) FROM #AgentList )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, AgentID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of Agent: %d.'

RAISERROR (@msg_total, 0, 1, @agent_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #AgentList
	SET isfinished = 1
		,@AgentID = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @AgentID) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@AgentID = @AgentID, 						
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------

CREATE TABLE #AgentList (custid INT, isfinished BIT DEFAULT(0))

DECLARE @AgentID INT

INSERT INTO #AgentList(custid)
SELECT 	1 --list rest agents
	
-- For deployer info
DECLARE @agent_cnt INT, @index INT = 0

SET @agent_cnt = (SELECT COUNT(*) FROM #AgentList )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, AgentID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of Agent: %d.'

RAISERROR (@msg_total, 0, 1, @agent_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #AgentList
	SET isfinished = 1
		,@AgentID = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @AgentID) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@AgentID = @AgentID, 						
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO		
-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------
