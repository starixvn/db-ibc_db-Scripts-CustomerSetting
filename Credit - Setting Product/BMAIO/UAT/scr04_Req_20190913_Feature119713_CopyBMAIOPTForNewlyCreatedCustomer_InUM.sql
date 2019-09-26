/*
	Created: Winnie
	Task: Copy BMAIO Setting for newly created customer -- UUS
	DB: DBCUST/CustDB
	Date: 20190913
*/ 

DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #DownlineListTemp
(
	CustID INT PRIMARY KEY CLUSTERED
)

CREATE TABLE #supers (custid INT)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
 INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
 INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
 AND ci.username NOT LIKE '3rdSuper%'
 AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
 AND s.islicensee = 0
 AND ci.currency=20

INSERT INTO #DownlineListTemp (CustID)
SELECT ci.custid
FROM Custinfo ci WITH (NOLOCK)
WHERE custid > @MaxCustID
	AND EXISTS (SELECT 1 FROM #supers WHERE custid = ci.srecommend )

INSERT INTO custsetting (custid, sporttype,Bettype,apositiontaking, mpositiontaking, spositiontaking, alivepositiontaking, mlivepositiontaking, slivepositiontaking
			, playerdiscount, discount, adiscount, sdiscount, groupa, groupb, groupc, groupd, groupe, groupf, minbet, maxbet
			, autopositiontaking, autolivepositiontaking, isautopositiontaking, isautolivepositiontaking, autompositiontaking, autolivempositiontaking, isautompositiontaking, isautolivempositiontaking	)
	
SELECT t.custid, cs.sporttype,9999,cs.apositiontaking, cs.mpositiontaking, cs.spositiontaking, cs.alivepositiontaking, cs.mlivepositiontaking, cs.slivepositiontaking
			, csb.playerdiscount, csb.discount, csb.adiscount, csb.sdiscount, 0, 0, 0, 0, 0, 0, csb.minbet,csb.maxbet
			, cs.autopositiontaking, cs.autolivepositiontaking, cs.isautopositiontaking, cs.isautolivepositiontaking, cs.autompositiontaking, cs.autolivempositiontaking, cs.isautompositiontaking, cs.isautolivempositiontaking
FROM #DownlineListTemp t
	INNER JOIN custsetting cs (NOLOCK) ON t.CustID = cs.custid AND cs.bettype = 1 AND cs.sporttype = 99 
	INNER JOIN custsetting csb (NOLOCK) ON t.CustID = csb.custid AND csb.bettype = 20 AND csb.sporttype = 99 		
	
INSERT INTO custoverride (custid, bettype, sporttype, minpositiontaking, maxpositiontaking, minlivepositiontaking, maxlivepositiontaking)
SELECT temp_pt.custid, 9999, sporttype, minpositiontaking, maxpositiontaking, minlivepositiontaking, maxlivepositiontaking
FROM #DownlineListTemp temp_pt
	INNER JOIN custoverride cs (NOLOCK) ON temp_pt.CustID = cs.custid		
WHERE  cs.bettype = 1 AND cs.sporttype = 99 	

DROP TABLE #DownlineListTemp
