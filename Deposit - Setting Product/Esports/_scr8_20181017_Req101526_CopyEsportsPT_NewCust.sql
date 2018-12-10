/*
	Created: Winnie
	Task: Copy PT & Bet setting for Esports new cust  RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181015
*/ 
USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
(@MaxCustID INT)
AS
BEGIN
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN



	DECLARE @AgentID	INT,@CustID	INT

	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM Custinfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN('Avia','GamingSoft','DBP','HL8','TLC','368Cash','Senibet','HonorW','Vwin','W88','alog','12Bet','asiabet88','mansion88','MayFair','OLE777','Salon365','SunGame'
					,'HAIFA','Bodog','Boma365','Happy1668','Hengcai88','KeenOcean','Unobet','ISC888','3star88','Newhonbet','Zzun88','Abcasino','Hecbet','iBET','Royal'
					,'XTD3','IBO','Liga','88Macao','9Club','Ae88','AG','HONBET','NBCbet','Aoncash','BE7','ITCBet','M8bola','Macaubet','Q8bola','9bet','TGO'
					,'WeBet168','KhmerG','365online','IONclub','Mayayule','Sun988','DEWA','Gampag','sbcbet','Bolanation','HuangMa','Webet138','Boying','webet88','MrCat','PKbet','BigGaming'
					,'NextBet','VCBA','Ty777','Taipanbet','Dawoo','BetStar','FLC','Sunrise','Uwoniwin','ECLBET','PanguGame','TGame','818Bet','Heaven','IGPTech','SSSSEA','K8VN'
					,'GPIGAME','Jinyazhou','Swin','Brown888','396Club','e8casino','HongChow','Lucky88','MAX88','OPEBET','BBIN2','Bobo88','GMASTER','Opal88','Sunriseb2b'
					,'YongBao','ALPHA88','11bet','Aplus','Fugui','zt828','ENTAPLAY','MICL','Tripleone','Yibo','TangChao','WBS','CGame','Xinbo','24TECH'
					,'FB88','9wickets','YBTech','jinmangguo','Monaco','GWORLD','BETSUN','Mybet88','JIBET','Gameroom','Fabet','WINCLUB88','Callmeboss'
					,'Uwin18','GOAB88','108bet','Citybk','HOT88','SSSGaming','ANGbet'
					,'HJTK','One88','Dachen','BetDeal','Dade','Nbbet','Bobbet','TitanOne')
		AND ci.custid<>916498


	DECLARE @fSportType INT = 99, @fBetType INT=1
	DECLARE @Sporttype INT = 43

	CREATE TABLE #Dummy (CustID INT PRIMARY KEY)	
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers)
		AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%Cas%' OR username LIKE '%LocalBank%')
		AND custid<=@maxcustid
	
	--------------------------------------PT Setting-------------------------------------------------	
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
	FROM Customer ci WITH(NOLOCK)
	WHERE ci.custid IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid
	
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
	FROM Customer ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid
		AND roleid=3
		AND custid NOT IN(SELECT CustID FROM #Dummy)

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
	FROM Customer ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid
		AND roleid=2 
		AND mrecommend NOT IN(SELECT CustID FROM #Dummy)

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
	WHERE srecommend IN(SELECT custid FROM #supers)
		AND custid>@maxcustid
		AND roleid=2 
		AND mrecommend NOT IN(SELECT CustID FROM #Dummy)

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
	FROM Customer t WITH(NOLOCK)
	WHERE t.srecommend IN(SELECT custid FROM #supers)
		AND t.custid>@maxcustid
		AND roleid=1 AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=t.CustID)
		AND mrecommend NOT IN(SELECT CustID FROM #Dummy)
		
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT CustID,24
	FROM #supers ci
	WHERE ci.custid>@maxcustid

	--------------------------------------Bet Setting-------------------------------------------------		

	--Agent Level
	INSERT INTO dbo.Dep_CustBetSetting_Agent(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)		
	SELECT 
	ci.CustID			,
	@Sporttype			,
	@fBetType			,		
	MinBet				,
	MaxBet				,
	MaxPerMatch99			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid  AND cs.sporttype=@fSportType AND cs.bettype=@fBetType
		AND roleid IN(2,3,4)
		AND mrecommend NOT IN(SELECT CustID FROM #Dummy)

	--Member Level
	INSERT INTO dbo.Dep_CustBetSetting_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
	SELECT 
	ci.CustID			,	
	@Sporttype			,
	@fBetType			,		
	MinBet				,
	MaxBet				,
	MaxPerMatch99			
	FROM custInfo ci WITH(NOLOCK)
		 INNER JOIN dbo.Dep_custSetting cs WITH(NOLOCK) ON ci.custid=cs.custid
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid  AND cs.sporttype=@fSportType AND cs.bettype=@fBetType
		AND roleid = 1 
		AND mrecommend NOT IN(SELECT CustID FROM #Dummy)

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT CustID,25
	FROM #supers ci
	WHERE ci.custid>@maxcustid

	DROP TABLE #supers
END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_DynamicCustSetting3rd_09 @MaxCustID=@MaxCustID