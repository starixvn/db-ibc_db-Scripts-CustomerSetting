/*
	Created: Elodie
	Task: Update PT settings of SB for licensees [RedmineID: #110111]
	DB: DBTXN/bodb02
	Date: 20190313
*/ 
USE bodb02
GO 

DECLARE @MaxTransId BIGINT

SELECT @MaxTransId = xxx
CREATE TABLE #supers (custid INT, PT SMALLMONEY)
CREATE TABLE #tmpAgent (CustID INT PRIMARY KEY, PT SMALLMONEY)	
CREATE TABLE #tmpTrans (CustId INT, TransId BIGINT, PT SMALLMONEY)	
CREATE TABLE #tmpTable (TransId BIGINT, PT SMALLMONEY)	
CREATE TABLE #tmpSportBettypeMatrix (bettype SMALLINT)
DECLARE @TransIdList XML, @TransIdStr VARCHAR(MAX)

INSERT INTO #supers(custid, PT)
SELECT ci.custid, 0.89	
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN(	'Ae88')


INSERT INTO #tmpAgent(CustID, PT)
SELECT ci.CustID, PT
FROM CustDB.dbo.custInfo ci WITH(NOLOCK)
	INNER JOIN #supers s ON ci.srecommend = s.custid
WHERE roleid = 2

INSERT INTO #tmpSportBettypeMatrix (bettype)
SELECT DISTINCT bettype FROM SportBettypeMatrix WITH (NOLOCK) WHERE productID = 1 

INSERT INTO #tmpTrans(CustId, TransId, PT)
SELECT b.CustID, TransId, PT
FROM dbo.bettrans b WITH (NOLOCK)
	INNER JOIN #tmpAgent a ON b.recommend = a.CustID
	INNER JOIN #tmpSportBettypeMatrix mt ON b.bettype = mt.BetType
WHERE b.winlostdate > '2019-08-01 00:00:00'
	AND b.statusID IN (0,1)
	AND TransId <= @MaxTransId
	AND b.apositiontaking <> 0

SELECT transid INTO bettrans_UpdatePT_DanielTmp FROM #tmpTrans

WHILE EXISTS(SELECT 1 FROM #tmpTrans)
BEGIN
	DELETE TOP (2500) #tmpTrans OUTPUT DELETED.TransId, Deleted.PT INTO #tmpTable

	SELECT @TransIdList = (SELECT (
									SELECT  bt.TransId	AS '@T',
											bt.PT		AS '@PT'
									FROM #tmpTable bt
									FOR XML PATH('C'), 
									TYPE
								)
						FOR XML PATH('R'), 
						TYPE)
	
	SELECT @TransIdStr = CONVERT(VARCHAR(MAX), @TransIdList)
	EXEC Acc_ExecRep_09 @TransIdList = @TransIdStr

	TRUNCATE TABLE #tmpTable
	WAITFOR DELAY '00:00:0.100'
END

/*
DROP TABLE #supers
DROP TABLE #tmpAgent
DROP TABLE #tmpSportBettypeMatrix
DROP TABLE #tmpTable
DROP TABLE #tmpTrans
*/