/*<info serverAlias="DBGLOB-GlobCustDB" ></info>*/
/*
	Created: 20250609@Dave
	Task: Live & RNG Casino - Product Status - Jackpot- Add Tooltip [Redmine: #229765]
	DB: DBGLOB-GlobCustDB

	Des: delete data Setting Matrix of Jackpot Contribution (Credit)
*/
USE GlobCustDB;

WITH TMP AS (
	SELECT 200 AS SportType, 1698 AS BetType /*SABA.games*/
	UNION ALL SELECT 171, 3898	/*Vgaming*/
	UNION ALL SELECT 143, 11698 /*PLAYSTAR*/
	UNION ALL SELECT 129, 15798 /*Playtech Live*/
)
UPDATE s
SET s.[RepUpdateTime]=dbo.f_GetDateTime2(),
	s.[isDeleted]=1
FROM SportBettypeSettingMatrix s  WITH (ROWLOCK,UPDLOCK)
	INNER JOIN TMP 
		ON s.SportType = tmp.SportType AND s.BetType = tmp.BetType
WHERE s.isLicensee = 0 AND isDeleted = 0;
