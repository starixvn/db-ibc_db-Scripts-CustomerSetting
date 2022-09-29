/*<info serverAlias="DBCUST-CustDB, DBTP-bodb02, DBACC-bodb02"></info>*/

/*
	Created: 20220929@Tacy
	Task: Insert new games's reference setting into SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBCUST-CustDB, DBTP-bodb02, DBACC-bodb02
*/

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
								Site ASC)
		)

INSERT INTO #tmpRefSetting (SportType, BetType, isLicensee, isLive, Site)
SELECT SportType, BetType, isLicensee, isLive, Site
FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting WITH (NOLOCK)
WHERE Site<>'CN88' 
	AND (BetType IN (3741,3742,						--#178015
					 5805,5807,5808,5809,5810,5811	--#177448
					)
		OR BetType BETWEEN 6757 AND 6778			--#177397
		)

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
	INNER JOIN #tmpRefSetting tmp 
		ON tmp.SportType=rm.SportType
		AND tmp.BetType=rm.BetType
		AND tmp.isLicensee=rm.isLicensee
		AND tmp.isLive=rm.isLive
		AND tmp.Site=rm.Site
	INNER JOIN dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting ref WITH (NOLOCK)
		ON ref.SportType=rm.SportType
		AND ref.BetType=rm.BetType
		AND ref.isLicensee=rm.isLicensee
		AND ref.isLive=rm.isLive
		AND ref.Site=rm.Site