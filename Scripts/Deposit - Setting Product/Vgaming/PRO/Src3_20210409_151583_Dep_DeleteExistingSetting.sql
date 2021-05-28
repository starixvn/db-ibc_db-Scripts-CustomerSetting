/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210409
	Task:  Insert Setting StakeLevelGroupDetail [Vgaming] - deposit RedmineID:#151583
	DB: DBCUST/CustDB
	
	P/s : Step 3 Delete existing data saba.Club for all currency
*/
-- BEGIN STEP 3.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN
	
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	DECLARE @sportType SMALLINT , @BetType SMALLINT
	SELECT @sportType = 171 , @BetType = 3801
	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND (cs.site IN('3Star88','88Macao','AE88','AG','9Club','iBET','IBO','Liga','Abcasino','Hecbet','Dewa','TGO','365online','IONclub','Mayayule','Gampag','HuangMa','BigGaming','Boying','PKbet','IGPTech','Dawoo','CGame','Uwoniwin','ECLBET','818Bet','Heaven','Lucky88','396Club','Mybet88','e8casino','TangChao','Tripleone','11bet','GMaster','WBS','FB88','zt828','BETSUN','JIBET','WINCLUB88','Fabet','ANGbet','One88','Hong88','Bobbet','AEUG','Sin88','Debet','Zbet','Sunwin','VCBA','Gaobet','GGBook','Five88','Champion','AnvoFH','Leng4D','BBIN3','Onegaming','B24VN','allwincity','BWGaming','KingBet','Datang','YTX','erhaozhan','Datang001','CGame4','starsoccer','Lode88','XTDGT','yunji','Tianbo','TCBet','TaoCai','Soon88','Bsdbet','998bet','M8Credit','MANBETX','WMCASINO','Winbox','TIC88','Nbet','Sky88','Kbet','Dabet','AOGcasino','XO88','OXbet','RICbet','WABET','Kzing2','ManCity','Alphalota','GAMEBee','bdtt','HOT99','X2Dynamic','ug396','7Kplatform','WGaming','IGSW','TYCgame','BananaTech','UNOgaming','Pinbo','XINSHNEG','Comebet','Easywin22','Win365','BB3','ECBet88','FHLMSABA','UG2','ab6688','Mancity2','VEGA77','dj888','Barcelo9','Aoncash','Macaubet','ITCbet','9bet','M8bola','BE7','Q8bola','Bolanation','UNObet','18Luck','24AVIA','368CASH','Alpha88','BOG22','Callmeboss','DF88','GAMINGSOFT','GPIgame','Happy8','HC6YAYOU','Happy1668','Hejiyongle','HONORW','ID88','liv66','KeenOcean','mansion88','MAX88','Nbbet','OPEbet','SENIBET','TT128','US8YAYOU','VN88','W88','Xtu168','12BET','HL8','Saba789')
	AND ci.currency IN (2,3,4,5,6,9,12,13,15,20,32,41,45,46,49,50,52,53,54,55,56,57,58,61,66,70,71,73,79,80,82,83,85,86,92,93,94,96,97,121) )
	
	CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustStakeLevel_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustStakeLevel_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustStakeLevel_AgentTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustStakeLevel_MemberTemp(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSettingTemp(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	INSERT INTO #Dep_CustPTSetting_Agent(CustID,Sporttype,Bettype,IsLive)
	SELECT s.Custid,SportType,BetType,IsLive 
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #Dep_CustPTSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.CustID,Sporttype,Bettype,IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #Dep_CustPTGroupSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT AgentID,SportType,BetType,IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType 

	INSERT INTO #Dep_CustStakeLevel_Agent(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType

	INSERT INTO #Dep_CustStakeLevel_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
		INNER JOIN #supers su ON c.srecommend = su.custid
	WHERE SportType =@sportType AND BetType = @BetType 

	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID,dl.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
			INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE dp.ProductID = 66

	DECLARE @batch int = 3000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustPTSetting_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive INTO #Dep_CustPTSetting_AgentTemp(CustID,Sporttype,Bettype,IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive

		TRUNCATE TABLE #Dep_CustPTSetting_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Member)
	BEGIN	
	
		DELETE TOP (@batch) #Dep_CustPTSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive INTO #Dep_CustPTSetting_MemberTemp(CustID,Sporttype,Bettype,IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
		OPTION(MAXDOP 1)
		
		TRUNCATE TABLE #Dep_CustPTSetting_MemberTemp
				
	END  
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTGroupSetting_Member)
	BEGIN	
		DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype,DELETED.IsLive INTO #Dep_CustPTGroupSetting_MemberTemp(CustID,Sporttype,Bettype,IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTGroupSetting_MemberTemp  t 
				ON cg.AgentID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
			
		TRUNCATE TABLE #Dep_CustPTGroupSetting_MemberTemp			
	END 		
			
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Agent)
	BEGIN		
			
		DELETE TOP (@batch) #Dep_CustStakeLevel_Agent OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustStakeLevel_AgentTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustStakeLevel_AgentTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype

		TRUNCATE TABLE #Dep_CustStakeLevel_AgentTemp				
	END 

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustStakeLevel_Member OUTPUT DELETED.CustID,DELETED.Sporttype,DELETED.Bettype INTO #Dep_CustStakeLevel_MemberTemp(CustID,Sporttype,Bettype)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustStakeLevel_MemberTemp  t 
				ON cg.CustID=t.CustID AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype
		OPTION(MAXDOP 1)	
		
		TRUNCATE TABLE #Dep_CustStakeLevel_MemberTemp
			
	END	
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
	BEGIN	
		DELETE TOP (@batch) #Dep_LicenseeProductSetting OUTPUT DELETED.CustID,DELETED.ProductSettingID INTO #Dep_LicenseeProductSettingTemp(CustID,ProductSettingID)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_LicenseeProductSetting cg WITH(ROWLOCK)		
		INNER JOIN #Dep_LicenseeProductSettingTemp  t 
			ON cg.CustID=t.CustID AND cg.ProductSettingID=t.ProductSettingID	
	
		TRUNCATE TABLE #Dep_LicenseeProductSettingTemp			
	END
	
	DROP TABLE #Dep_CustPTSetting_Agent
	DROP TABLE #Dep_CustPTSetting_Member
	DROP TABLE #Dep_CustPTGroupSetting_Member
	DROP TABLE #Dep_CustStakeLevel_Agent
	DROP TABLE #Dep_CustStakeLevel_Member
	DROP TABLE #Dep_LicenseeProductSetting
END	
GO
-- END STEP 3.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 3.2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

-- BEGIN STEP 3.3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'
