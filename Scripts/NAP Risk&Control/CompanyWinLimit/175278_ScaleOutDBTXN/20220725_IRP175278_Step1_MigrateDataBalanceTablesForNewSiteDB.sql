/*<info serverAlias="DBSIG-bodb02"></info>*/
/*
	Created: 20220725@Johnson
	Task: Migrate data for balance game tables for SITEDB to scale out DBTXN for CWL [#RedmineID:#167819]
	DB: DBSIG/bodb02
*/
IF NOT EXISTS (SELECT TOP (1) 1 FROM DBCTG.bodb02.dbo.BalancePendingCreditGame WITH(NOLOCK))
	AND NOT EXISTS (SELECT TOP (1) 1 FROM DBCTG.bodb02.dbo.BalancePendingDebitGame WITH(NOLOCK))
BEGIN
	CREATE TABLE #tmp_cust
	(
		custid INT PRIMARY KEY
	)
	
	------------------------------------------------
	INSERT INTO #tmp_cust (custid)
	SELECT DISTINCT custid
	FROM CustDB.dbo.Customer WITH (NOLOCK)
	WHERE site IN ('Athena000','SampleSite')
		and roleid = 1

	SELECT [custid],[winlostdate],[Winlost],[bettype]
	INTO Winlimit_CreditGame_Old20220825
	FROM dbo.Winlimit_CreditGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)
	
	SELECT [custid],[winlostdate],[Winlost],[bettype]
	INTO Winlimit_DebitGame_Old20220825
	FROM dbo.Winlimit_DebitGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)
	
	TRUNCATE TABLE Winlimit_CreditGame
	TRUNCATE TABLE Winlimit_DebitGame
	
	INSERT INTO [dbo].[Winlimit_CreditGame]
			   ([custid]
			   ,[winlostdate]
			   ,[Winlost]
			   ,[bettype])
	SELECT [custid]
		   ,[winlostdate]
		   ,[Winlost]
		   ,[bettype]
	FROM dbo.Winlimit_CreditGame_Old20220825 WITH(NOLOCK)
	
	INSERT INTO [dbo].[Winlimit_DebitGame]
			   ([custid]
			   ,[winlostdate]
			   ,[Winlost]
			   ,[bettype])
	SELECT [custid]
		   ,[winlostdate]
		   ,[Winlost]
		   ,[bettype]
	FROM Winlimit_DebitGame_Old20220825 WITH(NOLOCK)	

	DROP TABLE Winlimit_CreditGame_Old20220825
	DROP TABLE Winlimit_DebitGame_Old20220825
END		   