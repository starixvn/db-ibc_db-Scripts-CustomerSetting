/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Eden@20230307
	Task: Update Data for SportBettypeSettingMatrix table [#179711]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE t 
SET t.SportTypeRefPT = 161,
	t.BetTypeRefPT = 81,
	TablePT = 'CustPTSetting3rd_Member',
	StructureVerPT = 'DCS'
FROM SportBettypeSettingMatrix t WITH(ROWLOCK,UPDLOCK) 
WHERE sporttype IN(161,164,168)
	AND isLicensee = 0 
	AND site = 'ALL'

UPDATE t 
SET t.SportTypeRefPT = 202,
	t.BetTypeRefPT = 1501,
	TablePT = 'CustPTSetting3rd_Member',
	StructureVerPT = 'DCS',
	SportTypeRefBetSetting = 202,
	BetTypeRefBetSetting = 1501,
	TableBetSetting = 'CustBetSetting3rd_Member',
	StructureVerBetSetting = 'DCS'
FROM SportBettypeSettingMatrix t WITH(ROWLOCK,UPDLOCK) 
WHERE sporttype IN(202)
	AND isLicensee = 0 
	AND site = 'ALL'
/*
SELECT * 
FROM SportBettypeSettingMatrix WITH(NOLOCK) 
WHERE sporttype IN(161,164,168)
	AND isLicensee = 0 
	AND site = 'ALL'

SELECT * 
FROM SportBettypeSettingMatrix WITH(NOLOCK) 
WHERE sporttype IN(202)
	AND isLicensee = 0 
	AND site = 'ALL'
*/