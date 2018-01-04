/*
	Created: Elodie
	Date: 20171201
	Task: Delete existing data of BullFighting
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN				

	CREATE TABLE #OfferedSite (site VARCHAR(10))
	CREATE TABLE #OfferedSiteBatch1 (site VARCHAR(10))	
	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)
	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)
	CREATE TABLE #DirectMaster (CustID INT PRIMARY KEY,roleid TINYINT)
	CREATE TABLE #DirectAgent (CustID INT PRIMARY KEY,mrecommend INT,roleid TINYINT)
	CREATE TABLE #DirectMember (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid TINYINT)
	CREATE TABLE #DirectAgentBatch1 (CustID INT PRIMARY KEY,mrecommend INT,roleid TINYINT)
	CREATE TABLE #DirectMemberBatch1 (CustID INT PRIMARY KEY,recommend INT,mrecommend INT,roleid TINYINT)	
	CREATE TABLE #DummyBatch1 (CustID INT PRIMARY KEY,roleid TINYINT)	
	CREATE TABLE #supers (custid INT)
	DECLARE @Sporttype SMALLINT 

	SELECT @Sporttype = 207

	INSERT INTO #OfferedSite (site)
	VALUES  ('733333'), ('222223'), ('222225'), ('222227'), ('033333'), ('JPNIBC'), ('611111'), ('722222'), ('766666'), ('7aa666'), ('BEST-ODDS'), ('XYZbet'), ('755555'), ('789y')       
	INSERT INTO #OfferedSiteBatch1 (site)
	VALUES  ('Indo'), ('KORIBC')

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 		
	WHERE ci.custid IN (15) -- dummy super of batch 1	
		
	--- get direct agent
	INSERT INTO #DirectAgentBatch1 (CustID,mrecommend,roleid)
	SELECT ci.custid, ci.mrecommend,ci.roleid
	FROM Customer ci WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid
	WHERE  EXISTS (SELECT 1 FROM #OfferedSiteBatch1 WHERE site = ci.site)
		AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		and ci.roleid = 2 
		AND c.Enabled=1

	INSERT INTO #DirectMemberBatch1(CustID,recommend,mrecommend,roleid)
	SELECT c.custid, c.recommend,c.mrecommend,c.roleid
	FROM Customer c WITH(NOLOCK)
		INNER JOIN Customer ca (nolock) on c.recommend=ca.custid 
		INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid
	WHERE EXISTS (SELECT 1 FROM #OfferedSiteBatch1 WHERE site = ca.site)
		AND EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND c.roleid=1 
		AND ci.Enabled=1

	----------- For SMA  -----------
	INSERT INTO #DummyBatch1 (CustID,roleid)	
	-----------------------Master--------------------------------------		
	SELECT DISTINCT d.mrecommend, 3 -- Master of direct agent
	FROM #DirectAgentBatch1 d
	UNION 
	SELECT DISTINCT d.mrecommend, 3 -- Master of direct member
	FROM #DirectMemberBatch1 D 	
	UNION 
	-----------------------Agent--------------------------------------		
	SELECT DISTINCT d.recommend, 2 -- agent of direct member
	FROM #DirectMemberBatch1 D 

	--- get direct master
	INSERT INTO #DirectMaster (CustID,roleid)
	SELECT ci.custid, ci.roleid
	FROM Customer ci with(nolock)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid
	WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
		AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 
		AND c.Enabled=1
		
	--- get direct agent
	INSERT INTO #DirectAgent (CustID,mrecommend,roleid)
	SELECT ci.custid, ci.mrecommend,ci.roleid
	FROM Customer ci WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid
	WHERE  EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ci.site)
		AND  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		and ci.roleid = 2 
		AND c.Enabled=1

	INSERT INTO #DirectMember(CustID,recommend,mrecommend,roleid)
	SELECT c.custid, c.recommend,c.mrecommend,c.roleid
	FROM Customer c WITH(NOLOCK)
		INNER JOIN Customer ca (nolock) on c.recommend=ca.custid 
		INNER JOIN custInfo ci WITH(NOLOCK) ON ci.custid=c.custid
		INNER JOIN #supers s ON c.srecommend = s.custid
	WHERE EXISTS (SELECT 1 FROM #OfferedSite WHERE site = ca.site)
		AND EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND c.roleid=1 
		AND ci.Enabled=1

	----------- For SMA  -----------
	INSERT INTO #SMATemp (CustID,RoleID)	
	-----------------------Master--------------------------------------
	SELECT d.CustID, 3 -- Direct Master 
	FROM #DirectMaster d	
	UNION 
	SELECT DISTINCT d.mrecommend, 3 -- Master of direct agent
	FROM #DirectAgent d
	UNION 
	SELECT DISTINCT d.mrecommend, 3 -- Master of direct member
	FROM #DirectMember D 	
	UNION 
	-----------------------Agent--------------------------------------
	SELECT ci.CustID,2 -- Agent of direct master
	FROM custInfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster D ON ci.mrecommend = d.CustID 
	WHERE ci.roleid = 2 AND ci.Enabled=1 
	UNION
	SELECT DISTINCT d.recommend, 2 -- agent of direct member
	FROM #DirectMember D 	
	UNION 
	SELECT d.CustID, 2 -- Direct Agent
	FROM #DirectAgent D
	UNION ALL
	--dummy account don't have member enabled
	SELECT ci.custid, ci.roleid
	FROM Custinfo ci WITH (NOLOCK)
	WHERE username IN ('WSNT','midrup','MLOTTO','MSSD')

	--Delete dummy account has setting in batch1 from temp table
	DELETE s
	FROM #SMATemp s
	WHERE EXISTS (SELECT 1 FROM #DummyBatch1 WHERE CustID = s.custid)

	---------- For members ---------
	INSERT INTO #MemberTemp (CustID)
	SELECT  ci.custid -- member of direct master
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectMaster m ON ci.mrecommend = m.CustID
	WHERE ci.roleid = 1	AND ci.Enabled = 1 			
	UNION ALL -- member of direct agent
	SELECT  ci.custid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN #DirectAgent a ON ci.recommend = a.CustID
	WHERE ci.roleid = 1 AND ci.Enabled = 1 			
	-- Direct member		
	UNION 
	SELECT ci.custid
	FROM #DirectMember ci	

	SELECT DISTINCT cg.custid 
	INTO #CustPT_Agent
	FROM CustPTSetting3rd_Agent cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #SMATemp s ON ci.custid = s.custid
	WHERE SportType = @Sporttype
						
	SELECT DISTINCT cg.custid 
	INTO #CustPT_Member
	FROM CustPTSetting3rd_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #MemberTemp s ON ci.custid = s.custid
	WHERE SportType = @Sporttype
		
	SELECT DISTINCT cg.AgentID AS CustID
	INTO #CustPTGroup_Member
	FROM CustPTGroupSetting3rd_Member cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.AgentID	
		INNER JOIN #SMATemp s ON ci.custid = s.custid
	WHERE SportType = @Sporttype
				
	SELECT DISTINCT cg.custid 
	INTO #CustBet_Agent
	FROM CustBetSetting3rd_Agent cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #SMATemp s ON ci.custid = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustBet_Member
	FROM CustBetSetting3rd_Member cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #MemberTemp s ON ci.custid = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustDiscount_Agent
	FROM dbo.CustDiscount3rd_Agent cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #SMATemp s ON ci.custid = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustDiscount_Member
	FROM dbo.CustDiscount3rd_Member cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #MemberTemp s ON ci.custid = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustWinLoss_Agent
	FROM dbo.CustWinLossLimit_Agent cg WITH(NOLOCK)	
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID	
		INNER JOIN #SMATemp s ON ci.custid = s.custid
	WHERE SportType = @Sporttype

	SELECT DISTINCT cg.custid 
	INTO #CustWinLoss_Member
	FROM dbo.CustWinLossLimit_Member cg WITH(NOLOCK)		
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cg.CustID
		INNER JOIN #MemberTemp s ON ci.custid = s.custid
	WHERE SportType = @Sporttype

	DELETE cg
	FROM CustPTSetting3rd_Agent cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustPT_Agent ci ON ci.custid = cg.CustID
	WHERE SportType = @Sporttype
						
	DELETE cg
	FROM CustPTSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustPT_Member ci ON ci.custid = cg.CustID
	WHERE SportType = @Sporttype
		
	DELETE cg
	FROM CustPTGroupSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)	
		INNER JOIN #CustPTGroup_Member ci ON ci.CustID = cg.AgentID	
	WHERE SportType = @Sporttype
				
	DELETE cg
	FROM CustBetSetting3rd_Agent cg WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustBet_Agent ci ON ci.custid = cg.CustID			
	WHERE SportType = @Sporttype

	DELETE cg
	FROM CustBetSetting3rd_Member cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustBet_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype

	DELETE cg
	FROM dbo.CustDiscount3rd_Agent cg WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #CustDiscount_Agent ci ON ci.custid = cg.CustID			
	WHERE SportType = @Sporttype

	DELETE cg
	FROM dbo.CustDiscount3rd_Member cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustDiscount_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype

	DELETE cg
	FROM dbo.CustWinLossLimit_Agent cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustWinLoss_Agent ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype

	DELETE cg
	FROM dbo.CustWinLossLimit_Member cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustWinLoss_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype

END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

