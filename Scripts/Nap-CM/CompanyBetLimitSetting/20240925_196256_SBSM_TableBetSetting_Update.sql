/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20240925@Tacy
	Task: Update RNG's TableBetSetting [RedmineID: #196256]
	Database: DBCUST-CustDB
*/
USE CustDB
GO

CREATE TABLE #tmpRefSetting (
		SportType	smallint,
		BetType		int,
		isLicensee	bit,
		isLive		bit default 0,
		Site		varchar(50),
		IsFinshed	bit default 0,
		PRIMARY KEY CLUSTERED ( BetType ASC,
								SportType ASC,
								isLicensee ASC,
								isLive ASC,
								Site ASC)
		)

CREATE TABLE #tmpRefSetting_Batch (
		SportType	smallint,
		BetType		int,
		isLicensee	bit,
		isLive		bit,
		Site		varchar(50),
		PRIMARY KEY CLUSTERED ( BetType ASC,
								SportType ASC,
								isLicensee ASC,
								isLive ASC,
								Site ASC)
)

INSERT INTO #tmpRefSetting (SportType, BetType, isLicensee, isLive, Site)
SELECT DISTINCT ref.SportType, ref.BetType, ref.isLicensee, ref.isLive, ref.site AS site
FROM SportBettypeSettingMatrix ref WITH (NOLOCK)
INNER JOIN ProductStakeLevelGroup psl WITH (NOLOCK)
		ON psl.Sporttype=ref.SportType
WHERE ref.isDeleted=0 
AND ref.isActive=1
AND ref.isLicensee=0
UNION ALL
SELECT DISTINCT ref.SportType, ref.BetType, ref.isLicensee, ref.isLive, ref.site AS site
FROM SportBettypeSettingMatrix ref WITH (NOLOCK)
INNER JOIN Dep_ProductStakeLevelGroup psl WITH (NOLOCK)
		ON psl.Sporttype=ref.SportType AND psl.SiteID=0
WHERE ref.isDeleted=0 
AND ref.isActive=1
AND ref.isLicensee=1

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpRefSetting_Batch

	UPDATE TOP (1000) T
	SET IsFinshed=1
	OUTPUT inserted.SportType, inserted.BetType, inserted.isLicensee, inserted.isLive, inserted.Site 
		INTO #tmpRefSetting_Batch(SportType, BetType, isLicensee, isLive, Site)
	FROM #tmpRefSetting T WITH(NOLOCK)
	WHERE IsFinshed=0

	IF @@ROWCOUNT=0
		BREAK;
	
	UPDATE ref
	SET ref.TableBetSetting = CASE WHEN ref.isLicensee=0 THEN 'ProductStakeLevelGroup'
									WHEN ref.isLicensee=1 THEN 'Dep_ProductStakeLevelGroup'
									ELSE ref.TableBetSetting
							END
		,ref.RepUpdateTime=dbo.f_GetDateTime2()
	FROM SportBettypeSettingMatrix ref WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #tmpRefSetting_Batch tmp 
			ON tmp.SportType=ref.SportType
			AND tmp.BetType=ref.BetType
			AND tmp.isLicensee=ref.isLicensee
			AND tmp.isLive=ref.isLive
			AND tmp.Site=ref.Site

	WAITFOR DELAY '00:00:0.280'
END
