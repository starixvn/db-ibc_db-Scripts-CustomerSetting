/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220928@Tacy
	Task: Move data from Sport_Bettype_Reference to SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBCUST-CustDB
*/
DECLARE @Batch_size INT;

SET @Batch_size=5000;

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

--CREDIT:
INSERT INTO #tmpRefSetting (SportType, BetType, isLicensee, Site)
SELECT DISTINCT a.SportType, a.BetType, a.isLicensee, Site
FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference a WITH (NOLOCK)
WHERE NOT EXISTS (SELECT 1 FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting b WITH (NOLOCK)
				  WHERE a.SportType=b.SportType
					AND a.BetType=b.BetType
					AND a.isLicensee=b.isLicensee
					AND a.Site=b.Site
				)
	AND a.isLicensee=0

--DEPOSIT:
INSERT INTO #tmpRefSetting (SportType, BetType, isLicensee, Site)
SELECT DISTINCT a.SportType, a.BetType, a.isLicensee, Site
FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference a WITH (NOLOCK)
	INNER JOIN Dep_ProductSettingDetail psd WITH (NOLOCK) ON psd.SportType=a.SporttypeRef AND psd.BetType=a.BettypeRef
WHERE NOT EXISTS (SELECT 1 FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference_Setting b WITH (NOLOCK)
				  WHERE a.SportType=b.SportType
					AND a.BetType=b.BetType
					AND a.isLicensee=b.isLicensee
					AND a.Site=b.Site
				)
	AND a.isLicensee=1

--Insert into SportBettypeSettingMatrix:
INSERT INTO SportBettypeSettingMatrix (SportType, BetType, isLicensee, isLive, Site)
SELECT SportType, BetType, isLicensee, isLive, Site
FROM #tmpRefSetting_Batch

UPDATE rm
SET 
	rm.isActive=1,
	rm.SportTypeRefPT=ref.SporttypeRef,
	rm.BetTypeRefPT=ref.BettypeRef,
	rm.TablePT='Dep_CustPTGroupSetting_Member',
	rm.SportTypeRefComm=ref.SporttypeRef,
	rm.BetTypeRefComm=ref.BettypeRef,
	rm.TableComm='Dep_CustDiscountGroupSetting_Member',
	rm.SportTypeRefBetSetting=ref.SporttypeRef,
	rm.BetTypeRefBetSetting=ref.BettypeRef,
	rm.TableBetSetting=CASE WHEN ref.SporttypeRef=202 THEN 'Dep_CustBetSetting_Member' ELSE 'Dep_CustBetSettingGameGroup_Member' END
FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpRefSetting_Batch tmp 
		ON tmp.SportType=rm.SportType
		AND tmp.BetType=rm.BetType
		AND tmp.isLicensee=rm.isLicensee
		AND tmp.Site=rm.Site
	INNER JOIN dbtxn.bodb02.dbo.Sport_Bettype_Reference ref WITH (NOLOCK)
		ON ref.SportType=rm.SportType
		AND ref.BetType=rm.BetType
		AND ref.isLicensee=rm.isLicensee
		AND ref.Site=rm.Site
WHERE rm.isLicensee=1
		
UPDATE rm
SET 
	rm.isActive=1,
	rm.SportTypeRefPT=ref.SporttypeRef,
	rm.BetTypeRefPT=ref.BettypeRef,
	rm.TablePT=CASE WHEN ref.SporttypeRef IN (1,2,3,5,8,10,11,99)	THEN 'CustSetting'
					WHEN ref.SporttypeRef IN (161,164)				THEN 'CustSetting3rd'
					WHEN ref.SporttypeRef IN (202,255)				THEN 'CustSettingGame'
																	ELSE 'CustPTsetting3rd_Member' END,
	rm.SportTypeRefComm=ref.SporttypeRef,
	rm.BetTypeRefComm=ref.BettypeRef,
	rm.TableComm=CASE WHEN ref.SporttypeRef IN (1,2,3,5,8,10,11,99)	THEN 'CustSetting'
					WHEN ref.SporttypeRef IN (202,255)				THEN 'CustSettingGame'
																	ELSE 'CustDiscount3rd_Member' END,
	rm.SportTypeRefBetSetting=ref.SporttypeRef,
	rm.BetTypeRefBetSetting=ref.BettypeRef,
	rm.TableBetSetting=CASE WHEN ref.SporttypeRef=202										THEN 'CustGameType' 
							WHEN ref.SporttypeRef IN (1,2,3,5,8,10,11,99,161,164,9901,9902) THEN 'CustBetSetting_Member' 
																							ELSE 'CustBetSetting3rd_Member' END
FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpRefSetting_Batch tmp 
		ON tmp.SportType=rm.SportType
		AND tmp.BetType=rm.BetType
		AND tmp.isLicensee=rm.isLicensee
		AND tmp.Site=rm.Site
	INNER JOIN dbtxn.bodb02.dbo.Sport_Bettype_Reference ref WITH (NOLOCK)
		ON ref.SportType=rm.SportType
		AND ref.BetType=rm.BetType
		AND ref.isLicensee=rm.isLicensee
		AND ref.Site=rm.Site
WHERE rm.isLicensee=0

--Update TableRef: isLicensee=1
UPDATE rm
SET rm.TablePT='Dep_CustPTGroupSetting_Member',
	rm.TableComm='Dep_CustDiscountGroupSetting_Member',
	rm.TableBetSetting=CASE WHEN rm.SportTypeRefBetSetting IN (1,2,3,5,8,10,11,43,99,161,9901,9902) THEN 'Dep_CustBetSettingGameGroup_Member' ELSE 'Dep_CustBetSetting_Member' END
FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
WHERE isLicensee=1

--Update TableRef: isLicensee=0
UPDATE rm
SET rm.TablePT=CASE WHEN rm.TablePT='CustPTsetting3rd' THEN 'CustPTsetting3rd_Member' ELSE rm.TablePT END,
	rm.TableComm=CASE WHEN rm.TableComm='CustDiscount3rd' THEN 'CustDiscount3rd_Member' ELSE rm.TableComm END,
	rm.TableBetSetting=CASE WHEN rm.TableBetSetting='CustBetSetting3rd' THEN 'CustBetSetting3rd_Member' 
							WHEN rm.TableBetSetting='CustSetting'		THEN 'CustBetSetting_Member'
																		ELSE rm.TableBetSetting END
FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
WHERE isLicensee=0

INSERT INTO SportBettypeSettingMatrix ([SportType], [BetType], [isLicensee], [isLive], [Site], [isActive], [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT], [StructureVerPT], [SportTypeRefComm], [BetTypeRefComm], [TableComm], [StructureVerComm], [SportTypeRefBetSetting], [BetTypeRefBetSetting], [TableBetSetting], [StructureVerBetSetting], [IsLiveComm], [IsLiveBetSetting])
		  SELECT 5, 5, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,5,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,5,'Dep_CustBetSettingGameGroup_Member',NULL,0,0
UNION ALL SELECT 5, 15, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,5,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,5,'Dep_CustBetSettingGameGroup_Member',NULL,0,0
UNION ALL SELECT 6, 5, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,5,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,99,'Dep_CustBetSettingGameGroup_Member',NULL,0,0
UNION ALL SELECT 6, 15, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,5,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,99,'Dep_CustBetSettingGameGroup_Member',NULL,0,0
UNION ALL SELECT 7, 5, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,5,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,99,'Dep_CustBetSettingGameGroup_Member',NULL,0,0
UNION ALL SELECT 7, 15, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,5,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,99,'Dep_CustBetSettingGameGroup_Member',NULL,0,0
UNION ALL SELECT 7, 21, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,4,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,99,'Dep_CustBetSettingGameGroup_Member',NULL,0,0
UNION ALL SELECT 8, 5, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,5,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,8,'Dep_CustBetSettingGameGroup_Member',NULL,0,0
UNION ALL SELECT 8, 15, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,5,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,8,'Dep_CustBetSettingGameGroup_Member',NULL,0,0
UNION ALL SELECT 27, 5, 1, 0, 'All', 1, 1, 1, 0, 'Dep_CustPTGroupSetting_Member',NULL,5,1,'Dep_CustDiscountGroupSetting_Member',NULL,1,99,'Dep_CustBetSettingGameGroup_Member',NULL,0,0