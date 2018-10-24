/*
	Created: Winnie
	Date: 20181019
	Task: Update IsActive for Ref Setting
	DB: DBTXN/bodb02
*/
 

------------------------------------------------------

UPDATE Sport_Bettype_Reference_Setting  WITH(ROWLOCK,UPDLOCK)
	SET IsActive=1
WHERE Sporttype=43 AND isLicensee=1