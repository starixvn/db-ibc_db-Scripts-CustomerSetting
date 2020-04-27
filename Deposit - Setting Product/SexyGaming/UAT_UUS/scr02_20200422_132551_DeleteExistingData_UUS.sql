/*
	Created: 20200422@Tiara
	Date: 20200422
	Task: Delete existing data of Sexy Gaming Deposit - UUS [Redmine: 132551]
	DB: DBCUST/CustDB
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

	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN('spondemo','Athena000')
		AND ci.currency=20

	CREATE TABLE #CustPTSetting3rd_Agent(CustID INT,SporttypeID INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ,IsLive))
	CREATE TABLE #CustPTSetting3rd_Member(CustID INT,SporttypeID INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ,IsLive))
	CREATE TABLE #CustPTGroupSetting3rd_Member(CustID INT,SporttypeID INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ,IsLive))
	CREATE TABLE #CustBetSetting3rd_Agent(CustID INT,SporttypeID INT,Bettype INT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ))
	CREATE TABLE #CustBetSetting3rd_Member(CustID INT,SporttypeID INT,Bettype INT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ))

	INSERT INTO #CustPTSetting3rd_Agent(CustID,SporttypeID,Bettype,IsLive)
	SELECT s.Custid,SportType,BetType,IsLive 
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =243 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #CustPTSetting3rd_Member(CustID,SporttypeID,Bettype,IsLive)
	SELECT s.CustID,Sporttype,Bettype,IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =243 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #CustPTGroupSetting3rd_Member(CustID,SporttypeID,Bettype,IsLive)
	SELECT AgentID,SportType,BetType,IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	WHERE SportType =243 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #CustBetSetting3rd_Agent(CustID,SporttypeID,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =243 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #CustBetSetting3rd_Member(CustID,SporttypeID,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =243 AND c.srecommend IN(SELECT CustID FROM #supers)

	IF EXISTS(SELECT 1 FROM #CustPTSetting3rd_Agent)
	BEGIN
		DELETE cg
		FROM Dep_CustPTSetting_Agent cg 	
			INNER JOIN #CustPTSetting3rd_Agent t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END	
	
	IF EXISTS(SELECT 1 FROM #CustPTSetting3rd_Member)
	BEGIN					
		DELETE cg
		FROM Dep_CustPTSetting_Member cg
			INNER JOIN #CustPTSetting3rd_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
		OPTION(MAXDOP 1)		
	END  
	
	IF EXISTS(SELECT 1 FROM #CustPTGroupSetting3rd_Member)
	BEGIN	
		DELETE cg
		FROM Dep_CustPTGroupSetting_Member cg 
			INNER JOIN #CustPTGroupSetting3rd_Member t 
				ON cg.AgentID=t.CustID	AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END 		
			
	IF EXISTS(SELECT 1 FROM #CustBetSetting3rd_Agent)
	BEGIN		
		DELETE cg
		FROM Dep_CustStakeLevel_Agent cg
			INNER  JOIN #CustBetSetting3rd_Agent t
				ON cg.CustID=t.CustID	AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype 		
	END 

	IF EXISTS(SELECT 1 FROM #CustBetSetting3rd_Member)
	BEGIN
		DELETE cg
		FROM Dep_CustStakeLevel_Member cg	
			INNER JOIN #CustBetSetting3rd_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype 	
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
