/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231018@Johnson
	Task: backup Saba Games settings
	DB: DBCust/CustDB
*/
-----------------------------------------------------------------------------
--prepare structure
SELECT TOP 0 *
INTO tmpCustPTGroupSetting3rd_Member_bk
FROM CustPTGroupSetting3rd_Member

SELECT TOP 0 *
INTO tmpCustPTSetting3rd_Agent_bk
FROM CustPTSetting3rd_Agent

SELECT TOP 0 *
INTO tmpCustWinLossLimit_Agent_bk
FROM CustWinLossLimit_Agent

SELECT TOP 0 *
INTO tmpCustStakeLevel_Agent_bk
FROM CustStakeLevel_Agent

SELECT TOP 0 *
INTO tmpCustPTSetting3rd_Member_bk
FROM CustPTSetting3rd_Member

SELECT TOP 0 *
INTO tmpCustWinLossLimit_Member_bk
FROM CustWinLossLimit_Member

SELECT TOP 0 *
INTO tmpCustStakeLevel_Member_bk
FROM CustStakeLevel_Member
GO

-----------------------------------------------------------
--backup data
DECLARE @custid INT
	
CREATE TABLE #tblSuper(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #tblSuper(custid)	
SELECT DISTINCT ci.custid
FROM vw_customer ci WITH (NOLOCK) 
    INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
    INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site 
    INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	LEFT JOIN CustPTSetting3rd_Agent pt WITH(NOLOCK) ON ci.custid = pt.custid AND pt.SportType = 200  
	LEFT JOIN CustWinLossLimit_Agent wl WITH(NOLOCK) ON ci.custid = wl.custid AND wl.SportType = 200
	LEFT JOIN CustStakeLevel_Agent sl WITH(NOLOCK) ON ci.custid = sl.custid AND sl.SportType = 200
WHERE ci.roleid = 4     
    AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
    AND s.islicensee = 0    
    AND cs.IsInternal=0       
    AND ci.username not like '3rdSuper%'   
    AND s.siteLabel <> '789y' 
    AND cu.Enabled = 1
	AND (pt.custid IS NOT NULL OR wl.custid IS NOT NULL OR sl.custid IS NOT NULL)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #tblSuper )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
DECLARE @tmpCust TABLE(custid INT PRIMARY KEY)

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tblSuper
	SET isfinished = 1
		,@custid = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	--RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	DECLARE @__msgtemp VARCHAR(200) = @msg + '- curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
	RAISERROR (@__msgtemp, 0, 1, @index, @custid) WITH NOWAIT
	
	
	INSERT INTO #tblCust(custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK) 
	WHERE srecommend = @custid
		AND enabled = 1
	
	INSERT INTO [dbo].[tmpCustPTGroupSetting3rd_Member_bk]
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
    SELECT [AgentID]
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
	FROM CustPTGroupSetting3rd_Member WITH(NOLOCK)
	WHERE SportType = 200
		AND AgentID IN (SELECT custid FROM #tblCust WHERE roleid = 2)
	
	INSERT INTO [dbo].[tmpCustPTSetting3rd_Agent_bk]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[IsAutoMasterPT]
           ,[IsAutoSuperPT]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[AutoSuperPT]
           ,[AutoMasterPT]
           ,[MinPT]
           ,[MaxPT])
    SELECT [CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[IsAutoMasterPT]
           ,[IsAutoSuperPT]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[AutoSuperPT]
           ,[AutoMasterPT]
           ,[MinPT]
           ,[MaxPT]
	FROM CustPTSetting3rd_Agent WITH(NOLOCK)
	WHERE CustID IN (SELECT custid FROM #tblCust)
		AND SportType = 200

	INSERT INTO [dbo].[tmpCustWinLossLimit_Agent_bk]
           ([CustId]
           ,[SportType]
           ,[BetType]
           ,[MaxWinLimit]
           ,[MaxLossLimit]
           ,[IsAutoReset])
    SELECT [CustId]
           ,[SportType]
           ,[BetType]
           ,[MaxWinLimit]
           ,[MaxLossLimit]
           ,[IsAutoReset]
	FROM CustWinLossLimit_Agent WITH(NOLOCK)
	WHERE CustID IN (SELECT custid FROM #tblCust)
		AND SportType = 200
	
	INSERT INTO [dbo].[tmpCustStakeLevel_Agent_bk]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList])
    SELECT [CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList]
	FROM CustStakeLevel_Agent WITH(NOLOCK)
	WHERE CustID IN (SELECT custid FROM #tblCust)
		AND SportType = 200
		
	INSERT INTO [dbo].[tmpCustPTSetting3rd_Member_bk]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[IsAutoMasterPT]
           ,[IsAutoSuperPT]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[AutoSuperPT]
           ,[AutoMasterPT])
    SELECT [CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[IsAutoMasterPT]
           ,[IsAutoSuperPT]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[AutoSuperPT]
           ,[AutoMasterPT]
	FROM CustPTSetting3rd_Member WITH(NOLOCK)
	WHERE CustID IN (SELECT custid FROM #tblCust)
		AND SportType = 200
	
	INSERT INTO [dbo].[tmpCustWinLossLimit_Member_bk]
           ([CustId]
           ,[SportType]
           ,[BetType]
           ,[MaxWinLimit]
           ,[MaxLossLimit]
           ,[IsAutoReset])
	SELECT [CustId]
           ,[SportType]
           ,[BetType]
           ,[MaxWinLimit]
           ,[MaxLossLimit]
           ,[IsAutoReset]
	FROM CustWinLossLimit_Member WITH(NOLOCK)
	WHERE CustID IN (SELECT custid FROM #tblCust)
		AND SportType = 200
		
	INSERT INTO [dbo].[tmpCustStakeLevel_Member_bk]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList]
           ,[LastUpdated])
    SELECT [CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList]
           ,[LastUpdated]	
	FROM CustStakeLevel_Member WITH(NOLOCK)
	WHERE CustID IN (SELECT custid FROM #tblCust)
		AND SportType = 200
	
	DELETE #tblCust	
	
END	