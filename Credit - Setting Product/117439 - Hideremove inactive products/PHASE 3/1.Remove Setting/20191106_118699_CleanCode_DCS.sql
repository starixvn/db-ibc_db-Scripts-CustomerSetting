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
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN			

	DECLARE @SportbettypeRowcount INT

	CREATE TABLE #Sporttype (Sporttype SMALLINT)
	INSERT INTO #Sporttype (Sporttype)
	SELECT Data.value('(Sporttype/text())[1]','smallint') as Sporttype
	FROM @SportTypeListXML.nodes('SportTypeList/SportType') Node(Data)

	SET @SportbettypeRowcount = @@ROWCOUNT

	CREATE TABLE #Tempcustsetting(CustID INT)
	CREATE TABLE #TempCust(CustID INT)

	INSERT INTO  #TempCust(CustID)
	SELECT c.custid
	FROM Custinfo c WITH (NOLOCK)
	WHERE c.srecommend = @srecommend

	DECLARE @Batch INT 
	SET @Batch = 5000/@SportbettypeRowcount

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Tempcustsetting		
		
		DELETE TOP (@Batch) a
		OUTPUT deleted.CustID INTO #Tempcustsetting(CustID)
		FROM #TempCust a	

		IF @@ROWCOUNT = 0
			BREAK;

	--> DELETE DATA
		--> PT
		DELETE cg
		FROM CustPTSetting3rd_Agent cg WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype
						
		DELETE cg
		FROM CustPTSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)	
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype
		
		DELETE cg
		FROM CustPTGroupSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)	
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.AgentID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype
	
		--> Bet Setting			
		DELETE cg
		FROM CustBetSetting3rd_Agent cg WITH(UPDLOCK,ROWLOCK)		
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype

		DELETE cg
		FROM CustBetSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype
	
		--> Commission
		DELETE cg
		FROM dbo.CustDiscount3rd_Agent cg WITH(UPDLOCK,ROWLOCK)	
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype

		DELETE cg
		FROM dbo.CustDiscount3rd_Member cg WITH(UPDLOCK,ROWLOCK)	
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype
	
		--> Win/Loss Limit
		DELETE cg
		FROM dbo.CustWinLossLimit_Agent cg WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype

		DELETE cg
		FROM dbo.CustWinLossLimit_Member cg WITH(UPDLOCK,ROWLOCK)		
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype

		--> StakeLevel
		DELETE cg
		FROM dbo.CustStakeLevel_Agent cg WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype

		DELETE cg
		FROM dbo.CustStakeLevel_Member cg WITH(UPDLOCK,ROWLOCK)		
			INNER JOIN #Tempcustsetting c ON c.CustID = cg.CustID
			INNER JOIN #Sporttype s ON  cg.sporttype = s.Sporttype

	END

	DROP TABLE #Sporttype	
	DROP TABLE #TempCust
	DROP TABLE #Tempcustsetting
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
						
		WAITFOR DELAY '00:00:00.100'
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
						
		WAITFOR DELAY '00:00:0.100'
	END

	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DROP TABLE #Supers
	DROP TABLE #SportTypeList
END
GO
