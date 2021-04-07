/*
	Created: 20210407@Johnson
	Task: data patch sync custinfo from dbcust for list headlines
	DB: DBCasinoAdmin/LiveCasinoAdmin
*/		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
DECLARE @tmpBetSetting TABLE(currency INT, MaxBet MONEY, MPM MONEY, MPB MONEY, MaxLoss MONEY)

INSERT INTO @tmpBetSetting(currency,MaxBet,MPM,MPB,MaxLoss)
SELECT 2, 50, 500, 100, 1500 --RM
UNION SELECT 5, 90, 900,180,2700 --HK$
UNION SELECT 13, 90, 900,180,2700 --RMB
UNION SELECT 33, 180,1800,360,5400 --IDD
UNION SELECT 43, 500, 5000,1000,15000 --THB
UNION SELECT 67, 50, 500, 100, 1500 --HKK

INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM DBCUST.CUSTDB.dbo.CustAccount ca WITH(NOLOCK)
	INNER JOIN customer ci WITH(NOLOCK) ON ca.custid = ci.custid
	INNER JOIN custinfo c WITH(NOLOCK) ON ca.custid = c.custid
WHERE ca.groupid in (
	SELECT 	groupID 
	FROM DBCUST.CUSTDB.dbo.CustAccount WITH(NOLOCK)
	WHERE custid IN (SELECT custid 
					FROM custinfo WITH (NOLOCK) 
					WHERE username IN ('CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'))
		   )
	AND ci.roleid = 4
	AND c.enabled = 1
	AND site NOT IN ('789y','IBCIndo','76666b')
	AND ci.currency IN (SELECT currency FROM @tmpBetSetting)

SELECT ci.custid, cs.DisableNumber, cs.DisableCasino, cs.maxperball161, cs.maxpermatch161, cs.maxpermatch164
INTO #tblCust
FROM custinfo ci WITH(NOLOCK)
	INNER JOIN DBCUST.CUSTDB.dbo.custinfo cs WITH(NOLOCK) ON ci.custid = cs.custid
WHERE ci.srecommend IN (SELECT custid FROM #super)
	AND ci.enabled = 1
	AND (ci.DisableNumber <> cs.DisableNumber
		OR ci.DisableCasino <> cs.DisableCasino
		OR ci.maxpermatch161 <> cs.maxpermatch161
		OR ci.maxperball161 <> cs.maxperball161
		OR ci.maxpermatch164 <> cs.maxpermatch164
		)

UPDATE ci
SET ci.DisableNumber = CASE WHEN ci.DisableNumber <> cs.DisableNumber THEN cs.DisableNumber ELSE ci.DisableNumber END,
	ci.DisableCasino = CASE WHEN ci.DisableCasino <> cs.DisableCasino THEN cs.DisableCasino ELSE ci.DisableCasino END,
	ci.maxpermatch161 = CASE WHEN ci.maxpermatch161 <> cs.maxpermatch161 THEN cs.maxpermatch161 ELSE ci.maxpermatch161 END,
	ci.maxperball161 = CASE WHEN ci.maxperball161 <> cs.maxperball161 THEN cs.maxperball161 ELSE ci.maxperball161 END,
	ci.maxpermatch164 = CASE WHEN ci.maxpermatch164 <> cs.maxpermatch164 THEN cs.maxpermatch164 ELSE ci.maxpermatch164 END
FROM custinfo ci WITH(ROWLOCK)
	INNER JOIN #tblCust cs ON ci.custid = cs.custid	
	
	
	