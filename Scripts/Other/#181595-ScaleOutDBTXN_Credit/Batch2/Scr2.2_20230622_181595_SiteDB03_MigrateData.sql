/*<info serverAlias="DBSIC-bodb02"></info>*/
/*
	Created: 20230622@Eden
	Task: Migrate data credit customer from DBCTG to SITEDB3 - Batch2 [#RedmineID:#181595]
	DB: DBSIC/bodb02  (SiteDB03 only)
*/
USE bodb02
GO

--> check pending table of centralDB
WHILE EXISTS( SELECT 1 FROM DBCTG.bodb02.dbo.BalancePendingCreditGame WITH(NOLOCK) )
	OR EXISTS(SELECT 1 FROM DBCTG.bodb02.dbo.BalancePendingDebitGame WITH(NOLOCK))
BEGIN
	PRINT 'Wait 10s for job ''bodb02 : Game : Task_BalanceUpd'' proceed done'
	WAITFOR DELAY '00:00:10'
END

CREATE TABLE #Supers (custid int PRIMARY KEY)

INSERT INTO #Supers(custid)
SELECT DISTINCT ci.Custid
FROM custdb.dbo.customer ci WITH(NOLOCK) 
	INNER JOIN custdb.dbo.Site s WITH(NOLOCK) 
		ON ci.site = s.site
WHERE s.isLicensee = 0
	AND ci.roleid = 4
	AND ci.custid NOT IN ( SELECT custid FROM custdb.dbo.Dep_CustSuper WITH(NOLOCK))
	AND s.SiteLabel IN ('Nova88','789y')
	AND s.site NOT IN( 'CN88','222227')

INSERT INTO Winlimit_CreditGame(CustId,WinlostDate,BetType,Winlost)
SELECT c.CustId,c.WinlostDate,c.BetType,c.Winlost
FROM DBCTG.bodb02.dbo.Winlimit_CreditGame c WITH(NOLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND NOT EXISTS( SELECT  TOP 1 1 
					FROM Winlimit_CreditGame e WITH(NOLOCK)
					WHERE e.CustId = c.CustId
						AND e.WinlostDate = c.WinlostDate
						AND e.BetType = c.BetType
					)

INSERT INTO Winlimit_DebitGame(CustId,WinlostDate,BetType,Winlost)
SELECT c.CustId,c.WinlostDate,c.BetType,c.Winlost
FROM DBCTG.bodb02.dbo.Winlimit_DebitGame c WITH(NOLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND NOT EXISTS( SELECT  TOP 1 1 
					FROM Winlimit_DebitGame e WITH(NOLOCK)
					WHERE e.CustId = c.CustId
						AND e.WinlostDate = c.WinlostDate
						AND e.BetType = c.BetType
					)

INSERT INTO BalanceCreditGame(CustId,WinlostDate,BetType,Balance)
SELECT c.CustId,c.WinlostDate,c.BetType,c.Balance
FROM DBCTG.bodb02.dbo.BalanceCreditGame c WITH(NOLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND NOT EXISTS( SELECT  TOP 1 1 
					FROM BalanceCreditGame e WITH(NOLOCK)
					WHERE e.CustId = c.CustId
						AND e.WinlostDate = c.WinlostDate
						AND e.BetType = c.BetType
					)

INSERT INTO BalanceDebitGame(CustId,WinlostDate,BetType,Balance)
SELECT c.CustId,c.WinlostDate,c.BetType,c.Balance
FROM DBCTG.bodb02.dbo.BalanceDebitGame c WITH(NOLOCK)
	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND NOT EXISTS( SELECT  TOP 1 1 
					FROM BalanceDebitGame e WITH(NOLOCK)
					WHERE e.CustId = c.CustId
						AND e.WinlostDate = c.WinlostDate
						AND e.BetType = c.BetType
					)


	
--INSERT INTO Task_Cust_CheckBalance_Exception(CustId,Remark)
--SELECT c.CustId,c.Remark
--FROM DBCTG.bodb02.dbo.Task_Cust_CheckBalance_Exception c WITH(NOLOCK)
--	INNER JOIN custdb.dbo.custinfo ci WITH(NOLOCK) ON c.CustId = ci.custid
--WHERE ci.srecommend IN (SELECT custid FROM #Supers)
--	AND NOT EXISTS( SELECT  TOP 1 1 
--					FROM Task_Cust_CheckBalance_Exception e WITH(NOLOCK)
--					WHERE e.CustId = c.CustId
--					)
	
DROP TABLE #Supers