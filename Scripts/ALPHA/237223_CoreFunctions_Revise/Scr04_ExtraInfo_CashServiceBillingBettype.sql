/*<info serverAlias="DBPRO-bodb02"></info>*/
/*
	Created: 20250827@Virgil
	Task: Revise core function report to use SportBettypeMatrix [Redmine: #235369]
	DB: DBPRO-bodb02
*/
USE [bodb02]
GO

-- Cash Service Billing
UPDATE sbm
SET sbm.ExtraInfo = JSON_MODIFY(ISNULL(sbm.ExtraInfo, '{}'), '$.BettypeRef', sbm.bettype)
FROM SportBettypeMatrix sbm WITH(ROWLOCK, UPDLOCK)
WHERE ProductID = 111 AND bettype IN (31003, 31004, 31005)

-- Saba Casino
UPDATE sbm
SET sbm.ExtraInfo = JSON_MODIFY(ISNULL(sbm.ExtraInfo, '{}'), '$.BettypeRef', 71)
FROM SportBettypeMatrix sbm WITH(ROWLOCK, UPDLOCK)
WHERE ProductID = 6 AND SportType = 251

/*
SELECT *
FROM SportBettypeMatrix sbm (NOLOCK)
WHERE ProductID = 111 AND bettype IN (31003, 31004, 31005)
*/	
