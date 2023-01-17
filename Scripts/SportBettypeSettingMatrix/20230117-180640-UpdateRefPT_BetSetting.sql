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
SET BetTypeRefPT=CASE	WHEN SportType BETWEEN 180 AND 186	THEN 1201	--Virtual Sports
						WHEN SportType=220					THEN 1024	--Lottery
				END,
	SportTypeRefPT=CASE WHEN SportType BETWEEN 180 AND 186	THEN 9908 
						WHEN SportType=220					THEN 220
				END,
	BetTypeRefBetSetting=CASE	WHEN SportType BETWEEN 180 AND 186	THEN 1201 
								WHEN SportType=220					THEN 1024
						END,
	SportTypeRefBetSetting=CASE WHEN SportType BETWEEN 180 AND 186	THEN 9908 
								WHEN SportType=220					THEN 220
						END
FROM SportBettypeSettingMatrix sm WITH (ROWLOCK, UPDLOCK)
WHERE isLicensee=0
AND (SportType BETWEEN 180 AND 186
	OR SportType=220)