 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSetting (SportBook and SportBook2)
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_CustSetting_17]
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustOverride') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	

	CREATE TABLE #CustList (CustID INT PRIMARY KEY, PT smallmoney, roleID tinyint)
	INSERT INTO #CustList(custid)					
	SELECT '5603319'				--BHK
	UNION ALL SELECT '1146496'		--BNE

	UPDATE tmp 
	SET tmp.roleID = ci.roleid
	FROM #CustList tmp 
		INNER JOIN custinfo ci WITH(NOLOCK) ON tmp.CustID = ci.custid 

	-------------------------------Normal account ----------------------------
	--> FOR SportBook
	UPDATE cs 
	SET cs.spositiontaking = tmp.PT ,
		cs.mpositiontaking = cs.mpositiontaking + tmp.PT - cs.spositiontaking ,
		cs.apositiontaking = cs.apositiontaking + tmp.PT - cs.spositiontaking
	FROM CustSetting cs WITH (ROWLOCK)
		INNER JOIN #CustList tmp ON cs.custid = tmp.CustID
	WHERE tmp.roleID = 4

	UPDATE cs 
	SET maxpositiontaking = CASE WHEN tmp.PT > maxpositiontaking THEN tmp.PT ELSE maxpositiontaking END,
		maxlivepositiontaking = CASE WHEN tmp.PT > maxlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT ELSE maxlivepositiontaking END
	FROM custoverride cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #CustList tmp ON cs.custid = tmp.CustID
	WHERE tmp.roleID = 4 

	--> FOR Muay Thai, E-Sports
	UPDATE cs 
	SET cs.MaxPT = 90, --Profiles
		cs.SuperPT  =  tmp.PT ,
		cs.MasterPT =  cs.MasterPT + tmp.PT - cs.SuperPT ,
		cs.AgentPT  =  cs.AgentPT + tmp.PT - cs.SuperPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #CustList tmp ON cs.custid = tmp.CustID
	WHERE cs.SportType IN (43,44) AND tmp.roleID = 4


	-------------------dummy account -----------------------------

	CREATE TABLE #DummyCustList (CustID INT PRIMARY KEY, PT smallmoney, roleID tinyint)
	CREATE TABLE #DirectCustList (CustID INT PRIMARY KEY, PT smallmoney, roleID tinyint)

	INSERT INTO #DirectCustList(CustID, PT, RoleID)
	SELECT CustID, PT, RoleID FROM #CustList WHERE roleid IN (2,3)

	INSERT INTO #DummyCustList(CustID,PT,roleID)
	SELECT ci.srecommend,tmp.PT,4 -- Dummy super
	FROM #DirectCustList tmp 
		INNER JOIN custinfo ci WITH(NOLOCK) ON tmp.CustID = ci.custid 


	INSERT INTO #DummyCustList(CustID,PT,roleID)
	SELECT ci.mrecommend,tmp.PT,3 -- Dummy master
	FROM #DirectCustList tmp 
		INNER JOIN custinfo ci WITH(NOLOCK) ON tmp.CustID = ci.custid AND ci.roleid = 2

	--> FOR SportBook
	UPDATE cs 
	SET cs.spositiontaking = CASE WHEN ci.roleid = 4 THEN tmp.PT ELSE cs.spositiontaking END,
		cs.mpositiontaking = CASE WHEN ci.roleid = 4 THEN tmp.PT
									WHEN ci.roleid = 3 THEN tmp.PT 
									ELSE cs.mpositiontaking END,
		cs.apositiontaking = CASE WHEN ci.roleid = 4 THEN tmp.PT
									WHEN ci.roleid = 2 THEN tmp.PT 
									ELSE cs.apositiontaking END
	FROM CustSetting cs WITH (ROWLOCK)
		INNER JOIN #DummyCustList tmp ON cs.custid = tmp.CustID
		INNER JOIN custinfo ci  WITH (NOLOCK) ON ci.custid = tmp.CustID

	--> FOR Muay Thai, E-Sports
	UPDATE cs 
	SET cs.SuperPT = CASE WHEN ci.roleid = 4 THEN tmp.PT ELSE cs.SuperPT END,
		cs.MasterPT = CASE WHEN ci.roleid = 4 THEN tmp.PT
									WHEN ci.roleid = 3 THEN tmp.PT 
									ELSE cs.MasterPT END,
		cs.AgentPT = CASE WHEN ci.roleid = 4 THEN tmp.PT
									WHEN ci.roleid = 2 THEN tmp.PT 
									ELSE cs.AgentPT END
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #DummyCustList tmp ON cs.custid = tmp.CustID
		INNER JOIN custinfo ci  WITH (NOLOCK) ON ci.custid = tmp.CustID
	WHERE cs.SportType IN (43,44)
	
	------------------------DIRECT acc---------------------------
	--> FOR SportBook
	UPDATE cs 
	SET cs.mpositiontaking = CASE WHEN ci.roleid = 3 THEN tmp.PT ELSE cs.mpositiontaking END,
		cs.apositiontaking = CASE WHEN ci.roleid = 2 THEN tmp.PT ELSE cs.apositiontaking END
	FROM CustSetting cs WITH (ROWLOCK)
		INNER JOIN #DirectCustList tmp ON cs.custid = tmp.CustID
		INNER JOIN custinfo ci  WITH (NOLOCK) ON ci.custid = tmp.CustID
	
	UPDATE cs 
	SET maxpositiontaking = CASE WHEN tmp.PT > maxpositiontaking THEN tmp.PT ELSE maxpositiontaking END,
		maxlivepositiontaking = CASE WHEN tmp.PT > maxlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT ELSE maxlivepositiontaking END
	FROM custoverride cs WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #DirectCustList tmp ON cs.custid = tmp.CustID

	--> FOR Muay Thai, E-Sports
	UPDATE cs 
	SET cs.MasterPT = CASE WHEN ci.roleid = 3 THEN tmp.PT ELSE cs.MasterPT END,
		cs.AgentPT = CASE WHEN ci.roleid = 2 THEN tmp.PT ELSE cs.AgentPT END,
		cs.MaxPT = 90 --Profiles
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #DirectCustList tmp ON cs.custid = tmp.CustID
		INNER JOIN custinfo ci  WITH (NOLOCK) ON ci.custid = tmp.CustID
	WHERE cs.SportType IN (43,44)

	

	DROP TABLE #CustList
	DROP TABLE #DummyCustList
	DROP TABLE #DirectCustList

END    
GO