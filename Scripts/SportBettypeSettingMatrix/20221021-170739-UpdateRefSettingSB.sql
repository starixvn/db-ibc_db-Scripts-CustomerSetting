/*<info serverAlias="DBCUST-CustDB, DBTP-bodb02, DBACC-bodb02"></info>*/

/*
	Created: 20221021@Tacy
	Task: Update SB's reference setting & Insert Saba soccer, basketball's reference setting [RedmineID: #170739]
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
								isLive ASC,
								Site ASC)
		)

INSERT INTO #tmpRefSetting (SportType, BetType, isLicensee, isLive, Site)
SELECT DISTINCT ref.SportType, ref.BetType, ref.isLicensee, ref.isLive, ref.site AS site
FROM SportBettypeSettingMatrix ref WITH (NOLOCK)
INNER JOIN dbtxn.bodb02.dbo.SportBettypeMatrix sbm WITH (NOLOCK)
	ON sbm.SportType=ref.SportType
	AND sbm.BetType=ref.BetType
	AND sbm.isLive=ref.isLive
WHERE sbm.ProductID IN (1,63,69) AND ref.Site='All'
AND NOT (ref.SportType=50 AND isLicensee=1)
AND NOT (ref.SportType IN (169,175) AND isLicensee=0)	--Bitcoin, Sports Lottery

-- DEPOSIT: Update SB's RefSetting:
UPDATE rm
SET 
	rm.SportTypeRefPT=CASE WHEN rm.SportType IN (169,175) THEN 2 ELSE 1 END,
	rm.BetTypeRefPT=CASE WHEN rm.SportType IN (169,175) THEN 2 ELSE 1 END,
	rm.TablePT='Dep_CustPTGroupSetting_Member',
	rm.SportTypeRefComm=CASE WHEN rm.SportType IN (169,175) THEN 2 ELSE 1 END,
	rm.BetTypeRefComm=CASE	WHEN rm.BetTypeRefComm IN (1,3,7,8) OR (rm.SportTypeRefComm<>2 AND rm.BetTypeRefComm=2)THEN 1
							WHEN rm.BetTypeRefComm IN (4,6,10,20,21,22) THEN 4
							ELSE rm.BetTypeRefComm END,
	rm.TableComm='Dep_CustDiscountGroupSetting_Member',
	rm.SportTypeRefBetSetting=CASE WHEN rm.SportType IN (1,2,3,5,8,10,11,43,99,169,175) THEN rm.SportType ELSE 99 END,
	rm.BetTypeRefBetSetting=CASE WHEN rm.SportType IN (169,175) THEN rm.BetTypeRefBetSetting
								 WHEN rm.BetType IN (9,29,38) THEN 9 ELSE 1 END,
	rm.TableBetSetting=CASE WHEN rm.SportType IN (169,175) THEN 'Dep_CustBetSetting_Member' ELSE 'Dep_CustBetSettingGameGroup_Member' END
FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpRefSetting tmp 
		ON tmp.SportType=rm.SportType
		AND tmp.BetType=rm.BetType
		AND tmp.isLicensee=rm.isLicensee
		AND tmp.isLive=rm.isLive
		AND tmp.Site=rm.Site
WHERE rm.isLicensee=1

-- CREDIT: Update SB's RefSetting:
UPDATE rm
SET 
	rm.SportTypeRefBetSetting=CASE WHEN rm.SportType IN (1,2,3,5,8,10,11,43,99) THEN rm.SportType ELSE 99 END,
	rm.BetTypeRefBetSetting=CASE WHEN rm.BetType IN (9,29,38) THEN 9 ELSE 1 END
FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpRefSetting tmp 
		ON tmp.SportType=rm.SportType
		AND tmp.BetType=rm.BetType
		AND tmp.isLicensee=rm.isLicensee
		AND tmp.isLive=rm.isLive
		AND tmp.Site=rm.Site
WHERE rm.isLicensee=0

-- SABA sports: Soccer, Basketball
INSERT INTO SportBettypeSettingMatrix 
	(SportType, BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, SportTypeRefBetSetting, BetTypeRefBetSetting, TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting) 
SELECT	CASE WHEN SportType=1 THEN 9901 ELSE 9902 END AS SportType, 
		BetType, isLicensee, isLive, Site, isActive, SportTypeRefPT, BetTypeRefPT, isLivePT, TablePT, StructureVerPT, SportTypeRefComm, BetTypeRefComm, TableComm, StructureVerComm, 
		CASE WHEN SportType=1 AND BetType NOT IN (9,29,38) THEN 9901 
			 WHEN SportType=2 AND BetType NOT IN (9,29,38) THEN 9902  
			 ELSE SportType 
		END AS SportTypeRefBetSetting, 
		BetTypeRefBetSetting, 
		TableBetSetting, StructureVerBetSetting, IsLiveComm, IsLiveBetSetting
FROM SportBettypeSettingMatrix ref WITH (NOLOCK)
WHERE ref.SportType IN (1,2)

-- UPDATE NULL DATA
UPDATE ref
SET SportTypeRefPT=CASE WHEN ISNULL(SportTypeRefPT,0)=0 THEN NULL ELSE SportTypeRefPT END,
	BetTypeRefPT=CASE WHEN ISNULL(BetTypeRefPT,0)=0 THEN NULL ELSE BetTypeRefPT END,
	TablePT=CASE WHEN ISNULL(TablePT,'')='' THEN NULL ELSE TablePT END,
	StructureVerPT=CASE WHEN ISNULL(TablePT,'')='' THEN NULL ELSE StructureVerPT END,

	SportTypeRefComm=CASE WHEN ISNULL(SportTypeRefComm,0)=0 THEN NULL ELSE SportTypeRefComm END,
	BetTypeRefComm=CASE WHEN ISNULL(BetTypeRefComm,0)=0 THEN NULL ELSE BetTypeRefComm END,
	TableComm=CASE WHEN ISNULL(TableComm,'')='' THEN NULL ELSE TableComm END,
	StructureVerComm=CASE WHEN ISNULL(TableComm,'')='' THEN NULL ELSE StructureVerComm END,

	SportTypeRefBetSetting=CASE WHEN ISNULL(SportTypeRefBetSetting,0)=0 THEN NULL ELSE SportTypeRefBetSetting END,
	BetTypeRefBetSetting=CASE WHEN ISNULL(BetTypeRefBetSetting,0)=0 THEN NULL ELSE BetTypeRefBetSetting END,
	TableBetSetting=CASE WHEN ISNULL(TableBetSetting,'')='' THEN NULL ELSE TableBetSetting END,
	StructureVerBetSetting=CASE WHEN ISNULL(TableBetSetting,'')='' THEN NULL ELSE StructureVerBetSetting END

FROM SportBettypeSettingMatrix ref WITH (ROWLOCK,UPDLOCK)
WHERE NOT (ref.SportType=50 AND isLicensee=1)
AND (ISNULL(SportTypeRefPT,0)=0 OR
	 ISNULL(BetTypeRefPT,0)=0 OR
	 ISNULL(SportTypeRefComm,0)=0 OR
	 ISNULL(BetTypeRefComm,0)=0 OR
	 ISNULL(SportTypeRefBetSetting,0)=0 OR
	 ISNULL(BetTypeRefBetSetting,0)=0 OR
	 --TABLE
	 ISNULL(TablePT,'')='' OR
	 ISNULL(TableComm,'')='' OR
	 ISNULL(TableBetSetting,'')='')