/*
	Created: 20200514@Tiara
	Date: 20200514
	Task:  Disable status of SA Gaming for HK$, RMB, HKK - New users[Redmine: #134176]
	DB: DBCUST/CustDB
*/

	DECLARE @maxcustid INT
	DECLARE @CustID	INT

	SELECT @maxcustid = xxx
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		AND ci.currency NOT IN (45,75,76,77,41) --Won (KRW), PTU, PS, PTH, CHF
	ORDER BY CI.custid 

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

	DECLARE @SportType INT = 244, @BetType INT=3001
-----
		CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		SiteID INT
	)

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		Currency INT,
		SiteID INT

	)

	INSERT INTO #SMATemp (CustID,Currency, SiteID)
	SELECT CI.custid, CI.currency, S.siteid 
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
		INNER  JOIN SITE S WITH (NOLOCK) ON S.site = C.site
	WHERE ci.srecommend IN(SELECT CustID FROM #supers) AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @maxcustid 
			AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #MemberTemp (CustID,Currency, SiteID)
	SELECT CI.custid, CI.currency, S.siteid 
	FROM custInfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.recommend
		INNER  JOIN SITE S WITH (NOLOCK) ON S.site = C.site
	WHERE CI.srecommend IN(SELECT CustID FROM #supers) AND CI.roleid = 1  AND Enabled = 1 AND CI.custid > @maxcustid	
		AND CI.mrecommend NOT IN (SELECT custid FROM #Dummy)


	--------------------------------------Status-------------------------------------------------
	DECLARE @BitOrder INT
	SELECT @BitOrder= bitmapOrder from Dep_ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype

	UPDATE c 
	SET  c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,1)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,1)
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @BetType AND PSP.Sporttype = @SportType
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid

	UPDATE c 
	SET  c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,1)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,1)
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @BetType AND PSP.Sporttype = @SportType
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

	
	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #supers
	DROP TABLE #Dummy


