/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*      
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBGLOB-GlobCustDB

*/
USE [GlobCustDB];

CREATE TABLE #tbl_LC_GROUPED_BETTYPE_242260 
(
    ProductID TINYINT PRIMARY KEY
);

/*INSERT DATA FOR MBC SITE*/
INSERT INTO #tbl_LC_GROUPED_BETTYPE_242260 (ProductID)
SELECT 
    ProductID
FROM (VALUES (21),(39),(65),(52),(80),(70),(45)
) AS G2 (ProductID)
UNION ALL
SELECT 
    ProductID
FROM (VALUES (51),(57),(76),(90),(96),(98),(101),(107),(113)
) AS G3 (ProductID);



UPDATE sbsm
SET isDeleted = 1
    ,RepUpdateTime = dbo.f_GetDateTime2()
FROM SportBettypeSettingMatrix sbsm WITH (NOLOCK)
WHERE sbsm.ProductID = 41 AND sbsm.Site <> 'All' AND sbsm.isLicensee = 0 AND sbsm.isDeleted = 0
AND EXISTS (SELECT TOP 1 1 FROM #tbl_LC_GROUPED_BETTYPE_242260 B WHERE B.ProductID = sbsm.RealProductId);

UPDATE sbsm
SET isDeleted = 0
    ,RepUpdateTime = dbo.f_GetDateTime2()
FROM SportBettypeSettingMatrix sbsm WITH (NOLOCK)
WHERE sbsm.ProductID = 41 AND sbsm.Site = 'All' AND sbsm.isLicensee = 0 AND sbsm.isDeleted = 1
AND EXISTS (SELECT TOP 1 1 FROM #tbl_LC_GROUPED_BETTYPE_242260 B WHERE B.ProductID = sbsm.RealProductId);

DROP TABLE #tbl_LC_GROUPED_BETTYPE_242260 ;

/*
INSERT INTO SportBettypeSettingMatrix
(RealProductId,ProductID,SportType,BetType,isLicensee,isLive,Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,
    SportTypeRefComm,BetTypeRefComm,isLiveComm,TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans,RepUpdateTime)
SELECT TMP.RealProductId,TMP.ProductID,SportType,BetType,isLicensee,isLive,'All',isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,
    SportTypeRefComm,BetTypeRefComm,isLiveComm,TableComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,IsLiveBetSetting,TableBetSetting,
    SporttypeRefWinlossLimit,BettypeRefWinlossLimit,
    isDeleted,TableBettrans,dbo.f_GetDateTime2()
FROM dbo.SportBettypeSettingMatrix AS TMP WITH (NOLOCK)
    INNER JOIN #tbl_LC_GROUPED_BETTYPE_242260 AS SP ON TMP.RealProductId = SP.ProductID
    INNER JOIN (
        SELECT TOP (1) si.Site, si.SiteLabel
        FROM Site si WITH (NOLOCK)
        WHERE si.isActive = 1
            AND si.isLicensee = 0
            AND si.SiteLabel IN ('789y')
    ) SI ON SI.Site = TMP.Site /*Site = 'All'*/
WHERE
    TMP.isLicensee = 0;


/*Site <> 'All'*/
DELETE TMP
FROM dbo.SportBettypeSettingMatrix AS TMP WITH (ROWLOCK)
    INNER JOIN #tbl_LC_GROUPED_BETTYPE_242260 AS SP ON TMP.RealProductId = SP.ProductID
    --INNER JOIN #tbl_Site_242260 SI ON SI.Site = TMP.Site 
AND TMP.isLicensee = 0
    AND TMP.Site <> 'All'
;

*/

