/*<info serverAlias="DBTXN-bodb02"></info>*/
/*      
	Created: 20251023@Dave  
	Task: Live Casino - Adjust-pt-comm-for-live-casino [RedmineID: #242260]
	DB: DBTXN/bodb02

*/
USE [bodb02];

CREATE TABLE #tbl_Reference_Setting_242260(
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
	[StructureVerPT] [varchar](10) NULL,
	[SportTypeRefComm] [smallint] NULL,
	[BetTypeRefComm] [int] NULL,
	[TableComm] [varchar](50) NULL,
	[StructureVerComm] [varchar](10) NULL,
	[SportTypeRefBetSetting] [smallint] NULL,
	[BetTypeRefBetSetting] [int] NULL,
	[TableBetSetting] [varchar](50) NULL,
	[StructureVerBetSetting] [varchar](10) NULL,
	[IsLiveComm] [bit] NOT NULL,
	[IsLiveBetSetting] [bit] NOT NULL,
    SiteLabel	varchar(50),
    CONSTRAINT [PK_Reference_Setting_242260] PRIMARY KEY CLUSTERED 
    (
        [BetType] ASC,
        [SportType] ASC,
        [isLicensee] ASC,
        [isLive] ASC,
        [Site] ASC
    )
);

CREATE TABLE #tbl_Site_242260(
    siteid	int,
    site	nvarchar(50),
    SiteLabel	varchar(50)
);

CREATE TABLE #tbl_SportType_242260(
    SportType smallint
);


/*********************************   INITIAL DATA   **************************************/

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
;

INSERT INTO #tbl_Reference_Setting_242260(
    SportType,BetType,isLicensee,isLive,
    Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,StructureVerPT,
    SportTypeRefComm,BetTypeRefComm,TableComm,StructureVerComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,TableBetSetting,StructureVerBetSetting,
    IsLiveComm,IsLiveBetSetting,SiteLabel)
SELECT 
    TMP.SportType,BetType,isLicensee,isLive,
    SI.Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,StructureVerPT,
    SportTypeRefComm,BetTypeRefComm,TableComm,StructureVerComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,TableBetSetting,StructureVerBetSetting,
    IsLiveComm,IsLiveBetSetting,SiteLabel
FROM dbo.Sport_Bettype_Reference_Setting AS TMP WITH (NOLOCK)
    INNER JOIN #tbl_SportType_242260 AS SP ON TMP.SportType = SP.SportType
    CROSS JOIN #tbl_Site_242260 AS SI
WHERE
    TMP.isLicensee = 0
    AND TMP.Site = 'All'
;

--IF re-run script
IF NOT EXISTS (SELECT TOP 1 1 FROM #tbl_Reference_Setting_242260)
BEGIN

    INSERT INTO #tbl_Reference_Setting_242260(
        SportType,BetType,isLicensee,isLive,
        Site,isActive,
        SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,StructureVerPT,
        SportTypeRefComm,BetTypeRefComm,TableComm,StructureVerComm,
        SportTypeRefBetSetting,BetTypeRefBetSetting,TableBetSetting,StructureVerBetSetting,
        IsLiveComm,IsLiveBetSetting,SiteLabel)
    SELECT 
        TMP.SportType,BetType,isLicensee,isLive,
        SI2.Site,isActive,
        SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,StructureVerPT,
        SportTypeRefComm,BetTypeRefComm,TableComm,StructureVerComm,
        SportTypeRefBetSetting,BetTypeRefBetSetting,TableBetSetting,StructureVerBetSetting,
        IsLiveComm,IsLiveBetSetting,SiteLabel
    FROM dbo.Sport_Bettype_Reference_Setting AS TMP WITH (NOLOCK)
        INNER JOIN #tbl_SportType_242260 AS SP ON TMP.SportType = SP.SportType
        INNER JOIN (SELECT TOP 1 Site FROM #tbl_Site_242260) SI ON SI.Site = TMP.Site /*Site = 'All'*/
        CROSS JOIN #tbl_Site_242260 AS SI2
    WHERE
        TMP.isLicensee = 0
    ;

END

/********************************************    UPDATE COMM, PT     ********************************************/

-----------------MBC PT 85%
/*
211--Allbet
244--SA Gaming
176--FGG
170--PP Live Casino
225--ION
228--WE Live Casino
243--AE Sexy
*/

UPDATE TMP 
SET SportTypeRefPT = 9916,
    BetTypeRefPT = 2400
FROM #tbl_Reference_Setting_242260 AS TMP
WHERE TMP.SiteLabel = 'MBC'
    AND TMP.Site <> 'INDO'
    AND TMP.SportType IN (211, 244, 176, 170, 225, 228, 243)
;

-----------------MBC PT 90%
/*
138--ON Casino
129--Playtech Live
124--Microgaming Live
233--WM
239--BG
159--YeeBet
136--W Casino
144--GPI Live Casino
*/

UPDATE TMP 
SET SportTypeRefPT = 9917,
    BetTypeRefPT = 2400
FROM #tbl_Reference_Setting_242260 AS TMP
WHERE TMP.SiteLabel = 'MBC'
    AND TMP.Site <> 'INDO'
    AND TMP.SportType IN (138, 129, 124, 233, 239, 159, 136, 144)
;


-----------------MBC COMM 0.5
/*
not change dummy SportType
211--Allbet
244--SA Gaming
176--FGG
170--PP Live Casino
225--ION
228--WE Live Casino
243--AE Sexy
*/

UPDATE TMP 
SET SportTypeRefComm = 9911,
    BetTypeRefComm = 2400
FROM #tbl_Reference_Setting_242260 AS TMP
WHERE TMP.SiteLabel = 'MBC'
    AND TMP.Site <> 'INDO'
    AND TMP.SportType IN (211, 244, 176, 170, 225, 228, 243)
;

-----------------MBC COMM 0
/*
138--ON Casino
129--Playtech Live
124--Microgaming Live
233--WM
239--BG
159--YeeBet
136--W Casino
144--GPI Live Casino
*/

UPDATE TMP 
SET SportTypeRefComm = NULL,
    BetTypeRefComm = NULL,
    TableComm = NULL
FROM #tbl_Reference_Setting_242260 AS TMP
WHERE TMP.SiteLabel = 'MBC'
    AND TMP.Site <> 'INDO'
    AND TMP.SportType IN (138, 129, 124, 233, 239, 159, 136, 144)
;


-----------------INDO site No changes on PT, applies remove comm
/*All product*/

UPDATE TMP 
SET 
    SportTypeRefPT = 9911,
    BetTypeRefPT = 2400,
    SportTypeRefComm = NULL,
    BetTypeRefComm = NULL,
    TableComm = NULL
FROM #tbl_Reference_Setting_242260 AS TMP
WHERE TMP.Site = 'INDO';



/********************************************    INSERT INTO TABLE    ********************************************/



IF EXISTS (
    SELECT TOP 1 1
    FROM dbo.Sport_Bettype_Reference_Setting AS TMP WITH (NOLOCK)
        INNER JOIN #tbl_SportType_242260 AS SP ON TMP.SportType = SP.SportType
    WHERE
        TMP.isLicensee = 0
        AND TMP.Site = 'All'
)
BEGIN

    DELETE TMP
    FROM dbo.Sport_Bettype_Reference_Setting AS TMP WITH (ROWLOCK)
        INNER JOIN #tbl_SportType_242260 AS SP ON TMP.SportType = SP.SportType
    WHERE
        TMP.isLicensee = 0
        AND TMP.Site = 'All'

END


DELETE TMP
FROM dbo.Sport_Bettype_Reference_Setting AS TMP WITH (ROWLOCK)
    INNER JOIN #tbl_Reference_Setting_242260 AS RS
        ON TMP.BetType = RS.BetType
        AND TMP.SportType = RS.SportType
        AND TMP.isLicensee = RS.isLicensee
        AND TMP.isLive = RS.isLive
        AND TMP.Site = RS.Site
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
    Site,isActive,
    SportTypeRefPT,BetTypeRefPT,isLivePT,TablePT,StructureVerPT,
    SportTypeRefComm,BetTypeRefComm,TableComm,StructureVerComm,
    SportTypeRefBetSetting,BetTypeRefBetSetting,TableBetSetting,StructureVerBetSetting,
    IsLiveComm,IsLiveBetSetting
FROM #tbl_Reference_Setting_242260 AS TMP WITH (NOLOCK)
;




DROP TABLE #tbl_Reference_Setting_242260;
DROP TABLE #tbl_Site_242260;
DROP TABLE #tbl_SportType_242260;

