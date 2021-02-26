/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200828
	Task: Delete existing data or Sports Lottery UUS [Redmine: 147361]
	DB: DBCust/CustDB
	
	P/s : Step 1 Delete existing data or Sports Lottery UUS
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
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	DECLARE @sportType SMALLINT	 = 169

	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN('spondemo','Athena000')
		AND ci.currency in (72,20)

	CREATE TABLE #CustPTSetting_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTGroupSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustBetSetting_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #CustBetSetting_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))

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

	INSERT INTO #CustBetSetting_Agent(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #CustBetSetting_Member(CustID,Sporttype,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =@sportType AND c.srecommend IN(SELECT CustID FROM #supers)

	IF EXISTS(SELECT 1 FROM #CustPTSetting_Agent)
	BEGIN
		DELETE cg
		FROM Dep_CustPTSetting_Agent cg 	
			INNER JOIN #CustPTSetting_Agent t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END	
	
	IF EXISTS(SELECT 1 FROM #CustPTSetting_Member)
	BEGIN					
		DELETE cg
		FROM Dep_CustPTSetting_Member cg
			INNER JOIN #CustPTSetting_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
		OPTION(MAXDOP 1)		
	END  
	
	IF EXISTS(SELECT 1 FROM #CustPTGroupSetting_Member)
	BEGIN	
		DELETE cg
		FROM Dep_CustPTGroupSetting_Member cg 
			INNER JOIN #CustPTGroupSetting_Member t 
				ON cg.AgentID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END 		
			
	IF EXISTS(SELECT 1 FROM #CustBetSetting_Agent)
	BEGIN		
		DELETE cg
		FROM Dep_CustStakeLevel_Agent cg
			INNER  JOIN #CustBetSetting_Agent t
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype 		
	END 

	IF EXISTS(SELECT 1 FROM #CustBetSetting_Member)
	BEGIN
		DELETE cg
		FROM Dep_CustStakeLevel_Member cg	
			INNER JOIN #CustBetSetting_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype 	
		OPTION(MAXDOP 1)		
	END	
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
