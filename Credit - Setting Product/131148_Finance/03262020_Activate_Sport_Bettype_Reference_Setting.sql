/*
    Created: Tiara
    Date: 2020-03-25
    Task : Activate reference setting for Sporttype 55 [Redmine: #131148]
    DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

UPDATE S
SET S.isActive = 1
FROM Sport_Bettype_Reference_Setting S WITH (ROWLOCK, UPDLOCK)
WHERE S.SportType = 55 AND S.isActive = 0

