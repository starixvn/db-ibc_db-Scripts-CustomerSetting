/*
	Created: Johnson
	Date: 2018-09-05
	Task: set isActive =1 on PRO for PT info & virtual rate for new sports 4NS & 5US [Redmine: #96478]
	DB: DBTXN/bodb02
*/

UPDATE Sport_Bettype_Reference_Setting WITH(UPDLOCK,ROWLOCK)
SET isActive = 1
WHERE sporttype IN (47,48,49,51) 
GO

UPDATE Sport_Bettype_Reference_VirtualRate WITH(UPDLOCK,ROWLOCK)
SET isActive = 1
WHERE sporttype IN (47,48,49,51) 

