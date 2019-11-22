/*
	Created: Eden
	Date: 2019/10/09
	Task: Delete existing settings for Horse racing Fixed Odds, MuayThai
	DB: DBCUST/CUSTDB
*/	
ALTER PROCEDURE [dbo].[Acc_custsetting_19]
	@srecommend INT, 
	@target VARCHAR(20),
	@SportTypeBetTypeListXML XML
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
				
	IF dbo.f_CheckRepTable('custsetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custoverride') = 0 RETURN
	IF dbo.f_CheckRepTable('DEP_custsetting') = 0 RETURN

	--DROP TABLE #SportTypeBetType
	CREATE TABLE #SportTypeBetType (Sporttype SMALLINT ,BetType SMALLINT)
	INSERT INTO #SportTypeBetType(Sporttype, BetType)
	SELECT Data.value('(Sporttype/text())[1]','smallint') as Sporttype
		  ,Data.value('(BetType/text())[1]','smallint') as BetType
	FROM @SportTypeBetTypeListXML.nodes('SportTypeBetTypeList/SportTypeBetType') Node(Data)

	CREATE TABLE #custsetting (CustID INT, Sporttype SMALLINT, Bettype SMALLINT, PRIMARY KEY(CustID,Bettype,SportType))
	CREATE TABLE #custoverride (CustID INT, Sporttype SMALLINT, Bettype SMALLINT, PRIMARY KEY(CustID,Bettype,SportType))
	CREATE TABLE #DEP_custsetting (CustID INT, Sporttype SMALLINT, Bettype SMALLINT, PRIMARY KEY(CustID,Bettype,SportType))

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
		TRUNCATE TABLE #custsetting
		TRUNCATE TABLE #custoverride
		TRUNCATE TABLE #DEP_custsetting

		IF @RowCount1 > 0
			INSERT INTO #custsetting(CustID,Sporttype,Bettype)
			SELECT TOP (@Batch) ac.CustID,ac.Sporttype,ac.Bettype
			FROM custsetting ac WITH(NOLOCK) 
				INNER JOIN #TempCust tmp ON tmp.CustID = ac.CustId
				INNER JOIN #SportTypeBetType s ON ac.SportType = s.Sporttype	AND ac.bettype = s.BetType

		SELECT @Rowcount1 = @@ROWCOUNT

		IF @RowCount2 > 0
			INSERT INTO #custoverride(CustID,Sporttype,Bettype)
			SELECT TOP (@Batch) ac.CustID,ac.Sporttype,ac.Bettype
			FROM custoverride ac WITH(NOLOCK) 
				INNER JOIN #TempCust tmp ON tmp.CustID = ac.CustId
				INNER JOIN #SportTypeBetType s ON ac.SportType = s.Sporttype	AND ac.bettype = s.BetType

		SELECT @Rowcount2 = @@ROWCOUNT

		IF @RowCount3 > 0
			INSERT INTO #DEP_custsetting(CustID,Sporttype,Bettype)
			SELECT TOP (@Batch) ac.CustID,ac.Sporttype,ac.Bettype
			FROM DEP_custsetting ac WITH(NOLOCK) 
				INNER JOIN #TempCust tmp ON tmp.CustID = ac.CustId
				INNER JOIN #SportTypeBetType s ON ac.SportType = s.Sporttype	AND ac.bettype = s.BetType

		SELECT @Rowcount3 = @@ROWCOUNT

		IF @Rowcount1 = 0 AND  @Rowcount2 = 0 AND  @Rowcount3 = 0
			BREAK;
		
		IF @RowCount1 > 0
			DELETE a
			FROM custsetting a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #custsetting temp 
					ON a.CustId = temp.CustID 
					AND a.Sporttype = temp.Sporttype
					AND a.Bettype = temp.Bettype
		
		IF @RowCount2 > 0
			DELETE a
			FROM custoverride a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #custoverride temp 
					ON a.CustId = temp.CustID 
					AND a.Sporttype = temp.Sporttype
					AND a.Bettype = temp.Bettype

		IF @RowCount3 > 0
			DELETE a
			FROM DEP_custsetting a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #DEP_custsetting temp 
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
	SELECT 154 -- Horse racing Fixed Odds
	UNION ALL SELECT 44 --MuayThai

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
								INNER JOIN custsetting ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN custoverride ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN DEP_custsetting ac WITH(NOLOCK) ON ci.CustID = ac.CustId
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

		EXEC dbo.Acc_custsetting_19 
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
	SELECT 154 -- Horse racing Fixed Odds
	UNION ALL SELECT 44 --MuayThai

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
								INNER JOIN custsetting ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN custoverride ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN DEP_custsetting ac WITH(NOLOCK) ON ci.CustID = ac.CustId
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

		EXEC dbo.Acc_custsetting_19 
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