/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Delete existing data of Setting (PT, Comm, BetSetting) SportsBook Real Currency With Exchange have IsActive = 0 , CustSuper.isinternal = 1 [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB 
*/


BEGIN
	SET NOCOUNT ON
	

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
		    AND e.OfferSite IN (0 , 1)
	LEFT JOIN CustSuper cs WITH (NOLOCK)
		    ON cu.custid = cs.custid
		WHERE
			cu.roleid			= 4
			AND s.islicensee		= 0
			AND s.isActive		= 1
			AND cu.username		NOT LIKE '3rdSuper%'
			AND ((e.IsActive = 0)  OR (e.IsActive = 1 AND cs.IsInternal = 1))
			AND cu.custid		NOT IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
			--AND e.ExchangeId		<> 20



	-- Collect PT
	INSERT INTO #CustPTSMA(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustPTSetting3rd_Agent c WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
	INNER JOIN #SportBetType t 
		ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN ( SELECT custid FROM #supers)
	AND t.SettingType = 28


	--INSERT INTO #CustPTMember(CustID,SportType,BetType)
	--SELECT c.CustID,c.SportType,c.BetType
	--FROM CustPTSetting3rd_Member c WITH(NOLOCK)
	--	INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
	--	INNER JOIN #SportBetType t 
	--		ON c.SportType = t.SportType AND c.BetType = t.BetType
	--WHERE ci.srecommend IN( SELECT custid FROM #supers)
	--AND t.SettingType = 28

	--INSERT INTO #CustPTGroupMember(CustID,SportType,BetType)
	--SELECT c.AgentID,c.SportType,c.BetType
	--FROM CustPTGroupSetting3rd_Member c WITH(NOLOCK)
	--	INNER JOIN custinfo ci WITH(NOLOCK) ON c.AgentID = ci.custid
	--	INNER JOIN #SportBetType t 
	--		ON c.SportType = t.SportType AND c.BetType = t.BetType
	--WHERE ci.srecommend IN( SELECT custid FROM #supers)
	--AND t.SettingType = 28


	-- Collect BetSetting
	INSERT INTO #BetSettingSMA(CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustBetSetting_Agent c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
	AND t.SettingType = 26

	--INSERT INTO #BetSettingMember (CustID,SportType,BetType)
	--SELECT c.CustID,c.SportType,c.BetType
	--FROM CustBetSetting_Member c WITH(NOLOCK)
	--	INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
	--	INNER JOIN #SportBetType t 
	--		ON c.SportType = t.SportType AND c.BetType = t.BetType
	--WHERE ci.srecommend IN( SELECT custid FROM #supers)
	--AND t.SettingType = 26

	-- Collect Discount
	INSERT INTO #DiscountSMA (CustID,SportType,BetType)
	SELECT c.CustID,c.SportType,c.BetType
	FROM CustDiscount3rd_Agent c WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN #SportBetType t 
			ON c.SportType = t.SportType AND c.BetType = t.BetType
	WHERE ci.srecommend IN( SELECT custid FROM #supers)
	AND t.SettingType = 25

	--INSERT INTO #DiscountMember (CustID,SportType,BetType)
	--SELECT c.CustID,c.SportType,c.BetType
	--FROM CustDiscount3rd_Member c WITH(NOLOCK)
	--	INNER JOIN custinfo ci WITH(NOLOCK) ON c.CustID = ci.custid
	--	INNER JOIN #SportBetType t 
	--		ON c.SportType = t.SportType AND c.BetType = t.BetType
	--WHERE ci.srecommend IN( SELECT custid FROM #supers)
	--AND t.SettingType = 25


	SELECT '#BetSettingSMA' , * FROM #BetSettingSMA
	SELECT '#BetSettingMember' ,* FROM #BetSettingMember
	SELECT '#CustPTGroupMember' , * FROM #CustPTGroupMember
	SELECT '#CustPTSMA' , * FROM #CustPTSMA
	SELECT '#CustPTMember' , * FROM #CustPTMember
	SELECT '#DiscountSMA' , * FROM #DiscountSMA
	SELECT '#DiscountMember' , * FROM #DiscountMember
	     	   
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
