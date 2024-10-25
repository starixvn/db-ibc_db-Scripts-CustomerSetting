/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - Update Site , Currency Fixx Data wrong SIT [#206823]   
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/


DECLARE  @Threshold	INT  -- the number of each batch
		
SET @Threshold		= 4000

CREATE TABLE #tmpTable (CustID INT , Site varchar(10), Currency int )

INSERT INTO #tmpTable 
	(
		CustID,
		Site,
		Currency
	)
SELECT c.custid , c.Site , c.currency
from CustInfoMini ci WITH (NOLOCK)
INNER JOIN Customer c WITH (NOLOCK) ON ci.CustID = c.CustID 
WHERE ci.Site  <>  c.Site


WHILE (1=1)
BEGIN
	--SELECT TOP (@Threshold) cim.CustID
	UPDATE TOP (@Threshold) cim
		SET cim.Site = T.Site , cim.Currency = T.Currency , cim.RepUpdateTime = SYSDATETIME ()
	FROM CustInfoMini cim WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #tmpTable t ON cim.CustID = t.CustID

	DELETE TOP (@Threshold) FROM #tmpTable

	IF @@ROWCOUNT = 0
			BREAK;
END

DROP TABLE #tmpTable

----select c.custid , c.Site , c.currency , c.creatdate , ci.CustID , ci.Site , ci.Currency
Update ci 
	Set ci.Site = c.site , ci.Currency = c.currency , ci.RepUpdateTime = SYSDATETIME()
from CustInfoMini ci WITH (ROWLOCK ,UPDLOCK) 
INNER JOIN Customer c WITH (NOLOCK) ON c.CustID = ci.CustID
where c.RoleID > 4 AND (c.Site IS NOT NULL OR c.currency IS NOT NULL)


----select * from Customer WITH (NOLOCK) Where CustID = 28031433
----select c.custid , c.recommend , c.Site , c.currency , ci.CustID , ci.recommend , ci.Site , ci.Currency
Update ci 
	Set ci.Site = c.site , ci.Currency = c.currency , ci.RepUpdateTime = SYSDATETIME()
from CustInfoMini ci WITH (ROWLOCK ,UPDLOCK) 
INNER JOIN Customer c WITH (NOLOCK) ON ci.CustID = c.CustID
Where ci.Roleid = 1
AND (ci.Site IS NULL OR ci.currency IS NULL)