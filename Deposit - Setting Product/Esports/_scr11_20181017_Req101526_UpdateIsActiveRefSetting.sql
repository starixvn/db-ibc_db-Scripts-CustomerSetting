/*
	Created: Winnie
	Date: 20181019
	Task: Update IsActive for Ref Setting
	DB: DBTXN/bodb02
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
UPDATE Sport_Bettype_Reference WITH(ROWLOCK,UPDLOCK)
	SET IsActive=0
WHERE Sporttype=43 AND isLicensee=1


UPDATE Sport_Bettype_Reference_Setting  WITH(ROWLOCK,UPDLOCK)
	SET IsActive=1
WHERE Sporttype=43 AND isLicensee=1