/*
	Created: Eden
	Date: 2019/11/11
	Task: Delete existing settings for Lucky 3, Poker Games, Bullfighting, IMBC Cricket, Cockfighting (DEPOSIT)
	DB: DBCUST/CUSTDB
*/	
--------------------------------------------------------------------------------------
-- BEGIN STEP 1
--------------------------------------------------------------------------------------
ALTER  PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20),
	@srecommend INT,
	@SportTypeListXML XML
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('DEP_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('DEP_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('DEP_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('DEP_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('DEP_CustStakeLevel_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN				
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN		

	CREATE TABLE #Sporttype (Sporttype SMALLINT PRIMARY KEY)
	INSERT INTO #Sporttype (Sporttype)
	SELECT Data.value('(Sporttype/text())[1]','smallint') as Sporttype
	FROM @SportTypeListXML.nodes('SportTypeList/SportType') Node(Data)

	CREATE TABLE #TempCust(CustID INT PRIMARY KEY)

	INSERT INTO  #TempCust(CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend

	CREATE TABLE #DEP_CustPTSetting_Agent		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #DEP_CustPTSetting_Member		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #DEP_CustPTGroupSetting_Member	(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #DEP_CustStakeLevel_Agent		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #DEP_CustStakeLevel_Member		(CustID INT, Sporttype SMALLINT)
	CREATE TABLE #Dep_LicenseeProductSetting    (CustID INT, ProductSettingID INT)

	DECLARE @RowCount1 INT = 1
	DECLARE @RowCount2 INT = 1
	DECLARE @RowCount3 INT = 1
	DECLARE @RowCount4 INT = 1
	DECLARE @RowCount5 INT = 1
	DECLARE @RowCount6 INT = 1
	DECLARE @Batch INT = 5000

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #DEP_CustPTSetting_Agent		
		TRUNCATE TABLE #DEP_CustPTSetting_Member		
		TRUNCATE TABLE #DEP_CustPTGroupSetting_Member	
		TRUNCATE TABLE #DEP_CustStakeLevel_Agent
		TRUNCATE TABLE #DEP_CustStakeLevel_Member
			

		IF @RowCount1 > 0
			INSERT INTO #DEP_CustPTSetting_Agent(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM DEP_CustPTSetting_Agent cg  WITH(NOLOCK)	
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID
		
		SET @RowCount1 = @@ROWCOUNT
						
		IF @RowCount2 > 0
			INSERT INTO #DEP_CustPTSetting_Member(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM DEP_CustPTSetting_Member cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID

		SET @RowCount2 = @@ROWCOUNT
		
		IF @RowCount3 > 0
			INSERT INTO #DEP_CustPTGroupSetting_Member(CustID, Sporttype)
			SELECT TOP (@Batch) cg.AgentID,cg.SportType
			FROM DEP_CustPTGroupSetting_Member cg  WITH(NOLOCK)	
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.AgentID  = tmp.CustID

		SET @RowCount3 = @@ROWCOUNT

		IF @RowCount4 > 0
			INSERT INTO #DEP_CustStakeLevel_Agent(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM DEP_CustStakeLevel_Agent cg  WITH(NOLOCK)	
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID
		
		SET @RowCount4 = @@ROWCOUNT
						
		IF @RowCount5 > 0
			INSERT INTO #DEP_CustStakeLevel_Member(CustID, Sporttype)
			SELECT TOP (@Batch) cg.CustID,cg.SportType
			FROM DEP_CustStakeLevel_Member cg  WITH(NOLOCK)		
				INNER JOIN #Sporttype s ON cg.SportType = s.Sporttype	
				INNER JOIN #TempCust tmp ON cg.CustID  = tmp.CustID

		SET @RowCount5 = @@ROWCOUNT

		IF @RowCount6 > 0
		INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT d.CustID
			  ,d.ProductSettingID
		FROM Dep_LicenseeProductSetting d WITH(NOLOCK) 
			INNER JOIN Dep_ProductSettingDetail dps WITH(NOLOCK) ON dps.ProductSettingID = d.ProductSettingID 
			INNER JOIN #Sporttype s ON dps.SportType = s.Sporttype	
		WHERE d.CustID = @srecommend

		SET @RowCount6 = @@ROWCOUNT

		IF (@RowCount1 = 0 AND @RowCount2 = 0 AND @RowCount3 = 0 AND @RowCount4 = 0 AND @RowCount5 = 0 AND @RowCount6 = 0)
			BREAK;

		--> DELETE DATA
		--> PT
		IF @RowCount1 > 0
			DELETE cg
			FROM DEP_CustPTSetting_Agent cg WITH(UPDLOCK,ROWLOCK)
				INNER JOIN #DEP_CustPTSetting_Agent c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType
						
		IF @RowCount2 > 0
			DELETE cg
			FROM DEP_CustPTSetting_Member cg WITH(UPDLOCK,ROWLOCK)	
				INNER JOIN #DEP_CustPTSetting_Member c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType
		
		IF @RowCount3 > 0
			DELETE cg
			FROM DEP_CustPTGroupSetting_Member cg WITH(UPDLOCK,ROWLOCK)	
				INNER JOIN #DEP_CustPTGroupSetting_Member c 
					ON c.CustID = cg.AgentID
					AND c.Sporttype = cg.SportType

		--> StakeLevel
		IF @RowCount4 > 0
			DELETE cg
			FROM dbo.DEP_CustStakeLevel_Agent cg WITH(UPDLOCK,ROWLOCK)
				INNER JOIN #DEP_CustStakeLevel_Agent c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType

		IF @RowCount5 > 0
			DELETE cg
			FROM dbo.DEP_CustStakeLevel_Member cg WITH(UPDLOCK,ROWLOCK)		
				INNER JOIN #DEP_CustStakeLevel_Member c 
					ON c.CustID = cg.CustID
					AND c.Sporttype = cg.SportType

		IF @RowCount6 > 0
			DELETE cg
			FROM dbo.Dep_LicenseeProductSetting cg WITH(UPDLOCK,ROWLOCK)		
				INNER JOIN #Dep_LicenseeProductSetting c 
					ON c.CustID = cg.CustID
					AND c.ProductSettingID = cg.ProductSettingID

		WAITFOR DELAY '00:00:00.100'

	END

	DROP TABLE #Sporttype	
	DROP TABLE #DEP_CustPTSetting_Agent		
	DROP TABLE #DEP_CustPTSetting_Member		
	DROP TABLE #DEP_CustPTGroupSetting_Member		
	DROP TABLE #DEP_CustStakeLevel_Agent
	DROP TABLE #DEP_CustStakeLevel_Member
	DROP TABLE #Dep_LicenseeProductSetting
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
		AND ci.custid IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND ci.CustID IN (
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustPTSetting_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustPTSetting_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustPTGroupSetting_Member t WITH(NOLOCK) ON t.AgentID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustStakeLevel_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustStakeLevel_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN Dep_LicenseeProductSetting t WITH(NOLOCK) ON t.CustID = c.custid 
								INNER JOIN Dep_ProductSettingDetail dps WITH(NOLOCK) ON dps.ProductSettingID = t.ProductSettingID AND dps.SportType IN (SELECT Sporttype FROM #SportTypeList)
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

		EXEC dbo.Acc_Dep_DynamicCustSetting_09 
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
		AND ci.custid IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND ci.CustID IN (
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustPTSetting_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustPTSetting_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustPTGroupSetting_Member t WITH(NOLOCK) ON t.AgentID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustStakeLevel_Agent t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN DEP_CustStakeLevel_Member t WITH(NOLOCK) ON t.CustID = c.custid AND t.SportType IN (SELECT Sporttype FROM #SportTypeList)
							UNION ALL
							SELECT srecommend 
							FROM custinfo c WITH(NOLOCK) 
								INNER JOIN Dep_LicenseeProductSetting t WITH(NOLOCK) ON t.CustID = c.custid 
								INNER JOIN Dep_ProductSettingDetail dps WITH(NOLOCK) ON dps.ProductSettingID = t.ProductSettingID AND dps.SportType IN (SELECT Sporttype FROM #SportTypeList)
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

		EXEC dbo.Acc_Dep_DynamicCustSetting_09 
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