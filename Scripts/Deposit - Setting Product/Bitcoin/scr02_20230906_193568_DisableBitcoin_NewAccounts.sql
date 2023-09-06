/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230906
	Task: [BBIN] - Disable Bitcoin - New accounts [Redmine: #193658] 
	DB: DBCust/CustDB
*/

DECLARE	@Sporttype	SMALLINT = 175,
		@Bettype	SMALLINT = 7901,
		@bitmapOrder TINYINT,
		@max_custid	INT
	 
SELECT @bitmapOrder = bitmapOrder 
FROM dbo.Dep_ProductStatusProfile m WITH (NOLOCK) 
WHERE m.Sporttype = @SportType AND m.Bettype = @BetType	

SELECT @max_custid = xxx

CREATE TABLE #supers(custid int PRIMARY KEY)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
    INNER JOIN Dep_CustProductStatus s WITH (NOLOCK) ON ci.custid = s.CustID          
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled = 1
	AND site = 'Haifa'

CREATE TABLE #Dummy(CustID INT PRIMARY KEY)

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

CREATE TABLE #AllUsers (CustID int PRIMARY KEY, bitmapIsDisabled BINARY(32))

INSERT INTO #AllUsers(CustID, bitmapIsDisabled)
SELECT ci.custid, dbo.f_GenerateProductStatus(s.bitmapIsDisabled, @bitMapOrder, 1) as bitmapIsDisabled
FROM Custinfo ci WITH (NOLOCK)
    INNER JOIN Dep_CustProductStatus s WITH (NOLOCK) ON ci.custid = s.CustID
    CROSS APPLY f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitMapOrder) f     
WHERE ci.srecommend IN (SELECT custid FROM #supers) 
	AND ci.Enabled = 1
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND ci.custid > @max_custid
	AND f.value = 0

--------------------------------------------Product Status------------------------------------------------


CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY, bitmapIsDisabled binary(32))

WHILE 1 = 1 
BEGIN
	TRUNCATE TABLE #TempProductStatus

	DELETE TOP (5000) a
	OUTPUT deleted.CustID, deleted.bitmapIsDisabled INTO #TempProductStatus(CustID, bitmapIsDisabled)
	FROM #AllUsers a 

	IF @@ROWCOUNT = 0 
		BREAK;

	UPDATE c 
	SET c.bitmapIsDisabled = tmp.bitmapIsDisabled
	FROM Dep_CustProductStatus c WITH(ROWLOCK)
		INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

	WAITFOR DELAY '00:00:00.100'
END

DROP TABLE #AllUsers
			,#Dummy
			,#supers
			,#TempProductStatus
			
