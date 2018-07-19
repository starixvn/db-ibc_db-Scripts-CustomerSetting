/*	
	CreatedDate: 20180716@Elodie
	Task: Initial data for MsgCustReadStatus table
	DB: DBMSG/bodb_Message
*/

USE bodb_Message
GO

TRUNCATE TABLE dbo.MsgCustReadStatus

GO
CREATE TABLE #supers (custid INT)
CREATE TABLE #SubAccount (custid INT, SubAccID INT)
DECLARE @max_custid INT, @max_custSubId INT, @ReleaseDate DATETIME

SELECT @ReleaseDate = GETDATE()
SELECT @max_custid = xxx --SELECT MAX(custid) FROM bodb02.dbo.Custinfo WITH (NOLOCK)
SELECT @max_custSubId = xxx --SELECT MAX(subaccid) FROM bodb02.dbo.CustSub WITH (NOLOCK)

--Start: Main Account
INSERT INTO #supers(custid)
SELECT c.custid
FROM bodb02.dbo.customer c WITH (NOLOCK) 
	INNER JOIN bodb02.dbo.site s WITH (NOLOCK) ON c.site = s.site
	LEFT JOIN bodb02.dbo.custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.roleid = 4  
	AND c.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND c.custid NOT IN (SELECT custid FROM bodb02.dbo.Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND c.custid <= @max_custid

INSERT INTO dbo.MsgCustReadStatus (CustID, SubAccID, LastSeenNormalMsg, LastSeenPersonalMsg, LastSeenSpecialMsg, LastSeenSystemUpdMsg)
SELECT ci.custid, 0, @ReleaseDate, @ReleaseDate, @ReleaseDate, @ReleaseDate
FROM bodb02.dbo.CustInfo ci WITH (NOLOCK)
	INNER JOIN #supers s ON ci.srecommend = s.custid	
WHERE ci.roleid BETWEEN 2 AND 4
	AND ci.Enabled = 1
--End: Main Account

--Start: Sub Account
INSERT INTO #SubAccount(custid, SubAccID)
SELECT ci.custid, SubAccID
FROM bodb02.dbo.CustInfo ci WITH (NOLOCK)
	INNER JOIN bodb02.dbo.custSub cs WITH (NOLOCK) ON ci.custid = cs.custid	
WHERE ci.roleid BETWEEN 2 AND 4
	AND ci.Enabled = 1
	AND cs.subaccid <= @max_custSubId

INSERT INTO dbo.MsgCustReadStatus (CustID, SubAccID, LastSeenNormalMsg, LastSeenPersonalMsg, LastSeenSpecialMsg, LastSeenSystemUpdMsg)
SELECT custid, SubAccID, @ReleaseDate, @ReleaseDate, @ReleaseDate, @ReleaseDate
FROM #SubAccount
--End: Sub Account

DROP TABLE #supers
DROP TABLE #SubAccount

--SELECT COUNT(1) FROM dbo.MsgCustReadStatus

