/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 2024-05-28
	Created: @Helios
	Task: Database - Initialize Other RNG Casino for PT and Win Loss Limit [#205649]
	DB: DBCust/CustDB 
*/

DECLARE 
	@bitmapOrder TINYINT,
	@SportType	 SMALLINT	= 208 -- SportType of Saba Casino

SELECT @bitmapOrder = (SELECT psp.bitmapOrder FROM ProductStatusProfile psp WITH(NOLOCK)  WHERE psp.Sporttype = @SportType)

CREATE TABLE #SuperID (SuperID INT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid FROM Customer c WITH (NOLOCK) WHERE c.username  IN ('SA-US$','SA-IN','SWU','SVUS','SATU','SAS','OPS-US$','StarixTestYNG','TWSuper-7333','supertestteYM')

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
			CreatedDate SMALLDATETIME,
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
	    , CreatedDate
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
	    , cu.creatdate
FROM Customer cu WITH (NOLOCK)
INNER JOIN #SuperID c ON cu.srecommend = c.SuperID
WHERE cu.creatdate >= '2024-05-12 00:00:00'

UPDATE s
	SET s.currency = e.currency
FROM #TmpSuperAffected s
INNER JOIN exchange e WITH(NOLOCK) ON s.ExchangeId = e.ExchangeId


SELECT '#TmpSuperAffected' AS Note , * FROM #TmpSuperAffected

CREATE TABLE #tmpCollect (
    Site varchar(10),
    ExchangeId tinyint,
    currency nvarchar(50),
    creatdate smalldatetime,
    UserName varchar(30),
    UserName2 varchar(50),
    RoleID tinyint,
    CustID int,
    srecommend int,
    mrecommend int,
    recommend int,
    IsHidden bit,
    IsDisabled bit,
    HasSynced bit)


IF EXISTS (SELECT 1 FROM #TmpSuperAffected)
BEGIN



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
		, temCust.creatdate
		,IsHidden = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsHidden,  @bitmapOrder))
		,IsDisabled = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsDisabled,  @bitmapOrder))
		,HasSynced = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapHasSynced,  @bitmapOrder))
	FROM CustProductStatus cs WITH(NOLOCK)
	INNER JOIN #TmpSuperAffected temCust ON cs.CustID = temCust.CustID

	ORDER BY temCust.srecommend , temCust.RoleID
END

-- Scan PT

SELECT 'CustPTSetting3rd_Agent' AS Note , tsa.*  , cpa.*
FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
WHERE tsa.RoleID IN (2,3,4)

SELECT 'CustPTSetting3rd_member' AS Note , tsa.*  , cpa.*
FROM CustPTSetting3rd_member cpa WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
WHERE tsa.RoleID = 1


-- Scan WL

SELECT 'CustWinLossLimit_Agent' AS Note , tsa.*  , cpa.*
FROM CustWinLossLimit_Agent  cpa WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
WHERE tsa.RoleID IN (2,3,4)

SELECT 'CustWinLossLimit_Member' AS Note , tsa.*  , cpa.*
FROM CustWinLossLimit_Member  cpa WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tsa ON cpa.CustID = tsa.CustID
WHERE tsa.RoleID = 1

END

DROP TABLE #TmpSuperAffected
DROP TABLE #SuperID
DROP TABLE #tmpCollect