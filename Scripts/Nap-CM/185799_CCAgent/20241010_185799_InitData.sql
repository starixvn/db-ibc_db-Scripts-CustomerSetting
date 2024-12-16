/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20241008@Winfred
	DB: DBCUST/CustDB
	Task:  Customer Classification - Classify Agent
	Revisions:
		- 20241008@Winfred: [CTS] - Customer Classification - Classify Agent [RedmineID: #185799]
*/

DECLARE @cnt INT

CREATE TABLE #tblCustClass (custid INT, CustomerClass INT, CategoryID INT, isFinished BIT DEFAULT(0))
DECLARE @tmpAgent TABLE (custid INT, CustomerClass INT, CategoryID INT)

INSERT INTO #tblCustClass (custid, CustomerClass, CategoryID)
SELECT d.custid , d.CustomerClass, kq.CategoryID
FROM custinfo d WITH(NOLOCK) 
LEFT JOIN Dep_CustSuper cs WITH(NOLOCK) ON d.srecommend = cs.custid
OUTER APPLY ( SELECT Max(LogID) AS MLogID
			  FROM CustCategoryHistory a WITH(NOLOCK)
			  WHERE d.custid = a.custid
) mlog
OUTER APPLY ( SELECT TOP 1 custid, CategoryID, CustomerClass
			  FROM CustCategoryHistory a WITH(NOLOCK)
			  WHERE d.custid = a.custid AND a.LogID = mlog.MLogID
) kq
WHERE roleid > 1 AND roleid <=4 AND d.CustomerClass IS NOT NULL AND cs.custid IS NULL

WHILE (1=1)
BEGIN
	UPDATE TOP (5000) t
	SET isFinished = 1
	OUTPUT DELETED.custid, DELETED.CustomerClass, DELETED.CategoryID
	INTO @tmpAgent(custid, CustomerClass, CategoryID)
	FROM #tblCustClass t
	WHERE isFinished = 0
			
	SELECT @cnt = @@ROWCOUNT
			
	INSERT INTO CustomerClassSetting_Agent (custid, SportType, CategoryID, CustomerClass, ModifiedDate, RepUpdateTime)
	SELECT custid, 0 AS SportType, 
		CASE CategoryID WHEN 210 THEN 101010
						WHEN 52 THEN 120100
						WHEN 53 THEN 120200
						WHEN 54 THEN 120300
						WHEN 55 THEN 120400
						WHEN 58 THEN 120500
						WHEN 59 THEN 120600
						WHEN 162 THEN 120800
						WHEN 163 THEN 121100
						WHEN 92 THEN 125100
						WHEN 93 THEN 125200
						WHEN 94 THEN 125300
						WHEN 95 THEN 125400
						WHEN 98 THEN 125500
						WHEN 99 THEN 125600
						WHEN 102 THEN 125800
						WHEN 164 THEN 126100
						ELSE CategoryID END AS CategoryID, 
		CASE CustomerClass  WHEN 999 THEN 999
							WHEN 301 THEN 30000
							WHEN 303 THEN 30000
							WHEN 302 THEN 30000
							WHEN 303 THEN 30000
							WHEN 302 THEN 30000
							WHEN 303 THEN 30000
							WHEN 304 THEN 30000
							WHEN 300 THEN 30000
							WHEN 3001 THEN 31000
							WHEN 3003 THEN 31000
							WHEN 3002 THEN 31000
							WHEN 3003 THEN 31000
							WHEN 3002 THEN 31000
							WHEN 3003 THEN 31000
							WHEN 3004 THEN 31000
							WHEN 3000 THEN 31000
							ELSE CustomerClass END AS CustomerClass, 
		GETDATE() AS ModifiedDate, [dbo].[f_GetDateTime2]() AS RepUpdateTime
	FROM @tmpAgent a
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM CustomerClassSetting_Agent b WITH(NOLOCK) WHERE a.custid  = b.custid) ;
						
	IF @cnt < 5000
		BREAK;
				
	DELETE @tmpAgent
END

DROP TABLE #tblCustClass