/*
	Created by: Winnie
	Date: 2019-10-07
	Task: PT info Page For BMAIO
	DB: DBTXN/bodb02
*/ 
-------------------------------------------------

UPDATE [Sport_Bettype_Reference_Setting] WITH(ROWLOCK)  
SET	   IsActive = 1
WHERE  sporttype =9 AND bettype BETWEEN 701 AND 714 

UPDATE [Sport_Bettype_Reference_VirtualRate] WITH(ROWLOCK)  
SET	   IsActive = 1
WHERE  sporttype =9 AND bettype BETWEEN 701 AND 714 