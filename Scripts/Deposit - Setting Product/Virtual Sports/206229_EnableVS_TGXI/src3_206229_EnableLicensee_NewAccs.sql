/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240607@Winfred
	Task: [TGXI] - Enable VS product for TGXI [Redmine: #206229]
	DB: DBCust/CustDB
	
	P/s : Step 4 Delete redundant and copy new setting newly created customer 
*/

USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
(@maxcustID INT)
AS
BEGIN			
	
	IF (dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0 	

		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 	
		)
		RETURN

	DECLARE @SportType SMALLINT = 9908,@betType SMALLINT = 1201
	DECLARE @bitmapOrder TINYINT = 42
	DECLARE @SuperPT SMALLMONEY = 88
	DECLARE @srecommend INT = 52761582
	DECLARE @BatchNum INT = 5000 
	
	CREATE TABLE #Member
	( CustID INT PRIMARY KEY CLUSTERED ,InsSetting BIT DEFAULT 0 
	)
	CREATE TABLE #MemberTemp
	( CustID INT PRIMARY KEY CLUSTERED )

	CREATE TABLE #SMATemp
	( CustID INT PRIMARY KEY CLUSTERED ,RoleID TINYINT )


	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend = @srecommend AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #SMATemp(CustID,RoleID)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustID 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #Member(CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid > @maxcustID	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	--DELETE existing data -----------------------------------------------------------------------------------------------------------------

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
		INNER JOIN #SMATemp c ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #CustPTGroupSetting3rd_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT AgentID,SportType,BetType,IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN #SMATemp c ON s.AgentID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #CustPTSetting3rd_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.CustID,Sporttype,Bettype,IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN #Member c ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType
	
	DELETE cg
	FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
	INNER JOIN #CustPTSetting3rd_Agent ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype AND cg.IsLive = ci.IsLive

	DELETE cg
	FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
		INNER JOIN #CustPTGroupSetting3rd_Member ci ON ci.custid = cg.AgentID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype AND cg.IsLive = ci.IsLive
	
	DELETE cg
	FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
		INNER JOIN #CustPTSetting3rd_Member ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype AND cg.IsLive = ci.IsLive

	--Bet Setting
	INSERT INTO #CustBetSetting_Agent(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Agent S WITH(NOLOCK) 
		INNER JOIN #SMATemp c ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #CustBetSetting_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Member S WITH(NOLOCK) 
		INNER JOIN #Member c ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType
	
	DELETE cg
	FROM dbo.Dep_CustBetSetting_Agent cg WITH(ROWLOCK)		
		INNER JOIN #CustBetSetting_Agent ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype
		
	DELETE cg
	FROM dbo.Dep_CustBetSetting_Member cg WITH(ROWLOCK)		
		INNER JOIN #CustBetSetting_Member ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype
	
	--Comm
	INSERT INTO #Dep_CustDiscountGroupSetting_Member(AgentID,Sporttype,Bettype)
	SELECT DISTINCT s.AgentID,Sporttype,Bettype
	FROM Dep_CustDiscountGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN #SMATemp c ON s.AgentID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType


	INSERT INTO #Dep_CustDiscountSetting_Member(CustID,Sporttype,Bettype)
	SELECT DISTINCT s.Custid,SportType,BetType
	FROM Dep_CustDiscountSetting_Member s WITH(NOLOCK) 
		INNER JOIN #Member c ON s.CustID=c.custid
	WHERE SportType =@sportType AND BetType = @BetType
	
	DELETE cg
	FROM dbo.Dep_CustDiscountGroupSetting_Member cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustDiscountGroupSetting_Member ci ON ci.AgentID = cg.AgentID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype
	
	DELETE cg
	FROM dbo.Dep_CustDiscountSetting_Member cg WITH(ROWLOCK)		
		INNER JOIN #Dep_CustDiscountSetting_Member ci ON ci.custid = cg.CustID AND cg.SportType = ci.Sporttype AND cg.BetType = ci.Bettype

	DROP TABLE #CustPTSetting3rd_Agent
	DROP TABLE #CustPTSetting3rd_Member
	DROP TABLE #CustPTGroupSetting3rd_Member

	DROP TABLE #CustBetSetting_Agent
	DROP TABLE #CustBetSetting_Member

	DROP TABLE #Dep_CustDiscountSetting_Member
	DROP TABLE #Dep_CustDiscountGroupSetting_Member
-------------------------------------------------Add new Setting----------------------------------------------------------------
	INSERT INTO dbo.Dep_CustPTSetting_Agent
				(	[CustID] ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] )
	SELECT CustID,@Sporttype,@BetType,0,0,@SuperPT,0	
	FROM #SMATemp
	WHERE RoleID=3

	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID] ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] )
	SELECT CustID,@Sporttype,@BetType,0,0,0,@SuperPT
	FROM #SMATemp
	WHERE RoleID=2

	INSERT INTO dbo.Dep_CustPTGroupSetting_Member
		(	AgentID ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] )
	SELECT CustID,@Sporttype,@BetType,0,0,0,@SuperPT
	FROM #SMATemp
	WHERE RoleID=2
	
	INSERT INTO Dep_CustBetSetting_Agent ([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch])
	SELECT CustID, @Sporttype, @betType, 50, 22500, 75000
	FROM #SMATemp

	INSERT INTO Dep_CustDiscountGroupSetting_Member 
	([AgentID], [SportType], [BetType], [PlayerDiscount], [AgentDiscount], [MasterDiscount], [SuperDiscount])
	SELECT CustID, @SportType, @BetType, 0, 0, 0, 0
	FROM #SMATemp	
	WHERE RoleID=2

	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTemp
		UPDATE TOP (3000)  t SET t.InsSetting = 1 
		OUTPUT DELETED.CustID INTO #MemberTemp(CustID) FROM #Member t WHERE t.InsSetting = 0

		IF @@ROWCOUNT=0
			BREAK

		INSERT INTO dbo.Dep_CustPTSetting_Member
			(	CustID ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] )
		SELECT t.CustID ,@Sporttype ,@BetType ,0 ,0  ,0 ,@SuperPT
		FROM #MemberTemp t
			INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON t.CustID=m.CustID
		WHERE m.IsGroupedPT=0

		INSERT INTO dbo.Dep_CustBetSetting_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
		SELECT CustID, @Sporttype, @BetType, 50, 22500, 75000
		FROM #MemberTemp

		INSERT INTO Dep_CustDiscountSetting_Member 
		([CustID], [SportType], [BetType], [PlayerDiscount], [AgentDiscount], [MasterDiscount], [SuperDiscount])
		SELECT CustID, @SportType, @BetType, 0, 0, 0, 0
		FROM #MemberTemp	
	END

	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #Member M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  #Member temp ON temp.CustID = c.custid

	DECLARE @batch int = 3000
	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID,deleted.bitmapIsHidden,deleted.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.100'
	END

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden
	FROM #AllUsers A WITH (NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
