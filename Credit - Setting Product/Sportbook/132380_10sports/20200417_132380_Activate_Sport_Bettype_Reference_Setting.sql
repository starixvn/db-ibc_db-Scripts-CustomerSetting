/*
    Created: Tiara
    Date: 2020-04-17
    Task : Active reference setting for SB- 10 upcomming sports  [Redmine: #132380]
    DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

UPDATE S
SET S.isActive = 1
FROM Sport_Bettype_Reference_Setting S WITH (ROWLOCK, UPDLOCK)
WHERE S.SportType BETWEEN 57 AND 66
	AND S.isActive = 0

