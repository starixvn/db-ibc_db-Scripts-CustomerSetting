/*
	Created: Eden
	Date: 20191029
	Task: Migrate Comm and BetSetting of Keno and Number Games to DCS [RM:#123750]
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_08]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	--IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustDiscountSetting_Agent') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustSetting3rd') = 0 RETURN
	--IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN
	--IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN

	CREATE TABLE #MemberTemp(
		 CustID INT PRIMARY KEY CLUSTERED
		,maxpermatch161	money
		,MaxPerBall161	money
	)
	CREATE TABLE #SMATemp(
		 CustID INT PRIMARY KEY CLUSTERED
		,roleid TINYINT
		,maxpermatch161	money
		,MaxPerBall161	money
	)

	INSERT INTO #MemberTemp (
		 CustID
		,maxpermatch161	
		,MaxPerBall161	
		)
	SELECT custid
		,maxpermatch161	
		,MaxPerBall161	
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid

	
	INSERT INTO #SMATemp (
		 CustID
		,roleid
		,maxpermatch161	
		,MaxPerBall161	
		)
	SELECT custid
		,roleid
		,maxpermatch161	
		,MaxPerBall161	
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid

	DECLARE @Batch int = 1000

	------------------------------------Bet Setting-------------------------------------------------	
	--Number Gamnes
	INSERT INTO Dep_CustBetSettingGame_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerBall
	)
	SELECT a.custid
		  ,a.sporttype
		  ,a.bettype
		  ,a.minbet
		  ,a.maxbet
		  ,c.maxpermatch161
		  ,c.MaxPerBall161
	FROM Dep_CustSetting3rd a WITH(NOLOCK) 
		INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid = c.custid 
	WHERE SportType = 161 and bettype = 81 and islive = 0 

	INSERT INTO Dep_CustBetSettingGame_Member(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
		,MaxPerBall
	)
	SELECT a.custid
		  ,a.sporttype
		  ,a.bettype
		  ,a.minbet
		  ,a.maxbet
		  ,c.maxpermatch161
		  ,c.MaxPerBall161
	FROM Dep_CustSetting3rd a WITH(NOLOCK) 
		INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid = c.custid
	WHERE SportType IN (161) and bettype = 81 and islive = 0

	--Keno
	INSERT INTO Dep_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT a.custid
		  ,sporttype = 202
		  ,bettype = 1501
		  ,a.MinBet
		  ,a.maxbet
		  ,a.MaxPerGameType
	FROM  CustGameType a WITH(NOLOCK) 
		  INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid = c.custid
	WHERE GameTypeID = 1

	INSERT INTO Dep_CustBetSetting_Member(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT a.custid
		  ,sporttype = 202
		  ,bettype = 1501
		  ,a.MinBet
		  ,a.maxbet
		  ,a.MaxPerGameType
	FROM CustGameType a WITH(NOLOCK)
		 INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid = c.custid  
	WHERE GameTypeID = 1

	------------------------------------Commisson Setting-------------------------------------------------	
	--Number Games
	INSERT INTO Dep_CustDiscountSetting_Agent (CustID,SportType,BetType,Discount)
	SELECT a.CustID,SportType,BetType
		,Discount = CASE WHEN c.roleid = 2 THEN a.adiscount 
						 WHEN c.roleid = 3 THEN a.discount
						 WHEN c.roleid = 4 THEN a.sdiscount
					END
	FROM Dep_CustSetting3rd a WITH(NOLOCK) 
		 INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid = c.custid
	WHERE SportType = 161 and bettype = 81 and islive = 0 


	INSERT INTO Dep_CustDiscountSetting_Member (CustID,SportType,BetType,PlayerDiscount,AgentDiscount,MasterDiscount,SuperDiscount)
	SELECT a.CustID,SportType,BetType,PlayerDiscount,adiscount,discount,sdiscount
	FROM Dep_CustSetting3rd a WITH(NOLOCK) 
		INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid = c.custid
	WHERE SportType = 161 and bettype = 81 and islive = 0

	----Keno
	--INSERT INTO Dep_CustDiscountSetting_Agent (CustID,SportType,BetType,Discount)
	--SELECT a.CustID,SportType,BetType
	--	,Discount = CASE WHEN c.roleid = 2 THEN a.adiscount 
	--					 WHEN c.roleid = 3 THEN a.discount
	--					 WHEN c.roleid = 4 THEN a.sdiscount
	--				END
	--FROM CustSettingGame a WITH(NOLOCK) 
	--	 INNER JOIN #SMATemp c WITH(NOLOCK) ON a.custid = c.custid
	--WHERE SportType = 202 and bettype = 1501


	--INSERT INTO Dep_CustDiscountSetting_Member (CustID,SportType,BetType,PlayerDiscount,AgentDiscount,MasterDiscount,SuperDiscount)
	--SELECT a.CustID,SportType,BetType,PlayerDiscount,adiscount,discount,sdiscount
	--FROM CustSettingGame a WITH(NOLOCK) 
	--	INNER JOIN #MemberTemp c WITH(NOLOCK) ON a.custid = c.custid
	--WHERE SportType = 202 and bettype = 1501

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency = 20

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

	EXEC dbo.Acc_Dep_DynamicCustSetting_08 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO