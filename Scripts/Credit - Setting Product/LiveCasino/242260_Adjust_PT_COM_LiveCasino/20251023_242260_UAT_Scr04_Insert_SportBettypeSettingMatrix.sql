/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*      
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBGLOB-GlobCustDB

*/
USE [GlobCustDB];

CREATE TABLE #tbl_LC_GROUPED_BETTYPE_242260 
(
    ProductID TINYINT PRIMARY KEY,
    SportTypeRefPT INT,
    BetTypeRefPT INT,
    SportTypeRefComm INT,
    BetTypeRefComm INT
);

CREATE TABLE #tbl_Matrix_UAT_242260(
		[SportType] [smallint] NOT NULL,
		[BetType] [int] NOT NULL,
		[isLicensee] [bit] NOT NULL,
		[isLive] [bit] NOT NULL,
		[Site] [varchar](50) NOT NULL,
		[isActive] [bit] NOT NULL,
		[SportTypeRefPT] [smallint] NULL,
		[BetTypeRefPT] [int] NULL,
		[isLivePT] [bit] NOT NULL,
		[TablePT] [varchar](50) NULL,
		[SportTypeRefComm] [smallint] NULL,
		[BetTypeRefComm] [int] NULL,
		[TableComm] [varchar](50) NULL,
		[SportTypeRefBetSetting] [smallint] NULL,
		[BetTypeRefBetSetting] [int] NULL,
		[TableBetSetting] [varchar](50) NULL,
		[IsLiveComm] [bit] NOT NULL,
		[IsLiveBetSetting] [bit] NOT NULL,
		[TableBettrans] [varchar](100) NULL,
		[SporttypeRefWinlossLimit] [smallint] NULL,
		[BettypeRefWinlossLimit] [smallint] NULL,
		[RealProductId] [tinyint] NULL,
		[isDeleted] [bit] NULL,
		[RepUpdateTime] [datetime2](7) NULL,
		[ProductID] [tinyint] NULL
);

/*INSERT DATA FOR MBC SITE*/
INSERT INTO #tbl_LC_GROUPED_BETTYPE_242260 (ProductID, SportTypeRefPT, BetTypeRefPT, SportTypeRefComm, BetTypeRefComm)
SELECT 
    ProductID,
    9916 AS SportTypeRefPT,/*85*/
    2400 AS BetTypeRefPT,
    9911 AS SportTypeRefComm,/*not change dummy sportType*/
    2400 AS BetTypeRefComm
FROM (VALUES (21),(39),(65),(52),(80),(70),(45)
) AS G2 (ProductID)
UNION ALL
SELECT 
    ProductID,
    9917 AS SportTypeRefPT,/*90*/
    2400 AS BetTypeRefPT,
    NULL AS SportTypeRefComm,
    NULL AS BetTypeRefComm
FROM (VALUES (51),(57),(76),(90),(96),(98),(101),(107)
) AS G3 (ProductID);

/*DELETE SportBettypeSettingMatrix_UAT;*/

INSERT INTO #tbl_Matrix_UAT_242260
(RealProductId,ProductID,SportType,BetType,isLicensee,isLive,Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,
    SportTypeRefComm,BetTypeRefComm,isLiveComm,TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans)
SELECT RealProductId,ProductID,SportType,BetType,isLicensee,isLive,Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,
    SportTypeRefComm,BetTypeRefComm,isLiveComm,TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans
FROM dbo.SportBettypeSettingMatrix sbsm WITH (NOLOCK);

/********************************************    MBC    ********************************************/
--EXCLUDE INDO site
INSERT INTO #tbl_Matrix_UAT_242260(RealProductId,ProductID,SportType,BetType,isLicensee,isLive,
    Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,
    SportTypeRefComm,BetTypeRefComm,isLiveComm,TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans)
SELECT RealProductId,TMP.ProductID,SportType,BetType,isLicensee,isLive,
    s.Site,isActive,
    p.SportTypeRefPT,p.BetTypeRefPT,isLivePT,TablePT,
    p.SportTypeRefComm,p.BetTypeRefComm,isLiveComm,
    CASE WHEN p.SportTypeRefComm IS NOT NULL THEN TableComm END TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans
FROM #tbl_Matrix_UAT_242260 TMP
INNER JOIN #tbl_LC_GROUPED_BETTYPE_242260 p ON TMP.RealProductId = p.ProductID AND TMP.isLicensee = 0
CROSS APPLY (
    SELECT si.Site, si.SiteLabel
    FROM Site si WITH (NOLOCK)
    WHERE si.isActive = 1
        AND si.isLicensee = 0
        AND si.SiteLabel IN ('MBC')
        AND Site NOT IN ('INDO')
) AS s
WHERE TMP.Site <> S.site
AND TMP.isLicensee = 0
AND TMP.ProductID = 41
AND TMP.isDeleted = 0
AND TMP.Site = 'All'
;

--INDO site, No changes on PT, applies remove comm
INSERT INTO #tbl_Matrix_UAT_242260(RealProductId,ProductID,SportType,BetType,isLicensee,isLive,
    Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,
    SportTypeRefComm,BetTypeRefComm,isLiveComm,TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans)
SELECT RealProductId,ProductID,SportType,BetType,isLicensee,isLive,
    s.Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,
    NULL SportTypeRefComm,NULL BetTypeRefComm,isLiveComm,NULL TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans
FROM #tbl_Matrix_UAT_242260 TMP WITH (NOLOCK)
CROSS APPLY (
    SELECT si.Site, si.SiteLabel
    FROM Site si WITH (NOLOCK)
    WHERE si.isActive = 1
        AND si.isLicensee = 0
        AND si.Site IN ('INDO')
) AS s
WHERE TMP.Site <> S.site
AND TMP.isLicensee = 0
AND TMP.ProductID = 41
AND TMP.isDeleted = 0
AND TMP.Site = 'All'
AND EXISTS (SELECT TOP 1 1 FROM #tbl_LC_GROUPED_BETTYPE_242260 b WHERE TMP.RealProductId = b.ProductID)
;

/********************************************    IBC, 789y    ********************************************/
INSERT INTO #tbl_Matrix_UAT_242260(RealProductId,ProductID,SportType,BetType,isLicensee,isLive,
    Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,
    SportTypeRefComm,BetTypeRefComm,isLiveComm,TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans)
SELECT RealProductId,ProductID,SportType,BetType,isLicensee,isLive,
    s.Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,
    SportTypeRefComm,BetTypeRefComm,isLiveComm,TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans
FROM #tbl_Matrix_UAT_242260 TMP WITH (NOLOCK)
CROSS APPLY (
    SELECT si.Site, si.SiteLabel
    FROM Site si WITH (NOLOCK)
    WHERE si.isActive = 1
        AND si.isLicensee = 0
        AND si.SiteLabel IN ('IBC','789y')
) AS s
WHERE TMP.Site <> S.site
AND TMP.isLicensee = 0
AND TMP.ProductID = 41
AND TMP.isDeleted = 0
AND TMP.Site = 'All'
AND EXISTS (SELECT TOP 1 1 FROM #tbl_LC_GROUPED_BETTYPE_242260 b WHERE TMP.RealProductId = b.ProductID)
;


/********************************************    INSERT INTO TABLE    ********************************************/


/**UPDATE isDeleted FOR MERGE **/
IF EXISTS (SELECT TOP 1 1 FROM SportBettypeSettingMatrix_UAT A
            WHERE ProductID = 41 AND Site = 'All' AND isLicensee = 0 AND isDeleted = 0
            AND EXISTS (SELECT TOP 1 1 FROM #tbl_LC_GROUPED_BETTYPE_242260 B WHERE B.ProductID = A.RealProductId))
BEGIN

    UPDATE sbsm
    SET isDeleted = 1
        ,RepUpdateTime = dbo.f_GetDateTime2()
    FROM SportBettypeSettingMatrix_UAT sbsm WITH (NOLOCK)
    WHERE sbsm.ProductID = 41 AND sbsm.Site = 'All' AND sbsm.isLicensee = 0 AND sbsm.isDeleted = 0
    AND EXISTS (SELECT TOP 1 1 FROM #tbl_LC_GROUPED_BETTYPE_242260 B WHERE B.ProductID = sbsm.RealProductId);

END

DELETE sbsm
FROM #tbl_Matrix_UAT_242260 sbsm WITH (NOLOCK)
WHERE sbsm.ProductID = 41 AND sbsm.Site = 'All' AND sbsm.isLicensee = 0 AND sbsm.isDeleted = 0
AND EXISTS (SELECT TOP 1 1 FROM #tbl_LC_GROUPED_BETTYPE_242260 B WHERE B.ProductID = sbsm.RealProductId);

MERGE [dbo].[SportBettypeSettingMatrix_UAT] [t]
USING #tbl_Matrix_UAT_242260 [tvp] 
    ON [t].[BetType] = [tvp].[BetType] AND [t].[SportType] = [tvp].[SportType] AND [t].[isLicensee] = [tvp].[isLicensee] AND [t].[isLive] = [tvp].[isLive] AND [t].[Site] = [tvp].[Site]
WHEN MATCHED THEN	
    UPDATE SET
        [t].[isActive] = [tvp].[isActive]
        ,[t].[SportTypeRefPT] = [tvp].[SportTypeRefPT]
        ,[t].[BetTypeRefPT] = [tvp].[BetTypeRefPT]
        ,[t].[isLivePT] = [tvp].[isLivePT]
        ,[t].[TablePT] = [tvp].[TablePT]
        ,[t].[SportTypeRefComm] = [tvp].[SportTypeRefComm]
        ,[t].[BetTypeRefComm] = [tvp].[BetTypeRefComm]
        ,[t].[TableComm] = [tvp].[TableComm]
        ,[t].[SportTypeRefBetSetting] = [tvp].[SportTypeRefBetSetting]
        ,[t].[BetTypeRefBetSetting] = [tvp].[BetTypeRefBetSetting]
        ,[t].[TableBetSetting] = [tvp].[TableBetSetting]
        ,[t].[IsLiveComm] = [tvp].[IsLiveComm]
        ,[t].[IsLiveBetSetting] = [tvp].[IsLiveBetSetting]
        ,[t].[TableBettrans] = [tvp].[TableBettrans]
        ,[t].[SporttypeRefWinlossLimit] = [tvp].[SporttypeRefWinlossLimit]
        ,[t].[BettypeRefWinlossLimit] = [tvp].[BettypeRefWinlossLimit]
        ,[t].[RealProductId] = [tvp].[RealProductId]
        ,[t].[isDeleted] = [tvp].[isDeleted]
        ,[t].[RepUpdateTime] = dbo.f_GetDateTime2()
        ,[t].[ProductID] = [tvp].[ProductID]
WHEN NOT MATCHED THEN
    INSERT ([BetType],[SportType],[isLicensee],[isLive],[Site],[isActive],[SportTypeRefPT],[BetTypeRefPT],[isLivePT],[TablePT],[SportTypeRefComm],[BetTypeRefComm],[TableComm],[SportTypeRefBetSetting],[BetTypeRefBetSetting],[TableBetSetting],[IsLiveComm],[IsLiveBetSetting],[TableBettrans],[SporttypeRefWinlossLimit],[BettypeRefWinlossLimit],[RealProductId],[isDeleted],[RepUpdateTime],[ProductID])
    VALUES ([tvp].[BetType],[tvp].[SportType],[tvp].[isLicensee],[tvp].[isLive],[tvp].[Site],[tvp].[isActive],[tvp].[SportTypeRefPT],[tvp].[BetTypeRefPT],[tvp].[isLivePT],[tvp].[TablePT],[tvp].[SportTypeRefComm],[tvp].[BetTypeRefComm],[tvp].[TableComm],[tvp].[SportTypeRefBetSetting],[tvp].[BetTypeRefBetSetting],[tvp].[TableBetSetting],[tvp].[IsLiveComm],[tvp].[IsLiveBetSetting],[tvp].[TableBettrans],[tvp].[SporttypeRefWinlossLimit],[tvp].[BettypeRefWinlossLimit],[tvp].[RealProductId],[tvp].[isDeleted],dbo.f_GetDateTime2(),[tvp].[ProductID]);


DROP TABLE #tbl_LC_GROUPED_BETTYPE_242260 ;
DROP TABLE #tbl_Matrix_UAT_242260 ;

