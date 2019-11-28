/*
	Created by: Winnie
	Date: 2019-11-28
	Task: Update Active for 2 Upcoming Sports Chess (53) and Olympics (54)
	DB: DBTXN/bodb02
*/ 
-------------------------------------------------

UPDATE Sport_Bettype_Reference_Setting  WITH(ROWLOCK,UPDLOCK)  
SET	   IsActive = 1 
WHERE SportType IN(53,54) AND IsLicensee=0 AND Site<>'CN88'