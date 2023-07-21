/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created by: Tacy@20230703
	Task: NG2 - Remove Setting
		https://nexdev.net/issues/189762
	DB: DBTXN-bodb02
*/ 

UPDATE a 
SET a.isActive = 0
FROM [dbo].[Sport_Bettype_Reference] a  WITH(UPDLOCK,ROWLOCK) 
WHERE a.Sporttype BETWEEN 213 AND 218


UPDATE a 
SET a.isActive = 0
FROM [dbo].[Sport_Bettype_Reference_Setting] a  WITH(UPDLOCK,ROWLOCK) 
WHERE  a.Sporttype BETWEEN 213 AND 218
