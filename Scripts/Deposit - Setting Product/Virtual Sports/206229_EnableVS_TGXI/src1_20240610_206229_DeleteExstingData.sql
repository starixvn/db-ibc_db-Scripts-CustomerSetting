/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240607@Winfred
	DB: DBCUST/CustDB
	Task:  [TGXI] - Enable VS product [RedmineID: #206229] 
	Revisions:
		- 20240607@Winfred: [TGXI] - Enable VS product For TGXI [RedmineID: #206229] 
*/
-- Remove Data product VS For TGXI
--===================================================================================
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	@target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only

	IF (dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0

		OR dbo.f_CheckRepTable('Customer') = 0 
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0 	

		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 	
		)
		RETURN

	DECLARE @SportType SMALLINT, @BetType SMALLINT , @srecommend INT
	SET @SportType = 9908
	SET @BetType = 1201
	SET @srecommend = 52761582

	DECLARE @BatchNum INT = 5000 
	
	CREATE TABLE #CustPTSetting3rd_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTSetting3rd_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTGroupSetting3rd_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))

	CREATE TABLE #CustBetSetting_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #CustBetSetting_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))

	CREATE TABLE #Dep_CustDiscountSetting_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustDiscountGroupSetting_Member(AgentID INT,Sporttype INT,Bettype INT, PRIMARY KEY(AgentID ,Sporttype ,Bettype ))

	--PT
	INSERT INTO #CustPTSetting3rd_Agent(CustID,Sporttype,Bettype,IsLive)
	SELECT s.Custid,SportType,BetType,IsLive 
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType AND c.srecommend = @srecommend

	INSERT INTO #CustPTSetting3rd_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.CustID,Sporttype,Bettype,IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType AND c.srecommend = @srecommend

	INSERT INTO #CustPTGroupSetting3rd_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT AgentID,SportType,BetType,IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType AND c.srecommend = @srecommend
	
	CREATE TABLE #CustTempBatch_PT (CustID INT,Sporttype INT,Bettype INT,IsLive BIT)

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustPTSetting3rd_Agent 
		OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive INTO #CustTempBatch_PT(CustID, Sporttype, Bettype, IsLive)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch_PT ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype AND cg.IsLive = ci.IsLive
	
		TRUNCATE TABLE #CustTempBatch_PT
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustPTGroupSetting3rd_Member 
		OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive INTO #CustTempBatch_PT(CustID, Sporttype, Bettype, IsLive)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch_PT ci ON ci.custid = cg.AgentID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype AND cg.IsLive = ci.IsLive

		TRUNCATE TABLE #CustTempBatch_PT
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustPTSetting3rd_Member 
		OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype, DELETED.IsLive INTO #CustTempBatch_PT(CustID, Sporttype, Bettype, IsLive)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch_PT ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype AND cg.IsLive = ci.IsLive

		TRUNCATE TABLE #CustTempBatch_PT
	END
	
	--Bet Setting
	INSERT INTO #CustBetSetting_Agent(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType AND c.srecommend = @srecommend

	INSERT INTO #CustBetSetting_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType AND c.srecommend = @srecommend
	
	CREATE TABLE #CustTempBatch_BetLimit (CustID INT,Sporttype INT,Bettype INT)

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustBetSetting_Agent 
		OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype INTO #CustTempBatch_BetLimit(CustID, Sporttype, Bettype)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch_BetLimit ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype

		TRUNCATE TABLE #CustTempBatch_BetLimit
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #CustBetSetting_Member 
		OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype INTO #CustTempBatch_BetLimit(CustID, Sporttype, Bettype)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch_BetLimit ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype

		TRUNCATE TABLE #CustTempBatch_BetLimit
	END
	
	--Comm
	
	INSERT INTO #Dep_CustDiscountSetting_Member(CustID,Sporttype,Bettype)
	SELECT DISTINCT s.Custid,SportType,BetType
	FROM Dep_CustDiscountSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType AND c.srecommend = @srecommend

	INSERT INTO #Dep_CustDiscountGroupSetting_Member(AgentID,Sporttype,Bettype)
	SELECT DISTINCT s.AgentID,Sporttype,Bettype
	FROM Dep_CustDiscountGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType AND c.srecommend = @srecommend
	
	CREATE TABLE #CustTempBatch_Comm (CustID INT,Sporttype INT,Bettype INT)
	
	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustDiscountSetting_Member 
		OUTPUT DELETED.CustID, DELETED.Sporttype, DELETED.Bettype INTO #CustTempBatch_Comm(CustID, Sporttype, Bettype)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch_Comm ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype

		TRUNCATE TABLE #CustTempBatch_Comm
	END

	WHILE 1 = 1
	BEGIN
		DELETE TOP (@BatchNum) #Dep_CustDiscountGroupSetting_Member 
		OUTPUT DELETED.AgentID, DELETED.Sporttype, DELETED.Bettype INTO #CustTempBatch_Comm(CustID, Sporttype, Bettype)

		IF @@ROWCOUNT = 0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustTempBatch_Comm ci ON ci.custid = cg.AgentID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype

		TRUNCATE TABLE #CustTempBatch_Comm
	END

	DROP TABLE #CustPTSetting3rd_Agent
	DROP TABLE #CustPTSetting3rd_Member
	DROP TABLE #CustPTGroupSetting3rd_Member
	DROP TABLE #CustTempBatch_PT

	DROP TABLE #CustBetSetting_Agent
	DROP TABLE #CustBetSetting_Member
	DROP TABLE #CustTempBatch_BetLimit

	DROP TABLE #Dep_CustDiscountSetting_Member
	DROP TABLE #Dep_CustDiscountGroupSetting_Member
	DROP TABLE #CustTempBatch_Comm
END
GO
-- END STEP 4.1: DEPLOY THIS SP @ DBCUST.CustDB -------
------------------------------------------------------	

-- BEGIN STEP 4.2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
EXEC Acc_Dep_DynamicCustSetting_09 @target = @target
PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
--------------------------------------------------------------------------------------