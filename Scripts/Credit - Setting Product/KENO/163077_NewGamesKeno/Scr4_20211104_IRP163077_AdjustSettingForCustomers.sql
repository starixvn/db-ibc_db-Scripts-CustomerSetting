/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211025@Johnson
	Task: adjust settings for new games keno
	DB: DBCust/CustDB
*/


CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid	
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND Enabled = 1	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.currency <> 20
	AND cs.isinternal = 0
	AND s.islicensee = 0


CREATE TABLE #tblCustGameType
			   ([CustID] INT
			   ,[GameTypeID] INT		
			   ,[MaxPerGameType] MONEY
			   ,[MinBet] MONEY
			   ,[MaxBet] MONEY
			   ,[IsDisabled] BIT
			   PRIMARY KEY (custid,gametypeid)
			   )
			   
DECLARE  @tmpCust TABLE
			   ([CustID] INT
			   ,[GameTypeID] INT		
			   ,[MaxPerGameType] MONEY
			   ,[MinBet] MONEY
			   ,[MaxBet] MONEY
			   ,[IsDisabled] BIT
			   PRIMARY KEY (custid,gametypeid)
			   )			   

INSERT INTO #tblCustGameType(custid, GameTypeID, MinBet, MaxBet, MaxPerGameType,IsDisabled)
SELECT cs2.custid, cs2.GameTypeID, cs1.MinBet, cs1.MaxBet, cs1.MaxPerGameType,cs1.IsDisabled
FROM custinfo ci WITH(NOLOCK) 
	INNER JOIN CustGameType cs1 WITH(NOLOCK) ON cs1.custid = ci.custid
	INNER JOIN CustGameType cs2 WITH(NOLOCK) ON cs1.custid = cs2.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND cs1.GameTypeID = 15
	AND cs2.GameTypeID IN (30,31)
	AND (
		cs1.MinBet <> cs2.MinBet
		OR cs1.MaxBet <> cs2.MaxBet
		OR cs1.MaxPerGameType <> cs2.MaxPerGameType
		OR cs1.IsDisabled <> cs2.IsDisabled
	)
	
WHILE(1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.custid, DELETED.GameTypeID, DELETED.MinBet, DELETED.MaxBet, DELETED.MaxPerGameType, DELETED.IsDisabled
	INTO @tmpCust(custid,GameTypeID,MinBet,MaxBet,MaxPerGameType, IsDisabled)
	FROM #tblCustGameType t
	
	IF @@ROWCOUNT =0
		BREAK;
		
	UPDATE cs
	SET cs.MinBet = t.MinBet,
		cs.MaxBet = t.MaxBet,
		cs.MaxPerGameType = t.MaxPerGameType,
		cs.IsDisabled = t.IsDisabled
	FROM CustGameType cs WITH(ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custid
								AND cs.GameTypeID = t.GameTypeID
								
	DELETE @tmpCust
	
	WAITFOR DELAY '0:0:1'
END	