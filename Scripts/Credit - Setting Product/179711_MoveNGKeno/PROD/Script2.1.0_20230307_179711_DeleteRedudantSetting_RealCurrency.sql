/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230314@Eden
	Task: Delete existing data of Keno, NumberGame DCS for Real currency [Redmine: #179711]
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

	CREATE TABLE #supers (custid int)
	CREATE TABLE #CustPTSetting3rd_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustPTSetting3rd_Member (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustPTGroupSetting3rd_Member (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustBetSetting3rd_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustBetSetting3rd_Member (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #CustTempBatch (CustID INT, SportType SMALLINT, BetType SMALLINT)
	CREATE TABLE #SportBetType(SportType SMALLINT, BetType SMALLINT)

	INSERT INTO #SportBetType(SportType,BetType)
	SELECT 161, 81 UNION ALL
	SELECT 202, 1501 

	INSERT INTO #supers(custid)
	SELECT ci.custid
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
			AND ci.currency  NOT IN( 20,72)
			AND c.Enabled = 1

	--PT
	INSERT INTO #CustPTSetting3rd_Agent(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustPTSetting3rd_Agent c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)

	INSERT INTO #CustPTSetting3rd_Member(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustPTSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)

	INSERT INTO #CustPTGroupSetting3rd_Member(CustID,SportType,BetType)
	SELECT c.AgentID,c.SportType,c.BetType
	FROM CustPTGroupSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.AgentID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)

	--BS
	INSERT INTO #CustBetSetting3rd_Agent(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustBetSetting3rd_Agent c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)

	INSERT INTO #CustBetSetting3rd_Member(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustBetSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)

	--SELECT * FROM #CustPTSetting3rd_Agent
	--SELECT * FROM #CustPTSetting3rd_Member
	--SELECT * FROM #CustPTGroupSetting3rd_Member
	--SELECT * FROM #CustBetSetting3rd_Agent
	--SELECT * FROm #CustBetSetting3rd_Member

	DECLARE @batchNum INT = 5000

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


	DROP TABLE	#supers
	DROP TABLE #CustBetSetting3rd_Agent
	DROP TABLE #CustBetSetting3rd_Member
	DROP TABLE #CustPTGroupSetting3rd_Member
	DROP TABLE #CustPTSetting3rd_Agent
	DROP TABLE #CustPTSetting3rd_Member
	DROP TABLE #CustTempBatch
	DROP TABLE #SportBetType
END
GO

EXEC dbo.Acc_DynamicCustSetting3rd_09 
GO
			
