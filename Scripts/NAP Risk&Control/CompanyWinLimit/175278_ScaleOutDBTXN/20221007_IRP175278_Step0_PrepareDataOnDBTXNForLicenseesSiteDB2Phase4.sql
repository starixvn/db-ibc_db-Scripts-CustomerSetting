/*<info serverAlias="DBCTG-bodb02"></info>*/
/*
	Created: 20221007@Johnson
	Task: Prepare data for licensees migrate to sitedb2 phase 4 [#RedmineID:#175278]
	DB: DBCTG/bodb02
*/

IF NOT EXISTS (SELECT TOP (1) 1 FROM dbo.BalancePendingCreditGame WITH(NOLOCK))
	AND NOT EXISTS (SELECT TOP (1) 1 FROM dbo.BalancePendingDebitGame WITH(NOLOCK))
BEGIN
	CREATE TABLE #tmp_cust
		(
			custid INT PRIMARY KEY
		)
		
	------------------------------------------------
	INSERT INTO #tmp_cust (custid)
	SELECT DISTINCT custid
	FROM CustDB.dbo.Customer WITH (NOLOCK)
	WHERE site IN ('OneSports',
					'9Club',
					'X2Dynamic',
					'Macaubet')
		and roleid = 1
		
	SELECT [custid],[winlostdate],[Winlost],[bettype]
	INTO SiteDB2tmp.dbo.Winlimit_CreditGame_20221013
	FROM dbo.Winlimit_CreditGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)

	SELECT [custid],[winlostdate],[Winlost],[bettype]
	INTO SiteDB2tmp.dbo.Winlimit_DebitGame_20221013
	FROM dbo.Winlimit_DebitGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)	
END
