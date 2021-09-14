/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Create Group PT Setting for Bitcoin UUS [Redmine: 159039]
	DB: DBCUST/CustDB
	P/s : Step 3 Create Group PT Setting UUS
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustSettingMode3rd') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN

	DECLARE @ProductID TINYINT = 69, @Sporttype INT = 175  ,@Bettype INT  = 7901 
	DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @Currency INT

	CREATE TABLE #CustomerTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Recommend INT
	)

	CREATE TABLE #UnGroupedCustomer
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Recommend INT
	)

	CREATE TABLE #GroupedCustomer
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)

	CREATE TABLE #tempData (recommend int, custid int, cs1 bigint, cs2 int)
	CREATE TABLE #tempGroup(recommend int, cs1 bigint, cs2 int, memberCNT int, repCustID int)

	--Get a list of customers that are using PT Group
	INSERT #CustomerTemp(CustID,Recommend)
	SELECT ci.CustID,ci.recommend
	FROM dbo.CustSettingMode3rd m WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH(NOLOCK)
			ON m.CustID = ci.custid
	WHERE IsGrouped = 1 AND ci.srecommend = @srecommend AND ci.roleid = 1

	--Get representative CustID
	;WITH _s as (
		SELECT c.recommend, c.custid	
			,rdSetting = CAST(DENSE_RANK() OVER(ORDER BY sporttype, bettype, islive, superPT, masterPT, agentPT, isAutoMasterPT, AutoMasterPT, isAutoSuperPT, AutoSuperPT) as INT)
			,rdProduct = CAST(DENSE_RANK() OVER(ORDER BY sporttype, bettype, islive) as INT)
		FROM #CustomerTemp c WITH(NOLOCK)
			INNER JOIN dbo.CustPTSetting3rd_Member pt WITH(NOLOCK) ON c.custid = pt.custid AND pt.SportType = @Sporttype
	)
	INSERT INTO #tempdata (recommend, custid, cs1, cs2)
	SELECT recommend, custid, SUM(CONVERT(bigint,rdSetting) + POWER(2, rdProduct%10+1)), CHECKSUM_AGG(CHECKSUM(HASHBYTES('SHA1', CONVERT(nvarchar(max), rdSetting))))
	FROM _s
	group by recommend, custid

	INSERT INTO #tempGroup(recommend, cs1, cs2, memberCNT, repCustID)
	SELECT recommend, cs1, cs2, memberCnt, repCustID
	FROM (
		SELECT recommend, cs1, cs2, rn = ROW_NUMBER() OVER (partition by recommend ORDER BY count(1) desc, max(custid) desc), memberCnt = count(1), repCustID = max(custid)
		FROM #tempdata
		GROUP BY recommend, cs1, cs2
	) x
	WHERE rn = 1

	--Get a list of customers that do not continue using PT Group 
	INSERT INTO #UnGroupedCustomer(CustID,Recommend)
	SELECT c.CustID,c.Recommend
	FROM #CustomerTemp c WITH(NOLOCK)
		INNER JOIN #tempdata tmp1 WITH(NOLOCK)
			ON tmp1.custid = c.CustID
		INNER JOIN #tempGroup tmp2 WITH(NOLOCK)
			ON tmp1.recommend = tmp2.recommend
	WHERE tmp1.cs2 <> tmp2.cs2 OR tmp1.cs1 <> tmp2.cs1

	--Get a list of customers that continue using PT Group 
	INSERT INTO #GroupedCustomer(CustID)
	SELECT c.CustID
	FROM #CustomerTemp c WITH(NOLOCK)
		INNER JOIN #tempdata tmp1 WITH(NOLOCK)
			ON tmp1.custid = c.CustID
		INNER JOIN #tempGroup tmp2 WITH(NOLOCK)
			ON tmp1.recommend = tmp2.recommend
	WHERE tmp1.cs2 = tmp2.cs2 AND tmp1.cs1 = tmp2.cs1

	--Insert Individual PT for customers that do not continue using PT Group 
	INSERT INTO [dbo].[CustPTSetting3rd_Member]
		   ([CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		   ,[IsAutoMasterPT]
		   ,[AutoMasterPT]
		   ,[IsAutoSuperPT]
		   ,[AutoSuperPT])
	SELECT c.CustID
		  ,cs.[SportType]
		  ,cs.[BetType]
		  ,cs.[IsLive]
		  ,cs.[SuperPT]
		  ,cs.[MasterPT]
		  ,cs.[AgentPT]
		  ,cs.[IsAutoMasterPT]
		  ,cs.[AutoMasterPT]
		  ,cs.[IsAutoSuperPT]
		  ,cs.[AutoSuperPT]
	FROM [dbo].[CustPTGroupSetting3rd_Member] cs WITH(NOLOCK)
		INNER JOIN #UnGroupedCustomer c WITH(NOLOCK)
			ON c.Recommend = cs.AgentID

	--Update IsGrouped=0 for customers that do not continue using PT Group 		
	UPDATE dbo.CustSettingMode3rd
	SET IsGrouped = 0
	WHERE CustID IN (SELECT CustID FROM #UnGroupedCustomer WITH(NOLOCK)) 

	--Insert setting of PT Group for AllBet
	INSERT INTO [dbo].[CustPTGroupSetting3rd_Member]
		   ([AgentID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		   ,[IsAutoMasterPT]
		   ,[AutoMasterPT]
		   ,[IsAutoSuperPT]
		   ,[AutoSuperPT])
		SELECT tmp.recommend
		  ,[SportType]
		  ,[BetType]
		  ,[IsLive]
		  ,[SuperPT]
		  ,[MasterPT]
		  ,[AgentPT]
		  ,[IsAutoMasterPT]
		  ,[AutoMasterPT]
		  ,[IsAutoSuperPT]
		  ,[AutoSuperPT]
		FROM [dbo].[CustPTSetting3rd_Member] mb WITH(NOLOCK)
			INNER JOIN #tempGroup tmp 
				ON mb.CustID = tmp.repCustID
					AND mb.SportType = @Sporttype

	--Delete redundant individual setting				
	DELETE cs
	FROM [dbo].[CustPTSetting3rd_Member] cs WITH(NOLOCK)
		INNER JOIN #GroupedCustomer temp1 WITH(NOLOCK)
			ON cs.CustID = temp1.CustID
	WHERE cs.SportType = @Sporttype
	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.Site NOT IN ('CN88')
	AND ci.currency IN (20,72) -- UUS
	AND  ci.custid IN (
					--UUS
					17287861
					,18879367
					,14373244
					,18362423
					,18479460
					,18289591
				)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
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

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.Site NOT IN ('CN88')
	AND ci.currency IN (20,72) -- UUS
	AND  ci.custid IN (
					--UUS
					17287861
					,18879367
					,14373244
					,18362423
					,18479460
					,18289591
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

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.200'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
