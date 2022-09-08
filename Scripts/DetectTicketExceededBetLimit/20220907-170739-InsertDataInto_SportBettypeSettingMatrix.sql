/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Created: 20220907@Tacy
	Task: Copy data from Sport_Bettype_Reference_Setting to SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBTP-bodb02
*/
DECLARE @Batch_size INT;

SET @Batch_size=5000;

CREATE TABLE #tmpRefSetting (
		SportType	smallint,
		BetType		int,
		isLicensee	bit,
		isLive		bit,
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
FROM Sport_Bettype_Reference_Setting WITH (NOLOCK)

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpRefSetting_Batch

	UPDATE TOP (@Batch_size) T
	SET IsFinshed=1
	OUTPUT inserted.SportType, inserted.BetType, inserted.isLicensee, inserted.isLive, inserted.Site 
		INTO #tmpRefSetting_Batch(SportType, BetType, isLicensee, isLive, Site)
	FROM #tmpRefSetting T WITH(NOLOCK)
	WHERE IsFinshed=0

	IF @@ROWCOUNT=0
		BREAK;

	INSERT INTO SportBettypeSettingMatrix (SportType, BetType, isLicensee, isLive, Site)
	SELECT SportType, BetType, isLicensee, isLive, Site
	FROM #tmpRefSetting_Batch

	UPDATE rm
	SET 
		rm.isActive=ref.isActive,
		rm.SportTypeRefPT=ref.SportTypeRefPT,
		rm.BetTypeRefPT=ref.BetTypeRefPT,
		rm.isLivePT=ref.isLivePT,
		rm.TablePT=ref.TablePT,
		rm.StructureVerPT=ref.StructureVerPT,
		rm.SportTypeRefComm=ref.SportTypeRefComm,
		rm.BetTypeRefComm=ref.BetTypeRefComm,
		rm.TableComm=ref.TableComm,
		rm.StructureVerComm=ref.StructureVerComm,
		rm.SportTypeRefBetSetting=ref.SportTypeRefBetSetting,
		rm.BetTypeRefBetSetting=ref.BetTypeRefBetSetting,
		rm.TableBetSetting=ref.TableBetSetting,
		rm.StructureVerBetSetting=ref.StructureVerBetSetting,
		rm.IsLiveComm=ref.IsLiveComm,
		rm.IsLiveBetSetting=ref.IsLiveBetSetting
	FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #tmpRefSetting_Batch tmp 
			ON tmp.SportType=rm.SportType
			AND tmp.BetType=rm.BetType
			AND tmp.isLicensee=rm.isLicensee
			AND tmp.isLive=rm.isLive
			AND tmp.Site=rm.Site
		INNER JOIN Sport_Bettype_Reference_Setting ref WITH (NOLOCK)
			ON ref.SportType=rm.SportType
			AND ref.BetType=rm.BetType
			AND ref.isLicensee=rm.isLicensee
			AND ref.isLive=rm.isLive
			AND ref.Site=rm.Site

	WAITFOR DELAY '00:00:0.002'
END