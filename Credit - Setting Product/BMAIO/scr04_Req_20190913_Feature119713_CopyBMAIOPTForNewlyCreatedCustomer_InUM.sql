/*
	Created: Winnie
	Task: Copy BMAIO Setting for newly created customer
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

INSERT INTO #DownlineListTemp (CustID)
SELECT ci.custid
FROM Custinfo ci WITH (NOLOCK)
WHERE Enabled = 1 AND custid > @MaxCustID
	AND EXISTS (SELECT 1 FROM #supers WHERE custid = ci.srecommend )

INSERT INTO custsetting (custid, sporttype,Bettype,apositiontaking, mpositiontaking, spositiontaking, alivepositiontaking, mlivepositiontaking, slivepositiontaking
			, playerdiscount, discount, adiscount, sdiscount, groupa, groupb, groupc, groupd, groupe, groupf, minbet, maxbet
			, autopositiontaking, autolivepositiontaking, isautopositiontaking, isautolivepositiontaking, autompositiontaking, autolivempositiontaking, isautompositiontaking, isautolivempositiontaking	)
	
SELECT t.custid, sporttype,9999,apositiontaking, mpositiontaking, spositiontaking, alivepositiontaking, mlivepositiontaking, slivepositiontaking
			, playerdiscount, discount, adiscount, sdiscount, groupa, groupb, groupc, groupd, groupe, groupf, minbet,maxbet
			, autopositiontaking, autolivepositiontaking, isautopositiontaking, isautolivepositiontaking, autompositiontaking, autolivempositiontaking, isautompositiontaking, isautolivempositiontaking
FROM #DownlineListTemp t
	INNER JOIN custsetting cs (NOLOCK) ON t.CustID = cs.custid AND cs.sporttype = 99 AND cs.bettype = 1		
	
INSERT INTO custoverride (custid, bettype, sporttype, minpositiontaking, maxpositiontaking, minlivepositiontaking, maxlivepositiontaking)
SELECT temp_pt.custid, 9999, sporttype, minpositiontaking, maxpositiontaking, minlivepositiontaking, maxlivepositiontaking
FROM #DownlineListTemp temp_pt
	INNER JOIN custoverride cs (NOLOCK) ON temp_pt.CustID = cs.custid		
WHERE cs.sporttype = 99 AND cs.bettype = 1		

DROP TABLE #DownlineListTemp
