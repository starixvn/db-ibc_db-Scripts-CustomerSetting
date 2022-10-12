/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20221012@Tacy
	Task: Update MaxGameStake of MG's StakeLevels
		 https://nexdev.net/issues/170739 RedmineID: #170739
	Database: DBCUST-CustDB
*/
UPDATE slg
SET MaxGameStake = CASE WHEN GameTypeID IN (8400,8409)			THEN 40*MaxStake		
						WHEN GameTypeID IN (8404,8411)			THEN 150*MaxStake
						WHEN GameTypeID IN (8405,8430)			THEN 60*MaxStake
						WHEN GameTypeID IN (8406)				THEN 25*MaxStake
						WHEN GameTypeID IN (8410)				THEN 55.02*MaxStake
						WHEN GameTypeID IN (8412,8414,8441)		THEN 100*MaxStake
						WHEN GameTypeID IN (8424)				THEN 80*MaxStake
						WHEN GameTypeID IN (8429,8439)			THEN 50*MaxStake
						WHEN GameTypeID IN (8431)				THEN 110*MaxStake
						WHEN GameTypeID IN (8438)				THEN 90*MaxStake	
					END
FROM StakeLevelGroupDetail slg WITH (ROWLOCK,UPDLOCK)
WHERE GameTypeID IN (8400,8409,8404,8411,8405,8430,8406,8410,8412,8414,8441,8424,8429,8439,8431,8438)



