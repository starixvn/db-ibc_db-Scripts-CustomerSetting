/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230711
	Task: Delete existing data of Virtual Sports 3 Deposit - UUS [Redmine: #190952]
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductBetSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN Dep_CustProductStatus s WITH (NOLOCK) ON ci.custid = s.CustID
		INNER JOIN Dep_CustPTSetting_Agent a WITH (NOLOCK) ON ci.custid = a.CustID
		CROSS APPLY f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, 33) f		--VS3(Old) Status
		CROSS APPLY Dep_ProductBetSetting ps WITH (NOLOCK)
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled = 1
		AND cs.site IN('spondemo','Athena000')										
		AND a.Sporttype = 190 AND a.Bettype = 2701									--VS2 PT
		AND ps.Sporttype = 178 AND ps.Bettype = 5302 AND ps.Currency = ci.currency
		AND f.value = 0
		AND ci.currency = 20

	CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_Member(CustID INT,Sporttype INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #Dep_CustBetSetting_Agent(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_CustBetSetting_Member(CustID INT,Sporttype INT,Bettype INT, PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSetting(CustID INT, ProductSettingID INT, PRIMARY KEY(CustID, ProductSettingID))

	INSERT INTO #Dep_CustPTSetting_Agent(CustID,Sporttype,Bettype,IsLive)
	SELECT s.Custid, s.SportType, s.BetType, s.IsLive 
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustPTSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.CustID, s.Sporttype, s.Bettype, s.IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustPTGroupSetting_Member(CustID,Sporttype,Bettype,IsLive)
	SELECT s.AgentID, s.SportType, s.BetType, s.IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustBetSetting_Agent(CustID,Sporttype,Bettype)
	SELECT s.CustID, s.SportType, s.BetType 
	FROM Dep_CustBetSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_CustBetSetting_Member(CustID,Sporttype,Bettype)
	SELECT s.CustID, s.SportType, s.BetType 
	FROM Dep_CustBetSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE s.SportType =178 AND c.srecommend IN(SELECT CustID FROM #supers)

	INSERT INTO #Dep_LicenseeProductSetting(CustID, ProductSettingID)
	SELECT s.CustID, s.ProductSettingID
	FROM Dep_LicenseeProductSetting s WITH(NOLOCK)
		INNER JOIN Dep_ProductSetting p WITH (NOLOCK) ON s.ProductSettingID = p.ProductSettingID
	WHERE p.ProductID = 77

	IF EXISTS(SELECT 1 FROM #Dep_CustPTSetting_Agent)
	BEGIN
		DELETE cg
		FROM Dep_CustPTSetting_Agent cg WITH(ROWLOCK,UPDLOCK)	
			INNER JOIN #Dep_CustPTSetting_Agent t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END	
	
	IF EXISTS(SELECT 1 FROM #Dep_CustPTSetting_Member)
	BEGIN					
		DELETE cg
		FROM Dep_CustPTSetting_Member cg WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Dep_CustPTSetting_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive
		OPTION(MAXDOP 1)		
	END  
	
	IF EXISTS(SELECT 1 FROM #Dep_CustPTGroupSetting_Member)
	BEGIN	
		DELETE cg
		FROM Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Dep_CustPTGroupSetting_Member t 
				ON cg.AgentID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive		
	END 		
			
	IF EXISTS(SELECT 1 FROM #Dep_CustBetSetting_Agent)
	BEGIN		
		DELETE cg
		FROM Dep_CustBetSetting_Agent cg WITH(ROWLOCK,UPDLOCK)
			INNER  JOIN #Dep_CustBetSetting_Agent t
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype 		
	END 

	IF EXISTS(SELECT 1 FROM #Dep_CustBetSetting_Member)
	BEGIN
		DELETE cg
		FROM Dep_CustBetSetting_Member cg WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Dep_CustBetSetting_Member t 
				ON cg.CustID=t.CustID	AND cg.SportType=t.Sporttype AND cg.BetType=t.Bettype 	
		OPTION(MAXDOP 1)		
	END	

	IF EXISTS(SELECT 1 FROM #Dep_LicenseeProductSetting)
	BEGIN
		DELETE a
		FROM Dep_LicenseeProductSetting a WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Dep_LicenseeProductSetting t ON a.CustID = t.CustID AND a.ProductSettingID = t.ProductSettingID
	END

	DROP TABLE #Dep_CustBetSetting_Agent, 
				#Dep_CustBetSetting_Member,
				#Dep_CustPTGroupSetting_Member,
				#Dep_CustPTSetting_Agent,
				#Dep_CustPTSetting_Member,
				#Dep_LicenseeProductSetting,
				#supers
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST & ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

DECLARE @target NVARCHAR(20)

IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

EXEC Acc_Dep_DynamicCustSetting_09 @target = @target


PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'
-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST & ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------