/*
	Created: Winnie
	Date: 20181011
	Task: Delete existing data of Deposit Esports
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
	,@maxcustid INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN		
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN		

	DECLARE @Sporttype INT = 43, @BetType INT = 1

	CREATE TABLE #supers			(custid INT)
	CREATE TABLE #supersAsiabet88	(custid INT)
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY,recommend INT)
	CREATE TABLE #tmpCustAsiabet88	(CustID INT PRIMARY KEY,recommend INT)
	CREATE TABLE #tmpCustInsert		(CustID INT PRIMARY KEY,recommend INT)	

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site IN('Avia','GamingSoft','DBP','HL8','TLC','368Cash','Senibet','HonorW','Vwin','W88','12Bet','alog','mansion88','MayFair','OLE777','Salon365','SunGame'
						,'HAIFA','Bodog','Boma365','Happy1668','Hengcai88','KeenOcean','Unobet','ISC888','3star88','Newhonbet','Zzun88','Abcasino','Hecbet','iBET','Royal'
						,'XTD3','IBO','Liga','88Macao','9Club','Ae88','AG','HONBET','NBCbet','Aoncash','BE7','ITCBet','M8bola','Macaubet','Q8bola','9bet','TGO'
						,'WeBet168','KhmerG','365online','IONclub','Mayayule','Sun988','DEWA','Gampag','sbcbet','Bolanation','HuangMa','Webet138','Boying','webet88','MrCat','PKbet','BigGaming'
						,'NextBet','VCBA','Ty777','Taipanbet','Dawoo','BetStar','FLC','Sunrise','Uwoniwin','ECLBET','PanguGame','TGame','818Bet','Heaven','IGPTech','SSSSEA','K8VN'
						,'GPIGAME','Jinyazhou','Swin','Brown888','396Club','e8casino','HongChow','Lucky88','MAX88','OPEBET','BBIN2','Bobo88','GMASTER','Opal88','Sunriseb2b'
						,'YongBao','ALPHA88','11bet','Aplus','Fugui','zt828','ENTAPLAY','MICL','Tripleone','Yibo','TangChao','WBS','CGame','Xinbo','24TECH'
						,'FB88','9wickets','YBTech','jinmangguo','Monaco','GWORLD','BETSUN','Mybet88','JIBET','Gameroom','Fabet','WINCLUB88','Callmeboss'
						,'Uwin18','GOAB88','108bet','Citybk','HOT88','SSSGaming','ANGbet')

	
	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site IN('asiabet88')
		AND ci.currency NOT IN(3,6)

	INSERT INTO #supersAsiabet88(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site IN('asiabet88')
		AND ci.currency IN(3,6)

	INSERT INTO #tmpCust(CustID,recommend)
	SELECT BA.custID,c.recommend
	FROM Dep_CustBAActive BA WITH(NOLOCK)
		INNER JOIN Customer c WITH(NOLOCK) ON BA.CustId=c.custid
	WHERE BA.CustId<=@maxcustid AND c.srecommend IN(SELECT CustId FROM #supers)

	INSERT INTO #tmpCustAsiabet88(CustID,recommend)
	SELECT c.custID,c.recommend
	FROM custInfo c WITH(NOLOCK) 
	WHERE c.CustId<=@maxcustid AND c.srecommend IN(SELECT CustId FROM #supersAsiabet88)
			AND c.CustId NOT IN(SELECT CustID FROM Dep_CustBAActive BA WITH(NOLOCK))
			AND c.Enabled=1

	WHILE EXISTS(SELECT 1 FROM #tmpCust)
	BEGIN
		DELETE TOP (1000) #tmpCust OUTPUT DELETED.* INTO #tmpCustInsert

		INSERT INTO [dbo].[Dep_CustPTSetting_Member]
			   (CustID
			   ,[SportType]
			   ,[BetType]
			   ,[IsLive]
			   ,[SuperPT]
			   ,[MasterPT]
			   ,[AgentPT])
		SELECT 
				BA.CustId
			   ,@Sporttype
			   ,@BetType
			   ,0
			   ,0
			   ,0
			   ,0
		FROM #tmpCustInsert BA WITH(NOLOCK)		

		INSERT INTO [dbo].[Dep_CustPTSetting_Member]
			   (CustID
			   ,[SportType]
			   ,[BetType]
			   ,[IsLive]
			   ,[SuperPT]
			   ,[MasterPT]
			   ,[AgentPT])
		SELECT 
				BA.CustId
			   ,SportType
			   ,BetType
			   ,[IsLive]
			   ,[SuperPT]
			   ,[MasterPT]
			   ,[AgentPT]
		FROM #tmpCustInsert BA WITH(NOLOCK)		
			INNER JOIN [Dep_CustPTGroupSetting_Member] s WITH(NOLOCK) ON BA.recommend=s.AgentID
		WHERE s.SportType<>@Sporttype AND s.BetType<>@BetType

		UPDATE m
			SET m.IsGroupedPT=0
		FROM Dep_CustSettingMode m WITH(NOLOCK)
			INNER JOIN #tmpCustInsert ba WITH(NOLOCK) ON m.CustID=ba.CustId				
		
		TRUNCATE TABLE #tmpCustInsert
	END

	INSERT INTO [dbo].[Dep_CustPTSetting_Member]
			   (CustID
			   ,[SportType]
			   ,[BetType]
			   ,[IsLive]
			   ,[SuperPT]
			   ,[MasterPT]
			   ,[AgentPT])
	SELECT 
			BA.CustId
			,SportType
			,BetType
			,[IsLive]
			,[SuperPT]
			,[MasterPT]
			,[AgentPT]
	FROM #tmpCustAsiabet88 BA WITH(NOLOCK)		
		INNER JOIN Dep_CustPTSetting_Agent s WITH(NOLOCK) ON BA.recommend=s.CustID		

	UPDATE m
		SET m.IsGroupedPT=0
	FROM Dep_CustSettingMode m WITH(NOLOCK)
		INNER JOIN #tmpCustAsiabet88 ba WITH(NOLOCK) ON m.CustID=ba.CustId				
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT
SELECT @max_custid = xxx

EXEC Acc_DynamicCustSetting3rd_09	@target = 'REPLICATED'
									,@maxcustid = @max_custid

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT
SELECT @max_custid = xxx
EXEC Acc_DynamicCustSetting3rd_09	@target = 'DBCUST'
									,@maxcustid = @max_custid
