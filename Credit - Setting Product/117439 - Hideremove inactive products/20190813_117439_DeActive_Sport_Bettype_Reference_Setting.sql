/*
	Created by: Eden
	Date: 2019-08-13
	Task: Deactive Sport_Bettype Reference setting For Bullfighting, Lucky 3, Porkergame
	DB: DBTXN/bodb02
*/ 
-------------------------------------------------

UPDATE Sport_Bettype_Reference_Setting WITH(ROWLOCK)  
SET	   IsActive = 0 
WHERE  sporttype IN(160,163,207)