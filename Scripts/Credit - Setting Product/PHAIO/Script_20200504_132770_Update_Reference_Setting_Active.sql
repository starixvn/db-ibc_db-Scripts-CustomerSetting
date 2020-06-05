/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Date: 20200504@Eden
	Task: PHAIO 5.1: Offer New Bet Types Penalty Shootout Combo [#132770]
	DB: DBTXN/bodb02
*/
USE [bodb02]
GO
UPDATE s SET isActive = 1
FROM Sport_Bettype_Reference_Setting S WITH (ROWLOCK)
WHERE bettype = 376 and SportType = 1