/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230117@Tacy
	Task: Update reference PT and Bet setting of VS and RNG Lottery [#180640]
			https://nexdev.net/issues/180640
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE sm 
SET BetTypeRefPT=CASE WHEN SportType=220 THEN 1024	--Lottery
										 ELSE 1201	--Virtual Sports
				END,
	SportTypeRefPT=CASE WHEN SportType=220 THEN 220 ELSE 9908 END,
	BetTypeRefBetSetting=CASE WHEN SportType=220 THEN 1024 ELSE 1201 END,
	SportTypeRefBetSetting=CASE WHEN SportType=220 THEN 220 ELSE 9908 END 
FROM SportBettypeSettingMatrix sm WITH (ROWLOCK, UPDLOCK) 
WHERE isLicensee=0 AND Site = 'ALL' 
AND SportType IN (180, 186, 190, 191, 192, 193, 194, 196, 197, 199, 220)

-- Delete unused Sports
DELETE t	FROM SportBettypeSettingMatrix t WITH(ROWLOCK) WHERE SportType BETWEEN 180 AND 199 	AND isLicensee = 0  AND Site = 'ALL' 	AND SportType NOT IN (180, 186, 190, 191, 192, 193, 194, 196, 197, 199)