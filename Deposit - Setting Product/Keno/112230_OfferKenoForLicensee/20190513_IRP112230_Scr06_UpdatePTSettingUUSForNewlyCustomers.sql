/*
	Created: 20190513@Johnson
	Task: update PT = 0.9 for all newly UUS licensee customers 
	DB: DBCUST/CustDB
*/

DECLARE @max_custid INT
SELECT  @max_custid= xxx ---input maxcustid
	
CREATE TABLE #Supers (custid INT,isFinished BIT DEFAULT(0))

INSERT INTO #Supers (custid)
SELECT custid
FROM Dep_custSuper WITH(NOLOCK)
WHERE currency = 20

CREATE TABLE #tblCust (custid INT, mrecommend INT, roleid TINYINT)
DECLARE @tmpCust TABLE(Custid INT, roleid TINYINT)
DECLARE @rowcount INT

INSERT INTO #tblCust (custid,roleid,mrecommend)			
SELECT custid,roleid,mrecommend
FROM dbo.Customer WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND custid > @max_custid

DELETE #tblCust 
WHERE mrecommend IN (SELECT custid 
					FROM dbo.custinfo WITH(NOLOCK)
					WHERE srecommend IN (SELECT custid FROM #Supers)
					AND(username like '%Acc%'  OR username like '%AFF%' OR username like '%LocalBank%'
					AND roleid=3)


WHILE(1=1)
BEGIN			
	DELETE TOP (5000) t
	OUTPUT DELETED.custid, DELETED.roleid INTO @tmpCust
	FROM #tblCust
	
	SELECT @rowcount = @@rowcount	
	
	UPDATE cs
	SET spositiontaking = CASE WHEN roleid = 4 THEN 0.9 ELSE spositiontaking END,
		mpositiontaking = CASE WHEN roleid IN (4,3) THEN 0.9 ELSE mpositiontaking END,
		apositiontaking = CASE WHEN roleid IN (4,2,1) THEN 0.9 ELSE apositiontaking END		
	FROM CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @tmpCust t ON cs.custid = t.custid
	WHERE sporttype = 202
		AND bettype = 1501
	
	IF @rowcount < 5000
		BREAK;
END	

DROP TABLE #tblCust
DROP TABLE #Supers 
