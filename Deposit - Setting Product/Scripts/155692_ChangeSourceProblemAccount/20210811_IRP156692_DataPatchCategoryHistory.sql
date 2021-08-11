/*
	Created: 20210811@Johnson
	Task: Data patch Dep_CustCategoryHistory
	DB: DBCUST/CustDB
*/

--update Category 62-> 162
--14 rows affects
UPDATE c
SET CategoryID = 162
FROM Dep_CustCategoryHistory c WITH(ROWLOCK)
WHERE CategoryID = 62
GO


SELECT DISTINCT custid 
INTO #tmpCust
FROM Dep_CustCategoryHistory d(nolock) 
WHERE CategoryID IN ( 
201,
202,
206	,
1000
)

--1367 rows affects
DELETE FROM Dep_CustCategoryHistory WITH(ROWLOCK) 
WHERE CategoryID IN ( 
201,
202,
206	,
1000
)
GO

--50 rows affects
;WITH T AS (
	SELECT custid, MAX(CreatedDate) maxdate 
	FROM Dep_CustCategoryHistory d WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmpCust)
	GROUP BY custid 
)
UPDATE p
SET p.ModifiedDate = maxdate
FROM ProblemAccountClassification p WITH(ROWLOCK)
	INNER JOIN T on p.custid = t.custid
WHERE ModifiedDate <> maxdate
