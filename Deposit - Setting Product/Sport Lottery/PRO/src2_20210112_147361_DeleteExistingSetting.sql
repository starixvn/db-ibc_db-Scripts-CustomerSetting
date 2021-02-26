/*
	Created: Winfred
	Date: 20210223
	Task: Delete existing data for Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 2 Delete existing data
*/
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
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	DECLARE @sportType SMALLINT
	SET @sportType = 169
	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20,72)))


	CREATE TABLE #CustPTSetting_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTGroupSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustBetSetting_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustBetSetting_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT,ProductSettingID INT, PRIMARY KEY(CustID ,ProductSettingID ))

	INSERT INTO #CustPTSetting_Agent(CustID,Sporttype,Bettype,IsLive)
	SELECT s.Custid,SportType,BetType,IsLive 
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #CustPTSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.CustID,Sporttype,Bettype,IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #CustPTGroupSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT AgentID,SportType,BetType,IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustBetSetting_Agent(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustBetSetting_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustBetSetting_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID,dl.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
			INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
			INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
			INNER JOIN #supers s ON ci.srecommend = s.custid
	WHERE dp.ProductID = 63

	IF EXISTS(SELECT 1 FROM #CustPTSetting_Agent)
	BEGIN
		DELETE cg
		FROM Dep_CustPTSetting_Agent cg WITH(ROWLOCK,UPDLOCK) 	
			INNER JOIN #CustPTSetting_Agent t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END	
	
	IF EXISTS(SELECT 1 FROM #CustPTSetting_Member)
	BEGIN					
		DELETE cg
		FROM Dep_CustPTSetting_Member cg WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustPTSetting_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.SportType AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
		OPTION(MAXDOP 1)		
	END  
	
	IF EXISTS(SELECT 1 FROM #CustPTGroupSetting_Member)
	BEGIN	
		DELETE cg
		FROM Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK,UPDLOCK) 
			INNER JOIN #CustPTGroupSetting_Member t 
				ON cg.AgentID=t.CustID	AND cg.SportType=t.SportType AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END 		
			
	IF EXISTS(SELECT 1 FROM #Dep_CustBetSetting_Agent)
	BEGIN		
		DELETE cg
		FROM Dep_CustBetSetting_Agent cg WITH(ROWLOCK,UPDLOCK)
			INNER  JOIN #Dep_CustBetSetting_Agent t
				ON cg.CustID=t.CustID	AND cg.SportType=t.SportType AND cg.BetType=t.Bettype 		
	END 

	IF EXISTS(SELECT 1 FROM #Dep_CustBetSetting_Member)
	BEGIN
		DELETE cg
		FROM Dep_CustBetSetting_Member cg WITH(ROWLOCK,UPDLOCK)	
			INNER JOIN #Dep_CustBetSetting_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.SportType AND cg.BetType=t.Bettype 	
		OPTION(MAXDOP 1)		
	END	
	
	IF EXISTS(SELECT 1 FROM #Dep_LicenseeProductSetting)
	BEGIN
		DELETE cg
		FROM Dep_LicenseeProductSetting cg WITH(ROWLOCK,UPDLOCK) 	
			INNER JOIN #Dep_LicenseeProductSetting t 
				ON cg.CustID=t.CustID	AND cg.ProductSettingID=t.ProductSettingID 
	END
	
	DROP TABLE #CustPTSetting_Agent
	DROP TABLE #CustPTSetting_Member
	DROP TABLE #CustPTGroupSetting_Member
	DROP TABLE #Dep_CustBetSetting_Agent
	DROP TABLE #Dep_CustBetSetting_Member
	DROP TABLE #Dep_LicenseeProductSetting
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'
