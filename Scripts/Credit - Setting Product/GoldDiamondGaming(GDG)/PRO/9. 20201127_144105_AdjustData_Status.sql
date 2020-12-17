/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20201111@Tina
	Task: Adjust Status for Big Gaming (BG) [Redmine: #142458]
	DB: DBCUST/CustDB
*/ 

	
	CREATE TABLE #supers (custid int)

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.Site<>'CN88'
		AND s.islicensee = 0
		AND ci.currency IN (13,	--CNY(RMB)
							15,	--IDR(IN)
							22,	--IDR(IND)
							33,	--IDR(IDD)
							34,	--IDR(IDR)
							47,	--IDR(DDD)
							43,	--THB(THB)
							3,	--USD(US$)
							16,	--USD(Yen)
							35,	--USD($US)
							64,	--USD(UT)
							95,	--USD(USD)
							2,	--MYR(RM)
							5,	--HKD(HK$)
							67,	--HKD(HKK)
							69	--MMK(MMK)
						) --supported currencies
	
	CREATE TABLE #CustList_ST (custid INT, IsDisabledAB BIT)
--------------------------------------Status Setting-------------------------------------------------		
	DECLARE @BitmapOrder TINYINT = 31

	INSERT INTO #CustList_ST (custid, IsDisabledAB)
	SELECT CS.CustID, isDisabledAB.value
	FROM dbo.CustProductStatus cs WITH(NOLOCK)
		INNER JOIN dbo.CustProductStatus cs2 WITH(NOLOCK) ON cs.CustID= cs2.CustID
		INNER JOIN custInfo ci WITH(NOLOCK) ON cs.CustID = ci.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 22) as isDisabledAB
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsDisabled, @BitmapOrder) as isDisabledBB
		CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS2.bitmapIsHidden, @BitmapOrder) as isHiddenBB
	WHERE (isDisabledBB.value <> isDisabledAB.value	OR isHiddenBB.value != 0)
		AND ci.Enabled = 1

	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,ci.IsDisabledAB)) 	
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustList_ST CI WITH(NOLOCK) ON cs.CustID = ci.CustID

	DROP TABLE #CustList_ST
	DROP TABLE #supers
