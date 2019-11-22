/*
	Created: Eden
	Date: 2019/10/09
	Task: Delete existing settings for Microgame (LC & RNG), SLI Live Casino
	DB: DBCUST/CUSTDB
*/	
ALTER PROCEDURE [dbo].[Acc_CustSetting_18]
	@srecommend INT, 
	@target VARCHAR(20),
	@SportTypeBetTypeListXML XML
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
				
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingGame') = 0 RETURN
	IF dbo.f_CheckRepTable('CustOverrideGame') = 0 RETURN

	--DROP TABLE #SportTypeBetType
	CREATE TABLE #SportTypeBetType (Sporttype SMALLINT ,BetType SMALLINT)
	INSERT INTO #SportTypeBetType(Sporttype, BetType)
	SELECT Data.value('(Sporttype/text())[1]','smallint') as Sporttype
		  ,Data.value('(BetType/text())[1]','smallint') as BetType
	FROM @SportTypeBetTypeListXML.nodes('SportTypeBetTypeList/SportTypeBetType') Node(Data)

	CREATE TABLE #CustSettingGame (CustID INT, Sporttype SMALLINT, Bettype SMALLINT, PRIMARY KEY(CustID,Bettype,SportType))
	CREATE TABLE #Dep_CustSettingGame (CustID INT, Sporttype SMALLINT, Bettype SMALLINT, PRIMARY KEY(CustID,Bettype,SportType))
	CREATE TABLE #CustOverrideGame (CustID INT, Sporttype SMALLINT, Bettype SMALLINT, PRIMARY KEY(CustID,Bettype,SportType))


	CREATE TABLE #TempCust(CustID INT PRIMARY KEY)

	INSERT INTO  #TempCust(CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend

	DECLARE @Rowcount1 INT = 1
	DECLARE @Rowcount2 INT = 1
	DECLARE @Rowcount3 INT = 1
	DECLARE @Batch INT = 5000

	WHILE(1=1)
	BEGIN
		TRUNCATE TABLE #CustSettingGame
		TRUNCATE TABLE #Dep_CustSettingGame
		TRUNCATE TABLE #CustOverrideGame

		IF @RowCount1 > 0
			INSERT INTO #CustSettingGame(CustID,Sporttype,Bettype)
			SELECT TOP (@Batch) ac.CustID,ac.Sporttype,ac.Bettype
			FROM CustSettingGame ac WITH(NOLOCK) 
				INNER JOIN #TempCust tmp ON tmp.CustID = ac.CustId
				INNER JOIN #SportTypeBetType s ON ac.SportType = s.Sporttype	AND ac.bettype = s.BetType

		SELECT @Rowcount1 = @@ROWCOUNT

		IF @RowCount2 > 0
			INSERT INTO #Dep_CustSettingGame(CustID,Sporttype,Bettype)
			SELECT TOP (@Batch) ac.CustID,ac.Sporttype,ac.Bettype
			FROM Dep_CustSettingGame ac WITH(NOLOCK) 
				INNER JOIN #TempCust tmp ON tmp.CustID = ac.CustId
				INNER JOIN #SportTypeBetType s ON ac.SportType = s.Sporttype	AND ac.bettype = s.BetType

		SELECT @Rowcount2 = @@ROWCOUNT

		IF @RowCount3 > 0
			INSERT INTO #CustOverrideGame(CustID,Sporttype,Bettype)
			SELECT TOP (@Batch) ac.CustID,ac.Sporttype,ac.Bettype
			FROM CustOverrideGame ac WITH(NOLOCK) 
				INNER JOIN #TempCust tmp ON tmp.CustID = ac.CustId
				INNER JOIN #SportTypeBetType s ON ac.SportType = s.Sporttype	AND ac.bettype = s.BetType

		SELECT @Rowcount3 = @@ROWCOUNT

		IF @Rowcount1 = 0 AND  @Rowcount2 = 0 AND  @Rowcount3 = 0
			BREAK;
		
		IF @RowCount1 > 0
			DELETE a
			FROM CustSettingGame a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #CustSettingGame temp 
					ON a.CustId = temp.CustID 
					AND a.Sporttype = temp.Sporttype
					AND a.Bettype = temp.Bettype
		
		IF @RowCount2 > 0
			DELETE a
			FROM Dep_CustSettingGame a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #Dep_CustSettingGame temp 
					ON a.CustId = temp.CustID 
					AND a.Sporttype = temp.Sporttype
					AND a.Bettype = temp.Bettype

		IF @RowCount3 > 0
			DELETE a
			FROM CustOverrideGame a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #CustOverrideGame temp 
					ON a.CustId = temp.CustID 
					AND a.Sporttype = temp.Sporttype
					AND a.Bettype = temp.Bettype
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
BEGIN
	DECLARE @srecommend INT
	DECLARE @SportTypeBetTypeListXML XML 
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isfinished bit default(0))
	CREATE TABLE #SportTypeBetType (Sporttype SMALLINT ,BetType SMALLINT)
	CREATE TABLE #SportTypeList (Sporttype SMALLINT PRIMARY KEY)

	INSERT INTO #SportTypeList(Sporttype)
	SELECT 203 --Microgame LC
	UNION ALL SELECT 205 --Microgame RNG
	UNION ALL SELECT 162 --SLI Live Casino

	INSERT INTO #SportTypeBetType(Sporttype, BetType)
	SELECT b.Sporttype,a.bettype
	FROM DBPRO.bodb02.dbo.SportBettypeMatrix a WITH(NOLOCK)
		 INNER JOIN #SportTypeList b 
			ON a.Sporttype = b.Sporttype

	SET @SportTypeBetTypeListXML = (
			SELECT c.Sporttype,c.BetType
			FROM  #SportTypeBetType c
			FOR XML PATH('SportTypeBetType') ,ROOT('SportTypeBetTypeList') ) 

	INSERT INTO #Supers(custid)
	SELECT ci.custid 
	FROM dbo.customer ci WITH (NOLOCK) 
	WHERE ci.roleid = 4
		AND ci.custid IN ( SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN CustSettingGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN Dep_CustSettingGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN CustOverrideGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
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

		EXEC dbo.Acc_CustSetting_18 
				 @srecommend = @srecommend
				,@target = 'REPLICATED'
				,@SportTypeBetTypeListXML = @SportTypeBetTypeListXML
						
		WAITFOR DELAY '00:00:0.100'
	END

	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DROP TABLE #Supers
	DROP TABLE #SportTypeBetType
	DROP TABLE #SportTypeList
END
GO

								

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
BEGIN
	DECLARE @srecommend INT
	DECLARE @SportTypeBetTypeListXML XML 
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isfinished bit default(0))
	CREATE TABLE #SportTypeBetType (Sporttype SMALLINT ,BetType SMALLINT)
	CREATE TABLE #SportTypeList (Sporttype SMALLINT PRIMARY KEY)

	INSERT INTO #SportTypeList(Sporttype)
	SELECT 203 --Microgame LC
	UNION ALL SELECT 205 --Microgame RNG
	UNION ALL SELECT 162 --SLI Live Casino

	INSERT INTO #SportTypeBetType(Sporttype, BetType)
	SELECT b.Sporttype,a.bettype
	FROM DBPRO.bodb02.dbo.SportBettypeMatrix a WITH(NOLOCK)
		 INNER JOIN #SportTypeList b 
			ON a.Sporttype = b.Sporttype

	SET @SportTypeBetTypeListXML = (
			SELECT c.Sporttype,c.BetType
			FROM  #SportTypeBetType c
			FOR XML PATH('SportTypeBetType') ,ROOT('SportTypeBetTypeList') ) 

	INSERT INTO #Supers(custid)
	SELECT ci.custid 
	FROM dbo.customer ci WITH (NOLOCK) 
	WHERE ci.roleid = 4
		AND ci.custid IN ( SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN CustSettingGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN Dep_CustSettingGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN CustOverrideGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
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

		EXEC dbo.Acc_CustSetting_18 
				 @srecommend = @srecommend
				,@target = 'DBCUST'
				,@SportTypeBetTypeListXML = @SportTypeBetTypeListXML
						
		WAITFOR DELAY '00:00:0.100'
	END

	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DROP TABLE #Supers
	DROP TABLE #SportTypeBetType
	DROP TABLE #SportTypeList
END
GO
				
----------------------------------------------------------------
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----