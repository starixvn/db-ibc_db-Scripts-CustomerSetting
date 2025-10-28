/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*      
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBGLOB-GlobCustDB
*/
USE [GlobCustDB];

INSERT INTO dbo.SportBettypeSettingMatrix_UAT_Del_InHouse(BetType, SportType, isLicensee, isLive, Site, RepUpdateTime)
SELECT BetType, SportType, isLicensee, isLive, Site, dbo.f_GetDateTime2() AS RepUpdateTime
FROM dbo.SportBettypeSettingMatrix_UAT WITH (NOLOCK);


DELETE dbo.SportBettypeSettingMatrix_UAT;

WITH TMP_LC_GROUPED_BETTYPE AS
(
    SELECT 
        ProductID,
        9916 AS SportTypeRefPT,/*85*/
        2400 AS BetTypeRefPT,
        9916 AS SportTypeRefComm,/*0.8*/
        2400 AS BetTypeRefComm
    FROM (VALUES (21),(39)
    ) AS G2 (ProductID)

    UNION ALL

    SELECT 
        ProductID,
        9916 AS SportTypeRefPT,/*85*/
        2400 AS BetTypeRefPT,
        9917 AS SportTypeRefComm,/*0.5*/
        2400 AS BetTypeRefComm
    FROM (VALUES (65),(52),(80),(70)
    ) AS G2 (ProductID)

    UNION ALL

    SELECT 
        ProductID,
        9917 AS SportTypeRefPT,/*90*/
        2400 AS BetTypeRefPT,
        NULL AS SportTypeRefComm,
        NULL AS BetTypeRefComm
    FROM (VALUES (45),(51),(57),(76),(90),(96),(98),(101),(107)
    ) AS G3 (ProductID)
)
INSERT INTO dbo.SportBettypeSettingMatrix_UAT
(       RealProductId
		, ProductID
		, SportType
		, BetType
		, isLicensee
		, isLive
		, Site
		, isActive
		, SportTypeRefPT
		, BetTypeRefPT
        , isLivePT
        , TablePT
		, SportTypeRefComm
		, BetTypeRefComm
        , isLiveComm
        , TableComm
		, SportTypeRefBetSetting
		, BetTypeRefBetSetting
        , IsLiveBetSetting
        , TableBetSetting
		, SporttypeRefWinlossLimit
		, BettypeRefWinlossLimit
		, isDeleted
        , TableBettrans)
    SELECT
		  sbsm.RealProductId
		, sbsm.ProductID
		, sbsm.SportType
		, sbsm.BetType
		, sbsm.isLicensee
		, sbsm.isLive
		, ISNULL(s.Site, sbsm.Site) AS Site
		, sbsm.isActive
		, ISNULL(p.SportTypeRefPT, sbsm.SportTypeRefPT) AS SportTypeRefPT
		, ISNULL(p.BetTypeRefPT, sbsm.BetTypeRefPT) AS BetTypeRefPT
        , sbsm.isLivePT
        , sbsm.TablePT
		, ISNULL(p.SportTypeRefComm, sbsm.SportTypeRefComm) AS SportTypeRefComm
		, ISNULL(p.BetTypeRefComm, sbsm.BetTypeRefComm) AS BetTypeRefComm
        , sbsm.isLiveComm
        , sbsm.TableComm
		, sbsm.SportTypeRefBetSetting
		, sbsm.BetTypeRefBetSetting
        , sbsm.IsLiveBetSetting
        , sbsm.TableBetSetting
		, sbsm.SporttypeRefWinlossLimit
		, sbsm.BettypeRefWinlossLimit
		, sbsm.isDeleted
        , sbsm.TableBettrans
	FROM SportBettypeSettingMatrix sbsm WITH (NOLOCK)
        LEFT JOIN TMP_LC_GROUPED_BETTYPE p ON sbsm.RealProductId = p.ProductID AND sbsm.isLicensee = 0 
        OUTER APPLY (
            SELECT si.Site, si.SiteLabel
            FROM Site si WITH (NOLOCK)
            WHERE si.isActive = 1
                AND si.isLicensee = 0
                AND p.ProductID IS NOT NULL /*Live Casino - Crdedit*/
                AND si.SiteLabel IN ('MBC','IBC','789y')
            ) AS s
	WHERE sbsm.isDeleted = 0 
    AND sbsm.Site = 'All'