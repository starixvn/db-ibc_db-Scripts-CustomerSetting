/*
	Created: Johnson
	Date: 2018-11-08
	Task: copy bet setting for Happy 5 from NG for newly customers
	DB: DBCUST/CUSTDB
*/
DECLARE @max_custid INT, @max_custid2 INT 
SET @max_custid = xx,--old maxcustid
	@max_custid2 =yy --new maxcustid
CREATE TABLE #supers (custid INT)
CREATE TABLE #tblCust (custid INT PRIMARY KEY)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4 
	AND ci.currency <> 20
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0	
	
INSERT INTO #tblCust(custid)
SELECT custid
FROM dbo.CustInfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND custid > @max_custid	
	
DELETE cs
FROM Custsetting3rd cs WITH(UPDLOCK,ROWLOCK)
WHERE custid IN (SELECT custid FROM #tblCust)
	AND sporttype = 164
	AND bettype = 8101

INSERT INTO [dbo].[CustSetting3rd]
           ([custid]
           ,[bettype]
           ,[sporttype]
           ,[apositiontaking]
           ,[mpositiontaking]
           ,[spositiontaking]
           ,[playerdiscount]
           ,[discount]
           ,[adiscount]
           ,[sdiscount]
           ,[minbet]
           ,[maxbet]
           ,[autopositiontaking]
           ,[isautopositiontaking]
           ,[autompositiontaking]
           ,[isautompositiontaking]
           ,[alivepositiontaking]
           ,[mlivepositiontaking]
           ,[slivepositiontaking]
           ,[autolivepositiontaking]
           ,[isautolivepositiontaking]
           ,[autolivempositiontaking]
           ,[isautolivempositiontaking])
SELECT [custid]
	   ,8101 as [bettype]
	   ,164 as [sporttype]
	   ,0 [apositiontaking]
	   ,0 [mpositiontaking]
	   ,0 [spositiontaking]
	   ,0 [playerdiscount]
	   ,0 [discount]
	   ,0[adiscount]
	   ,0 [sdiscount]
	   ,[minbet]
	   ,[maxbet]
	   ,0 [autopositiontaking]
	   ,0 [isautopositiontaking]
	   ,0 [autompositiontaking]
	   ,0 [isautompositiontaking]
	   ,0 [alivepositiontaking]
	   ,0 [mlivepositiontaking]
	   ,0 [slivepositiontaking]
	   ,0 [autolivepositiontaking]
	   ,0 [isautolivepositiontaking]
	   ,0 [autolivempositiontaking]
	   ,0 [isautolivempositiontaking]	
FROM dbo.CustSetting3rd WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust)
	AND sporttype = 161 
	AND bettype = 81	

UPDATE ci
SET maxpermatch164 = maxpermatch161
FROM dbo.CustInfo ci WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust)

	