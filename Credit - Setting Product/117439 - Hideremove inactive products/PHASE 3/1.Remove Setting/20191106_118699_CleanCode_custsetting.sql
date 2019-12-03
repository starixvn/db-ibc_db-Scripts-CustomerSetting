/*
	Created: Eden
	Date: 2019/10/09
	Task: Delete existing settings for Horse racing Fixed Odds, MuayThai
	DB: DBCUST/CUSTDB
*/	
ALTER PROCEDURE [dbo].[Acc_custsetting_19]
	@srecommend INT, 
	@IsLicensee BIT,
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

	CREATE TABLE #Tempcustsetting (CustID INT, Sporttype SMALLINT, Bettype SMALLINT)
	CREATE TABLE #TempCust(CustID INT, Sporttype SMALLINT, Bettype SMALLINT)

	INSERT INTO  #TempCust(CustID,Bettype,Sporttype)
	SELECT c.custid,t.BetType,t.Sporttype
	FROM Custinfo c WITH (NOLOCK)
		 CROSS APPLY #SportTypeBetType t
	WHERE c.srecommend = @srecommend

	DECLARE @Batch INT = 5000

	WHILE(1=1)
	BEGIN
		TRUNCATE TABLE #Tempcustsetting

		DELETE TOP (@Batch) a
		OUTPUT deleted.CustID,deleted.Bettype,deleted.Sporttype INTO #Tempcustsetting(CustID,Bettype,Sporttype)
		FROM #TempCust a

		IF @@ROWCOUNT = 0
			BREAK;
		
		DELETE a
		FROM custoverride a WITH(UPDLOCK,ROWLOCK) 
				INNER JOIN #Tempcustsetting temp 
				ON a.CustId = temp.CustID 
				AND a.Sporttype = temp.Sporttype
				AND a.Bettype = temp.Bettype

		IF @IsLicensee = 0
		BEGIN
			DELETE a
			FROM custsetting a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #Tempcustsetting temp 
					ON a.CustId = temp.CustID 
					AND a.Sporttype = temp.Sporttype
					AND a.Bettype = temp.Bettype

		END
		ELSE
		BEGIN
			DELETE a
			FROM DEP_custsetting a WITH(UPDLOCK,ROWLOCK) 
				 INNER JOIN #Tempcustsetting temp 
					ON a.CustId = temp.CustID 
					AND a.Sporttype = temp.Sporttype
					AND a.Bettype = temp.Bettype
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

	INSERT INTO #Supers(custid,isLicensee)
	SELECT ci.custid, s.isLicensee
	FROM dbo.customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH(NOLOCK) ON ci.site = ci.site
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
			,@isLicensee = isLicensee
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_custsetting_19 
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

	INSERT INTO #Supers(custid,isLicensee)
	SELECT ci.custid, s.isLicensee
	FROM dbo.customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH(NOLOCK) ON ci.site = ci.site
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
			,@isLicensee = isLicensee
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_custsetting_19 
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