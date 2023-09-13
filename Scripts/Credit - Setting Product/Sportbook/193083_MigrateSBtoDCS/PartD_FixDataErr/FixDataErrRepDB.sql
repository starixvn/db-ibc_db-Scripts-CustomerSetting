/*<info serverAlias="DBTP-DBTP10C"></info>*/
/*
	Created: 20240116@Helios
	Task: Fix Data Err Commission  [#193083] 
	DB: DBTP/DBTP10C , DB06 , DB061
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	CREATE TABLE #TmpCustList
		(
			CustID	INT
		)

	CREATE TABLE #TmpAgentList
		(
			CustID	INT
		,	SportType	SMALLINT
		,	BetType	SMALLINT
		,	CommRate	DECIMAL (9,8)
		)

	-- Case 1: CustID not exists in AgentCommRate

	-- 1.1: Collect Cust List
	INSERT INTO #TmpCustList (CustID)
	SELECT DISTINCT c.custid
	FROM Customer c WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK) ON c.custid = i.custid
	LEFT JOIN AgentCommRate acr WITH (NOLOCK) ON c.custid = acr.CustId
	WHERE c.site = '76666B'
	AND acr.CustId IS NULL
	AND c.roleid IN (2,3,4)
	AND i.Enabled = 1

	---- 1.2: Sync data from DBCust
	INSERT INTO #TmpAgentList 
		(
			CustID
		    , SportType
		    , BetType
		    , CommRate
		)
	SELECT acr.CustId , acr.Sporttype , acr.Bettype , acr.CommRate
	FROM DBCUST.CustDB.dbo.AgentCommRate acr WITH (NOLOCK)
	INNER JOIN #TmpCustList tcl ON acr.CustId = tcl.CustID

	---- 1.3: Ins data missing AgentCommRate
	IF EXISTS (SELECT TOP 1 1 FROM #TmpAgentList)
	BEGIN
		INSERT INTO AgentCommRate 
		(
			CustId
		    , Sporttype
		    , Bettype
		    , CommRate
		)
		SELECT 
			CustId
		    , Sporttype
		    , Bettype
		    , CommRate
		FROM #TmpAgentList tal
	END


	
	-- Case 2: Data CustCommRate (sdiscount, adiscount) IS NULL
	TRUNCATE TABLE #TmpCustList

	CREATE TABLE #TmpCustAffect
		(
			CustID	INT
		,	SportType	SMALLINT
		,	BetType	SMALLINT
		,	sdiscount	DECIMAL (9,8)
		,	adiscount	DECIMAL (9,8)
		,	discount	DECIMAL (9,8)
		)
		

	-- 2.1: Collect Cust List
	INSERT INTO #TmpCustList (CustID)
	SELECT DISTINCT c.custid
	FROM Customer c WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK) ON c.custid = i.custid
	LEFT JOIN CustCommRate acr WITH (NOLOCK) ON c.custid = acr.CustId
	WHERE c.site = '76666B'
	AND c.roleid IN (1)
	AND (acr.sdiscount IS NULL OR acr.adiscount IS NULL OR acr.discount IS NULL)
	AND i.Enabled = 1

	-- 2.2: Collect Data Affected from DBCUST
	INSERT INTO #TmpCustAffect 
	(
		CustID
	    , SportType
	    , BetType
	    , sdiscount
	    , adiscount
	    , discount
	)
	SELECT acr.CustId , acr.Sporttype , acr.Bettype , acr.sdiscount , acr.adiscount  , acr.discount
	FROM DBCUST.CustDB.dbo.CustCommRate acr WITH (NOLOCK)
	INNER JOIN #TmpCustList tcc ON acr.CustId = tcc.CustID

	-- 2.3: Update data missing CustCommRate
	UPDATE acr
		SET 
			acr.sdiscount = tcc.sdiscount
		,	acr.adiscount = tcc.adiscount
		,	acr.discount = tcc.discount
	FROM CustCommRate acr WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #TmpCustAffect tcc ON acr.CustId = tcc.CustID AND acr.Sporttype = tcc.SportType AND acr.Bettype = tcc.BetType


	---- Case 3: Missing data CustCommRate 
	TRUNCATE TABLE #TmpCustList

	CREATE TABLE #TmpCustCommRateList
		(
			CustID		INT
		,	SportType		SMALLINT
		,	BetType		SMALLINT
		,	sdiscount		DECIMAL (9,8)
		,	adiscount		DECIMAL (9,8)
		,	discount		DECIMAL (9,8)
		,	playerdiscount	DECIMAL (9,8)
		)

	-- 3.1: Collect Cust List
	INSERT INTO #TmpCustList (CustID)
	SELECT DISTINCT c.custid
	FROM Customer c WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK) ON c.custid = i.custid
	LEFT JOIN CustCommRate acr WITH (NOLOCK) ON c.custid = acr.CustId
	WHERE c.site = '76666B'
	AND acr.CustId IS NULL
	AND c.roleid IN (1)
	AND i.Enabled = 1

	---- 3.2: Sync data from DBCust
	INSERT INTO #TmpCustCommRateList 
		(
			CustID
		    , SportType
		    , BetType
		    , sdiscount
		    , adiscount
		    , discount
		    , playerdiscount
		)
	SELECT acr.CustId , acr.Sporttype , acr.Bettype , acr.sdiscount , acr.adiscount , acr.discount , acr.playerdiscount 
	FROM DBCUST.CustDB.dbo.CustCommRate acr WITH (NOLOCK)
	INNER JOIN #TmpCustList tcl ON acr.CustId = tcl.CustID

	---- 3.3: Ins data missing AgentCommRate
	IF EXISTS (SELECT TOP 1 1 FROM #TmpCustCommRateList)
	BEGIN
		INSERT INTO CustCommRate 
		(
			CustId
		    , Sporttype
		    , Bettype
		    , sdiscount
		    , adiscount
		    , discount
		    , playerdiscount
		)
		SELECT 
			CustId
		    , Sporttype
		    , Bettype
		    , sdiscount
		    , adiscount
		    , discount
		    , playerdiscount
		FROM #TmpCustCommRateList tal
	END


	DROP TABLE #TmpCustAffect
	DROP TABLE #TmpCustList
	DROP TABLE #TmpAgentList
	DROP TABLE #TmpCustCommRateList