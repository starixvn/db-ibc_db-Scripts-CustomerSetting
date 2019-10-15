 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for DynamicCustSetting3rd.
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
    @custid int,
    @Target VARCHAR(20) = '',
	@PT tinyint
AS
BEGIN
	SET NOCOUNT ON
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
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
	UPDATE cs 
	SET cs.MaxPT = PS.MaxPT, --Profiles
		cs.SuperPT  =  tmp.PT ,
		cs.MasterPT =  cs.MasterPT + tmp.PT - cs.SuperPT ,
		cs.AgentPT  =  cs.AgentPT + tmp.PT - cs.SuperPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #CustList tmp ON cs.custid = tmp.CustID
		INNER JOIN ProductSettingDetail ps  WITH (NOLOCK)
			ON ps.SportType = cs.SportType and cs.BetType = ps.BetType and ps.SettingType = 1
	WHERE cs.sporttype IN (248,212,220,180,181,182,183,184,185,186,190,191,192,193,199) --PP, Macau, Lottery, Virtual Sports


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

	UPDATE cs 
	SET cs.SuperPT = CASE WHEN tmp.roleid = 4 THEN tmp.PT ELSE cs.SuperPT END,
		cs.MasterPT = CASE WHEN tmp.roleid = 4 THEN tmp.PT
									WHEN tmp.roleid = 3 THEN tmp.PT 
									ELSE cs.MasterPT END,
		cs.AgentPT = CASE WHEN tmp.roleid = 4 THEN tmp.PT
									WHEN tmp.roleid = 2 THEN tmp.PT 
									ELSE cs.AgentPT END
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #DummyCustList tmp ON cs.custid = tmp.CustID
	WHERE cs.sporttype IN (248,212,220,180,181,182,183,184,185,186,190,191,192,193,199) --PP, Macau, Lottery, Virtual Sports
	
	------------------------DIRECT acc---------------------------
	UPDATE cs 
	SET cs.MasterPT = CASE WHEN tmp.roleid = 3 THEN tmp.PT ELSE cs.MasterPT END,
		cs.AgentPT = CASE WHEN tmp.roleid = 2 THEN tmp.PT ELSE cs.AgentPT END,
		cs.MaxPT = PS.MaxPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN #DirectCustList tmp ON cs.custid = tmp.CustID
		INNER JOIN ProductSettingDetail ps  WITH (NOLOCK)
			ON ps.SportType = cs.SportType and cs.BetType = ps.BetType and ps.SettingType = 1
	WHERE cs.sporttype IN (248,212,220,180,181,182,183,184,185,186,190,191,192,193,199) --PP, Macau, Lottery, Virtual Sports

	DROP TABLE #CustList
	DROP TABLE #DummyCustList
	DROP TABLE #DirectCustList              
END    
GO