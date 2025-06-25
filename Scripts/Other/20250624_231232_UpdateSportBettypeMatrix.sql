/*<info serverAlias="DBPRO-bodb02"></info>*/ 
/*
	Created: Virgil
	Date: 20250624
	Task: Release the feature Agency Cash Service - Sprint 4 [RedmineID: #231232]
	DB: DBPRO-bodb02
*/
USE [bodb02]
GO

UPDATE SportBettypeMatrix WITH(ROWLOCK, UPDLOCK)
SET SubProduct = ''
WHERE ProductID = 111