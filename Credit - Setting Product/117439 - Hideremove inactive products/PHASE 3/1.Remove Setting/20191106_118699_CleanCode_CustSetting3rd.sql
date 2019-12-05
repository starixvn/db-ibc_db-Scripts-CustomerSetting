/*
	Created: Eden
	Date: 2019/10/09
	Task: Delete existing settings for Racing, Virtual Sport, Financials
	DB: DBCUST/CUSTDB
*/	
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@IsLicensee BIT,
	@target VARCHAR(20),
	@SportTypeBetTypeListXML XML
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
				
	IF dbo.f_CheckRepTable('CustSetting3rd') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSetting3rd') = 0 RETURN
	IF dbo.f_CheckRepTable('custOverride3rd') = 0 RETURN

	DECLARE @SportbettypeRowcount INT

	--DROP TABLE #SportTypeBetType
	CREATE TABLE #SportTypeBetType (Sporttype SMALLINT ,BetType SMALLINT)
	INSERT INTO #SportTypeBetType(Sporttype, BetType)
	SELECT Data.value('(Sporttype/text())[1]','smallint') as Sporttype
		  ,Data.value('(BetType/text())[1]','smallint') as BetType
	FROM @SportTypeBetTypeListXML.nodes('SportTypeBetTypeList/SportTypeBetType') Node(Data)

	SET @SportbettypeRowcount = @@ROWCOUNT

	CREATE TABLE #Tempcustsetting (CustID INT)
	CREATE TABLE #TempCust(CustID INT)

	INSERT INTO  #TempCust(CustID)
	SELECT c.custid
	FROM Custinfo c WITH (NOLOCK)
	WHERE c.srecommend = @srecommend

	DECLARE @Batch INT 
	SET @Batch = 5000/@SportbettypeRowcount

	WHILE(1=1)
	BEGIN
		TRUNCATE TABLE #Tempcustsetting

		DELETE TOP (@Batch) a
		OUTPUT deleted.CustID INTO #Tempcustsetting(CustID)
		FROM #TempCust a
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		DELETE a
		FROM custOverride3rd a WITH(UPDLOCK,ROWLOCK) 
			INNER JOIN #Tempcustsetting temp ON a.CustId = temp.CustID 
			INNER JOIN #SportTypeBetType s ON  a.sporttype = s.Sporttype AND s.BetType = s.BetType

		IF @IsLicensee = 0
		BEGIN
			DELETE a
			FROM CustSetting3rd a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #Tempcustsetting temp ON a.CustId = temp.CustID 
				INNER JOIN #SportTypeBetType s ON  a.sporttype = s.Sporttype AND s.BetType = s.BetType
	
		END
		ELSE
		BEGIN
			DELETE a
			FROM Dep_CustSetting3rd a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #Tempcustsetting temp ON a.CustId = temp.CustID 
				INNER JOIN #SportTypeBetType s ON  a.sporttype = s.Sporttype AND s.BetType = s.BetType
		END
	END

	DROP TABLE #SportTypeBetType
	DROP TABLE #Tempcustsetting
	DROP TABLE #TempCust
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
BEGIN
	DECLARE @srecommend INT,@isLicensee BIT
	DECLARE @SportTypeBetTypeListXML XML 
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isLicensee BIT,isfinished bit default(0))
	CREATE TABLE #SportTypeBetType (Sporttype SMALLINT ,BetType SMALLINT)
	CREATE TABLE #SportTypeList (Sporttype SMALLINT PRIMARY KEY)

	INSERT INTO #SportTypeList(Sporttype)
	SELECT 151 -- Racing
	UNION ALL SELECT 152 --
	UNION ALL SELECT 153 --
	UNION ALL SELECT 180 --Virtual Sport
	UNION ALL SELECT 181 --
	UNION ALL SELECT 182 --
	UNION ALL SELECT 183 --
	UNION ALL SELECT 184 --
	UNION ALL SELECT 185 --
	UNION ALL SELECT 186 --
	UNION ALL SELECT 187 --
	UNION ALL SELECT 201 --Financials


	INSERT INTO #SportTypeBetType(Sporttype, BetType)
	SELECT b.Sporttype,a.bettype
	FROM DBPRO.bodb02.dbo.SportBettypeMatrix a WITH(NOLOCK)
		 INNER JOIN #SportTypeList b 
			ON a.Sporttype = b.Sporttype

	INSERT INTO #SportTypeBetType (sporttype, bettype) 
	VALUES (151,41), (151,42), (151,51), (151,52), (152, 41), (152,42), (152,51), (152,52), (153,51), (153,52), (201,2), (201,3)

	SET @SportTypeBetTypeListXML = (
			SELECT c.Sporttype,c.BetType
			FROM  #SportTypeBetType c
			FOR XML PATH('SportTypeBetType') ,ROOT('SportTypeBetTypeList') ) 

	INSERT INTO #Supers(custid,isLicensee)
	SELECT ci.custid, s.isLicensee
	FROM dbo.customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH(NOLOCK) ON s.site = ci.site
	WHERE ci.roleid = 4
		AND ci.custid IN ( SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN CustSetting3rd ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN Dep_CustSetting3rd ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN custOverride3rd ac WITH(NOLOCK) ON ci.CustID = ac.CustId
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
			,@isLicensee = isLicensee
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_CustSetting3rd_19 
				 @srecommend = @srecommend
				,@isLicensee = @isLicensee
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
	DECLARE @srecommend INT,@isLicensee BIT
	DECLARE @SportTypeBetTypeListXML XML 
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isLicensee BIT,isfinished bit default(0))
	CREATE TABLE #SportTypeBetType (Sporttype SMALLINT ,BetType SMALLINT)
	CREATE TABLE #SportTypeList (Sporttype SMALLINT PRIMARY KEY)

	INSERT INTO #SportTypeList(Sporttype)
	SELECT 151 -- Racing
	UNION ALL SELECT 152 --
	UNION ALL SELECT 153 --
	UNION ALL SELECT 180 --Virtual Sport
	UNION ALL SELECT 181 --
	UNION ALL SELECT 182 --
	UNION ALL SELECT 183 --
	UNION ALL SELECT 184 --
	UNION ALL SELECT 185 --
	UNION ALL SELECT 186 --
	UNION ALL SELECT 187 --
	UNION ALL SELECT 201 --Financials


	INSERT INTO #SportTypeBetType(Sporttype, BetType)
	SELECT b.Sporttype,a.bettype
	FROM DBPRO.bodb02.dbo.SportBettypeMatrix a WITH(NOLOCK)
		 INNER JOIN #SportTypeList b 
			ON a.Sporttype = b.Sporttype

	INSERT INTO #SportTypeBetType (sporttype, bettype) 
	VALUES (151,41), (151,42), (151,51), (151,52), (152, 41), (152,42), (152,51), (152,52), (153,51), (153,52), (201,2), (201,3)

	SET @SportTypeBetTypeListXML = (
			SELECT c.Sporttype,c.BetType
			FROM  #SportTypeBetType c
			FOR XML PATH('SportTypeBetType') ,ROOT('SportTypeBetTypeList') ) 

	INSERT INTO #Supers(custid,isLicensee)
	SELECT ci.custid, s.isLicensee
	FROM dbo.customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH(NOLOCK) ON s.site = ci.site
	WHERE ci.roleid = 4
		AND ci.custid IN ( SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN CustSetting3rd ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN Dep_CustSetting3rd ac WITH(NOLOCK) ON ci.CustID = ac.CustId
								INNER JOIN #SportTypeBetType c ON ac.bettype = c.BetType AND ac.sporttype = c.Sporttype
						   UNION ALL		
						   SELECT srecommend 
						   FROM custinfo ci WITH(NOLOCK) 
								INNER JOIN custOverride3rd ac WITH(NOLOCK) ON ci.CustID = ac.CustId
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
			,@isLicensee = isLicensee
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_CustSetting3rd_19 
				 @srecommend = @srecommend
				,@isLicensee = @isLicensee
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