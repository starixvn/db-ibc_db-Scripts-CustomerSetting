/*
    Created: Tiara
    Date: 2020-03-25
    Task : Active reference setting for Betradar Virtual Sport - Phase 4 [Redmine: #105411]
    DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

UPDATE S
SET S.isActive = 1
FROM Sport_Bettype_Reference_Setting S WITH (ROWLOCK, UPDLOCK)
WHERE S.SportType = 196 AND S.isActive = 0

