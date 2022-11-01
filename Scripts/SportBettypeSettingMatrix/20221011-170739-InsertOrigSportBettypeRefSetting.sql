/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20221011@Tacy
	Task: Insert original sporttype, bettype reference into SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBCUST-CustDB
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
SELECT DISTINCT ref.SporttypeRef, ref.BettypeRef, ref.isLicensee AS isLicensee, sbm.isLive, ref.site AS site
FROM dbtxn.bodb02.dbo.Sport_Bettype_Reference ref WITH (NOLOCK)
INNER JOIN dbtxn.bodb02.dbo.SportBettypeMatrix sbm WITH (NOLOCK)
	ON sbm.SportType=ref.SporttypeRef
	AND sbm.BetType=ref.BettypeRef
WHERE NOT EXISTS (SELECT 1 FROM dbcust.custdb.dbo.SportBettypeSettingMatrix rm WITH (NOLOCK)
					WHERE rm.SportType=ref.SporttypeRef
					AND rm.BetType=ref.BettypeRef)

INSERT INTO SportBettypeSettingMatrix (SportType, BetType, isLicensee, isLive, Site)
SELECT SportType, BetType, isLicensee, isLive, Site
FROM #tmpRefSetting t
WHERE NOT EXISTS (SELECT 1 FROM SportBettypeSettingMatrix rm WITH (NOLOCK)
					WHERE t.BetType=rm.BetType
					AND t.SportType=rm.SportType
					AND t.isLicensee=rm.isLicensee
					AND t.isLive=rm.isLive
					AND t.Site=rm.Site)

-- Update RefSetting:
UPDATE rm
SET 
	rm.isActive=1,
	rm.SportTypeRefPT=tmp.SportType,
	rm.BetTypeRefPT=tmp.BetType,
	rm.SportTypeRefComm=tmp.SportType,
	rm.BetTypeRefComm=tmp.BetType,
	rm.SportTypeRefBetSetting=tmp.SportType,
	rm.BetTypeRefBetSetting=tmp.BetType
FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpRefSetting tmp 
		ON tmp.SportType=rm.SportType
		AND tmp.BetType=rm.BetType
		AND tmp.isLicensee=rm.isLicensee
		AND tmp.isLive=rm.isLive
		AND tmp.Site=rm.Site

-- Update TableRef:
UPDATE rm
SET 
	rm.TablePT=CASE 
				WHEN rm.isLicensee=0 THEN 
					CASE WHEN rm.SportTypeRefPT IN (1,2,3,5,8,10,11,99)	THEN 'CustSetting'
						 WHEN rm.SportTypeRefPT IN (161,164)			THEN 'CustSetting3rd'
						 WHEN rm.SportTypeRefPT IN (202,255)			THEN 'CustSettingGame'
																		ELSE 'CustPTsetting3rd_Member' END
				ELSE 'Dep_CustPTGroupSetting_Member' END,
	rm.TableComm=CASE 
					WHEN rm.isLicensee=0 THEN 
						CASE WHEN rm.SportTypeRefComm IN (1,2,3,5,8,10,11,99)	THEN 'CustSetting'
							 WHEN rm.SportTypeRefComm IN (202,255)				THEN 'CustSettingGame'
																				ELSE 'CustDiscount3rd_Member' END
					ELSE 'Dep_CustDiscountGroupSetting_Member' END,
	rm.TableBetSetting=CASE 
						WHEN rm.isLicensee=0 THEN 
							CASE WHEN rm.SportTypeRefBetSetting=202										  THEN 'CustGameType' 
								 WHEN rm.SportTypeRefBetSetting IN (1,2,3,5,8,10,11,99,161,164,9901,9902) THEN 'CustBetSetting_Member' END
						ELSE 
							CASE WHEN rm.SportTypeRefBetSetting IN (1,2,3,5,8,9,10,11,43,50,99,161,169,9901,9902,9907)  THEN 'Dep_CustBetSettingGameGroup_Member'
																														ELSE 'Dep_CustBetSetting_Member' END
						END
FROM SportBettypeSettingMatrix rm WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpRefSetting tmp 
		ON tmp.SportType=rm.SportType
		AND tmp.BetType=rm.BetType
		AND tmp.isLicensee=rm.isLicensee
		AND tmp.isLive=rm.isLive
		AND tmp.Site=rm.Site

-- update TableBettrans:
UPDATE ref
SET TableBettrans=CASE	WHEN SportType BETWEEN 1 AND 66
							OR SportType IN (99,161,164,175,9901,9902)
							OR SportType BETWEEN 180 AND 186
							OR SportType BETWEEN 190 AND 197
							OR SportType BETWEEN 213 AND 218					THEN 'bettrans'
						WHEN SportType IN (241,244)								THEN 'bettransG'
						WHEN SportType IN (170,176,211,225,233,236,239,242,243)	THEN 'bettransLC'
						WHEN SportType IN (155,156,165,167,200,208,209,212,219,
										   224,232,234,237,238,247,248)
							OR SportType BETWEEN 171 AND 174					THEN 'bettransRNG'
						WHEN SportType IN (168,169,202,220,222,223,231,245)		THEN 'translog'
					END
FROM SportBettypeSettingMatrix ref WITH (ROWLOCK, UPDLOCK)