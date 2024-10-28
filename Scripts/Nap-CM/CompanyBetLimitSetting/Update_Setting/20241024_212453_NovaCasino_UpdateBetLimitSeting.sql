/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241024
	Task: 3rd products - Adjust betlimit for RM currency and enable products for NovaCasino  [Redmine:#212453] 
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--UPDATE:
CREATE TABLE #tmp_Dep_ProductStakeLevelGroup
	(
		Sporttype		SMALLINT,
		GameGroupID		TINYINT, 
		LicenseeGroupID TINYINT, 
		MaxBet			MONEY, 
		SiteID			INT,
		PRIMARY KEY (Sporttype, GameGroupID, LicenseeGroupID, SiteID)
	)


INSERT INTO #tmp_Dep_ProductStakeLevelGroup (Sporttype, GameGroupID, LicenseeGroupID, SiteID, MaxBet)
	  SELECT 146,	1,	1,	0,	10000 -- FA CHAI
UNION SELECT 146,	2,	1,	0,	10000 -- FA CHAI
UNION SELECT 155,	1,	1,	0,	10000 -- MG-RNG
UNION SELECT 155,	2,	1,	0,	10000 -- MG-RNG
UNION SELECT 158,	1,	1,	0,	10000 -- Jili
UNION SELECT 158,	2,	1,	0,	10000 -- Jili
UNION SELECT 172,	1,	1,	0,	10000 -- Advantplay
UNION SELECT 230,	1,	1,	0,	10000 -- FastSpin
UNION SELECT 234,	1,	1,	0,	10000 -- Joker
UNION SELECT 247,	1,	1,	0,	10000 -- SG
UNION SELECT 248,	1,	1,	0,	10000 -- PP
UNION SELECT 248,	2,	1,	0,	10000 -- PP

UPDATE psl
SET psl.MaxBet=t.MaxBet
	, psl.RepUpdateTime=dbo.f_GetDateTime2()
FROM Dep_ProductStakeLevelGroup psl WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmp_Dep_ProductStakeLevelGroup t 
			ON t.Sporttype=psl.Sporttype
			AND t.GameGroupID=psl.GameGroupID
			AND t.LicenseeGroupID=psl.LicenseeGroupID
			AND t.SiteID=psl.SiteID
WHERE psl.isDeleted=0
GO
