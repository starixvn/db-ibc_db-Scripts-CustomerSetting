/*
	Created: Eden
	Date: 2019/10/21
	Task: Delete existing settings for Lucky 3, Poker Games, Bullfighting, IMBC Cricket, Cockfighting
	DB: DBCUST/CUSTDB
*/	
--------------------------------------------------------------------------------------
-- BEGIN STEP 1
--------------------------------------------------------------------------------------
ALTER  PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20),
	@srecommend INT,
	@SportTypeListXML XML
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN				

	CREATE TABLE #Sporttype (Sporttype SMALLINT PRIMARY KEY)
	INSERT INTO #Sporttype (Sporttype)
	SELECT Data.value('(Sporttype/text())[1]','smallint') as Sporttype
	FROM @SportTypeListXML.nodes('SportTypeList/SportType') Node(Data)

	CREATE TABLE #TempCust(CustID INT PRIMARY KEY)

	INSERT INTO  #TempCust(CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend

	CREATE TABLE #CustPTSetting3rd_Agent		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustPTSetting3rd_Member		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustPTGroupSetting3rd_Member	(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustBetSetting3rd_Agent		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustBetSetting3rd_Member		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustDiscount3rd_Agent			(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustDiscount3rd_Member		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustWinLossLimit_Agent		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustWinLossLimit_Member		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustStakeLevel_Agent			(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #CustStakeLevel_Member			(CustID INT, Sporttype SMALLINT)

	DECLARE @RowCount1 INT = 1
	DECLARE @RowCount2 INT = 1
	DECLARE @RowCount3 INT = 1
	DECLARE @RowCount4 INT = 1
	DECLARE @RowCount5 INT = 1
	DECLARE @RowCount6 INT = 1
	DECLARE @RowCount7 INT = 1
	DECLARE @RowCount8 INT = 1
	DECLARE @RowCount9 INT = 1
	DECLARE @RowCount10 INT = 1
	DECLARE @RowCount11 INT = 1
	DECLARE @Batch INT = 5000

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustPTSetting3rd_Agent		
		TRUNCATE TABLE #CustPTSetting3rd_Member		
		TRUNCATE TABLE #CustPTGroupSetting3rd_Member	
		TRUNCATE TABLE #CustBetSetting3rd_Agent		
		TRUNCATE TABLE #CustBetSetting3rd_Member		
		TRUNCATE TABLE #CustDiscount3rd_Agent			
		TRUNCATE TABLE #CustDiscount3rd_Member		
		TRUNCATE TABLE #CustWinLossLimit_Agent		
		TRUNCATE TABLE #CustWinLossLimit_Member	
		TRUNCATE TABLE #CustStakeLevel_Agent
		TRUNCATE TABLE #CustStakeLevel_Member
			

		IF @RowCount1 > 0
			INSERT INTO #CustPTSetting3rd_Agent(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM CustPTSetting3rd_Agent cg  WITH(NOLOCK)	
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID
		
		SET @RowCount1 = @@ROWCOUNT
						
		IF @RowCount2 > 0
			INSERT INTO #CustPTSetting3rd_Member(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM CustPTSetting3rd_Member cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID

		SET @RowCount2 = @@ROWCOUNT
		
		IF @RowCount3 > 0
			INSERT INTO #CustPTGroupSetting3rd_Member(CustID, Sporttype)
			SELECT TOP (@Batch) cg.AgentID,cg.SportType
			FROM CustPTGroupSetting3rd_Member cg  WITH(NOLOCK)	
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.AgentID  = tmp.CustID

		SET @RowCount3 = @@ROWCOUNT
				
		IF @RowCount4 > 0
			INSERT INTO #CustBetSetting3rd_Agent(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM CustBetSetting3rd_Agent cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID
	    
		SET @RowCount4 = @@ROWCOUNT

		IF @RowCount5 > 0
			INSERT INTO #CustBetSetting3rd_Member(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM CustBetSetting3rd_Member cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID
		
		SET @RowCount5 = @@ROWCOUNT

		IF @RowCount6 > 0
			INSERT INTO #CustDiscount3rd_Agent(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM dbo.CustDiscount3rd_Agent cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID

		SET @RowCount6 = @@ROWCOUNT
		
		IF @RowCount7 > 0
			INSERT INTO #CustDiscount3rd_Member(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM dbo.CustDiscount3rd_Member cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID

		SET @RowCount7 = @@ROWCOUNT
		
		IF @RowCount8 > 0
			INSERT INTO #CustWinLossLimit_Agent(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM dbo.CustWinLossLimit_Agent cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID

		SET @RowCount8 = @@ROWCOUNT
		
		IF @RowCount9 > 0
			INSERT INTO #CustWinLossLimit_Member(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM dbo.CustWinLossLimit_Member cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID
		
		SET @RowCount9 = @@ROWCOUNT

		IF @RowCount10 > 0
			INSERT INTO #CustStakeLevel_Agent(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM CustStakeLevel_Agent cg  WITH(NOLOCK)	
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID
		
		SET @RowCount10 = @@ROWCOUNT
						
		IF @RowCount11 > 0
			INSERT INTO #CustStakeLevel_Member(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM CustStakeLevel_Member cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID

		SET @RowCount11 = @@ROWCOUNT


		IF (@RowCount1 = 0 AND @RowCount2 = 0 AND @RowCount3 = 0 AND @RowCount4 = 0 AND @RowCount5 = 0 AND @RowCount6 = 0 AND @RowCount7 = 0 AND @RowCount8 = 0 AND @RowCount9 = 0  AND @RowCount10 = 0 AND @RowCount11 = 0)
			BREAK;

		--> DELETE DATA
		--> PT
		IF @RowCount1 > 0
			DELETE cg
			FROM CustPTSetting3rd_Agent cg WITH(UPDLOCK,ROWLOCK)
				INNER JOIN #CustPTSetting3rd_Agent c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType
						
		IF @RowCount2 > 0
			DELETE cg
			FROM CustPTSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)	
				INNER JOIN #CustPTSetting3rd_Member c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType
		
		IF @RowCount3 > 0
			DELETE cg
			FROM CustPTGroupSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)	
				INNER JOIN #CustPTGroupSetting3rd_Member c 
					ON c.CustID = cg.AgentID
					AND c.Sporttype = cg.SportType
	
		--> Bet Setting	
		IF @RowCount4 > 0		
			DELETE cg
			FROM CustBetSetting3rd_Agent cg WITH(UPDLOCK,ROWLOCK)		
				INNER JOIN #CustBetSetting3rd_Agent c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType

		IF @RowCount5 > 0
			DELETE cg
			FROM CustBetSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)
				INNER JOIN #CustBetSetting3rd_Member c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType	
	
		--> Commission
		IF @RowCount6 > 0
			DELETE cg
			FROM dbo.CustDiscount3rd_Agent cg WITH(UPDLOCK,ROWLOCK)	
				INNER JOIN #CustDiscount3rd_Agent c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType

		IF @RowCount7 > 0
			DELETE cg
			FROM dbo.CustDiscount3rd_Member cg WITH(UPDLOCK,ROWLOCK)	
				INNER JOIN #CustDiscount3rd_Member c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType	
	
		--> Win/Loss Limit
		IF @RowCount8 > 0
			DELETE cg
			FROM dbo.CustWinLossLimit_Agent cg WITH(UPDLOCK,ROWLOCK)
				INNER JOIN #CustWinLossLimit_Agent c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType

		IF @RowCount9 > 0
			DELETE cg
			FROM dbo.CustWinLossLimit_Member cg WITH(UPDLOCK,ROWLOCK)		
				INNER JOIN #CustWinLossLimit_Member c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType

		--> StakeLevel
		IF @RowCount10 > 0
			DELETE cg
			FROM dbo.CustStakeLevel_Agent cg WITH(UPDLOCK,ROWLOCK)
				INNER JOIN #CustStakeLevel_Agent c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType

		IF @RowCount11 > 0
			DELETE cg
			FROM dbo.CustStakeLevel_Member cg WITH(UPDLOCK,ROWLOCK)		
				INNER JOIN #CustStakeLevel_Member c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType

		WAITFOR DELAY '00:00:00.100'

	END

	DROP TABLE #Sporttype	
	DROP TABLE #CustPTSetting3rd_Agent		
	DROP TABLE #CustPTSetting3rd_Member		
	DROP TABLE #CustPTGroupSetting3rd_Member	
	DROP TABLE #CustBetSetting3rd_Agent		
	DROP TABLE #CustBetSetting3rd_Member		
	DROP TABLE #CustDiscount3rd_Agent			
	DROP TABLE #CustDiscount3rd_Member		
	DROP TABLE #CustWinLossLimit_Agent		
	DROP TABLE #CustWinLossLimit_Member		
	DROP TABLE #CustStakeLevel_Agent
	DROP TABLE #CustStakeLevel_Member
	DROP TABLE #TempCust
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
BEGIN
	DECLARE @srecommend INT
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isfinished bit default(0))
	CREATE TABLE #SportTypeList (Sporttype SMALLINT PRIMARY KEY)
	DECLARE @SportTypeListXML XML 

	INSERT INTO #SportTypeList(Sporttype)
	SELECT 160 --Lucky 3
	UNION ALL SELECT 163 -- Poker Games
	UNION ALL SELECT 207 --Bullfighting
	UNION ALL SELECT 50 --IMBC Cricket
	UNION ALL SELECT 206 --Cockfighting

	SET @SportTypeListXML = (
		SELECT c.Sporttype
		FROM  #SportTypeList c
		FOR XML PATH('SportType') ,ROOT('SportTypeList') ) 

	INSERT INTO #Supers(custid)
	SELECT ci.custid 
	FROM dbo.customer ci WITH (NOLOCK) 
	WHERE ci.roleid = 4
		AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND ci.CustID IN (
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustPTSetting3rd_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustPTSetting3rd_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustPTGroupSetting3rd_Member t WITH(NOLOCK) ON t.AgentID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustBetSetting3rd_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustBetSetting3rd_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustDiscount3rd_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustDiscount3rd_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustWinLossLimit_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustWinLossLimit_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustStakeLevel_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustStakeLevel_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
						)

	-- For deployer info
	DECLARE @super_cnt INT, @index INT = 0
	DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
	DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

	SET @super_cnt = (SELECT COUNT(*) FROM #supers )
	RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		UPDATE TOP (1) #Supers
		SET isfinished = 1
			,@srecommend = custid	
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_DynamicCustSetting3rd_09 
				 @srecommend = @srecommend
				,@target = 'REPLICATED'
				,@SportTypeListXML = @SportTypeListXML
						
		--WAITFOR DELAY '00:00:0.100'
	END

	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DROP TABLE #Supers
	DROP TABLE #SportTypeList
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------

BEGIN
	DECLARE @srecommend INT
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isfinished bit default(0))
	CREATE TABLE #SportTypeList (Sporttype SMALLINT PRIMARY KEY)
	DECLARE @SportTypeListXML XML 

	INSERT INTO #SportTypeList(Sporttype)
	SELECT 160 --Lucky 3
	UNION ALL SELECT 163 -- Poker Games
	UNION ALL SELECT 207 --Bullfighting
	UNION ALL SELECT 50 --IMBC Cricket
	UNION ALL SELECT 206 --Cockfighting

	SET @SportTypeListXML = (
		SELECT c.Sporttype
		FROM  #SportTypeList c
		FOR XML PATH('SportType') ,ROOT('SportTypeList') ) 

	INSERT INTO #Supers(custid)
	SELECT ci.custid 
	FROM dbo.customer ci WITH (NOLOCK) 
	WHERE ci.roleid = 4
		AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND ci.CustID IN (
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustPTSetting3rd_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustPTSetting3rd_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustPTGroupSetting3rd_Member t WITH(NOLOCK) ON t.AgentID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustBetSetting3rd_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustBetSetting3rd_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustDiscount3rd_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustDiscount3rd_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustWinLossLimit_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustWinLossLimit_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustStakeLevel_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN CustStakeLevel_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
						)

	-- For deployer info
	DECLARE @super_cnt INT, @index INT = 0
	DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
	DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

	SET @super_cnt = (SELECT COUNT(*) FROM #supers )
	RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		UPDATE TOP (1) #Supers
		SET isfinished = 1
			,@srecommend = custid	
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_DynamicCustSetting3rd_09 
				 @srecommend = @srecommend
				,@target = 'DBCUST'
				,@SportTypeListXML = @SportTypeListXML
						
		--WAITFOR DELAY '00:00:0.100'
	END

	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DROP TABLE #Supers
	DROP TABLE #SportTypeList
END
GO
