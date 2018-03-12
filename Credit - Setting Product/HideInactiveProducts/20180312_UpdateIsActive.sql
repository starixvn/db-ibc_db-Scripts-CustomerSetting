/*	
	Created: 20170312@Winnie
	Task: Update isActive=0 
	Redmine: https://redmine.nexcel.vn/issues/86086
	DB: DBTXN/bodb02

*/
UPDATE
Sport_Bettype_Reference WITH(ROWLOCK,UPDLOCK)
SET isActive=0 
WHERE Sporttype IN (151,152,153,154,162,206,252,253,201)

UPDATE Sport_Bettype_Reference_Setting  WITH(ROWLOCK,UPDLOCK)
SET isActive=0 
WHERE Sporttype IN (151,152,153,154,162,206,252,253,201)

