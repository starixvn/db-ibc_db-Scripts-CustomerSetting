/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Created: 20201028@Tina
	Task: [144296] Active Offer Moneyline and 1H Moneyline for Football and Baseball
		  
*/

USE [bodb02]
GO

UPDATE SBR SET isActive = 1
FROM Sport_Bettype_Reference_Setting SBR WITH (ROWLOCK)
WHERE SportType IN (3, 8) --Football & Baseball
	AND BetType IN (20, 21) --Moneyline & 1H Moneyline
	AND isActive = 0