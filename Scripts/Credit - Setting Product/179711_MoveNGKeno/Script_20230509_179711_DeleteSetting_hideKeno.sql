/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230509@Eden
	Task: Delete setting Hide Keno [Redmine: #179711]
	DB: DBCUST/CustDB
*/ 
ALTER PROCEDURE [dbo].Acc_DynamicCustSetting3rd_09
AS
BEGIN
	SET NOCOUNT ON
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1
	   AND dbo.f_CheckRepTable('custsuper') = 1
	   AND dbo.f_CheckRepTable('site') = 1
	   AND dbo.f_CheckRepTable('customer') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1
	   )
		RETURN

	CREATE TABLE #supers (custid int PRIMARY KEY)
	CREATE TABLE #Cust (custid int PRIMARY KEY,RoleID TINYINT)
	CREATE TABLE #CustPTSetting3rd_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustPTSetting3rd_Member (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustPTGroupSetting3rd_Member (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustBetSetting3rd_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustBetSetting3rd_Member (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustTempBatch (CustID INT, SportType SMALLINT, BetType SMALLINT)

	INSERT INTO #supers(custid)
	SELECT DISTINCT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN custinfo C WITH(NOLOCK) ON c.CustID = ci.custid 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND cs.isinternal = 0
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND ci.Site<>'CN88'
			AND c.Enabled = 1

	--All customer who hide Keno
	INSERT INTO #Cust(custid,RoleID)
	SELECT ci.custid ,ci.roleid
	FROM custinfo ci (NOLOCK) 
		INNER JOIN CustProductStatus cs WITH(NOLOCK)
			ON ci.custid = cs.CustID
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(Cs.bitmapIsHidden, 40) as HideKeno
	WHERE srecommend in ( select custid FROM #supers)
		AND HideKeno.value = 1
		AND ci.Enabled = 1


	--------------------DELETE Setting---------------------------------
	--PT
	INSERT INTO #CustPTSetting3rd_Agent(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustPTSetting3rd_Agent c WITH(NOLOCK)
		INNER JOIN #Cust t ON c.CustID = t.custid
	WHERE t.RoleID <> 1
		AND c.SportType = 202
		AND c.BetType = 1501

	INSERT INTO #CustPTSetting3rd_Member(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustPTSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN #Cust t ON c.CustID = t.custid
	WHERE t.RoleID = 1
		AND c.SportType = 202
		AND c.BetType = 1501

	INSERT INTO #CustPTGroupSetting3rd_Member(CustID,SportType,BetType)
	SELECT c.AgentID,c.SportType,c.BetType
	FROM CustPTGroupSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN #Cust t ON c.AgentID = t.custid
	WHERE t.RoleID <> 1
		AND c.SportType = 202
		AND c.BetType = 1501

	--BS
	INSERT INTO #CustBetSetting3rd_Agent(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustBetSetting3rd_Agent c WITH(NOLOCK)
		INNER JOIN #Cust t ON c.CustID = t.custid
	WHERE t.RoleID <> 1
		AND c.SportType = 202
		AND c.BetType = 1501

	INSERT INTO #CustBetSetting3rd_Member(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustBetSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #Cust t ON c.CustID = t.custid
	WHERE t.RoleID = 1
		AND c.SportType = 202
		AND c.BetType = 1501

	--SELECT * FROM #CustPTSetting3rd_Agent
	--SELECT * FROM #CustPTSetting3rd_Member
	--SELECT * FROM #CustPTGroupSetting3rd_Member
	--SELECT * FROM #CustBetSetting3rd_Agent
	--SELECT * FROm #CustBetSetting3rd_Member


	DECLARE @BatchNum INT = 2500

	-----------------Delete Setting-------------------
	--PT
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustPTSetting3rd_Agent t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustPTSetting3rd_Agent c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustPTSetting3rd_Member t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustPTSetting3rd_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustPTGroupSetting3rd_Member t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustPTGroupSetting3rd_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.AgentID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	--BS
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustBetSetting3rd_Agent t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustBetSetting3rd_Agent c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@batchNum) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustBetSetting3rd_Member t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustBetSetting3rd_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	DROP TABLE #CustBetSetting3rd_Agent
	DROP TABLE #CustBetSetting3rd_Member
	DROP TABLE #CustPTGroupSetting3rd_Member
	DROP TABLE #CustPTSetting3rd_Agent
	DROP TABLE #CustPTSetting3rd_Member
	DROP TABLE #CustTempBatch
	DROP TABLE #supers
	DROP TABLE #Cust
END
GO
----------
EXEC Acc_DynamicCustSetting3rd_09