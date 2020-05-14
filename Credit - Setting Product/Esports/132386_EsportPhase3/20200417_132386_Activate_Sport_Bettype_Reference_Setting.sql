/*
    Created: Tiara
    Date: 2020-04-17
    Task : Active reference setting for Esport Phase 3 [Redmine: #132386]
    DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

UPDATE S
SET S.isActive = 1
FROM Sport_Bettype_Reference_Setting S WITH (ROWLOCK, UPDLOCK)
WHERE S.SportType = 43 
	AND S.BetType IN (9087,9088) 
	AND S.isActive = 0

