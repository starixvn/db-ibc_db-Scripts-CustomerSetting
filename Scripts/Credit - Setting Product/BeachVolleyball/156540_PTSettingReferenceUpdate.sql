/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: Elodie
	Task: Update PT Setting References
	DB: DBTXN/bodb02
	Date: 2021071
*/ 
USE bodb02
GO

UPDATE Sport_Bettype_Reference_Setting
SET IsActive = 1
WHERE sporttype = 45

SELECT * FROM Sport_Bettype_Reference_Setting WHERE sporttype = 45