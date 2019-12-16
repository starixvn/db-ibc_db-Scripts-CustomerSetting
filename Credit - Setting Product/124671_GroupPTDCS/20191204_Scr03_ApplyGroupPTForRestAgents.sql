/*
	Created: Johnson
	Date: 2019-12-04
	Task: Apply group pt for dcs for rest agents
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
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingMode3rd') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	
	declare @Threshold INT = 20--if number of grouped member is more than 20 percent the current one 

	CREATE TABLE #tempData (custid int, cs1 bigint, cs2 int)
	
	CREATE TABLE #tempGroup(cs1 bigint, cs2 int, memberCNT int, repCustID int)
	
	SELECT CustID
	INTO #tmpMembers
	FROM CustInfo WITH (NOLOCK) 
	WHERE Recommend = @AgentID 
		AND roleid = 1
	
	;WITH _s as (
		SELECT c.custid	
			,rdSetting = CAST(DENSE_RANK() OVER(ORDER BY sporttype, bettype, islive, superPT, masterPT, agentPT, isAutoMasterPT, AutoMasterPT, isAutoSuperPT, AutoSuperPT) as INT)
			,rdProduct = CAST(DENSE_RANK() OVER(ORDER BY sporttype, bettype, islive) as INT)
		FROM #tmpMembers c WITH(NOLOCK)
			INNER JOIN dbo.CustPTSetting3rd_Member pt WITH(NOLOCK) ON c.custid = pt.custid		
	)
	
	INSERT INTO #tempdata (custid, cs1, cs2)
	SELECT custid, SUM(CONVERT(bigint,rdSetting) + POWER(2, rdProduct%10+1)), CHECKSUM_AGG(CHECKSUM(HASHBYTES('SHA1', CONVERT(nvarchar(max), rdSetting))))
	FROM _s
	GROUP BY custid

	INSERT INTO #tempGroup(cs1, cs2, memberCNT, repCustID)
	SELECT cs1, cs2, memberCnt, repCustID
	FROM (
		SELECT cs1, cs2, rn = ROW_NUMBER() OVER (ORDER BY count(1) desc), memberCnt = count(1), repCustID = max(custid)
		FROM #tempdata
		GROUP BY cs1, cs2
	) x
	WHERE rn = 1
	
	DECLARE @GroupedPlayers_Current INT
	DECLARE @GroupedPlayers_New INT
	
	SET @GroupedPlayers_Current = (SELECT COUNT(*) 
								  FROM CustSettingMode3rd CS WITH (NOLOCK) 
									JOIN #tmpMembers CI ON CS.CustID = CI.CustID
								  WHERE IsGrouped = 1)
	
	SET @GroupedPlayers_Current = @GroupedPlayers_Current + @GroupedPlayers_Current * @Threshold / 100
	
	SET @GroupedPlayers_New = (SELECT memberCNT FROM #tempGroup)
	
	IF @GroupedPlayers_New > = @GroupedPlayers_Current
	BEGIN
			--PRINT 'Starting regroup ....'
			
			DECLARE @repCustID INT = (SELECT repCustID FROM #tempGroup)
			IF NOT EXISTS( SELECT 1 
						FROM CustPTGroupSetting3rd_Member T1 WITH (NOLOCK) 
							JOIN  CustPTSetting3rd_Member T2 WITH (NOLOCK) ON T1.SportType =  T2.SportType AND T1.BetType = T2.BetType AND T1.IsLive = T2.IsLive
																	AND (T1.SuperPT <> T2.SuperPT OR T1.MasterPT <> T2.MasterPT OR T1.AgentPT <> T2.AgentPT
																	OR T1.IsAutoMasterPT <> T2.IsAutoMasterPT OR T1.AutoMasterPT <>  T2.AutoMasterPT 
																	OR T1.IsAutoSuperPT <> T2.IsAutoSuperPT	OR T1.AutoSuperPT <> T2.AutoSuperPT)
						WHERE T1.agentID = @AgentID	AND T2.CustID = @repCustID)
			BEGIN
				--PRINT 'Processing for old group and new group has the same setting for this agent ...'
				-- Update isGroup for player
				UPDATE T
				SET IsGrouped = 1
				FROM CustSettingMode3rd T WITH(UPDLOCK,ROWLOCK)
					JOIN #tempdata T1 ON T1.CustID = T.CustID  
					JOIN #tempGroup T3 ON T3.CS1 = T1.CS1 AND T3.CS2=T1.CS2  
				
				-- Delete individual Setting
				--will delete later
				/*
				DELETE T
				FROM CustPTSetting3rd_Member T
					JOIN #tempdata T1 ON T1.CustID = T.CustID  
					JOIN #tempGroup T3 ON T3.CS1 = T1.CS1 AND T3.CS2=T1.CS2  
				*/
			END			
			ELSE
			BEGIN
				--PRINT 'Starting creating new group for this agent ...'
				-- Move Old PT Group to individual Setting
				INSERT INTO CustPTSetting3rd_Member([CustID]
												   ,[SportType]
												   ,[BetType]
												   ,[IsLive]
												   ,[SuperPT]
												   ,[MasterPT]
												   ,[AgentPT]
												   ,[IsAutoMasterPT]
												   ,[AutoMasterPT]
												   ,[IsAutoSuperPT]
												   ,[AutoSuperPT])
				SELECT  cs.custid,T1.SportType,T1.BetType,T1.IsLive,T1.SuperPT,T1.MasterPT,T1.AgentPT,T1.IsAutoMasterPT,T1.AutoMasterPT,T1.IsAutoSuperPT,T1.AutoSuperPT
				FROM CustSettingMode3rd CS WITH (NOLOCK) 
					JOIN #tmpMembers m ON CS.Custid = m.Custid
					JOIN CustPTGroupSetting3rd_Member T1 WITH (NOLOCK) ON T1.AgentID = @AgentID
				WHERE cs.IsGrouped = 1 
				
				UPDATE CSM
					SET IsGrouped = 0
				FROM CustSettingMode3rd CSM WITH(UPDLOCK,ROWLOCK)
					JOIN #tmpMembers m ON m.CustID = CSM.custid
				WHERE CSM.IsGrouped = 1 
				
				-- Create new Group PT for agent
				DELETE FROM CustPTGroupSetting3rd_Member WITH(UPDLOCK,ROWLOCK)
				WHERE AgentID = @AgentID
				
				INSERT INTO CustPTGroupSetting3rd_Member([AgentID]
													   ,[SportType]
													   ,[BetType]
													   ,[IsLive]
													   ,[SuperPT]
													   ,[MasterPT]
													   ,[AgentPT]
													   ,[IsAutoMasterPT]
													   ,[AutoMasterPT]
													   ,[IsAutoSuperPT]
													   ,[AutoSuperPT])				
				SELECT @agentID AS agentID ,
						T1.SportType,T1.BetType,T1.IsLive,T1.SuperPT,T1.MasterPT,T1.AgentPT,T1.IsAutoMasterPT,T1.AutoMasterPT,T1.IsAutoSuperPT,T1.AutoSuperPT
				FROM CustPTSetting3rd_Member T1 WITH(NOLOCK)
				WHERE T1.CustID = @repCustID
				
				UPDATE T
				SET IsGrouped = 1
				FROM CustSettingMode3rd T WITH(UPDLOCK,ROWLOCK)
					JOIN #tempdata T1 ON T1.CustID = T.CustID  
					JOIN #tempGroup T3 ON T3.CS1 = T1.CS1 AND T3.CS2=T1.CS2
					
				-- Delete Individual setting for grouped players 
				--will delete later
				/*DELETE T
				FROM CustPTSetting3rd_Member T
					JOIN #tempdata TempD ON t.Custid = tempD.CustID
					JOIN #tempGroup TempG ON TempG.cs2 = TempD.cs2 AND TempD.cs1 = TempG.cs1
				*/	
			END	
			
	END
	
	DROP TABLE #TempData
	DROP TABLE #tempGroup
	DROP TABLE #tmpMembers
END	
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

CREATE TABLE #AgentList (custid INT, isfinished BIT DEFAULT(0))

DECLARE @AgentID INT

INSERT INTO #AgentList(custid)
select 1
	
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
SELECT 	1--put list agents 

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
