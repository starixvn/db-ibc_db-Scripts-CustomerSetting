/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210223
	Task: Get list licensee for Sports Lottery - API Licensee - Deposit [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Get list licensee for Sports Lottery for Sports Lottery
*/
-- Get licensee active
CREATE TABLE #supers (custid INT,site VARCHAR(20))

SELECT l.LicenseeName 
INTO #ActiveLic
FROM bodb_Licensee.dbo.Licensees l WITH (NOLOCK)
WHERE l.IsActive = 1 AND l.IsDeposit = 1 AND l.LicenseeName NOT IN ('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol','spondemo','Athena000')

--Get Super for licensee 
INSERT INTO #supers(custid , site)
SELECT ds.custid, ds.site
FROM Dep_CustSuper ds WITH (NOLOCK) 
INNER JOIN #ActiveLic l on ds.site = l.LicenseeName
ORDER BY ds.site

-- Lottery	Sport : 220	, Bettype : 1021 , bitmapOrder : 6
SELECT  ds.site
INTO #Result
FROM dbo.Dep_CustProductStatus CPS (NOLOCK)
INNER JOIN custInfo ci WITH(NOLOCK) ON cps.CustID = ci.custid
INNER JOIN #supers ds WITH (NOLOCK) ON ds.custid= ci.srecommend
CROSS APPLY dbo.f_CustSetting_ProductStatusSel(cps.bitmapIsDisabled, 6) as isDisabled
WHERE ISNULL(isDisabled.value, 1) = 0 -- offer=0 | not offer=1

SELECT DISTINCT Site FROM #Result

DROP TABLE #ActiveLic
DROP TABLE #supers
DROP TABLE #Result
