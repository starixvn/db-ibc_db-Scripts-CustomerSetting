/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221214@Tacy
	Task: Inital data for RealProductId column
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCUST/CustDB
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
SELECT SportType, BetType, isLicensee, isLive, Site
FROM SportBettypeSettingMatrix WITH (NOLOCK)

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpRefSetting_Batch

	UPDATE TOP (3000) T
	SET IsFinshed=1
	OUTPUT inserted.SportType, inserted.BetType, inserted.isLicensee, inserted.isLive, inserted.Site 
		INTO #tmpRefSetting_Batch(SportType, BetType, isLicensee, isLive, Site)
	FROM #tmpRefSetting T WITH(NOLOCK)
	WHERE IsFinshed=0

	IF @@ROWCOUNT=0
		BREAK;

	UPDATE ref
	SET RealProductId = CASE WHEN ref.SportType IN (9901, 9902)			 THEN 1
							 WHEN ref.SportType=231 AND ref.isLicensee=0 THEN 5
							 WHEN ref.SportType=231 AND ref.isLicensee=1 THEN 49
																	 ELSE sm.ProductID
						END
	FROM SportBettypeSettingMatrix ref WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #tmpRefSetting_Batch tmp 
			ON tmp.SportType=ref.SportType
			AND tmp.BetType=ref.BetType
			AND tmp.isLicensee=ref.isLicensee
			AND tmp.isLive=ref.isLive
			AND tmp.Site=ref.Site
		LEFT JOIN DBACC.bodb02.dbo.SportBettypeMatrix sm WITH (NOLOCK) 
			ON ref.SportType=sm.SportType
	WHERE sm.ProductID NOT IN (25)

	WAITFOR DELAY '00:00:0.002'
END
