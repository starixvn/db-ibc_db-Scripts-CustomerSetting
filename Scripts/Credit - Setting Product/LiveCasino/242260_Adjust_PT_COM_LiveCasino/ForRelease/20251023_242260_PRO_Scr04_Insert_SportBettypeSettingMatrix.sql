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

/********************************************    INSERT INTO TABLE    ********************************************/


/**UPDATE isDeleted FOR MERGE **/
IF EXISTS (SELECT TOP 1 1 FROM SportBettypeSettingMatrix A
            WHERE ProductID = 41 AND Site = 'All' AND isLicensee = 0 AND isDeleted = 0
            AND EXISTS (SELECT TOP 1 1 FROM #tbl_LC_GROUPED_BETTYPE_242260 B WHERE B.ProductID = A.RealProductId))
BEGIN

    UPDATE sbsm
    SET isDeleted = 1
        ,RepUpdateTime = dbo.f_GetDateTime2()
    FROM SportBettypeSettingMatrix sbsm WITH (NOLOCK)
    WHERE sbsm.ProductID = 41 AND sbsm.Site = 'All' AND sbsm.isLicensee = 0 AND sbsm.isDeleted = 0
    AND EXISTS (SELECT TOP 1 1 FROM #tbl_LC_GROUPED_BETTYPE_242260 B WHERE B.ProductID = sbsm.RealProductId);

END


MERGE [dbo].[SportBettypeSettingMatrix] [t]
USING (SELECT [BetType],[SportType],[isLicensee],[isLive],[Site],[isActive],[SportTypeRefPT],[BetTypeRefPT],[isLivePT],[TablePT],[SportTypeRefComm],[BetTypeRefComm],[TableComm],[SportTypeRefBetSetting],[BetTypeRefBetSetting],[TableBetSetting],[IsLiveComm],[IsLiveBetSetting],[TableBettrans],[SporttypeRefWinlossLimit],[BettypeRefWinlossLimit],[RealProductId],[isDeleted],[RepUpdateTime],[ProductID] 
        FROM SportBettypeSettingMatrix_UAT WHERE RealProductId IN (SELECT ProductID FROM #tbl_LC_GROUPED_BETTYPE_242260)) [tvp] 
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


DROP TABLE #tbl_LC_GROUPED_BETTYPE_242260;

