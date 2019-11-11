/*
	Created: Elodie
	Task: Fix PT setting on BMAIO - [Redimine:#119713]
	DB: DBCUST/CustDB
	Date: 20191111
*/ 

SELECT custid, roleid INTO #CustList
FROM dbo.custInfo ci WITH (NOLOCK) 
WHERE ci.custid IN (
39020537	,
39022251	,
39022932	,
39022987	,
39023069	,
39025057	,
39025053	,
39025084	,
39027091	,
39043413	,
39059415	,
39059461	,
39059484	,
39059489	,
39059500	,
39092428	,
39092451	,
39092542	,
39093083	,
39142574	,
39142590	,
39177485	,
39240089	,
39241246	,
39241896	,
39243503	,
39243556	,
39243575	,
39247016	,
39258578	,
39258583	,
39258598	,
39258620	,
39258610	,
39258631	,
39258967	,
39258995	,
39259013	,
39335295	,
39337920	,
39347138	,
39358721	,
39358741	,
39358767	,
39359567	,
39359947	,
39360101	,
39371634	,
39371905	,
39371955	,
39372069	,
39372160	,
39372194	,
39372243	,
39372294	,
39372398	,
39372474	,
39372478	,
39372489	,
39372629	,
39372688	,
39372760	,
39374488	,
39374515	,
39376054	,
39376076	,
39376182	,
39390531	,
39411376	,
39468824	,
39469298	,
39471806	,
39471862	,
39519450	)

INSERT INTO custsetting (custid, sporttype,Bettype,apositiontaking, mpositiontaking, spositiontaking, alivepositiontaking, mlivepositiontaking, slivepositiontaking
			, playerdiscount, discount, adiscount, sdiscount, groupa, groupb, groupc, groupd, groupe, groupf, minbet, maxbet
			, autopositiontaking, autolivepositiontaking, isautopositiontaking, isautolivepositiontaking, autompositiontaking, autolivempositiontaking, isautompositiontaking, isautolivempositiontaking	)
	
SELECT t.custid, cs.sporttype,9999,cs.apositiontaking, cs.mpositiontaking, cs.spositiontaking, cs.alivepositiontaking, cs.mlivepositiontaking, cs.slivepositiontaking
			, csb.playerdiscount, csb.discount, csb.adiscount, csb.sdiscount, 0, 0, 0, 0, 0, 0, csb.minbet,csb.maxbet
			, cs.autopositiontaking, cs.autolivepositiontaking, cs.isautopositiontaking, cs.isautolivepositiontaking, cs.autompositiontaking, cs.autolivempositiontaking, cs.isautompositiontaking, 
			cs.isautolivempositiontaking
	FROM #CustList t
		INNER JOIN custsetting cs (NOLOCK) ON t.CustID = cs.custid  AND cs.bettype = 1 AND cs.sporttype = 99
		INNER JOIN custsetting csb (NOLOCK) ON t.CustID = csb.custid AND csb.bettype = 20 AND csb.sporttype = 99 			
	
INSERT INTO custoverride (custid, bettype, sporttype, minpositiontaking, maxpositiontaking, minlivepositiontaking, maxlivepositiontaking)
SELECT temp_pt.custid, 9999, sporttype, minpositiontaking, maxpositiontaking, minlivepositiontaking, maxlivepositiontaking
FROM #CustList temp_pt
	INNER JOIN custoverride cs (NOLOCK) ON temp_pt.CustID = cs.custid		
WHERE   cs.bettype = 1	AND cs.sporttype = 99	AND temp_pt.roleid <> 1	
