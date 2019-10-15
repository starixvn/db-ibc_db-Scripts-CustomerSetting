 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSetting (SportBook and SportBook2)
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_CustSetting_17]
    --@custid int,
	--@PT smallmoney = NULL,
	--@IsUpdateMaxPT BIT = 1, -- 1 : Update maxPT,s4/m4/a4 , 0 : Update MinPT = MaxPT and adjust PT
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustOverride') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	

	CREATE TABLE #CustList (CustID INT PRIMARY KEY, PT smallmoney)
	INSERT INTO #CustList(custid)					
	SELECT '5603319'				--BHK
	UNION ALL SELECT '1146496'		--BNE

	INSERT INTO #CustList(CustID,PT)
	SELECT DummyS.CustID,tmp.PT
	FROM #CustList tmp 
		INNER JOIN custinfo ci WITH(NOLOCK) ON tmp.CustID = ci.custid AND ci.roleid IN (2,3)
		INNER JOIN custinfo DummyS WITH(NOLOCK) ON ci.srecommend = DummyS.custid

	INSERT INTO #CustList(CustID,PT)
	SELECT DummyM.CustID,tmp.PT
	FROM #CustList tmp 
		INNER JOIN custinfo ci WITH(NOLOCK) ON tmp.CustID = ci.custid AND ci.roleid = 2
		INNER JOIN custinfo DummyM WITH(NOLOCK) ON ci.mrecommend = DummyM.custid

		--> FOR SportBook
		UPDATE cs 
		SET cs.spositiontaking = CASE WHEN ci.roleid = 4 THEN tmp.PT ELSE cs.spositiontaking END,
			cs.mpositiontaking = CASE WHEN ci.roleid = 4 THEN cs.mpositiontaking + tmp.PT - cs.spositiontaking
									  WHEN ci.roleid = 3 THEN tmp.PT 
									  ELSE cs.mpositiontaking END,
			cs.apositiontaking = CASE WHEN ci.roleid = 4 THEN cs.apositiontaking + tmp.PT - cs.spositiontaking
									  WHEN ci.roleid = 3 THEN cs.apositiontaking + tmp.PT - cs.mpositiontaking
									  WHEN ci.roleid = 2 THEN tmp.PT 
									  ELSE cs.apositiontaking END
		FROM CustSetting cs WITH (ROWLOCK)
			JOIN #CustList tmp ON cs.custid = tmp.CustID
			JOIN custinfo ci  WITH (ROWLOCK) ON ci.custid = tmp.CustID

		UPDATE cs 
		SET maxpositiontaking = CASE WHEN tmp.PT > maxpositiontaking THEN tmp.PT ELSE maxpositiontaking END,
			maxlivepositiontaking = CASE WHEN tmp.PT > maxlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN tmp.PT ELSE maxlivepositiontaking END
		FROM custoverride cs WITH(ROWLOCK, UPDLOCK)
			 INNER JOIN #CustList tmp ON cs.custid = tmp.CustID

		--> FOR Muay Thai, E-Sports
		UPDATE cs 
		SET cs.MaxPT = 90, --Profiles
			cs.SuperPT  = CASE WHEN ci.roleid = 4 THEN tmp.PT ELSE cs.SuperPT END,
			cs.MasterPT = CASE WHEN ci.roleid = 4 THEN cs.MasterPT + tmp.PT - cs.SuperPT
									  WHEN ci.roleid = 3 THEN tmp.PT 
									  ELSE cs.MasterPT END,
			cs.AgentPT  = CASE WHEN ci.roleid = 4 THEN cs.AgentPT + tmp.PT - cs.SuperPT
									  WHEN ci.roleid = 3 THEN cs.AgentPT + tmp.PT - cs.MasterPT
									  WHEN ci.roleid = 2 THEN tmp.PT 
									  ELSE cs.AgentPT END
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
			INNER JOIN #CustList tmp ON cs.custid = tmp.CustID
			INNER JOIN custinfo ci  WITH (ROWLOCK) ON ci.custid = tmp.CustID
		WHERE cs.SportType IN (43,44)



		DROP TABLE #CustList

END    
GO