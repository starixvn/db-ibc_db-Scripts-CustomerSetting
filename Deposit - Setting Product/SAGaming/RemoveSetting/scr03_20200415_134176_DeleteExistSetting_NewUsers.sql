/*
	Created: 20200514@Tiara
	Date: 20200514
	Task:  Delete existing data of SA Gaming for HK$, RMB, HKK - New users [Redmine: #134176]
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

	DECLARE @maxcustid INT

	SELECT @maxcustid = xxx

	CREATE TABLE #supers (custid INT)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		AND ci.currency IN (5,13,67)--HK$, RMB, HKK


	CREATE TABLE #CustPTSetting3rd_Agent(CustID INT,SporttypeID INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ,IsLive))
	CREATE TABLE #CustPTSetting3rd_Member(CustID INT,SporttypeID INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ,IsLive))
	CREATE TABLE #CustPTGroupSetting3rd_Member(CustID INT,SporttypeID INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ,IsLive))
	CREATE TABLE #CustBetSetting3rd_Agent(CustID INT,SporttypeID INT,Bettype INT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ))
	CREATE TABLE #CustBetSetting3rd_Member(CustID INT,SporttypeID INT,Bettype INT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSetting (CustID INT, ProductSettingID INT)

	CREATE TABLE #CustPTSetting3rd_AgentBatch (CustID INT,SporttypeID INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ,IsLive))
	CREATE TABLE #CustPTSetting3rd_MemberBatch (CustID INT,SporttypeID INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ,IsLive))
	CREATE TABLE #CustPTGroupSetting3rd_MemberBatch (CustID INT,SporttypeID INT,Bettype INT,IsLive BIT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ,IsLive))
	CREATE TABLE #CustBetSetting3rd_AgentBatch (CustID INT,SporttypeID INT,Bettype INT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ))
	CREATE TABLE #CustBetSetting3rd_MemberBatch (CustID INT,SporttypeID INT,Bettype INT, PRIMARY KEY(CustID ,SporttypeID ,Bettype ))
	CREATE TABLE #Dep_LicenseeProductSettingBatch (CustID INT, ProductSettingID INT)

	INSERT INTO #CustPTSetting3rd_Agent(CustID,SporttypeID,Bettype,IsLive)
	SELECT s.Custid,SportType,BetType,IsLive 
	FROM Dep_CustPTSetting_Agent s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =244 AND BetType = 3001 AND c.srecommend IN(SELECT CustID FROM #supers)
		AND s.CustID > @maxcustid


	WHILE EXISTS(SELECT 1 FROM #CustPTSetting3rd_Agent)
	BEGIN
		DELETE TOP (3000) #CustPTSetting3rd_Agent OUTPUT DELETED.* INTO #CustPTSetting3rd_AgentBatch

		IF @@ROWCOUNT=0
			BREAK	
		DELETE TOP (3000) cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustPTSetting3rd_AgentBatch t
			ON cg.CustID=t.CustID AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive	
		
		TRUNCATE TABLE #CustPTSetting3rd_AgentBatch
	END

	INSERT INTO #CustPTSetting3rd_Member(CustID,SporttypeID,Bettype,IsLive)
	SELECT s.CustID,Sporttype,Bettype,IsLive 
	FROM Dep_CustPTSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =244 AND BetType = 3001 AND c.srecommend IN(SELECT CustID FROM #supers)
		AND s.CustID > @maxcustid

	WHILE EXISTS(SELECT 1 FROM #CustPTSetting3rd_Member)
	BEGIN
		DELETE TOP (3000) #CustPTSetting3rd_Member OUTPUT DELETED.* INTO #CustPTSetting3rd_MemberBatch

		IF @@ROWCOUNT=0
			BREAK	
		DELETE TOP (3000) cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustPTSetting3rd_MemberBatch t
			ON cg.CustID=t.CustID AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive	
		
		TRUNCATE TABLE #CustPTSetting3rd_MemberBatch
	END
	INSERT INTO #CustPTGroupSetting3rd_Member(CustID,SporttypeID,Bettype,IsLive)
	SELECT AgentID,SportType,BetType,IsLive 
	FROM Dep_CustPTGroupSetting_Member s WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.AgentID=c.custid
	WHERE SportType =244 AND BetType = 3001 AND c.srecommend IN(SELECT CustID FROM #supers)
		AND s.AgentID > @maxcustid
	
	WHILE EXISTS(SELECT 1 FROM #CustPTGroupSetting3rd_Member)
	BEGIN
		DELETE TOP (3000) #CustPTGroupSetting3rd_Member OUTPUT DELETED.* INTO #CustPTGroupSetting3rd_MemberBatch

		IF @@ROWCOUNT=0
			BREAK	
		DELETE TOP (3000) cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustPTGroupSetting3rd_MemberBatch t
			ON cg.AgentID=t.CustID AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype AND cg.IsLive=t.IsLive	
		
		TRUNCATE TABLE #CustPTGroupSetting3rd_MemberBatch
	END

	INSERT INTO #CustBetSetting3rd_Agent(CustID,SporttypeID,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Agent S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =244 AND BetType = 3001 AND c.srecommend IN(SELECT CustID FROM #supers)
		AND s.CustID > @maxcustid
	
	
	WHILE EXISTS(SELECT 1 FROM #CustBetSetting3rd_Agent)
	BEGIN
		DELETE TOP (3000) #CustBetSetting3rd_Agent OUTPUT DELETED.* INTO #CustBetSetting3rd_AgentBatch

		IF @@ROWCOUNT=0
			BREAK	
		DELETE TOP (3000) cg
		FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustBetSetting3rd_AgentBatch t
			ON cg.CustID=t.CustID AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype 
		
		TRUNCATE TABLE #CustBetSetting3rd_AgentBatch
	END

	INSERT INTO #CustBetSetting3rd_Member(CustID,SporttypeID,Bettype)
	SELECT S.CustID,SportType,BetType 
	FROM Dep_CustStakeLevel_Member S WITH(NOLOCK) 
		INNER JOIN Customer c WITH(NOLOCK) ON s.CustID=c.custid
	WHERE SportType =244 AND BetType = 3001 AND c.srecommend IN(SELECT CustID FROM #supers)
		AND s.CustID > @maxcustid

	
	WHILE EXISTS(SELECT 1 FROM #CustBetSetting3rd_Member)
	BEGIN
		DELETE TOP (3000) #CustBetSetting3rd_Member OUTPUT DELETED.* INTO #CustBetSetting3rd_MemberBatch

		IF @@ROWCOUNT=0
			BREAK	
		DELETE TOP (3000) cg
		FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustBetSetting3rd_MemberBatch t
			ON cg.CustID=t.CustID AND cg.SportType=t.SporttypeID AND cg.BetType=t.Bettype 
		
		TRUNCATE TABLE #CustBetSetting3rd_MemberBatch
	END

	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT S.CustID,ProductSettingID
	FROM Dep_LicenseeProductSetting S WITH(NOLOCK) 
	WHERE S.CustID IN (SELECT CustID FROM #supers)
		AND s.CustID > @maxcustid
		AND S.ProductSettingID IN (42,43,44)


	WHILE EXISTS(SELECT 1 FROM #Dep_LicenseeProductSetting)
	BEGIN
		DELETE TOP (3000) #Dep_LicenseeProductSetting OUTPUT DELETED.* INTO #Dep_LicenseeProductSettingBatch

		IF @@ROWCOUNT=0
			BREAK	
		DELETE TOP (3000) cg
		FROM dbo.Dep_LicenseeProductSetting cg WITH(ROWLOCK)		
			INNER JOIN #Dep_LicenseeProductSettingBatch t
			ON cg.CustID=t.CustID AND CG.ProductSettingID = T.ProductSettingID	
		
		TRUNCATE TABLE #Dep_LicenseeProductSettingBatch
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
