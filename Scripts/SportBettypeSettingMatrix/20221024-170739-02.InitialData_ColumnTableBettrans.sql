/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220525@Tacy
	Task: Initial data into column TableBettrans on table SportBettypeSettingMatrix
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

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