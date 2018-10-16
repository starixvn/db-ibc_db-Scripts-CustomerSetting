/*
	Created: Winnie
	Task: Group PT Setting for Esports
	DB: DBCUST/CustDB
	Date: 20181015
*/  
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE Acc_DynamicCustSetting3rd_09
	@srecommend INT	
	,@target VARCHAR(30)
AS
BEGIN  
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at DBCUST only
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 1
	   AND dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 1
	   AND dbo.f_CheckRepTable('Dep_CustSettingMode') = 1
	   AND dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 1
	   )
	  RETURN

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
	FROM dbo.Dep_CustSettingMode m WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH(NOLOCK)
			ON m.CustID = ci.custid
	WHERE IsGroupedPT = 1 AND ci.srecommend = @srecommend AND ci.roleid = 1

	--Get representative CustID
	;WITH _s as (
		SELECT c.recommend, c.custid	
			,rdSetting = CAST(DENSE_RANK() OVER(ORDER BY sporttype, bettype, islive, superPT, masterPT, agentPT) as INT)
			,rdProduct = CAST(DENSE_RANK() OVER(ORDER BY sporttype, bettype, islive) as INT)
		FROM #CustomerTemp c WITH(NOLOCK)
			INNER JOIN dbo.Dep_CustPTSetting_Member pt WITH(NOLOCK) ON c.custid = pt.custid AND (pt.SportType =43)
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
	INSERT INTO [dbo].[Dep_CustPTSetting_Member]
		   ([CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		)
	SELECT c.CustID
		  ,cs.[SportType]
		  ,cs.[BetType]
		  ,cs.[IsLive]
		  ,cs.[SuperPT]
		  ,cs.[MasterPT]
		  ,cs.[AgentPT]		
	FROM [dbo].[Dep_CustPTGroupSetting_Member] cs WITH(NOLOCK)
		INNER JOIN #UnGroupedCustomer c WITH(NOLOCK)
			ON c.Recommend = cs.AgentID

	--Update IsGrouped=0 for customers that do not continue using PT Group 		
	UPDATE dbo.Dep_CustSettingMode
	SET IsGroupedPT = 0
	WHERE CustID IN (SELECT CustID FROM #UnGroupedCustomer WITH(NOLOCK)) 

	--Insert setting of PT Group for Esports
	INSERT INTO [dbo].[Dep_CustPTGroupSetting_Member]
		   ([AgentID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		)
		SELECT tmp.recommend
		  ,[SportType]
		  ,[BetType]
		  ,[IsLive]
		  ,[SuperPT]
		  ,[MasterPT]
		  ,[AgentPT]		 
		FROM [dbo].[Dep_CustPTSetting_Member] mb WITH(NOLOCK)
			INNER JOIN #tempGroup tmp 
				ON mb.CustID = tmp.repCustID
					AND (mb.SportType =43)

	--Delete redundant individual setting				
	DELETE cs
	FROM [dbo].[Dep_CustPTSetting_Member] cs WITH(NOLOCK)
		INNER JOIN #GroupedCustomer temp1 WITH(NOLOCK)
			ON cs.CustID = temp1.CustID
	WHERE cs.SportType =43
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM Custinfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled=1
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.280'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT

INSERT INTO #supers(custid)
SELECT ci.custid
FROM Custinfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled=1
	
WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend,@target = 'DBCUST'
			
			
	waitfor delay '00:00:0.280'
END