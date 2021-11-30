/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20211118@Johnson
	Task: update IsActive For Sport_Bettype_Reference_Setting
	DB: DBTXN/bodb02
*/

USE [bodb02]
GO

/*
UPDATE Sport_Bettype_Reference_Setting WITH(ROWLOCK)
SET IsActive = 0
WHERE sporttype = 202 
	AND bettype IN (1530,1531)
*/

UPDATE Sport_Bettype_Reference_Setting WITH(ROWLOCK)
SET IsActive = 1
WHERE sporttype = 202 
	AND bettype IN (1530,1531)