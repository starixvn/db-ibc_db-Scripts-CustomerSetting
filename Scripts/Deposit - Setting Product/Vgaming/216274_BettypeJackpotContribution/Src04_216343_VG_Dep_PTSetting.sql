/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250110@Virgil
	Task: Vgaming - Integrate Bettype Jackpot Contribution [RedmineID: #216274]
	DB: DBCUST-CustDB
	Description: Step 2 - Insert PT and Betlimit all Licensee Deposit
*/

------ BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST -------			
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers	  (CustID INT PRIMARY KEY, Currency INT, isfinished BIT DEFAULT(0))
CREATE TABLE #Dummy		  (CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust	  (CustID INT PRIMARY KEY CLUSTERED, srecommend INT)
CREATE TABLE #tmpSMA	  (CustID INT PRIMARY KEY CLUSTERED, srecommend INT, RoleID INT)
CREATE TABLE #tmpCustTemp (CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp  (CustID INT PRIMARY KEY)
CREATE TABLE #CustList    (CustID INT PRIMARY KEY)
CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)

DECLARE @CustIDs VARCHAR(MAX), @max_custid INT, @srecommend INT, @currency INT, @__waitfor VARCHAR(50);

DECLARE @sportType  SMALLINT = 171,
		@RefBetType	SMALLINT = 3801,
		@BetType	SMALLINT = 3898,
		@batch		SMALLINT = 2000,
		@PT			smallmoney = 100.00,
		@Role		SMALLINT = 0;

SELECT @__waitfor = [dbo].[f_DelayTime]('Key1');

SELECT @max_custid = XXX;

-- List all supers
INSERT INTO #supers(custid,Currency)
SELECT ci.custid, ci.currency
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) 
		ON ci.custid = cs.custid
	INNER JOIN Dep_CustPTSetting_Agent pt WITH(NOLOCK) 
		ON ci.custid = pt.CustID 
		AND SportType = @sportType 
		AND BetType = @RefBetType
WHERE ci.Enabled = 1
	AND ci.CustID <= @max_custid

-- get dummyaccount from list supers
INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #supers) 
	AND roleid = 3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid <= @max_custid 

-- list underline member of each supers
INSERT INTO #tmpCust(CustID,srecommend)
SELECT ci.CustID, ci.srecommend
FROM custInfo ci WITH(NOLOCK)
INNER JOIN Dep_CustPTSetting_Member pt WITH(NOLOCK) 
	ON ci.custid = pt.CustID 
	AND SportType = @sportType 
	AND BetType = @RefBetType
INNER JOIN #supers sp
	ON ci.srecommend = sp.CustID
WHERE ci.custid <= @max_custid 
	AND roleid = 1 
	AND ci.Enabled = 1	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

-- list underline SMA of each supers
INSERT INTO #tmpSMA(CustID,RoleID,srecommend)
SELECT CustID,RoleID,srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) 
	AND ci.custid <= @max_custid 
	AND roleid IN (2,3,4) 
	AND ci.Enabled=1 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)		

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT ;

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 , @DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	TRUNCATE TABLE #CustList

	IF EXISTS(SELECT TOP 1 1 FROM #tmpSMA WHERE srecommend = @srecommend)
		OR EXISTS (SELECT TOP 1 1 FROM #tmpCust WHERE srecommend = @srecommend)
	BEGIN
		-- get SM first
		DELETE TOP (@batch) #tmpSMA 
		OUTPUT DELETED.CustID 
		INTO #tmpSMATemp(CustID)	
		WHERE RoleID <> 2 
			AND srecommend = @srecommend
		
		IF @@ROWCOUNT = 0 
			SET @DoneSM = 1

		IF @DoneSM = 0
		BEGIN
			INSERT INTO #CustList(custid)	
			SELECT custid
			FROM #tmpSMATemp
		END
		ELSE
		BEGIN
			-- if done SM, move on to Agent
			DELETE TOP (@batch) #tmpSMA
			OUTPUT DELETED.CustID 
			INTO #tmpSMATemp(CustID)	
			WHERE RoleID = 2 
				AND srecommend = @srecommend
			
			IF @@ROWCOUNT = 0 
				SET @DoneAgent = 1

			IF @DoneAgent = 0
			BEGIN
				INSERT INTO #CustList(custid)	
				SELECT custid
				FROM #tmpSMATemp

				SELECT @Role = 2
			END
			ELSE
			BEGIN
				-- if done Agent, move on to Member
				DELETE TOP (@batch) #tmpCust
				OUTPUT DELETED.CustID 
				INTO #tmpCustTemp(CustID)	
				WHERE srecommend = @srecommend

				IF @@ROWCOUNT = 0 
					BREAK

				INSERT INTO #CustList(custid)	
				SELECT custid
				FROM #tmpCustTemp

				SELECT @Role = 1
			END
		END

----------------------------------------------------------------------------------
		-- SMA LEVEL
		IF @Role <> 1
		BEGIN
			WHILE(1 = 1)
			BEGIN
				DELETE TOP (@batch) #CustList
				OUTPUT DELETED.CustID 
				INTO #CustListTemp(CustID)
			
				IF @@ROWCOUNT = 0 
					BREAK

				INSERT INTO dbo.Dep_CustPTSetting_Agent
					(	[CustID]
					   ,[SportType]
					   ,[BetType]
					   ,[IsLive]
					   ,[SuperPT]
					   ,[MasterPT]
					   ,[AgentPT]
					   ,[RepUpdateTime]
					 )
				SELECT  a.CustID
					   ,@sportType
					   ,@BetType
					   ,0 AS IsLive
					   ,CASE WHEN @Role = 0 AND a.CustID = @srecommend THEN @PT ELSE 0 END AS SuperPT
					   ,CASE WHEN @Role = 0 THEN @PT ELSE 0 END AS MasterPT
					   ,CASE WHEN @Role = 2 OR a.CustID = @srecommend  THEN @PT ELSE 0 END AS AgentPT
					   ,[dbo].[f_GetDateTime2]()
				FROM #CustListTemp a WITH(NOLOCK)
				
				-- Agent Level
				IF @Role = 2
				BEGIN
					INSERT INTO dbo.Dep_CustPTGroupSetting_Member
						(	AgentID
						   ,[SportType]
						   ,[BetType]
						   ,[IsLive]
						   ,[SuperPT]
						   ,[MasterPT]
						   ,[AgentPT]
						   ,[RepUpdateTime]
						 )
					SELECT  a.CustID
						   ,@sportType
						   ,@BetType
						   ,0 AS IsLive
						   ,0 AS SuperPT
						   ,0 AS MasterPT
						   ,@PT AS AgentPT
						   ,[dbo].[f_GetDateTime2]()
					FROM #CustListTemp a WITH(NOLOCK)

				END 
			
				TRUNCATE TABLE #CustListTemp
			END
		END	
	
		-- Member
		IF @Role = 1
		BEGIN
			WHILE(1 = 1)
			BEGIN		
				DELETE TOP (@batch) #CustList
				OUTPUT DELETED.CustID 
				INTO #CustListTemp(CustID)
			
				IF @@ROWCOUNT = 0 BREAK

				-- Member Level
				INSERT INTO dbo.Dep_CustPTSetting_Member
					(	CustID
					   ,[SportType]
					   ,[BetType]
					   ,[IsLive]
					   ,[SuperPT]
					   ,[MasterPT]
					   ,[AgentPT]
					   ,[RepUpdateTime]
					 )
				SELECT  a.CustID
					   ,@sportType
					   ,@BetType
					   ,0 AS IsLive
					   ,0 AS SuperPT
					   ,0 AS MasterPT
					   ,@PT AS AgentPT
					   ,[dbo].[f_GetDateTime2]()
				FROM #CustListTemp a WITH(NOLOCK)
					INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
				WHERE m.IsGroupedPT=0

				INSERT INTO Dep_CustSettingMode(CustID, IsGroupedPT, RepUpdateTime)
				SELECT t.CustID, 1, [dbo].[f_GetDateTime2]()
				FROM #CustListTemp t WITH(NOLOCK) 
				WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
					AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
		
				TRUNCATE TABLE #CustListTemp
			END 	
		END

----------------------------------------------------------------------------------	
		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp	
	END
	ELSE
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid
			,@currency = currency
			,@DoneSM = 0
			,@DoneAgent = 0	
			,@Role  = 0		
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + 1
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT

		WAITFOR DELAY @__waitfor
	END
END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
DROP TABLE #CustList
DROP TABLE #CustListTemp
GO

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
