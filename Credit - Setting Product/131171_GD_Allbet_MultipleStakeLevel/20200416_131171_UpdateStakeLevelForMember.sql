/*
	Created: 20200416@Tiara
	Date: 20200416
	Task: Update betlimit for Allbet, SA, Sexy Gaming, Gold Deluxe for member [Redmine: #131171]
	DB: DBCUST/CustDB
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	
	---------------Allbet,SA Gaming, Sexy Gaming-------------------------------------------
	
	--Get list of member whose StakeLevelList need to get all checked stakelevel from agent
	CREATE TABLE #CustStakeLevelMember_All (
			CustID INT 
			,AgentID INT
			,Sporttype SMALLINT
			,Bettype SMALLINT
			,StakeLevelList VARCHAR(100)
			,StakeLevelList_new VARCHAR(100)							
			, PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
		)

	INSERT INTO #CustStakeLevelMember_All (CustID,AgentID,Sporttype,Bettype,StakeLevelList,StakeLevelList_new)
	SELECT CI.custid,
		  CI.recommend AS AgentID,	
		  cs.SportType,
		  cs.Bettype,
		  cs.StakeLevelList,
		  CA.StakeLevelList
	FROM dbo.custinfo CI WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Member CS WITH(NOLOCK) ON CI.custid = CS.custid	
		INNER JOIN DBO.CustStakeLevel_Agent CA WITH (NOLOCK) ON CI.recommend = CA.CustID AND CS.SportType = CA.SportType AND CS.BetType = CA.BetType
	WHERE CI.srecommend = @srecommend 
		AND roleid = 1
		AND CI.Enabled = 1
		AND CS.SportType IN (211,243,244)
		AND CS.BetType IN (2401, 3001, 3101)
		AND CS.StakeLevelList <> '' 
		AND CS.StakeLevelList IS NOT NULL
	

	--Get list of member whose stakelevel are empty or null
	CREATE TABLE #CustStakeLevelMember_Lowest (
			CustID INT 
			,AgentID INT
			,Sporttype SMALLINT
			,Bettype SMALLINT
			,StakeLevelList VARCHAR(100)
			,StakeLevelList_new VARCHAR(100)							
			, PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
		)

	INSERT INTO #CustStakeLevelMember_Lowest (CustID,AgentID,Sporttype,Bettype,StakeLevelList,StakeLevelList_new)
	SELECT CI.custid,
		  CI.recommend AS AgentID,
		  cs.SportType,
		  cs.Bettype,
		  cs.StakeLevelList,
		  CA.StakeLevelList
	FROM dbo.custinfo CI WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Member CS WITH(NOLOCK) ON CI.custid = CS.custid
		INNER JOIN DBO.CustStakeLevel_Agent CA WITH (NOLOCK) ON CI.recommend = CA.CustID AND CS.SportType = CA.SportType AND CS.BetType = CA.BetType 
	WHERE  CI.srecommend = @srecommend
		AND roleid = 1
		AND CI.Enabled = 1
		AND CS.SportType IN (211,243,244)
		AND CS.BetType IN (2401, 3001, 3101)
		AND (CS.StakeLevelList = '' OR CS.StakeLevelList IS NULL)
		AND CA.StakeLevelList != '' 
		AND CA.StakeLevelList IS NOT NULL

	UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelMember_Lowest T		 		
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(T.StakeLevelList_new,','))  CD
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON CD.val = SL.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY MaxStake DESC
					) T1 -- Get lowest stakelevel from agent

	--Apply all checked stakelevel from agent to member whose stake level is not null
	UPDATE CS
	SET CS.StakeLevelList = ISNULL(DL.StakeLevelList_new,'')
	FROM dbo.CustStakeLevel_Member CS WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustStakeLevelMember_All DL ON CS.CustID = DL.CustID 
												AND CS.SportType = DL.Sporttype
												AND CS.bettype = DL.bettype
	WHERE CS.StakeLevelList <> DL.StakeLevelList_new
		AND CS.SportType IN (211,243,244)
		AND CS.BetType IN (2401, 3001, 3101)

	--Apply lowest stakelevel from agent to member whose stakelevel is null

	UPDATE CS
	SET CS.StakeLevelList = ISNULL(DL.StakeLevelList_new,'')
	FROM dbo.CustStakeLevel_Member CS WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustStakeLevelMember_Lowest DL ON CS.CustID = DL.CustID 
												AND CS.SportType = DL.Sporttype
												AND CS.bettype = DL.bettype
	WHERE CS.StakeLevelList <> DL.StakeLevelList_new
		AND CS.SportType IN (211,243,244)
		AND CS.BetType IN (2401, 3001, 3101)

	--Adjust StakelevelList if exceed MaxChoice
	SELECT T.CustID, T.AgentID,T.Sporttype,T.Bettype,T.StakeLevelList_new,3 AS MaxChoice INTO #AdjustList
	FROM #CustStakeLevelMember_All T WITH (NOLOCK)
		CROSS APPLY dbo.strSplit(T.StakeLevelList_new,',') 
		WHERE T.Sporttype = 211 AND T.Bettype = 2401
		GROUP BY T.CustID, T.AgentID,T.Sporttype,T.Bettype, T.StakeLevelList_new
		HAVING COUNT(VAL) > 3 --Allbet MaxChoice
	
	UPDATE C
	SET C.StakeLevelList_new = ISNULL(CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)),'')
	FROM #AdjustList C WITH (ROWLOCK)
	INNER JOIN CUSTINFO CI WITH (NOLOCK) ON CI.custid = C.CustID
	CROSS APPLY
	(SELECT ',' + ISNULL(CAST(StakeLevelID AS VARCHAR(10)),'')
	FROM (SELECT TOP 3 CAST(val AS INT) AS val
			FROM dbo.strSplit(C.StakeLevelList_new,',')
			ORDER BY VAL DESC ) CD
			INNER JOIN StakeLevel S WITH (NOLOCK) ON CD.val=S.StakeLevelID AND S.GameTypeID = C.Bettype AND CI.currency = S.ExchangeId 
			FOR XML PATH ('') ) AS A(STL)
	WHERE C.BETTYPE = 2401

	UPDATE CS
	SET CS.StakeLevelList = ISNULL(A.StakeLevelList_new,'')
	FROM dbo.CustStakeLevel_Member CS WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #AdjustList A ON CS.CustID = A.CustID 
												AND CS.SportType = A.Sporttype
												AND CS.bettype = A.bettype
	WHERE CS.StakeLevelList <> A.StakeLevelList_new
		AND CS.SportType = 211
		AND CS.BetType = 2401

	---------------Gold Deluxe-------------------------------------------

	CREATE TABLE #MemberTemp_All (
			CustID INT 
			,AgentID INT		
			,Bettype INT
			,StakeLevelList VARCHAR(100)
			,StakeLevelList_new VARCHAR(100)							
			, PRIMARY KEY CLUSTERED (CustID,Bettype)
		)

	INSERT INTO #MemberTemp_All (CustID,AgentID,Bettype,StakeLevelList,StakeLevelList_new)
	SELECT DISTINCT ci.custid, ci.recommend,CS.GameTypeID, CS.StakeLevelList, CA.StakeLevelList
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN CustGameType CS WITH (NOLOCK) ON CI.custid = CS.CustID
		INNER JOIN CustGameType CA WITH (NOLOCK) ON CI.recommend = CA.CustID AND CS.GameTypeID = CA.GameTypeID
	WHERE srecommend = @srecommend 
		AND ci.roleid = 1  
		AND ci.Enabled = 1 
		AND CS.GameTypeID IN (1701,1702) --GoldDeluxe
		AND CS.StakeLevelList <> '' 
		AND CS.StakeLevelList IS NOT NULL


	CREATE TABLE #MemberTemp_Lowest (
			CustID INT 
			,AgentID INT		
			,Bettype INT
			,StakeLevelList VARCHAR(100)
			,StakeLevelList_new VARCHAR(100)							
			, PRIMARY KEY CLUSTERED (CustID,Bettype)
		)

	INSERT INTO #MemberTemp_Lowest (CustID,AgentID,Bettype,StakeLevelList,StakeLevelList_new)
	SELECT DISTINCT ci.custid, ci.recommend,CS.GameTypeID, CS.StakeLevelList, CA.StakeLevelList
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN CustGameType CS WITH (NOLOCK) ON CI.custid = CS.CustID
		INNER JOIN CustGameType CA WITH (NOLOCK) ON CI.recommend = CA.CustID AND CS.GameTypeID = CA.GameTypeID
	WHERE srecommend = @srecommend 
		AND ci.roleid = 1  
		AND ci.Enabled = 1 
		AND CS.GameTypeID IN (1701,1702) --GoldDeluxe
		AND (CS.StakeLevelList = '' OR CS.StakeLevelList IS NULL)
		AND CA.StakeLevelList != '' 
		AND CA.StakeLevelList IS NOT NULL

	UPDATE M
	SET M.StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #MemberTemp_Lowest M WITH (ROWLOCK, UPDLOCK)
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(val AS INT) AS val
						  FROM dbo.strSplit(M.StakeLevelList_new,','))  CD
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON CD.val = SL.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY MaxStake DESC
					) T1 -- Get lowest stakelevel from agent

	--Apply all checked stakelevel from agent to member whose stake level is not null
	UPDATE CT
	SET CT.StakeLevelList = ISNULL (M.StakeLevelList_new,'')
	FROM CustGameType CT WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #MemberTemp_All M WITH (NOLOCK) ON M.CustID = CT.CustID AND M.Bettype = CT.GameTypeID
	WHERE CT.StakeLevelList <> M.StakeLevelList_new
		AND CT.GameTypeID IN (1701,1702)

	--Apply lowest stakelevel from agent to member whose stakelevel is null
	UPDATE CT
	SET CT.StakeLevelList = ISNULL (M.StakeLevelList_new,'')
	FROM CustGameType CT WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #MemberTemp_Lowest M WITH (NOLOCK) ON M.CustID = CT.CustID AND M.Bettype = CT.GameTypeID
	WHERE CT.StakeLevelList <> M.StakeLevelList_new
		AND CT.GameTypeID IN (1701,1702)

	--Drop all temp tables
	DROP TABLE #CustStakeLevelMember_All
	DROP TABLE #CustStakeLevelMember_Lowest
	DROP TABLE #MemberTemp_All
	DROP TABLE #MemberTemp_Lowest


END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@super_cnt INT, 
		@index INT = 0

CREATE TABLE #supers (custid int,isfinished bit default(0))

INSERT INTO #supers(CustID)

SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = CI.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.currency IN (15,22,33,34,47) --( 'IDD', 'IDR', 'IN', 'IND','DDD')
	AND C.Enabled=1

-- For deployer info
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@target = 'REPLICATED'
					
	waitfor delay '00:00:0.200'
END
GO

-- END STEP 2: Run this SP at replicated DB -----
---------------------------------------------------------------------------------

-- BEGIN STEP 3: Run this SP at DBCust -----
---------------------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@super_cnt INT, 
		@index INT = 0

CREATE TABLE #supers (custid int,isfinished bit default(0))

INSERT INTO #supers(CustID)

SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = CI.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.currency IN (15,22,33,34,47) --( 'IDD', 'IDR', 'IN', 'IND','DDD')
	AND C.Enabled=1

-- For deployer info
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@target = 'DBCUST'
					
	waitfor delay '00:00:0.200'
END
GO

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 