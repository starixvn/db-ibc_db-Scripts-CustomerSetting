/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210603
	Task: Update PT sport book for newly created customer Licensee Deposit Sports Lottery  RedmineID:#156385
	DB: DBCUST/CustDB
	
	P/s : Step 2 Delete redundant and add new setting newly created customer
*/
-- BEGIN STEP 2.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
(@maxcustID INT)
AS
BEGIN			
	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('site') = 0 RETURN
	IF dbo.f_CheckRepTable('custsuper') = 0 RETURN

	DECLARE @batch int = 3000

	CREATE TABLE #supers (custid INT PRIMARY KEY,PT_SB MONEY)
	DECLARE @SportBetType TABLE
	(
		SportType	SMALLINT, 
		BetType		SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (169, 3611)
		
	CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,PT_SB MONEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #SMATemp    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,PT_SB MONEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #MemberBatch (CustID INT PRIMARY KEY CLUSTERED,mrecommend INT,PT_SB MONEY)
	CREATE TABLE #SMABatch    (CustID INT PRIMARY KEY CLUSTERED,RoleID TINYINT,mrecommend INT ,PT_SB MONEY)

	INSERT INTO #supers(custid,PT_SB)
	SELECT ci.custid,cs_sb.apositiontaking * 100 AS PT_SB
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN Dep_CustPTSetting_Agent cps  WITH (NOLOCK) ON ci.custid = cps.custid AND cps.SportType =  169 AND  cps.BetType = 3611
		INNER JOIN Dep_CustSetting cs_sb WITH (NOLOCK) ON ci.custid = cs_sb.custid AND cs_sb.sporttype = 1 AND cs_sb.bettype = 2
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.Enabled=1
		AND cs.site NOT IN ('Saba789')
	ORDER BY ci.custid 		
		
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #SMATemp(CustID,RoleID,mrecommend,PT_SB)
	SELECT a.custid, a.roleid,a.mrecommend,b.PT_SB
	FROM Custinfo a WITH (NOLOCK)
	INNER JOIN #supers b ON a.srecommend = b.custid
	WHERE a.roleid IN (2,3,4) AND a.Enabled = 1 AND a.custid > @maxcustID 
	AND a.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp(CustID,mrecommend,PT_SB)
	SELECT a.custid, a.mrecommend,b.PT_SB
	FROM Custinfo a WITH (NOLOCK)
	INNER JOIN #supers b ON a.srecommend = b.custid
	WHERE srecommend IN (SELECT custid FROM #supers) AND a.roleid = 1  AND a.Enabled = 1 AND a.custid > @maxcustID	
	AND a.mrecommend NOT IN (SELECT custid FROM #Dummy)
	------------------------------------PT Setting-------------------------------------------------	
	-- SMA LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.RoleID,DELETED.PT_SB INTO #SMABatch(CustID,RoleID,PT_SB)
		FROM #SMATemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		
		UPDATE a 
		SET a.SuperPT = CASE WHEN c.RoleID = 4 THEN c.PT_SB ELSE 0 END 
			,a.MasterPT = CASE WHEN c.RoleID IN (4,3) THEN c.PT_SB ELSE 0 END
			,a.AgentPT= CASE WHEN c.RoleID IN (4,2) THEN c.PT_SB ELSE 0 END
		FROM dbo.Dep_CustPTSetting_Agent a WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #SMABatch c WITH(NOLOCK) ON a.CustID = c.CustID
		INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
		
		UPDATE a 
		SET a.AgentPT= c.PT_SB
		FROM dbo.Dep_CustPTGroupSetting_Member a WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #SMABatch c WITH(NOLOCK) ON a.AgentID = c.CustID
		INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
		WHERE c.RoleID=2  
		
		TRUNCATE TABLE #SMABatch
	END			
	
	--MEMBER LEVEL
	WHILE(1 =1)
	BEGIN
		
		UPDATE TOP (@batch) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.PT_SB INTO #MemberBatch(CustID,PT_SB)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
	
		UPDATE a 
		SET a.AgentPT= c.PT_SB
		FROM dbo.Dep_CustPTSetting_Member a WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #MemberBatch c WITH(NOLOCK) ON a.CustID = c.CustID
		INNER JOIN @SportBetType t	ON a.SportType = t.SportType AND a.BetType = t.BetType
		
		TRUNCATE TABLE #MemberBatch
	END 
	
END		
GO
-- END STEP 2.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2.2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
