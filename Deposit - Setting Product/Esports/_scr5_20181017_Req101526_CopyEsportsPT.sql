/*
	Created: Winnie
	Task: Copy PT & Bet setting for Esports Deposit RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181011
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN

	DECLARE @fSportType INT = 99, @fBetType INT=1
	DECLARE @Sporttype	INT = 43	
	
	--------------------------------------PT Setting-------------------------------------------------	

	CREATE TABLE #Dummy (CustID INT PRIMARY KEY)	
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%Cas%' OR username LIKE '%LocalBank%')
		AND custid<=@maxcustid 
	--AGENT LEVEL	
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@fBetType
		   ,0
		   ,CASE WHEN site='Haifa' THEN 90.5 ELSE 85 END
		   ,CASE WHEN site='Haifa' THEN 90.5 ELSE 85 END
		   ,CASE WHEN site='Haifa' THEN 90.5 ELSE 85 END	
	FROM Customer WITH(NOLOCK)
	WHERE custid=@srecommend
	
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@fBetType
		   ,0
		   ,0
		   ,CASE WHEN site='Haifa' THEN 90.5 ELSE 85 END
		   ,0	
	FROM Customer WITH(NOLOCK)
	WHERE srecommend=@srecommend AND roleid=3 AND custid<=@maxcustid 
		AND custid NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@fBetType
		   ,0
		   ,0
		   ,0
		   ,CASE WHEN site='Haifa' THEN 90.5 ELSE 85 END
	FROM Customer WITH(NOLOCK)
	WHERE srecommend=@srecommend AND roleid=2 AND custid<=@maxcustid 
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustPTGroupSetting_Member
		(	AgentID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@fBetType
		   ,0
		   ,0
		   ,0
		   ,CASE WHEN site='Haifa' THEN 90.5 
				 WHEN site='Asiabet88' AND currency IN(3,6) THEN 0
			ELSE 85 END
	FROM Customer WITH(NOLOCK)
	WHERE srecommend=@srecommend AND roleid=2 AND custid<=@maxcustid 
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
	FROM Customer t WITH(NOLOCK)
	WHERE srecommend=@srecommend 
		AND custid<=@maxcustid 
		AND roleid=1 AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=t.CustID)
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,24

	--------------------------------------Bet Setting-------------------------------------------------		

	--Agent Level
	INSERT INTO dbo.Dep_CustBetSetting_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)	
	SELECT 
		ci.CustID			,		
		@Sporttype			,
		@fBetType			,		
		MinBet				,
		MaxBet				,
		maxpermatch99			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid AND cs.sporttype=@fSportType AND cs.bettype=@fBetType	
		AND roleid IN(2,3,4)
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)	

	--Member Level
	INSERT INTO dbo.Dep_CustBetSetting_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)			
	SELECT 
		ci.CustID			,	
		@Sporttype			,
		@fBetType			,		
		MinBet				,
		MaxBet				,
		maxpermatch99			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE ci.srecommend = @srecommend AND ci.custid<=@maxcustid AND cs.sporttype=@fSportType AND cs.bettype=@fBetType	
		AND roleid = 1 
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,25

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('Avia','GamingSoft','DBP','HL8','TLC','368Cash','Senibet','HonorW','Vwin','W88','12Bet','alog','asiabet88','mansion88','MayFair','OLE777','Salon365','SunGame'
					,'HAIFA','Bodog','Boma365','Happy1668','Hengcai88','KeenOcean','Unobet','ISC888','3star88','Newhonbet','Zzun88','Abcasino','Hecbet','iBET','Royal'
					,'XTD3','IBO','Liga','88Macao','9Club','Ae88','AG','HONBET','NBCbet','Aoncash','BE7','ITCBet','M8bola','Macaubet','Q8bola','9bet','TGO'
					,'WeBet168','KhmerG','365online','IONclub','Mayayule','Sun988','DEWA','Gampag','sbcbet','Bolanation','HuangMa','Webet138','Boying','webet88','MrCat','PKbet','BigGaming'
					,'NextBet','VCBA','Ty777','Taipanbet','Dawoo','BetStar','FLC','Sunrise','Uwoniwin','ECLBET','PanguGame','TGame','818Bet','Heaven','IGPTech','SSSSEA','K8VN'
					,'GPIGAME','Jinyazhou','Swin','Brown888','396Club','e8casino','HongChow','Lucky88','MAX88','OPEBET','BBIN2','Bobo88','GMASTER','Opal88','Sunriseb2b'
					,'YongBao','ALPHA88','11bet','Aplus','Fugui','zt828','ENTAPLAY','MICL','Tripleone','Yibo','TangChao','WBS','CGame','Xinbo','24TECH'
					,'FB88','9wickets','YBTech','jinmangguo','Monaco','GWORLD','BETSUN','Mybet88','JIBET','Gameroom','Fabet','WINCLUB88','Callmeboss'
					,'Uwin18','GOAB88','108bet','Citybk','HOT88','SSSGaming','ANGbet')

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
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.280'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('Avia','GamingSoft','DBP','HL8','TLC','368Cash','Senibet','HonorW','Vwin','W88','12Bet','alog','asiabet88','mansion88','MayFair','OLE777','Salon365','SunGame'
					,'HAIFA','Bodog','Boma365','Happy1668','Hengcai88','KeenOcean','Unobet','ISC888','3star88','Newhonbet','Zzun88','Abcasino','Hecbet','iBET','Royal'
					,'XTD3','IBO','Liga','88Macao','9Club','Ae88','AG','HONBET','NBCbet','Aoncash','BE7','ITCBet','M8bola','Macaubet','Q8bola','9bet','TGO'
					,'WeBet168','KhmerG','365online','IONclub','Mayayule','Sun988','DEWA','Gampag','sbcbet','Bolanation','HuangMa','Webet138','Boying','webet88','MrCat','PKbet','BigGaming'
					,'NextBet','VCBA','Ty777','Taipanbet','Dawoo','BetStar','FLC','Sunrise','Uwoniwin','ECLBET','PanguGame','TGame','818Bet','Heaven','IGPTech','SSSSEA','K8VN'
					,'GPIGAME','Jinyazhou','Swin','Brown888','396Club','e8casino','HongChow','Lucky88','MAX88','OPEBET','BBIN2','Bobo88','GMASTER','Opal88','Sunriseb2b'
					,'YongBao','ALPHA88','11bet','Aplus','Fugui','zt828','ENTAPLAY','MICL','Tripleone','Yibo','TangChao','WBS','CGame','Xinbo','24TECH'
					,'FB88','9wickets','YBTech','jinmangguo','Monaco','GWORLD','BETSUN','Mybet88','JIBET','Gameroom','Fabet','WINCLUB88','Callmeboss'
					,'Uwin18','GOAB88','108bet','Citybk','HOT88','SSSGaming','ANGbet')

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
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.280'
END

PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
