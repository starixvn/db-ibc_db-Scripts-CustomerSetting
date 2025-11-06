/*<info serverAlias="DBTXN-bodb02"></info>*/
/*      
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBTXN/bodb02

*/
USE [bodb02];


CREATE TABLE #tbl_Site_242260(
    siteid	int,
    site	varchar(50),
    SiteLabel	varchar(50)
);

CREATE TABLE #tbl_SportType_242260(
    SportType smallint
);


--GET Site
INSERT INTO #tbl_Site_242260(siteid, site, SiteLabel)
SELECT si.siteid, si.Site, si.SiteLabel
FROM CustDB.dbo.Site si WITH (NOLOCK)
WHERE si.isActive = 1
    AND si.isLicensee = 0
    AND si.SiteLabel IN ('MBC','IBC','789y')
;


INSERT INTO #tbl_SportType_242260(SportType)
    SELECT 211--Allbet
UNION ALL SELECT 244--SA Gaming
UNION ALL SELECT 176--FGG

UNION ALL SELECT 170--PP Live Casino
UNION ALL SELECT 225--ION
UNION ALL SELECT 228--WE Live Casino

UNION ALL SELECT 243--AE Sexy
UNION ALL SELECT 138--ON Casino
UNION ALL SELECT 129--Playtech Live
UNION ALL SELECT 124--Microgaming Live
UNION ALL SELECT 233--WM
UNION ALL SELECT 239--BG
UNION ALL SELECT 159--YeeBet
UNION ALL SELECT 136--W Casino
UNION ALL SELECT 144--GPI Live Casino
UNION ALL SELECT 119--OFA Live
;


INSERT INTO dbo.Sport_Bettype_Reference_Setting(
    SportType,BetType,isLicensee,isLive,
    Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,StructureVerPT,
    SportTypeRefComm,BetTypeRefComm,TableComm,StructureVerComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,TableBetSetting,StructureVerBetSetting,
    IsLiveComm,IsLiveBetSetting)
SELECT 
    TMP.SportType,BetType,isLicensee,isLive,
    'All' AS Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,StructureVerPT,
    SportTypeRefComm,BetTypeRefComm,TableComm,StructureVerComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,TableBetSetting,StructureVerBetSetting,
    IsLiveComm,IsLiveBetSetting
FROM dbo.Sport_Bettype_Reference_Setting AS TMP WITH (NOLOCK)
    INNER JOIN #tbl_SportType_242260 AS SP ON TMP.SportType = SP.SportType
    INNER JOIN (SELECT TOP 1 Site FROM #tbl_Site_242260 WHERE SiteLabel = '789y') SI ON SI.Site = TMP.Site /*Site = 'All'*/
WHERE
    TMP.isLicensee = 0
;


/*Site <> 'All'*/
DELETE TMP
FROM dbo.Sport_Bettype_Reference_Setting AS TMP WITH (ROWLOCK)
    INNER JOIN #tbl_SportType_242260 AS SP ON TMP.SportType = SP.SportType
    --INNER JOIN #tbl_Site_242260 SI ON SI.Site = TMP.Site 
AND TMP.isLicensee = 0
    AND TMP.Site <> 'All'
;



DROP TABLE #tbl_Site_242260;
DROP TABLE #tbl_SportType_242260;

