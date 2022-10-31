/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20221026@Elodie
	Task : Update ProductSettingDetail [Redmine:#179335]
	DB:  DBTXN/bodb02 
*/
USE bodb02
GO

UPDATE p
SET isActive = 0
FROM Sport_Bettype_Reference_Setting p WITH (ROWLOCK)
WHERE SportType IN (214,215,216,217,218)
	OR (SportType = 213 AND bettype BETWEEN 2506 AND 2511)
