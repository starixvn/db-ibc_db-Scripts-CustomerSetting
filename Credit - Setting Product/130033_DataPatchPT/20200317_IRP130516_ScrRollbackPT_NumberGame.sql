/*
	Created: 20200317@Johnson
	Task: rollback setting for NG for super TP [redmine: 129401]
	DB: DBCUST/CUSTDB
*/
DECLARE @tmpCust TABLE(custid INT)

SELECT custid, 0 isUpdated
INTO #tblCust
FROM custinfo WITH(NOLOCK)
WHERE srecommend = 9727510

SELECT *
INTO #tmpCustsetting3rd
FROM DBNOTI.custdb_test2.dbo.custsetting3rd WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust)
	AND sporttype = 161

SELECT *
INTO #tmpCustOverride3rd
FROM DBNOTI.custdb_test2.dbo.custOverride3rd WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust)
	AND sporttype = 161


WHILE(1=1)
BEGIN
	DELETE @tmpCust
	
	UPDATE TOP (500) t
	SET isUpdated = 1
	OUTPUT DELETED.custid INTO @tmpCust
	FROM #tblCust t
	WHERE isUpdated = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET cs.apositiontaking = t.apositiontaking,
		cs.mpositiontaking = t.mpositiontaking,
		cs.spositiontaking = t.spositiontaking,
		cs.autopositiontaking = t.autopositiontaking,
		cs.isautopositiontaking = t.isautopositiontaking,
		cs.autompositiontaking = t.autompositiontaking,
		cs.isautompositiontaking = t.isautompositiontaking,
		cs.alivepositiontaking = t.alivepositiontaking,
		cs.mlivepositiontaking = t.mlivepositiontaking,
		cs.slivepositiontaking  = t.slivepositiontaking,
		cs.autolivepositiontaking = t.autolivepositiontaking,
		cs.isautolivepositiontaking = t.isautolivepositiontaking,
		cs.autolivempositiontaking = t.autolivempositiontaking,
		cs.isautolivempositiontaking = t.isautolivempositiontaking
	FROM custsetting3rd cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpCustsetting3rd t ON cs.custid = t.custid
											AND cs.sporttype = t.sporttype
											AND cs.bettype = t.bettype
	WHERE t.custid IN (SELECT custid FROM @tmpCust)										
	
	UPDATE 	cs
	SET cs.minpositiontaking = t.minpositiontaking,
		cs.maxpositiontaking = t.maxpositiontaking,
		cs.minlivepositiontaking = t.minlivepositiontaking,
		cs.maxlivepositiontaking = t.maxlivepositiontaking
	FROM CustOverride3rd cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpCustOverride3rd t ON cs.custid = t.custid
											AND cs.sporttype = t.sporttype
											AND cs.bettype = t.bettype
	WHERE t.custid IN (SELECT custid FROM @tmpCust)	
	
	WAITFOR DELAY '0:0:0.28'
END	
	