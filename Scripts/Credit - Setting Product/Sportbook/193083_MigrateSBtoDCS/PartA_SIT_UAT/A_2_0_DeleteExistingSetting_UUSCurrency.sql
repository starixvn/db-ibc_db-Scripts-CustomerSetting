/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Delete existing data of Setting (PT, Comm, BetSetting) SportsBook Currency UUS [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB 
*/

ALTER PROCEDURE [dbo].Acc_DynamicCustSetting3rd_12
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
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Member') = 1
	   )
		RETURN


	CREATE TABLE #supers
		(
			custid INT PRIMARY KEY
		)

	CREATE TABLE #CustPTSMA
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		)

	CREATE TABLE #CustPTMember
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		)

	CREATE TABLE #CustPTGroupMember
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		)

	CREATE TABLE #BetSettingSMA
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		)

	CREATE TABLE #BetSettingMember
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		)
	
	CREATE TABLE #DiscountSMA
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		)

	CREATE TABLE #DiscountMember
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		)

	CREATE TABLE #CustTempBatch
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		)

	CREATE TABLE #SportBetType
		(
			SettingType SMALLINT
		    , SportType   SMALLINT
		    , BetType     SMALLINT
		)

	INSERT INTO #SportBetType (SettingType, SportType, BetType)
	SELECT psdu.SettingType, psdu.SportType , psdu.BetType
	FROM ProductSettingProfile_UAT psdu WITH (NOLOCK)
	WHERE psdu.ProductID = 1 
	AND psdu.SettingType NOT IN (13,27)

	DELETE FROM #SportBetType WHERE SettingType = 26 AND SportType NOT IN (43,44)
	


	-- Collect ALL Super
	INSERT INTO #supers(custid)
	SELECT cu.CustId
	FROM Customer cu WITH (NOLOCK)
	INNER JOIN Site s WITH (NOLOCK)
		    ON cu.Site = s.Site
	INNER JOIN exchange e WITH (NOLOCK)
		    ON cu.currency = e.ExchangeId
		    AND e.IsActive = 1
		    AND e.OfferSite IN (0 , 1)
	LEFT JOIN CustSuper cs WITH (NOLOCK)
		    ON cu.custid = cs.custid
		WHERE
			cu.roleid			= 4
			AND s.islicensee		= 0
			AND s.isActive		= 1
			AND cu.username		NOT LIKE '3rdSuper%'
			AND cs.isinternal		= 0
			AND cu.custid		NOT IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
			AND e.ExchangeId		= 20


	-- Collect PT

	INSERT INTO #CustPTSMA(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustPTSetting3rd_Agent c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
	AND t.SettingType = 28


	INSERT INTO #CustPTMember(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustPTSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
	AND t.SettingType = 28

	INSERT INTO #CustPTGroupMember(CustID,SportType,BetType)
	SELECT c.AgentID,c.SportType,c.BetType
	FROM CustPTGroupSetting3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.AgentID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
	AND t.SettingType = 28


	-- Collect BetSetting
	INSERT INTO #BetSettingSMA(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustBetSetting_Agent c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
	AND t.SettingType = 26

	INSERT INTO #BetSettingMember (CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustBetSetting_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
	AND t.SettingType = 26

	-- Collect Discount
	INSERT INTO #DiscountSMA (CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustDiscount3rd_Agent c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
	AND t.SettingType = 25

	INSERT INTO #DiscountMember (CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustDiscount3rd_Member c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
	AND t.SettingType = 25

	----------------------------DELETE SETTING----------------------------
	DECLARE  @Batch		INT			= 5000

	-- DELETE PT
	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@Batch) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustPTSMA t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustPTSetting3rd_Agent c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@Batch) t
		OUTPUT deleted.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustPTMember t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustPTSetting3rd_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@Batch) t
		OUTPUT DELETED.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #CustPTGroupMember t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustPTGroupSetting3rd_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.AgentID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	-- DELETE BetSetting

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@Batch) t
		OUTPUT DELETED.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #BetSettingSMA t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustBetSetting_Agent c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@Batch) t
		OUTPUT DELETED.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #BetSettingMember t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustBetSetting_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	-- DELETE Discount

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@Batch) t
		OUTPUT DELETED.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #DiscountSMA t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustDiscount3rd_Agent c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	WHILE 1 = 1
	BEGIN
		TRUNCATE TABLE #CustTempBatch

		DELETE TOP(@Batch) t
		OUTPUT DELETED.CustID, deleted.SportType, deleted.BetType INTO #CustTempBatch(CustID,SportType,BetType)
		FROM #DiscountMember t

		IF @@ROWCOUNT = 0
			BREAK;

		DELETE c
		FROM CustDiscount3rd_Member c WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #CustTempBatch t ON c.CustID = t.CustID AND c.SportType = t.SportType AND c.BetType = t.BetType

	END

	--SELECT '#BetSettingSMA' , * FROM #BetSettingSMA
	--SELECT '#BetSettingMember' ,* FROM #BetSettingMember
	--SELECT '#CustPTGroupMember' , * FROM #CustPTGroupMember
	--SELECT '#CustPTSMA' , * FROM #CustPTSMA
	--SELECT '#CustPTMember' , * FROM #CustPTMember
	--SELECT '#DiscountSMA' , * FROM #DiscountSMA
	--SELECT '#DiscountMember' , * FROM #DiscountMember
	     	   
	DROP TABLE #BetSettingMember
	DROP TABLE #BetSettingSMA
	DROP TABLE #CustPTGroupMember
	DROP TABLE #CustPTMember
	DROP TABLE #CustPTSMA
	DROP TABLE #CustTempBatch
	DROP TABLE #DiscountMember
	DROP TABLE #DiscountSMA
	DROP TABLE #SportBetType
	DROP TABLE #supers

END
GO

EXEC Acc_DynamicCustSetting3rd_12
GO