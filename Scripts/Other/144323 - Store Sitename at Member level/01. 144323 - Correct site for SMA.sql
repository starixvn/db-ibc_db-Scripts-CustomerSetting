/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Tina@20201117
	Task: Correct Sitename at SMA level [RedmineID: 144323]
	DB: DBCUST/CustDB
*/ 
USE [CustDB]
GO
--Correct table Customer
CREATE TABLE #UpdateSMA (CustID INT PRIMARY KEY CLUSTERED, [Site] VARCHAR(10))

INSERT INTO #UpdateSMA(CustID, [Site])
SELECT C.custid, Sup.[site]
FROM Customer C WITH (NOLOCK)
	INNER JOIN Customer Sup WITH (NOLOCK) ON C.srecommend = Sup.custid
WHERE C.roleid IN (3,2)
	AND C.[site] IS NULL

UPDATE sma SET sma.[site] = upd.[site]
FROM Customer sma WITH (ROWLOCK,UPDLOCK)
	INNER JOIN #UpdateSMA upd WITH (NOLOCK) ON sma.custid = upd.custid

DROP TABLE #UpdateSMA
GO

--Correct table CustAgent
UPDATE CA SET CA.[site] = C.[site]
FROM CustAgent CA WITH (ROWLOCK,UPDLOCK)
	INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CA.custid
WHERE (CA.[site] <> C.[site] OR CA.[site] IS NULL)
