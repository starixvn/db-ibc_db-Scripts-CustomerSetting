/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240423@Johnson
	Task: REDUCE the Max Bet/ Max per Match settings 
		If there are any downline settings greater than the upline one [redmine: #204108]
	DB: DBCUST/CUSTDB	
*/ 

CREATE TABLE #Supers (custid INT PRIMARY KEY)
CREATE TABLE #tblCustSport (custid INT, roleid TINYINT, Sporttype INT, Bettype INT)

INSERT INTO #Supers(custid)
SELECT ci.custid
FROM		dbo.custInfo AS ci WITH (NOLOCK)
INNER JOIN	dbo.Customer AS c WITH (NOLOCK)
		ON	ci.custid = c.custid
INNER JOIN	dbo.custSuper AS s WITH (NOLOCK)
		ON	ci.custid = s.custid
WHERE	ci.RoleID = 4  
	AND	NOT EXISTS (SELECT custid FROM dbo.Dep_CustSuper AS dcs WITH (NOLOCK) WHERE ci.custid = dcs.CustId)
	AND	ci.Enabled = 1
	AND	s.IsInternal = 0
	AND	NOT (	ci.username LIKE '%Acc%'
		OR	ci.username LIKE '%3rdSuper%'
		OR	ci.username LIKE 'STEST%'
		OR	(	ci.username LIKE 'SM%'
			AND	ci.custid < 100
			)
		)

INSERT INTO #tblCustSport(custid,roleid,Sporttype,Bettype)
SELECT ci.custid,roleid,cs.Sporttype,cs.Bettype
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN CustBetSetting3rd_Agent cs (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN CustBetSetting3rd_Agent scs (NOLOCK) ON scs.custid = ci.srecommend AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
	AND ci.roleid = 3
	AND ci.Enabled = 1
	AND cs.SportType IN (175,169,220,222,202,9908)
	AND ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
		OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
		)

INSERT INTO #tblCustSport(custid,roleid,Sporttype,Bettype)
SELECT ci.custid,roleid,cs.Sporttype,cs.Bettype
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN CustBetSetting3rd_Agent cs (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN CustBetSetting3rd_Agent mcs (NOLOCK) ON mcs.custid = ci.mrecommend AND cs.SportType = mcs.SportType AND cs.BetType = mcs.BetType
WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
	AND ci.roleid = 2
	AND ci.Enabled = 1
	AND cs.SportType IN (175,169,220,222,202,9908)
	AND ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
		OR (mcs.MaxPerMatch > 0 AND cs.MaxPerMatch > mcs.MaxPerMatch)
		)		
		
INSERT INTO #tblCustSport(custid,roleid,Sporttype,Bettype)
SELECT ci.custid,roleid,cs.Sporttype,cs.Bettype
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN CustBetSetting3rd_Member cs (NOLOCK) ON cs.custid = ci.custid
	INNER JOIN CustBetSetting3rd_Agent acs (NOLOCK) ON acs.custid = ci.recommend AND cs.SportType = acs.SportType AND cs.BetType = acs.BetType
WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
	AND ci.roleid = 2
	AND ci.Enabled = 1
	AND cs.SportType IN (175,169,220,222,202,9908)
	AND ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
		OR (mcs.MaxPerMatch > 0 AND cs.MaxPerMatch > mcs.MaxPerMatch)
		)		
		
		