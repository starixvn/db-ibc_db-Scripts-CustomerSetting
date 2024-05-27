/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 2024-05-27
	Created: @Helios
	Task: Database - Initialize Other RNG Casino for PT and Win Loss Limit [#205649]
	DB: DBCust/CustDB 
*/

DECLARE 
	@bitmapOrder TINYINT,
	@SportType	 SMALLINT	= 208 -- SportType of Saba Casino

SELECT @bitmapOrder = (SELECT psp.bitmapOrder FROM ProductStatusProfile psp WITH(NOLOCK)  WHERE psp.Sporttype = @SportType)

CREATE TABLE #TmpSuperAffected
		(
			Site		VARCHAR(10),
			ExchangeId	TINYINT,
			currency	NVARCHAR(50),
			creatdate	SMALLDATETIME,
			UserName	VARCHAR(30),
			UserName2	VARCHAR(50),
			RoleID	TINYINT,
			CustID	INT,
			srecommend	INT,
			mrecommend	INT,
			recommend	INT,
			PRIMARY KEY CLUSTERED (CustID)
		)

INSERT INTO #TmpSuperAffected 
	(
		Site
	    , ExchangeId
	    , creatdate
	    , UserName
	    , UserName2
	    , RoleID
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
	)
SELECT	Site
	    , currency
	    , creatdate
	    , UserName
	    , UserName2
	    , cu.roleid
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
FROM Customer cu WITH (NOLOCK)
WHERE cu.username IN ('SA-US$','SA-IN','SWU','SVUS','SATU','SAS','OPS-US$','StarixTestYNG','TWSuper-7333','supertestteYM')

UPDATE s
	SET s.currency = e.currency
FROM #TmpSuperAffected s
INNER JOIN exchange e WITH(NOLOCK) ON s.ExchangeId = e.ExchangeId

SELECT 'Cust Affected' AS Note , * 
FROM #TmpSuperAffected

--COUNT Downline
SELECT 
		tem.Site
	    , tem.currency
	    , tem.creatdate
	    , tem.UserName
	    , tem.roleid
	    , tem.CustID
	    , COUNT(1) AS CountDownline
FROM #TmpSuperAffected tem
INNER JOIN Customer c ON tem.srecommend = c.srecommend
GROUP BY 
  tem.Site
, tem.currency
, tem.creatdate
, tem.UserName
, tem.roleid
, tem.CustID


-- Scan ProductStatus

IF @bitmapOrder IS NOT NULL 
BEGIN
	SELECT 
		  temCust.Site
		, temCust.ExchangeId
		, temCust.currency
		, temCust.creatdate
		, temCust.UserName
		, temCust.UserName2
		, temCust.RoleID
		, temCust.CustID
		, temCust.srecommend
		, temCust.mrecommend
		, temCust.recommend
		,IsHidden = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsHidden,  @bitmapOrder))
		,IsDisabled = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsDisabled,  @bitmapOrder))
		,HasSynced = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapHasSynced,  @bitmapOrder))
	FROM CustProductStatus cs WITH(NOLOCK)
	INNER JOIN #TmpSuperAffected temCust ON cs.CustID = temCust.CustID
	WHERE 
	(SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsHidden,  @bitmapOrder)) = 1
	OR
	(SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsDisabled,  @bitmapOrder)) = 1
END


-- Scan PT

SELECT tsa.*  , cpa.*
FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
WHERE cpa.SportType = @SportType


-- Scan WL

SELECT tsa.*  , cpa.*
FROM CustWinLossLimit_Agent  cpa WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
WHERE cpa.SportType = @SportType


DROP TABLE #TmpSuperAffected