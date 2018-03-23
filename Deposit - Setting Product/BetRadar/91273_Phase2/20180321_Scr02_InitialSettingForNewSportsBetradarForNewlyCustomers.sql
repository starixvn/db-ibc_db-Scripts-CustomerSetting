/*
	Created: 20180321@Johnson
	Task: Initial bet Settings for new sports of BetRadar for licensees
	Redmine: https://nexdev.net/issues/91273
	DB: DBCUST/CUSTDB
*/

	CREATE TABLE #tblCust (custid INT PRIMARY KEY,roleid TINYINT)
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)
	DECLARE @sport TABLE(sporttype SMALLINT, bettype SMALLINT, fromSportType SMALLINT, fromBettype SMALLINT)
	DECLARE @max_custid  INT 
	
	SELECT @max_custid = xxx
	
	INSERT INTO @sport
	SELECT 192 as sporttype, 2701 as bettype, 191 FromSport, 2701 FromBettype
	UNION SELECT 193, 2801, 190, 2701

	INSERT INTO #tblCust (custid,roleid)			
	SELECT custid,roleid
	FROM dbo.Customer WITH(NOLOCK)
	WHERE srecommend IN (SELECT custid FROM Dep_custSuper WITH(NOLOCK))
		AND mrecommend NOT IN (SELECT custid FROM dbo.CustInfo WITH(NOLOCK)
							   WHERE srecommend IN (SELECT custid FROM Dep_custSuper WITH(NOLOCK))
							    and username like '%Acc%' and roleid=3)
		AND custid > @max_custid
	
	DELETE #tblCust
	OUTPUT DELETED.custID
	INTO @tmpCust
	WHERE roleid > 1
	
	INSERT INTO dbo.Dep_CustBetSetting_Agent(
					CustID
					,SportType
					,BetType
					,MinBet
					,MaxBet
					,MaxPerMatch)
	SELECT	cb.custid
			,s.sporttype
			,s.bettype
			,cb.minbet
			,cb.maxbet
			,cb.maxpermatch
	FROM dbo.Dep_CustBetSetting_Agent cb WITH(NOLOCK)
		INNER JOIN @tmpCust t ON cb.custid = t.custid
		INNER JOIN @sport s ON cb.sporttype = s.FromSporttype AND cb.BetType = s.FromBettype
		LEFT JOIN dbo.Dep_CustBetSetting_Agent cb2 WITH(NOLOCK) ON cb2.custid = t.custID
																AND cb2.sporttype = s.sporttype
																AND cb2.bettype = s.bettype
	WHERE cb2.custid IS NULL																
		
	INSERT INTO dbo.Dep_CustBetSetting_Member(
				CustID
				,SportType
				,BetType
				,MinBet
				,MaxBet
				,MaxPerMatch)
	SELECT	cb.custid
			,s.sporttype
			,s.bettype
			,cb.minbet
			,cb.maxbet
			,cb.maxpermatch
	FROM dbo.Dep_CustBetSetting_Member cb WITH(NOLOCK)
		INNER JOIN #tblCust t ON cb.custid = t.custid			
		INNER JOIN @sport s ON cb.sporttype = s.FromSporttype AND cb.BetType = s.FromBettype
		LEFT JOIN dbo.Dep_CustBetSetting_Member cb2 WITH(NOLOCK) ON cb2.custid = t.custID
																AND cb2.sporttype = s.sporttype
																AND cb2.bettype = s.bettype
	WHERE cb2.custid IS NULL
	
	DROP TABLE #tblCust		