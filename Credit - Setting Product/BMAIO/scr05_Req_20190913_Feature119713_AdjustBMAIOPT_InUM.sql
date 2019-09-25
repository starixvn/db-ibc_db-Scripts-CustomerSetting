/*
	Created: Winnie
	Task: Adjust BMAIO Setting 
	DB: DBCUST/CustDB
	Date: 20190913
*/ 

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.currency<>20

--------------------- Update PT -------------------
CREATE TABLE #tmpCustSetting(CustID INT PRIMARY KEY)
CREATE TABLE #tmpComm(CustID INT PRIMARY KEY)
CREATE TABLE #tmpCustOverride(CustID INT PRIMARY KEY)

INSERT INTO #tmpCustSetting(CustID)
SELECT c.CustID
FROM customer c WITH (NOLOCK) 
	INNER JOIN custsetting cs WITH (NOLOCK)  ON cs.custid = c.custid AND cs.bettype=1 AND cs.sporttype=99 
	INNER JOIN custsetting cso WITH (NOLOCK)  ON cso.custid = c.custid AND cso.bettype=9999 AND cso.sporttype=99 
WHERE (cs.apositiontaking <> cso.apositiontaking 
				 OR cs.mpositiontaking <> cso.mpositiontaking 
				 OR cs.spositiontaking <> cso.spositiontaking 
				 OR cs.alivepositiontaking <> cso.alivepositiontaking 
				 OR cs.mlivepositiontaking <> cso.mlivepositiontaking 
				 OR cs.slivepositiontaking <> cso.slivepositiontaking 
				 OR cs.autopositiontaking <> cso.autopositiontaking 
				 OR cs.autolivepositiontaking <> cso.autolivepositiontaking 
				 OR cs.isautopositiontaking <> cso.isautopositiontaking 
				 OR cs.isautolivepositiontaking <> cso.isautolivepositiontaking 
				 OR cs.autompositiontaking <> cso.autompositiontaking 
				 OR cs.autolivempositiontaking <> cso.autolivempositiontaking 				 
				 OR cs.isautompositiontaking <> cso.isautompositiontaking 
				 OR cs.isautolivempositiontaking <> cso.isautolivempositiontaking)
	AND c.srecommend IN (SELECT custid FROM #supers)


INSERT INTO #tmpComm(CustID)
SELECT c.CustID
FROM customer c WITH (NOLOCK) 
	INNER JOIN custsetting cs WITH (NOLOCK)  ON cs.custid = c.custid  AND cs.bettype=20 AND cs.sporttype=99 
	INNER JOIN custsetting cso WITH (NOLOCK)  ON cso.custid = c.custid AND cso.bettype=9999 AND cso.sporttype=99 
WHERE (cs.playerdiscount <> cso.playerdiscount 
				 OR cs.discount <> cso.discount 
				 OR cs.adiscount <> cso.adiscount 
				 OR cs.sdiscount <> cso.sdiscount 
				 OR cs.groupa <> cso.groupa 
				 OR cs.groupb <> cso.groupb 
				 OR cs.groupc <> cso.groupc 
				 OR cs.groupd <> cso.groupd 
				 OR cs.groupe <> cso.groupe 
				 OR cs.groupf <> cso.groupf 
				 OR cs.minbet <> cso.minbet 
				 OR cs.maxbet <> cso.maxbet 				 
			)
	AND c.srecommend IN (SELECT custid FROM #supers)

--2. custoverride

INSERT INTO #tmpCustOverride(CustID)
SELECT c.CustID
FROM customer c WITH (NOLOCK) 
	INNER JOIN CustOverride cs WITH (NOLOCK)  ON cs.custid = c.custid  AND cs.bettype=1 AND cs.sporttype=99
	INNER JOIN CustOverride cso WITH (NOLOCK)  ON cso.custid = c.custid AND cso.bettype=9999 AND cso.sporttype=99 
WHERE (cs.minpositiontaking <> cso.minpositiontaking
		OR cs.maxpositiontaking <> cso.maxpositiontaking
		OR cs.minlivepositiontaking <> cso.minlivepositiontaking
		OR cs.maxlivepositiontaking <> cso.maxlivepositiontaking)
		AND c.srecommend IN (SELECT custid FROM #supers)

--1. CustSetting
UPDATE cso
	SET 
		-- Update PT
		apositiontaking = cs.apositiontaking
		, mpositiontaking = cs.mpositiontaking
		, spositiontaking = cs.spositiontaking
		, alivepositiontaking = cs.alivepositiontaking
		, mlivepositiontaking= cs.mlivepositiontaking
		, slivepositiontaking = cs.slivepositiontaking
		, autopositiontaking = cs.autopositiontaking
		, autolivepositiontaking = cs.autolivepositiontaking
		, isautopositiontaking = cs.isautopositiontaking
		, isautolivepositiontaking = cs.isautolivepositiontaking
		, autompositiontaking = cs.autompositiontaking
		, autolivempositiontaking = cs.autolivempositiontaking
		, isautompositiontaking = cs.isautompositiontaking
		, isautolivempositiontaking = cs.isautolivempositiontaking
		
FROM #tmpCustSetting c
	INNER JOIN custsetting cs WITH (NOLOCK)  ON cs.custid = c.custid AND cs.sporttype=99 AND cs.bettype=1
	INNER JOIN custsetting cso WITH (ROWLOCK,UPDLOCK)  ON cso.custid = c.custid AND cso.sporttype=99 AND cso.bettype=9999

UPDATE cso
	SET 
		-- Update PT
		playerdiscount = cs.playerdiscount
		, discount = cs.discount
		, adiscount = cs.adiscount
		, sdiscount = cs.sdiscount
		, groupa= cs.groupa
		, groupb = cs.groupb
		, groupc = cs.groupc
		, groupd = cs.groupd
		, groupe = cs.groupe
		, groupf = cs.groupf
		, minbet = cs.minbet
		, maxbet = cs.maxbet		
FROM #tmpComm c
	INNER JOIN custsetting cs WITH (NOLOCK)  ON cs.custid = c.custid AND cs.bettype=20 AND cs.sporttype=99 
	INNER JOIN custsetting cso WITH (ROWLOCK,UPDLOCK)  ON cso.custid = c.custid AND cso.bettype=9999 AND cso.sporttype=99 

UPDATE cso
	SET 
		-- Update PT
		minpositiontaking = cs.minpositiontaking
		, maxpositiontaking = cs.maxpositiontaking
		, minlivepositiontaking = cs.minlivepositiontaking
		, maxlivepositiontaking = cs.maxlivepositiontaking
FROM #tmpCustOverride c WITH (NOLOCK) 
	INNER JOIN CustOverride cs WITH (NOLOCK)  ON cs.custid = c.custid AND cs.bettype=1 AND cs.sporttype=99 
	INNER JOIN CustOverride cso WITH(ROWLOCK,UPDLOCK)  ON cso.custid = c.custid AND cso.bettype=9999 AND cso.sporttype=99 
				  
--------------- END OF updating PT ----------------

