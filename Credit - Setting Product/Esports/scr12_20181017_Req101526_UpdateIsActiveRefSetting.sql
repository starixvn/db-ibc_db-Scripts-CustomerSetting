/*
	Created: Winnie
	Date: 20181019
	Task: Update IsActive for Ref Setting
	DB: DBTXN/bodb02
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
DELETE FROM Sport_Bettype_Reference 
WHERE Sporttype=43 AND isLicensee=0


UPDATE Sport_Bettype_Reference_Setting  WITH(ROWLOCK,UPDLOCK)
	SET IsActive=1
WHERE Sporttype=43 AND isLicensee=0