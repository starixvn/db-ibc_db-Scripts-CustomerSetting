/*
	Created: Johnson
	Task: Enable Esports for newly customers of hl ZU01 [RedmineID: #131058]
	DB: DBCUST/CustDB
	Date: 20200325
*/ 

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN CustAccount ca (nolock) ON ci.custid = ca.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ca.groupid = 515 --ZU01	
	
DECLARE @BitOrder INT = 18-- E-sports	

CREATE TABLE #tblCust (CustID INT PRIMARY KEY)
DECLARE @tmpCust TABLE(custid INT)

INSERT INTO #tblCust(CustID)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 
	INNER JOIN CustProductStatus cs WITH(NOLOCK) ON ci.custid = cs.custid
WHERE ci.srecommend = @srecommend 		
	AND ci.Enabled=1	
	AND ci.custid > @maxcustid
	AND (SELECT value FROM dbo.f_CustSetting_ProductStatusSel(bitmapIsDisabled,@BitOrder)) = 1
	
WHILE (1=1)
BEGIN
	DELETE TOP (1000) #tblCust
	OUTPUT DELETED.custid
	INTO @tmpCust(custid)

	IF @@ROWCOUNT=0
		BREAK	
		
	UPDATE cs
	SET								
		bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,0)
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)

	DELETE @tmpCust
	
	WAITFOR DELAY '00:00:00.280'	
END	