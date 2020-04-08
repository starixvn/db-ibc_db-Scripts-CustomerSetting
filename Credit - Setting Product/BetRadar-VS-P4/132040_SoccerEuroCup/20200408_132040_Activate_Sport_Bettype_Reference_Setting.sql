/*
    Created: Tiara
    Date: 2020-04-08
    Task : Active reference setting for Betradar Virtual Sport - Integrate Virtual Soccer Euro Cup [Redmine: #132040]
    DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

UPDATE S
SET S.isActive = 1
FROM Sport_Bettype_Reference_Setting S WITH (ROWLOCK, UPDLOCK)
WHERE S.SportType = 197 AND S.isActive = 0

